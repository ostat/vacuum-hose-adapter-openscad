
$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName
$workingFolder = (Split-Path -Parent $PSCommandPath)
$outputFolder = Join-Path $script:SourceFolder 'generated\demos'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe'

$script:ScenarioFilter = 'transitionext'
$renderOptions = @('text') #@('png','text','stl')

echo $outputFolder

function Create-Gifs($ParentFolderPath){ 
    Get-ChildItem -LiteralPath $ParentFolderPath -Directory | ForEach-Object{
        $folder = $_
        Create-Gif $folder.FullName "$($folder.Parent.Name)-$($folder.Name)"
    }
}

function Create-Gif($FolderPath, $Name) 
{
    cd $FolderPath
    & $script:ImageMagickPath convert '*.png' -set delay 100 "$($Name).gif"
    #convert 'frame_*.png' -set delay 1x15 animation.gif 
}

Function AddArgs($cmdArgs, $value, $argValue) {
    if (![string]::IsNullOrEmpty($value)) { 
        $cmdArgs += $argValue
    }
    return $cmdArgs
}

Function IIF{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    [bool]$If,
    $Right, 
    $Wrong)
    if ($If) { return $Right } else { return $Wrong }
}

Function AppendIfTrue{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    [string]$string = '', 
    [bool]$condition = $true,
    [string]$value, 
    [string]$seperater = '_')

    if([string]::IsNullOrEmpty($string)){
        return $value
    }
    if (![string]::IsNullOrEmpty($value)) { 
        return "$string$seperater$value"
    }
    return $string
}

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}


Class Scenario{
    [string]$ScenarioName
    [string]$ScenarioNameFriendly
    [int]$Count
}


function Create-ImageForDemo(
    [string]$ScadScriptPath,
    [string]$outputFolder,
    [bool]$SetFilePath = $true,
    [string]$ScenarioFilter = '',
    $renderOptions = @('png','text','stl')
    ){

    $Scenarios = New-Object System.Collections.ArrayList

    $scriptFile =  Get-Item -LiteralPath $scadScriptPath
    
    $demoName = $scriptFile.BaseName.Replace('_demo','')
    $demoOutputFolder = Join-Path $outputFolder "$($demoName)"
    Write-Host "Create-ImageForDemo : $($ScenarioNameFriendly) : $($demoName)`r`n`t$($ScadScriptPath)`r`n`t$($demoOutputFolder)" -ForegroundColor Yellow
 
    foreach($line in Get-Content $scadScriptPath) {
        if($line -match 'scenario\s?==\s?"(?<secenario>.*?)"\s?\?\s?\[\["(?<secenariofriendly>.*?)"\,\s?(?<count>\d*)'){
        
            $scenario = New-Object Scenario
            $scenario.ScenarioName = $Matches['secenario']
            $scenario.ScenarioNameFriendly = $Matches['secenariofriendly']
            $scenario.Count = $Matches['count']/1 #hack to convert to int

            $Scenarios.Add($scenario) | Out-Null
        }
    }

    $Scenarios | Where-Object{[string]::IsNullOrEmpty($ScenarioFilter) -or $_.ScenarioName -match $ScenarioFilter -or $demoName -eq $ScenarioFilter} | ForEach-Object {
      $scenario = $_
      Write-Host "scenario - $($scenario.ScenarioName)" -ForegroundColor Green
        
      $renderOptions | ForEach-Object {
        $option = $_
        $showtext = ($option -eq 'text')
        $scenarioName =  "$($scenario.ScenarioName)_$($option)"
        $scenarioOutputFolder = Join-Path $demoOutputFolder "$($option)\$($scenarioName)"
        
        Write-Host "scenario $($option) - $($scenarioName)`r`n`t$($scenarioOutputFolder)" -ForegroundColor Green
     

        CreateFolderIfNeeded $scenarioOutputFolder

        #invoke openscad
        $cmdArgs = "" 
        
        $target = Join-Path $scenarioOutputFolder "$($scenario.ScenarioName).$((IIF -If ($option -eq 'stl')  -Right 'stl' -Wrong 'png'))"
        if($SetFilePath)
        {
            $cmdArgs = "-o `"$($target)`""
            #--camera=translatex,y,z,rotx,y,z,dist
        }

        $cmdArgs += " -D `"scenario=`"`"$($scenario.ScenarioName)`"`"`""
        $cmdArgs += " -D `"showtext=$($showtext.ToString().tolower())`""
        $cmdArgs += " --colorscheme Tomorrow" #BeforeDawn
        $cmdArgs += " --enable textmetrics"
        $cmdArgs += " --imgsize 4096,3072"#" --imgsize 1024,768"4096,3072
        if($scenario.Count -gt 1)
        {
            $cmdArgs += " --animate $($scenario.Count)"
        }
        
        $cmdArgs += " $($scadScriptPath)"
        Write-Host  $cmdArgs
        $executionTime =  $cmdArgs | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
        
        if($option -ne 'stl' -and $scenario.Count -gt 1)
        {
            Create-Gif -FolderPath $scenarioOutputFolder -Name "$($demoName)-$($scenarioName)"
        }
      }
    }
}

Create-ImageForDemo -ScadScriptPath  (Join-Path $workingFolder 'vacuum_hose_adapter_demo.scad') -outputFolder $outputFolder  -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions