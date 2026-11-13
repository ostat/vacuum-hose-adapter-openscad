Param(
    [string]$OpenScadPath,
    [string[]]$ScadScriptFolders = @(
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
        [string]$expectedErrorPattern = '',
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

    $isExpectedFailure = -not [string]::IsNullOrWhiteSpace($expectedErrorPattern)
    $isParserOrIncludeFailure = $executionResult.stderr -match "(?im)(parser error|syntax error|can't open include file|can't open library|unable to open file)"
    $hasAssertionError = $executionResult.stderr -match "(?im)^error:\s*assertion\b"

    if ($isExpectedFailure) {
        $hasExpectedError = $executionResult.stderr -match $expectedErrorPattern
        if ($executionResult.ExitCode -ne 0 -and $hasExpectedError -and $hasAssertionError -and -not $isParserOrIncludeFailure -and $executionResult.stderr -notmatch '(?im)^warning:') {
            write-Host "Expected assertion failure observed." -ForegroundColor Green
            return $true
        }
        Write-Warning "Expected assertion failure did not match criteria in $($TargetFile.Name)"
        Write-Warning "ExitCode: $($executionResult.ExitCode)"
        Write-Warning "stderr: $($executionResult.stderr)"
        return $false
    }

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

$repositoryRoot = (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName
$oneidaTestsFolder = Join-Path $repositoryRoot "scripts/tests"
if (-not ($ScadScriptFolders -contains $oneidaTestsFolder)) {
    $ScadScriptFolders += $oneidaTestsFolder
}

$oneidaExpectedFailureCases = @(
    @{ case = "invalid_nominal_13"; pattern = "Unsupported Oneida nominal diameter" },
    @{ case = "invalid_nominal_15"; pattern = "Unsupported Oneida nominal diameter" },
    @{ case = "invalid_nominal_17"; pattern = "Unsupported Oneida nominal diameter" },
    @{ case = "invalid_nominal_fractional"; pattern = "Unsupported Oneida nominal diameter" },
    @{ case = "invalid_nominal_type"; pattern = "Oneida nominal diameter must be a positive number" },
    @{ case = "invalid_fit_type"; pattern = "Oneida fit adjustment must be a number" },
    @{ case = "below_min_length"; pattern = "length must be at least" },
    @{ case = "bore_invalid"; pattern = "positive bore" },
    @{ case = "fit_shrinks_bore"; pattern = "positive bore" },
    @{ case = "factory_below_min_length"; pattern = "length must be 0 or at least" },
    @{ case = "factory_unsupported_nominal"; pattern = "Unsupported Oneida nominal diameter" }
)

$oneidaDemoRelativePaths = @(
    "demos/oneida_adapter.scad",
    "demos/oneida_fit_ring.scad"
)

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
        if($TargetFile.BaseName -ieq 'oneida_expected_failures'){
            $oneidaExpectedFailureCases | ForEach-Object {
                $caseName = $_.case
                $input_args = " -D `"Case=`"`"$($caseName)`"`"`""
                $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults -cmdArgsInput $input_args -SaveAppend "_$($caseName)" -expectedErrorPattern $_.pattern
                if(!$success){
                    $failed = $true
                }
            }
        }
        elseif($TargetFile.BaseName -ieq 'caliper_geometry'){
            foreach ($case in 0..15) {
                $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults -Backend CGAL -cmdArgsInput " -D `"Case=$case`"" -SaveAppend "-case$case"
                if(!$success){
                    $failed = $true
                }
            }
        }
        elseif($TargetFile.BaseName -ieq 'vacuum-hose-adapter'){
            $styles = @('mag', 'flange', 'hose', 'dyson', 'camlock', 'dw735', 'centec_female', 'centec_male', 'osvacm32', 'osvacm', 'osvacf32', 'osvacf', 'makita_male', 'bosch_sander', 'festoolcleanteclug', 'oneida', 'kobalt', 'rigid_nxt', 'nozzle')

            $styles | ForEach-Object {
                $style = $_
                $input_args  = " -D `"End1_Style=`"`"$($style)`"`"`""
                $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults -cmdArgsInput $input_args -SaveAppend $style
                if(!$success){
                    $failed = $true
                }
            }
            # Transition scenarios, name = OpenSCAD -D arguments. Add new transition styles and options here.
            $transitions = [ordered]@{
                'transition_flat'             = ' -D "Transition_Style=""flat"""'
                'transition_bend_taper'       = ' -D "Transition_Style=""bend+taper""" -D "Transition_Angle=45"'
                'transition_bend_taper_multi' = ' -D "Transition_Style=""bend+taper""" -D "Transition_Angle=45" -D "Transition_End2_Count=2"'
                'transition_taper_bend'       = ' -D "Transition_Style=""taper+bend""" -D "Transition_Angle=45"'
                'transition_organicbend'      = ' -D "Transition_Style=""organicbend""" -D "Transition_Angle=45"'
                'transition_hull'             = ' -D "Transition_Style=""hull""" -D "Transition_Angle=30" -D "Transition_End2_Count=3"'
                'transition_hull_center'      = ' -D "Transition_Style=""hull""" -D "Transition_Angle=40" -D "Transition_End2_Count=4" -D "Transition_HullCenter=""end3"""'
                'transition_inline'           = ' -D "Transition_Style=""inline""" -D "Transition_End2_Count=3"'
                'transition_inline_end3'      = ' -D "Transition_Style=""inline""" -D "Transition_End2_Count=4" -D "Transition_Inline_End3_Positions=[1,3]" -D "Transition_HullLength=10"'
            }

            $transitions.Keys | ForEach-Object {
                $name = $_
                $success = Test-OpenSCAD -TargetFile $TargetFile -saveResults $saveResults -cmdArgsInput $transitions[$name] -SaveAppend $name
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
}

$oneidaDemoRelativePaths | ForEach-Object {
    $demoFile = Get-Item -LiteralPath (Join-Path $repositoryRoot $_)
    if($saveResults) {
        $outputScriptFolderPath = Join-Path $demoFile.DirectoryName $outputScriptFolder
        New-Item -ItemType Directory -Path $outputScriptFolderPath -Force | Out-Null
    }
    $success = Test-OpenSCAD -TargetFile $demoFile -saveResults $saveResults
    if(!$success){
        $failed = $true
    }
}

if ($failed) {
    throw "OpenSCAD validation failed"
}

Write-Host "All OpenSCAD files passed."
