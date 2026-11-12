Param(
    [string]$OpenScadPath,
    $ScadScriptFolders = @(
            (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName
            ),
    [switch]$saveResults,
    [string]$outputScriptFolder = 'test_results'
)

if (-not $OpenScadPath) {

    # Try PATH first
    $cmd = Get-Command 'openscad.exe' -ErrorAction SilentlyContinue

    if ($cmd) {
        $OpenScadPath = $cmd.Source
    }
    else {
        # Common Windows install paths
        $candidates = @(
            $OpenScadPath,
            $env:OPENSCAD_PATH,
            "C:\tools\OpenSCAD\openscad.exe",
            "C:\Program Files\OpenSCAD\openscad.exe",
            "C:\Program Files (x86)\OpenSCAD\openscad.exe"
        )

        foreach ($path in $candidates) {
            if (![string]::IsNullOrEmpty($path) -and (Test-Path -Path $path)) {
                $OpenScadPath = $path
                break
            }
        }
    }
}

if (-not $OpenScadPath) {
    throw "OpenSCAD not found. Set OPENSCAD_PATH or pass -OpenScadPath"
}

function Start-ProcessWithOutputs
{
    param (
        [Parameter(Mandatory=$false)] [string]$commandTitle,
        [Parameter(Mandatory=$true)] [string]$commandPath,
        [Parameter(Mandatory=$false)] [string[]]$ArgumentList
    )

    $StandardOutputSourceIdentifier = "StandardOutput$([Guid]::NewGuid())"
    $StandardErrorSourceIdentifier = "StandardError$([Guid]::NewGuid())"
    $messagedata = new-object psobject -property @{
       StandardOutput= New-Object -TypeName System.Text.StringBuilder
       StandardError = New-Object -TypeName System.Text.StringBuilder}

    $pinfo = New-object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = $commandPath
    $pinfo.CreateNoWindow = $true
    $pinfo.UseShellExecute = $false
    $pinfo.RedirectStandardOutput = $true
    $pinfo.RedirectStandardError = $true
    $pinfo.Arguments = $ArgumentList

    $Process = New-Object System.Diagnostics.Process
    $Process.StartInfo = $pinfo

    $ProcessOutputEventAction = {
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.StandardOutput.AppendLine($EventArgs.Data)
        }
    }

    $ProcessErrorEventAction = {
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.StandardError.AppendLine($EventArgs.Data)
        }
    }

    $OutputDataReceivedEvent = Register-ObjectEvent -SourceIdentifier $StandardOutputSourceIdentifier -InputObject $Process -EventName "OutputDataReceived" -Action $ProcessOutputEventAction -messagedata $messagedata
    $ErrorDataReceivedEvent = Register-ObjectEvent -SourceIdentifier $StandardErrorSourceIdentifier -InputObject $Process -EventName "ErrorDataReceived" -Action $ProcessErrorEventAction -messagedata $messagedata

    $executionTime = Measure-Command {
        $Process.Start() | Out-Null
        $Process.BeginErrorReadLine()
        $Process.BeginOutputReadLine()
        $Process.WaitForExit()
    }

    Start-Sleep -Milliseconds 200

    Unregister-Event -SourceIdentifier $StandardOutputSourceIdentifier
    Unregister-Event -SourceIdentifier $StandardErrorSourceIdentifier

    return [pscustomobject]@{
        commandTitle = $commandTitle
        ExitCode = $Process.ExitCode;
        stdout = $messagedata.StandardOutput.ToString();
        stderr = $messagedata.StandardError.ToString();
        ExitTime = $Process.ExitTime;
        StartTime = $Process.StartTime;
        executionTime = $executionTime
    }
}
function Test-OpenSCAD(
        $TargetFile,
        [bool]$saveResults = $false,
        $cmdArgsInput = '',
        $saveAppend = '',
        [string]$AllowedWarningRegex = '',
        [ValidateSet('Manifold', 'CGAL')][string]$Backend = 'Manifold')
{
    $scadScriptPath = $TargetFile.FullName

    Write-Host "`r`nTesting '$($scadScriptPath)' input_args:'$($cmdArgsInput)'"

    $cmdArgs = ''
    if($saveResults) {
        $cmdArgs += " -o `"$(Join-Path $outputScriptFolderPath $TargetFile.BaseName)$($saveAppend).stl`""
    }
    else {
        $cmdArgs += " -o NUL"
    }

    $cmdArgs += $cmdArgsInput
    $cmdArgs += " --export-format binstl"
    $cmdArgs += " --enable textmetrics"
    $cmdArgs += " --backend $Backend"

    $cmdArgs += " $($scadScriptPath)"
    Write-Host  $cmdArgs
    $executionResult = (Start-ProcessWithOutputs -commandPath $script:OpenScadPath -ArgumentList $cmdArgs)

    write-host "openscad executionTime: $($executionResult.executionTime)"

    $stderrForValidation = $executionResult.stderr
    if(-not [string]::IsNullOrWhiteSpace($AllowedWarningRegex)) {
        $stderrForValidation = (($executionResult.stderr -split "`r?`n") | Where-Object { $_ -notmatch $AllowedWarningRegex }) -join "`n"
    }

    # Check for warnings/errors
    if ($stderrForValidation -match '(?im)^(warning|error):' -or $executionResult.ExitCode -ne 0) {
        Write-Warning "OpenSCAD warnings/errors in $($TargetFile.Name)"
        write-warning "stderr: $($executionResult.stderr)"
        return $false
    } else {
        write-Host "ExitCode: $($executionResult.ExitCode)" -ForegroundColor Green
        #write-Host "stderr: $($executionResult.stderr)"
        return $true
    }
}
$ErrorActionPreference = "Stop"

