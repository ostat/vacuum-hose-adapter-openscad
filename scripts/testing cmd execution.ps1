function Start-ProcessWithOutputv1
{
    param ([string]$Path,[string[]]$ArgumentList)
    $Output = New-Object -TypeName System.Text.StringBuilder
    $Error = New-Object -TypeName System.Text.StringBuilder
    $psi = New-object System.Diagnostics.ProcessStartInfo 
    $psi.CreateNoWindow = $true 
    $psi.UseShellExecute = $false 
    $psi.RedirectStandardOutput = $true 
    $psi.RedirectStandardError = $true 
    $psi.FileName = $Path
    if ($ArgumentList.Count -gt 0)
    {
        $psi.Arguments = $ArgumentList
    }
    $process = New-Object System.Diagnostics.Process 
    $process.StartInfo = $psi 
    [void]$process.Start()
    do
    {
        if (!$process.StandardOutput.EndOfStream)
       {
           [void]$Output.AppendLine($process.StandardOutput.ReadLine())
       }
       if (!$process.StandardError.EndOfStream)
       {
           [void]$Error.AppendLine($process.StandardError.ReadLine())
       }
       Start-Sleep -Milliseconds 10
    } while (!$process.HasExited)

    #read remainder
    while (!$process.StandardOutput.EndOfStream)
    {
        #write-verbose 'read remaining output'
        [void]$Output.AppendLine($process.StandardOutput.ReadLine())
    }
    while (!$process.StandardError.EndOfStream)
    {
        #write-verbose 'read remaining error'
        [void]$Error.AppendLine($process.StandardError.ReadLine())
    }

    return @{ExitCode = $process.ExitCode; Output = $Output.ToString(); Error = $Error.ToString(); ExitTime=$process.ExitTime}
}

# Launch an executable and return the exitcode, output text, and error text of the process.
function Start-ProcessWithOutputv2
{
    # Function requires a path to an executable and an optional list of arguments
    param (
        [Parameter(Mandatory=$false)] [string]$commandTitle,
        [Parameter(Mandatory=$true)] [string]$ExecutablePath,
        [Parameter(Mandatory=$false)] [string[]]$ArgumentList
    )

    $messagedata = new-object psobject -property @{
       ProcessOutput = New-Object -TypeName System.Text.StringBuilder 
       ProcessError = New-Object -TypeName System.Text.StringBuilder}

    $ProcessStartInfoObject = New-object System.Diagnostics.ProcessStartInfo 
    $ProcessStartInfoObject.FileName = $ExecutablePath
    $ProcessStartInfoObject.CreateNoWindow = $true 
    $ProcessStartInfoObject.UseShellExecute = $false 
    $ProcessStartInfoObject.RedirectStandardOutput = $true 
    $ProcessStartInfoObject.RedirectStandardError = $true 
    
    if ($ArgumentList.Count -gt 0)
    {
        $ProcessStartInfoObject.Arguments = $ArgumentList
    }

    $Process = New-Object System.Diagnostics.Process 
    $Process.StartInfo = $ProcessStartInfoObject 

    $ProcessOutputEventAction = { 
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.ProcessError.AppendLine($EventArgs.Data)
        }
    }
    $ProcessErrorEventAction = { 
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.ProcessOutput.AppendLine($EventArgs.Data)
        }
    }
    Register-ObjectEvent -InputObject $Process -EventName "OutputDataReceived" -Action $ProcessOutputEventAction -messagedata $messagedata | out-null
    Register-ObjectEvent -InputObject $Process -EventName "ErrorDataReceived" -Action $ProcessErrorEventAction -messagedata $messagedata | out-null

    $executionTime = Measure-Command {
        [void]$Process.Start()
        $Process.BeginErrorReadLine()
        $Process.BeginOutputReadLine()
        $Process.WaitForExit()
    }

    Start-Sleep -Milliseconds 200
    Write-Host "Exiction is done.... ExitCode:$($Process.ExitCode) HasExited:$($Process.HasExited) StandardError:$($Process.StandardError) StartTime:$($Process.StartTime) "
    return [pscustomobject]@{
        commandTitle = $commandTitle
        ExitCode = $Process.ExitCode; 
        stdout = $messagedata.ProcessOutput.ToString(); 
        stderr = $messagedata.ProcessError.ToString(); 
        ExitTime = $Process.ExitTime;
        StartTime = $Process.StartTime;
        executionTime = $executionTime
    }
}


