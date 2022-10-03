#version 2022-10-02
$Script:transitionAngles = (0, 30, 45, 90)
#$Script:transitionAngles = (90)

$Script:transitionStyles = ("tapered", "sweep")

$Script:ForceRegeneration = $false

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ScadScriptPath = Join-Path $SourceFolder 'vacuum-hose-adapter-openscad.scad'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'

$script:inchmm = 25.4

$Script:Hoses = 
    @{
        System = 'imperial';
        ExternalDiameter = 1
    },
    @{
        System = 'imperial';
        ExternalDiameter = 1.25
    },
    @{
        System = 'imperial';
        ExternalDiameter = 1+3/8
    },
    @{
        System = 'imperial';
        ExternalDiameter = 1+7/16
    },
    @{
        System = 'imperial';
        ExternalDiameter = 1.5
    },
    @{
        System = 'imperial';
        ExternalDiameter = 2
    },
    @{
        System = 'imperial';
        ExternalDiameter = 2.5
    },
    @{
        System = 'imperial';
        ExternalDiameter = 3
    },
    @{
        System = 'imperial';
        ExternalDiameter = 3.5
    },
    @{
        System = 'imperial';
        ExternalDiameter = 4
    },
    @{
        System = 'imperial';
        ExternalDiameter = 4.5
    },
    @{
        System = 'metric';
        ExternalDiameter = 32
    },
    @{
        System = 'metric';
        ExternalDiameter = 35
    },
    @{
        System = 'metric';
        ExternalDiameter = 38
    },
    @{
        System = 'metric';
        ExternalDiameter = 40
    },
    @{
        System = 'metric';
        ExternalDiameter = 50
    },
    @{
        System = 'metric';
        ExternalDiameter = 60
    },
    @{
        System = 'metric';
        ExternalDiameter = 100
    }

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}

function CreateAdapter {
Param(
    $c1Size,
    $c2Size,
    [string]$c1ExternalDiameter,
    [string]$c2ExternalDiameter,
    [string]$c1Unit,
    [string]$c2Unit,
    [int]$transitionAngle,
    [string]$transitionStyle
)
    $connectorLength = 40
    $connectorTaper = 3
    $wallThickness = 2
    
    $transitionBendRadius = 10
   
    $transLength = [Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($c1Size - $c2Size)), 40),5)
    
    
    if($c1Size -gt $c2Size)
    {
        $connector1StopThickness = 4;
        $connector1StopLength = 8;
        $connector2StopThickness = 0;
        $connector2StopLength = 0;
    }
    else
    {
        $connector1StopThickness = 0;
        $connector1StopLength = 0;
        $connector2StopThickness = 4;
        $connector2StopLength = 8;
    }
    
    
    if($TransitionStyle -eq "sweep")
    {
        $displayAngle = "$($transitionAngle)degsweep"
    }
    else
    {
        $displayAngle = "$($transitionAngle)deg"
    }

    if($transitionAngle -gt 0)
    {
        $filename = "$($c1Size)$($c1Unit)_to_$($c2Size)$($c2Unit)_transition$($transLength)mm_$($displayAngle)"
    }
    else
    {
        $filename = "$($c1Size)$($c1Unit)_to_$($c2Size)$($c2Unit)_transition$($transLength)mm"
    }
    
    $folder = Join-Path $script:SourceFolder "generated\HoseAdapter\$($displayAngle)\$($c1Size)$($c1Unit)"
    

    CreateFolderIfNeeded $folder
   
    $target = Join-Path $folder "$($filename).stl"

    if(!(Test-Path $target) -or $Script:ForceRegeneration)
    {
        Write-Host "Generating Adapter $($filename)"
        #invoke openscad
        $args = ""
        $args = "-o `"$($target)`""
        $args += " -D `"Wall_Thickness=$($wallThickness)`""
        $args += " -D `"Draw_Alignment_Ring=`"`"no`"`"`""
        $args += " -D `"Alignment_Depth=2`""
        $args += " -D `"Alignment_Upper_Width=2`""
        $args += " -D `"Alignment_Lower_Width=0.5`""
        $args += " -D `"Alignment_Side_Clearance=0.25`""
        $args += " -D `"Alignment_Side_Clearance=0.75`""

        $args += " -D `"End1_Style=`"`"hose`"`"`""
        $args += " -D `"End1_Measurement=`"`"outer`"`"`""
        $args += " -D `"End1_Diameter=$($c1Size)`""
        $args += " -D `"End1_Length=$($connectorLength)`""
        $args += " -D `"End1_Taper=$($connectorTaper)`""
        $args += " -D `"End1_StopThickness=$($connector1StopThickness)`""
        $args += " -D `"End1_StopLength=$($connector1StopLength)`""
        $args += " -D `"End1_Magnets_Count=0`""
        $args += " -D `"End1_Magnet_Diameter=0`""
        $args += " -D `"End1_Magnet_Thickness=0`""
        $args += " -D `"End1_Magnet_Border=0`""
        $args += " -D `"End1_Magnet_Flange_Thickness=0`""
        $args += " -D `"End1_Ring=`"`"recessed`"`"`""

        $args += " -D `"Transition_Style=`"`"$($TransitionStyle)`"`"`""
        $args += " -D `"Transition_Length=$($transLength)`""
        $args += " -D `"Transition_Bend_Radius=$($transitionBendRadius)`""
        $args += " -D `"Transition_Angle=$($transitionAngle)`""

        $args += " -D `"End2_Style=`"`"hose`"`"`""
        $args += " -D `"End2_Measurement=`"`"outer`"`"`""
        $args += " -D `"End2_Diameter=$($c2Size)`""
        $args += " -D `"End2_Length=$($connectorLength)`""
        $args += " -D `"End2_Taper=$($connectorTaper)`""
        $args += " -D `"End2_StopThickness=$($connector2StopThickness)`""
        $args += " -D `"End2_StopLength=$($connector2StopLength)`""
        $args += " -D `"End2_Magnets_Count=0`""
        $args += " -D `"End2_Magnet_Diameter=0`""
        $args += " -D `"End2_Magnet_Thickness=0`""
        $args += " -D `"End2_Magnet_Border=0`""
        $args += " -D `"End2_Magnet_Flange_Thickness=0`""
        $args += " -D `"End2_Ring=`"`"recessed`"`"`""

        $args += " $($script:ScadScriptPath)"
        $output
        $executionTime =  $args | Measure-Command { 
            write-host 'starting'
            Start-Process $script:ScadExePath -ArgumentList $_ -wait | Tee-Object -Variable output
            Write-Host   $output
            }
        Write-host "done $executionTime"
    }
    else
    {
        Write-Verbose "Skipping $($filename)"
    }
}