$failed = $false
$ScadScriptFolders |ForEach-Object {
    $ScadScriptFolder = $_
    write-host "path: $ScadScriptFolder"
    $outputScriptFolderPath = Join-Path $ScadScriptFolder $outputScriptFolder
    if($saveResults) {
        if(!(Test-Path -Path $outputScriptFolderPath)) {
            New-Item -ItemType Directory -Path $outputScriptFolderPath -Force
        }
    }

    Get-ChildItem -LiteralPath $ScadScriptFolder -Filter *.scad | ForEach-Object {
        $TargetFile = $_
        if($TargetFile.BaseName -ieq 'vacuum-hose-adapter'){

            $styles = @('mag', 'flange', 'hose', 'dyson', 'camlock', 'dw735', 'centec_female', 'centec_male', 'osvacm32', 'osvacm', 'osvacf32', 'osvacf', 'makita_male', 'bosch_sander', 'festoolcleanteclug')

            $styles | ForEach-Object {
                $style = $_
                $input_args  = " -D `"End1_Style=`"`"$($style)`"`"`""
                $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults -cmdArgsInput $input_args -SaveAppend $style
                if(!$success){
                    $failed = $true
                }
            }
        } else {
            $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults
            if(!$success){
                $failed = $true
            }
        }
    }

    $demoFile = Join-Path $ScadScriptFolder 'demos/vacuum_hose_adapter_demo.scad'
    if (Test-Path -LiteralPath $demoFile) {
        $demoTarget = Get-Item -LiteralPath $demoFile
        $demoAllowedWarningRegex = '(?i)^WARNING:\s+Viewall and autocenter disabled in favor of \$vp\*'
        $demoCommonArgs = " -D `"setViewPort=false`""
        $demoCases = @(
            @{ Name = 'demo-overview'; Args = "$demoCommonArgs -D `"scenario=`"`"demo`"`"`"" },
            @{ Name = 'demo-derived'; Args = "$demoCommonArgs -D `"scenario=`"`"demo2`"`"`"" },
            @{ Name = 'threads-outer'; Args = "$demoCommonArgs -D `"scenario=`"`"hose_threads`"`"`" -D `"`$t=0`"" },
            @{ Name = 'threads-inner'; Args = "$demoCommonArgs -D `"scenario=`"`"hose_threads`"`"`" -D `"`$t=0.33`"" },
            @{ Name = 'stop-outer'; Args = "$demoCommonArgs -D `"scenario=`"`"hose_stoplength`"`"`" -D `"`$t=0`"" },
            @{ Name = 'stop-inner'; Args = "$demoCommonArgs -D `"scenario=`"`"hose_stoplength`"`"`" -D `"`$t=1`"" },
            @{ Name = 'stop-symmetry'; Args = "$demoCommonArgs -D `"scenario=`"`"hose_stopsymmetrical`"`"`" -D `"`$t=0`"" },
            @{ Name = 'magnetic-alignment'; Args = "$demoCommonArgs -D `"scenario=`"`"magnetic_alignmentring`"`"`" -D `"`$t=0.66`"" },
            @{ Name = 'nozzle'; Args = "$demoCommonArgs -D `"scenario=`"`"nozzle_demo`"`"`" -D `"`$t=0.5`"" },
            @{ Name = 'nozzle-size'; Args = "$demoCommonArgs -D `"scenario=`"`"nozzle_size`"`"`" -D `"`$t=1`"" },
            @{ Name = 'transition-hull-center'; Args = "$demoCommonArgs -D `"scenario=`"`"transition_hullcenter`"`"`" -D `"`$t=0.75`"" },
            @{ Name = 'extension-grid-pre'; Args = "$demoCommonArgs -D `"scenario=`"`"transitionextpre_gridSize`"`"`" -D `"`$t=1`"" },
            @{ Name = 'extension-grid-post'; Args = "$demoCommonArgs -D `"scenario=`"`"transitionextpost_wallthickness`"`"`" -D `"`$t=1`"" },
            @{ Name = 'extension-overview-grid'; Args = "$demoCommonArgs -D `"scenario=`"`"transitionext_demo`"`"`" -D `"`$t=1`"" }
        )

        $demoCases | ForEach-Object {
            $demoCase = $_
            $success = Test-OpenSCAD -TargetFile $demoTarget -saveResults $saveResults -cmdArgsInput $demoCase.Args -SaveAppend ("-" + $demoCase.Name) -AllowedWarningRegex $demoAllowedWarningRegex
            if(!$success){
                $failed = $true
            }
        }
    }

    $gridFixture = Join-Path $ScadScriptFolder 'scripts/tests/end_cap_grid.scad'
    if (Test-Path -LiteralPath $gridFixture) {
        $success = Test-OpenSCAD -TargetFile (Get-Item -LiteralPath $gridFixture) -saveResults $saveResults
        if(!$success){
            $failed = $true
        }
    }

    $caliperFixture = Join-Path $ScadScriptFolder 'scripts/tests/caliper_geometry.scad'
    if (Test-Path -LiteralPath $caliperFixture) {
        foreach ($case in 0..15) {
            $success = Test-OpenSCAD -TargetFile (Get-Item -LiteralPath $caliperFixture) -saveResults $saveResults -Backend CGAL -cmdArgsInput " -D `"Case=$case`"" -SaveAppend "-case$case"
            if(!$success){
                $failed = $true
            }
        }
    }

    $stopFixture = Join-Path $ScadScriptFolder 'scripts/tests/demo_stop_settings.scad'
    if (Test-Path -LiteralPath $stopFixture) {
        $success = Test-OpenSCAD -TargetFile (Get-Item -LiteralPath $stopFixture) -saveResults $saveResults
        if(!$success){
            $failed = $true
        }
    }
}

if ($failed) {
    throw "OpenSCAD validation failed"
}

Write-Host "All OpenSCAD files passed."