function Start-ProcessWithOutputs
{
    param (
        [Parameter(Mandatory=$false)] [string]$commandTitle,
        [Parameter(Mandatory=$true)] [string]$commandPath,
        [Parameter(Mandatory=$false)] [string[]]$ArgumentList
    )

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

    Register-ObjectEvent -InputObject $Process -EventName "OutputDataReceived" -Action $ProcessOutputEventAction -messagedata $messagedata | out-null
    Register-ObjectEvent -InputObject $Process -EventName "ErrorDataReceived" -Action $ProcessErrorEventAction -messagedata $messagedata | out-null

    $executionTime = Measure-Command {
        $Process.Start() | Out-Null
        $Process.BeginErrorReadLine()
        $Process.BeginOutputReadLine()
        $Process.WaitForExit()
    }

    Start-Sleep -Milliseconds 200
    Write-Host "Exiction is done.... ExitCode:$($Process.ExitCode) HasExited:$($Process.HasExited) StandardError:$($Process.StandardError) StartTime:$($Process.StartTime) "
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


Function Execute-Command ($commandTitle, $commandPath, $commandArguments)
{  
  Try {
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = $commandPath
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = $commandArguments

    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    [pscustomobject]@{
        commandTitle = $commandTitle
        stdout = $p.StandardOutput.ReadToEnd()
        #stderr = $p.StandardError.ReadToEnd()
        ExitCode = $p.ExitCode
    }

    $p.WaitForExit()
  }
  Catch {
    Write-Warning "Error running CommandPath = '$($commandPath)' Error:$($Error[0])"
    exit
  }
}

Function Execute-Commandv1 ($commandTitle, $commandPath, $commandArguments)
{  
  Try {
    #$results = [pscustomobject]@{}
    #$executionTime = Measure-Command {
        $pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $pinfo.FileName = $commandPath
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        $pinfo.Arguments = $commandArguments
        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        [pscustomobject]@{
            commandTitle = $commandTitle
            #stdout = $p.StandardOutput.ReadToEnd()
            #stderr = $p.StandardError.ReadToEnd()
            ExitCode = $p.ExitCode
        }

        #$results | Add-Member -MemberType NoteProperty -Name 'commandTitle' -Value $commandTitle
        #$results | Add-Member -MemberType NoteProperty -Name 'stdout' -Value $p.StandardOutput.ReadToEnd()
        #$results | Add-Member -MemberType NoteProperty -Name 'stderr' -Value $p.StandardError.ReadToEnd()
        #$results | Add-Member -MemberType NoteProperty -Name 'ExitCode' -Value $p.ExitCode

        $p.WaitForExit()
    #}
    #$results | Add-Member -MemberType NoteProperty -Name 'executionTime' -Value $executionTime
    #$results
  }
  Catch {
    Write-Warning "Error running CommandPath = '$($commandPath)' Error:$($Error[0])"
    exit
  }
}

Function Execute-Commandv2 ($commandTitle, $commandPath, $commandArguments)
{
    $psi = New-object System.Diagnostics.ProcessStartInfo 
    $psi.CreateNoWindow = $true 
    $psi.UseShellExecute = $false 
    $psi.RedirectStandardOutput = $true 
    $psi.RedirectStandardError = $true 
    $psi.FileName = $commandPath 
    $psi.Arguments = $commandArguments
    $process = New-Object System.Diagnostics.Process 
    $process.StartInfo = $psi 
    [void]$process.Start()
    #$output = $process.StandardOutput.ReadToEnd() 
    $process.WaitForExit() 
    "done"
}

Function Execute-Commandv3 ($commandTitle, $commandPath, $commandArguments)
{
    $stdout = New-Object System.Text.StringBuilder
    $stderr = New-Object System.Text.StringBuilder

    $psi = New-object System.Diagnostics.ProcessStartInfo 
    $psi.CreateNoWindow = $true 
    $psi.UseShellExecute = $false 
    $psi.RedirectStandardOutput = $true 
    $psi.RedirectStandardError = $true 
    $psi.FileName = $commandPath 
    $psi.Arguments = $commandArguments
    $process = New-Object System.Diagnostics.Process 
    $process.StartInfo = $psi 
    [void]$process.Start()
    do
    {
         $stdout.AppendLine($process.StandardOutput.ReadLine())
         #$stderr.AppendLine($process.StandardOutput.ReadLine())
    }
    while (!$process.HasExited)

    Write-Host  $stdout
}

$outputtee

$arguments = '-o "C:\src\ostat\vacuum-hose-adapter-openscad\generated\demos\vacuum_hose_adapter\text\centec_male_demo_text\centec_male_demo.png" -D "scenario=""centec_male_demo""" -D "showtext=true" --colorscheme Tomorrow --enable textmetrics --imgsize 4096,307
2 C:\src\ostat\vacuum-hose-adapter-openscad\demos\vacuum_hose_adapter_demo.scad'
$cmdPath = 'C:\Program Files\OpenSCAD\openscad.exe'
#$result = Start-ProcessWithOutputv1 -Path  $cmdPath -ArgumentList $arguments
$result =  Start-ProcessWithOutputs -commandPath $cmdPath -ArgumentList $arguments 

#$result = Execute-Command -commandPath  $cmdPath -commandArguments $arguments
#$result = Execute-Commandv1 -commandPath  $cmdPath -commandArguments $arguments
#$result = Execute-Commandv2 -commandPath  $cmdPath -commandArguments $arguments
#$result = Execute-Commandv3 -commandPath  $cmdPath -commandArguments $arguments

Write-Output "Standard Output: $($result.stdout)"
Write-Output "Standard Error: $($result.stderr)"
$result |Format-List
write-host "execution done"