function CreateMagneticAdapter {
Param(
    $c1Size,
    $c2Size,
    [string]$c2ExternalDiameter,
    [string]$c2Unit,
    [int]$MagentCount,
    [int]$transitionAngle,
    [string]$transitionStyle
)
    $connectorLength = 40
    $connectorTaper = 3
    $wallThickness = 2

    $MagentDiameter = 10.5
    $MagentThickness = 4
    $MagentBorder = 3
            
    $FlangeThickness = 7.5
    $transitionBendRadius = 10


    $transLength = [Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($c1Size - $c2Size)), 40),5)
        
    if($TransitionStyle -eq "sweep")
    {
        $displayAngle = "$($transitionAngle)degsweep"
    }
    else
    {
        $displayAngle = "$($transitionAngle)deg"
    }


    if($transitionAngle -gt 0)
    {
        $filename = "$($c1Size)mm_$($MagentCount)Magnets_$($MagentDiameter-0.5)x$($MagentThickness-1)mm_to_$($c2Size)$($c2Unit)_transition$($transLength)mm_$($displayAngle)"
    }
    else
    {
        $filename = "$($c1Size)mm_$($MagentCount)Magnets_$($MagentDiameter-0.5)x$($MagentThickness-1)mm_to_$($c2Size)$($c2Unit)_transition$($transLength)mm"
    }
   
    $folder = Join-Path $script:SourceFolder "generated\magneticadapter\$($c1Size)mm\$($displayAngle)"
    CreateFolderIfNeeded $folder
   
    $target = Join-Path $folder "$($filename).stl"
    if(!(Test-Path $target) -or $Script:ForceRegeneration)
    {
        Write-Host "Generating magnetic $($filename)"

        #invoke openscad
        $args = ""
        $args = "-o `"$($target)`""
        $args += " -D `"Wall_Thickness=$($wallThickness)`""
        $args += " -D `"Draw_Alignment_Ring=`"`"no`"`"`""
        $args += " -D `"Alignment_Depth=2`""
        $args += " -D `"Alignment_Upper_Width=2`""
        $args += " -D `"Alignment_Lower_Width=0.5`""
        $args += " -D `"Alignment_Side_Clearance=0.25`""
        $args += " -D `"Alignment_Side_Clearance=0.75`""

        $args += " -D `"End1_Style=`"`"mag`"`"`""
        $args += " -D `"End1_Measurement=`"`"inner`"`"`""
        $args += " -D `"End1_Diameter=$($c1Size)`""
        $args += " -D `"End1_Length=15`""
        $args += " -D `"End1_Taper=0`""
        $args += " -D `"End1_StopThickness=0`""
        $args += " -D `"End1_StopLength=0`""
        $args += " -D `"End1_Magnets_Count=$MagentCount`""
        $args += " -D `"End1_Magnet_Diameter=$MagentDiameter`""
        $args += " -D `"End1_Magnet_Thickness=$MagentThickness`""
        $args += " -D `"End1_Magnet_Border=$MagentBorder`""
        $args += " -D `"End1_Magnet_Flange_Thickness=$FlangeThickness`""
        $args += " -D `"End1_Ring=`"`"recessed`"`"`""

        $args += " -D `"Transition_Style=`"`"$($TransitionStyle)`"`"`""
        $args += " -D `"Transition_Length=$($transLength)`""
        $args += " -D `"Transition_Bend_Radius=$($transitionBendRadius)`""
        $args += " -D `"Transition_Angle=$($transitionAngle)`""

        $args += " -D `"End2_Style=`"`"hose`"`"`""
        $args += " -D `"End2_Measurement=`"`"outer`"`"`""
        $args += " -D `"End2_Diameter=$($c2Size)`""
        $args += " -D `"End2_Length=$($connectorLength)`""
        $args += " -D `"End2_Taper=$($connectorTaper)`""
        $args += " -D `"End2_StopThickness=0`""
        $args += " -D `"End2_StopLength=0`""
        $args += " -D `"End2_Magnets_Count=0`""
        $args += " -D `"End2_Magnet_Diameter=0`""
        $args += " -D `"End2_Magnet_Thickness=0`""
        $args += " -D `"End2_Magnet_Border=0`""
        $args += " -D `"End2_Magnet_Flange_Thickness=0`""
        $args += " -D `"End2_Ring=`"`"recessed`"`"`""

        $args += " $($script:ScadScriptPath)"
        $executionTime =  $args | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
    
        Write-host "done $executionTime"
    }
    else
    {
        Write-Verbose "Skipping $($filename)"
    }
}
$Script:transitionStyles | ForEach-Object { 
    $transitionStyle = $_
    $Script:transitionAngles | ForEach-Object { 
        $transitionAngle = $_
        if($transitionStyle -ieq 'sweep' -and $transitionAngle -eq 0)
        {
            Write-Verbose "Skipping as sweep 0 is not valid, transitionStyle: $transitionStyle transitionAngle: $transitionAngle"
        }
        else
        {
            Write-Host "transitionStyle $($transitionStyle) | transitionAngle $($transitionAngle) "
            $Script:Hoses.GetEnumerator() | ForEach-Object { 
                $c1 = $_
                if($c1['System'] -ieq 'imperial')
                {
                    $c1Size = $c1['ExternalDiameter'] * $script:inchmm
                    $c1Unit = "in($($c1Size)mm)"
                    $c1Unit = "mm($($c1['ExternalDiameter'])in)"
                }
                else
                {
                    $c1Size = $c1['ExternalDiameter']
                    $c1Unit = "mm"
                }


                $Hoses.GetEnumerator() | ForEach-Object { 
                    $c2 = $_
                    if($c2['System'] -ieq 'imperial')
                    {
                        $c2Size = $c2['ExternalDiameter'] * $script:inchmm
                        $c2Unit = "mm($($c2['ExternalDiameter'])in)"
                    }
                    else
                    {
                        $c2Size = $c2['ExternalDiameter']
                        $c2Unit = "mm"
                    }
     
                    if($c1Size -gt $c2Size -or ($c1Size -ne $c2Size -and $transitionAngle -gt 0))
                    {
                        # Creates hose adapter from c1 to c2
                        CreateAdapter -c1Size $c1Size -c1ExternalDiamete $c1['ExternalDiameter'] -c1Unit $c1Unit `
                                      -c2Size $c2Size -c2ExternalDiamete $c2['ExternalDiameter'] -c2Unit $c2Unit `
                                      -transitionAngle $transitionAngle -transitionStyle $transitionStyle
                    }
                } 

                # Creates 50mm Magentic adapter to c1
                CreateMagneticAdapter -c1Size 50 -MagentCount 8 -c2Size $c1Size -c2ExternalDiamete $c1['ExternalDiameter'] -c2Unit $c1Unit -transitionAngle $transitionAngle -transitionStyle $transitionStyle
                # Creates 100mm Magentic adapter to c1
                CreateMagneticAdapter -c1Size 100 -MagentCount 12 -c2Size $c1Size -c2ExternalDiamete $c1['ExternalDiameter'] -c2Unit $c1Unit -transitionAngle $transitionAngle -transitionStyle $transitionStyle
            }
        }
    }
}
