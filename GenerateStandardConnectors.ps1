#version 2022-10-02
$Script:transitionAngles = (0, 30, 45, 90)

$Script:transitionStyles = ("tapered", "sweep")

$Script:ForceRegeneration = $false

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ScadScriptPath = Join-Path $SourceFolder 'vacuum-hose-adapter-modules.scad'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'

$script:inchmm = 25.4

$Script:Hoses = 
@(
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
)

$Script:Nozzels = 
@(
@{
    Scenario = 'nozzle_square_short'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=20;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=40; End2_Nozzle_Square_Depth=7; End2_Nozzle_Radius=2; End2_Nozzle_Length=0;
},
@{
    Scenario = 'nozzle_square_large'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=50;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=70; End2_Nozzle_Square_Depth=50; End2_Nozzle_Radius=10; End2_Nozzle_Length=10;
},
@{
    Scenario = 'nozzle_floorSweep'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=50;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=15; End2_Nozzle_Square_Depth=70; End2_Nozzle_Radius=5; End2_Nozzle_Length=0;
    End2_Nozzle_xOffset = -8; End2_Wall_Thickness=0.4;
},
@{
    Scenario = 'nozzle_square_wide'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=60;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=140; End2_Nozzle_Square_Depth=10; End2_Nozzle_Radius=5; End2_Nozzle_Length=20; End2_Nozzle_Tip_Wall_Thickness=0.8; End2_Nozzle_Chamfer_Percentage=80;  End2_Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_square_long'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=60;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=40; End2_Nozzle_Square_Depth=20; End2_Nozzle_Radius=5; End2_Nozzle_Length=60; End2_Nozzle_Tip_Wall_Thickness=0.8; End2_Nozzle_Chamfer_Percentage=60;  End2_Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_square_thin'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=30;
    End2_Nozzle_Shape='square'; End2_Nozzle_Square_Width=8; End2_Nozzle_Square_Depth=20; End2_Nozzle_Radius=3; End2_Nozzle_Length=90; End2_Nozzle_Tip_Wall_Thickness=0.8; End2_Nozzle_Chamfer_Percentage=60;  End2_Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_round'
    End2_Style='nozzle'; End2_Measurement='inner'; End2_Diameter=25; End2_Length=20;
    End2_Nozzle_Shape='circle'; End2_Nozzle_Radius=5; End2_Nozzle_Length=80; End2_Nozzle_Tip_Wall_Thickness=0.8; End2_Nozzle_Chamfer_Percentage=80;  End2_Nozzle_Chamfer_Angle=25;
};
)

$Script:CustomAdapters = 
@(
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\funnel\');
        Enabled = $false
        Scenario = 'funnel';
        transitionAngles = 0;
        transitionStyles = 'tapered';
        End1 = @{
            End1_Diameter=@(25,30,40,50,60,70,80,90,100,125,150,175,200);
            End1_Style='flange'; End1_Measurement='inner'; End1_Wall_Thickness=1.5; End1_Length=3;
            End1_Flange_Thickness=1.5; End1_Flange_Screw_Count=1; End1_Flange_Screw_Diameter=5; End1_Flange_Width=7; End1_Flange_Screw_Position=10; End1_Flange_Screw_Border=5;
        };
        End2 = @{
            End2_Diameter=@(5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,65,70,85,90,95,100)
            End2_Style='nozzle'; End2_Measurement='inner'; End2_Length=2;  End2_Wall_Thickness=1.5;
            End2_Nozzle_Shape='circle'; End2_Nozzle_Radius=0; End2_Nozzle_Length=30; End2_Nozzle_Tip_Wall_Thickness=0.6; End2_Nozzle_Chamfer_Percentage=100;  End2_Nozzle_Chamfer_Angle=30;
        };
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\funnel_offcenter\');
        Enabled = $true
        Scenario = 'funnel_offcenter';
        transitionAngles = 0;
        transitionStyles = 'tapered';
        End1 = @{
            End1_Diameter=@(25,30,40,50,60,70,80,90,100,125,150,175,200);
            End1_Style='flange'; End1_Measurement='inner'; End1_Wall_Thickness=1.5; End1_Length=3;
            End1_Flange_Thickness=1.5; End1_Flange_Screw_Count=1; End1_Flange_Screw_Diameter=5; End1_Flange_Width=7; End1_Flange_Screw_Position=10; End1_Flange_Screw_Border=5;
        };
        End2 = @{
            End2_Diameter=@(5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,65,70,85,90,95,100)
            End2_Style='nozzle'; End2_Measurement='inner'; End2_Length=2;  End2_Wall_Thickness=1.5;
            End2_Nozzle_Shape='circle'; End2_Nozzle_Radius=0; End2_Nozzle_Length=30; End2_Nozzle_Tip_Wall_Thickness=0.6; End2_Nozzle_Chamfer_Percentage=100;  End2_Nozzle_Chamfer_Angle=30;
        };
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\dyson\nozzle');
        Enabled = $false
        transitionAngles = (0, 30, 45);
        transitionStyles = ('sweep');
        End1 = @{
            Scenario = 'dyson'
            End1_Style='dyson'; End1_Measurement='inner'; End1_Diameter=28.5; End1_Wall_Thickness=2.75; 
        };
        End2 = $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\hose_nozzle');
        Scenario = "hose_nozzle"
        Enabled = $true
        transitionAngles = (0, 30, 45);
        transitionStyles = ('sweep');
        End1 = $Script:Hoses | ForEach-Object {
                $hose = $_
                if($hose['System'] -ieq 'imperial')
                {
                    $hoseSize = $hose['ExternalDiameter'] * $script:inchmm
                    #$hoseUnit = "in($($hoseSize)mm)"
                    $noseUnit = "mm($($hose['ExternalDiameter'])in)"
                }
                else
                {
                    $c1Size = $hose['ExternalDiameter']
                    $noseUnit = "mm"
                }

                return @{
                    Scenario = "$($hoseSize)$($noseUnit)"
                    End1_Style='hose'; End1_Measurement='outer'; End1_Diameter=$hoseSize;
                    End1_Taper=3; End1_StopThickness=4; End1_StopLength=8;
                };
            } 
        End2 = $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\magneticadapter_new\');
        Enabled = $false
        Scenario = 'magneticadapter'
        transitionAngles = (0, 30, 45);
        transitionStyles = ('sweep');
        Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=0.5; Alignment_Side_Clearance=0.25; Alignment_Depth_Clearance=0.75;
        End1 = @{
            Scenario = 'magneticadapter_50mm'
            End1_Style='mag'; End1_Measurement='inner'; End1_Diameter=50; End1_Wall_Thickness=2; End1_Length=15;
            End1_Magnets_Count=8; End1_Magnet_Diameter=10.5; End1_Magnet_Thickness=4; End1_Magnet_Border=3; End1_Magnet_Flange_Thickness=7.5; End1_Ring='recessed'; 
        };
        End2 = $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\magneticadapter_new\');
        Enabled = $false
        Scenario = 'magneticadapter'
        transitionAngles = (0, 30, 45);
        transitionStyles = ('sweep');
        End1 = @{
            Scenario = 'magneticadapter_50mm'
            End1_Style='mag'; End1_Measurement='inner'; End1_Diameter=100; End1_Wall_Thickness=2; End1_Length=15;
            End1_Magnets_Count=12; End1_Magnet_Diameter=10.5; End1_Magnet_Thickness=4; End1_Magnet_Border=3; End1_Magnet_Flange_Thickness=7.5; End1_Ring='recessed'; 
            Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=0.5; Alignment_Side_Clearance=0.25; Alignment_Depth_Clearance=0.75;
        };
        End2 = $Script:Nozzels
    }
    #,@{
    #     targetFolder = (Join-Path $script:SourceFolder 'generated\dyson\custom');
    #     scenario = 'dyson3'
    #     Wall_Thickness = 2;
    #     Draw_Alignment_Ring='no'; Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=.05; Alignment_Side_Clearance=0.25;#[decimal]$Alignment_Side_Clearance=0.75,
    #
    #     End1_Style='dyson'; End1_Measurement='outer'; End1_Diameter=40; End1_Length=20;
    #     End1_Taper=2; End1_StopThickness=0; End1_StopLength=0;
    #     End1_Magnets_Count=0; End1_Magnet_Diameter=0; End1_Magnet_Thickness=0; End1_Magnet_Border=0;
    #     End1_Flange_Thickness=5; End1_Screw_Count=6; End1_Screw_Diameter=5; End1_Flange_Outer_Diameter=0;
    #     
    #     Transition_Style='sweep'; Transition_Length=10; Transition_Bend_Radius=10; Transition_Angle=0;
    #
    #     End2_Style='hose'; End2_Measurement='outer'; End2_Diameter=50; End2_Length=20;
    #     End2_Taper=2; End2_StopThickness=0; End2_StopLength=0;
    #     End2_Magnets_Count=0; End2_Magnet_Diameter=0; End2_Magnet_Thickness=0; End2_Magnet_Border=0; End2_Magnet_Flange_Thickness=0; End2_Ring='recessed'; Nozzle_Chamfer_Percentage=0; End2_Nozzle_Chamfer_Angle=0;
    #}
)

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
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


Function AppendIf{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    [string]$string = '', 
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

Function AddArgs($cmdArgs, $value, $argValue) {
    if (![string]::IsNullOrEmpty($value)) { 
        $cmdArgs += $argValue
    }
    return $cmdArgs
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
        #$args += " -D `"Alignment_Side_Clearance=0.75`""
        $args += " -D `"Alignment_Depth_Clearance=0.75`""
        
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

function CreateDyson {
Param(
    [decimal]$SizeExternalDiameter,
    [string]$Unit,
    [int]$transitionAngle,
    [string]$transitionStyle
)
    $wallThickness = 2

    $c1Length = 10
    $c1Size = 30
    $transitionBendRadius = 10
    
    $c2Length = 20
    $c2Taper = 1

    
    $transLength = [Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($c1Size - $SizeExternalDiameter)), 40),5)

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
        $filename = "Dyson_$($SizeExternalDiameter)$($Unit)_$($displayAngle)"
    }
    else
    {
        $filename = "Dyson_$($SizeExternalDiameter)$($Unit)"
    }
   
    $folder = Join-Path $script:SourceFolder "generated\dyson\$($displayAngle)"
    CreateFolderIfNeeded $folder
   
    $target = Join-Path $folder "$($filename).stl"
    if(!(Test-Path $target) -or $Script:ForceRegeneration)
    {
        Write-Host "Generating $($filename)"

        #invoke openscad
        $args = ""
        $args = "-o `"$($target)`""
        $args += " -D `"Wall_Thickness=$($wallThickness)`""

        $args += " -D `"End1_Style=`"`"dyson`"`"`""
        $args += " -D `"End1_Measurement=`"`"inner`"`"`""
        $args += " -D `"End1_Diameter=$($c1Size)`""
        
        $args += " -D `"Transition_Style=`"`"$($TransitionStyle)`"`"`""
        $args += " -D `"Transition_Length=$($transLength)`""
        $args += " -D `"Transition_Bend_Radius=$($transitionBendRadius)`""
        $args += " -D `"Transition_Angle=$($transitionAngle)`""

        $args += " -D `"End2_Style=`"`"hose`"`"`""
        $args += " -D `"End2_Measurement=`"`"outer`"`"`""
        $args += " -D `"End2_Diameter=$($SizeExternalDiameter)`""
        $args += " -D `"End2_Length=$($c2Length)`""
        $args += " -D `"End2_Taper=$($c2Taper)`""

        $args += " $($script:ScadScriptPath)"
        $executionTime =  $args | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
    
        Write-host "done $executionTime"
    }
    else
    {
        Write-Verbose "Skipping $($filename)"
    }
}

function CreateFlange {
Param(
    [string]$scenario,
    [decimal]$Wall_Thickness = 2,
    [string]$Draw_Alignment_Ring = 'no',
    [decimal]$Alignment_Depth=2,
    [decimal]$Alignment_Upper_Width=2,
    [decimal]$Alignment_Lower_Width=.05,
    [decimal]$Alignment_Side_Clearance=0.25,
    #[decimal]$Alignment_Side_Clearance=0.75,

    [string]$End1_Style,
    [string]$End1_Measurement='outer',
    [decimal]$End1_Diameter=40,
    [decimal]$End1_Length=20,
    [decimal]$End1_Taper=2,
    [decimal]$End1_StopThickness=0,
    [decimal]$End1_StopLength=0,
    [decimal]$End1_Magnets_Count=0,
    [decimal]$End1_Magnet_Diameter=0,
    [decimal]$End1_Magnet_Thickness=0,
    [decimal]$End1_Magnet_Border=0,
    [decimal]$End1_Flange_Thickness=5,
    [decimal]$End1_Screw_Count=6,
    [decimal]$End1_Screw_Diameter=5,
    [decimal]$End1_Flange_Outer_Diameter,
        
    [string]$Transition_Style='sweep',
    [decimal]$Transition_Length=10,
    [decimal]$Transition_Bend_Radius=10,
    [decimal]$Transition_Angle=0,

    [string]$End2_Style='hose',
    [string]$End2_Measurement='outer',
    [decimal]$End2_Diameter=50,
    [decimal]$End2_Length=20,
    [decimal]$End2_Taper=2,
    [decimal]$End2_StopThickness=0,
    [decimal]$End2_StopLength=0,
    [decimal]$End2_Magnets_Count=0,
    [decimal]$End2_Magnet_Diameter=0,
    [decimal]$End2_Magnet_Thickness=0,
    [decimal]$End2_Magnet_Border=0,
    [decimal]$End2_Magnet_Flange_Thickness=0,
    [string]$End2_Ring='recessed'

)

    $FlangeOuter = IIF($End1_Flange_Outer_Diameter -eq 0, $($End1_Diameter+30),$End1_Flange_Outer_Diameter)

    $filename = "$($End1_Style)_$($End2_Style)_$($scenario)"
   
    $targetFolder = Join-Path $script:SourceFolder "generated\flange"
    $folder = $targetFolder
    CreateFolderIfNeeded $folder
   
    $target = Join-Path $folder "$($filename).stl"
    if(!(Test-Path $target) -or $Script:ForceRegeneration)
    {
        Write-Host "Generating flange adapter $($filename)"

        #invoke openscad
        $args = ""
        $args = "-o `"$($target)`""
        $args += " -D `"Wall_Thickness=$($Wall_Thickness)`""
        $args += " -D `"Draw_Alignment_Ring=`"`"$($Draw_Alignment_Ring)`"`"`""
        $args += " -D `"Alignment_Depth=$($Alignment_Depth)`""
        $args += " -D `"Alignment_Upper_Width=$($Alignment_Upper_Width)`""
        $args += " -D `"Alignment_Lower_Width=$($Alignment_Lower_Width)`""
        $args += " -D `"Alignment_Side_Clearance=$($Alignment_Side_Clearance)`""
        $args += " -D `"Alignment_Side_Clearance=$($Alignment_Side_Clearance)`""

        $args += " -D `"End1_Style=`"`"$($End1_Style)`"`"`""
        $args += " -D `"End1_Measurement=`"`"$($End1_Measurement)`"`"`""
        $args += " -D `"End1_Diameter=$($End1_Diameter)`""
        $args += " -D `"End1_Length=$($End1_Length)`""
        $args += " -D `"End1_Taper=$($End1_Taper)`""
        $args += " -D `"End1_StopThickness=$($End1_StopThickness)`""
        $args += " -D `"End1_StopLength=$($End1_StopLength)`""
        $args += " -D `"End1_Magnets_Count=$($End1_Magnets_Count)`""
        $args += " -D `"End1_Magnet_Diameter=$($End1_Magnet_Diameter)`""
        $args += " -D `"End1_Magnet_Thickness=$($End1_Magnet_Thickness)`""
        $args += " -D `"End1_Magnet_Border=$($End1_Magnet_Border)`""
        $args += " -D `"End1_Flange_Thickness=$($End1_Flange_Thickness)`""
        $args += " -D `"End1_Screw_Count=$($End1_Screw_Count)`""
        $args += " -D `"End1_Screw_Diameter=$($End1_Screw_Diameter)`""
        $args += " -D `"End1_Flange_Outer_Diameter=$($End1_Flange_Outer_Diameter)`""
        
        $args += " -D `"Transition_Style=`"`"$($Transition_Style)`"`"`""
        $args += " -D `"Transition_Length=$($Transition_Length)`""
        $args += " -D `"Transition_Bend_Radius=$($Transition_Bend_Radius)`""
        $args += " -D `"Transition_Angle=$($Transition_Angle)`""

        $args += " -D `"End2_Style=`"`"$($End2_Style)`"`"`""
        $args += " -D `"End2_Measurement=`"`"$($End2_Measurement)`"`"`""
        $args += " -D `"End2_Diameter=$($End2_Diameter)`""
        $args += " -D `"End2_Length=$($End2_Length)`""
        $args += " -D `"End2_Taper=$($End2_Taper)`""
        $args += " -D `"End2_StopThickness=$($End2_StopThickness)`""
        $args += " -D `"End2_StopLength=$($End2_StopLength)`""
        $args += " -D `"End2_Magnets_Count=$($End2_Magnets_Count)`""
        $args += " -D `"End2_Magnet_Diameter=$($End2_Magnet_Diameter)`""
        $args += " -D `"End2_Magnet_Thickness=$($End2_Magnet_Thickness)`""
        $args += " -D `"End2_Magnet_Border=$($End2_Magnet_Border)`""
        $args += " -D `"End2_Magnet_Flange_Thickness=$($End2_Magnet_Flange_Thickness)`""
        $args += " -D `"End2_Ring=`"`"$($End2_Ring)`"`"`""

        $args += " $($script:ScadScriptPath)"
        $executionTime =  $args | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
    
        Write-host "done $executionTime"
    }
    else
    {
        Write-Verbose "Skipping $($filename)"
    }
}

#disabled
$Script:transitionStyles | Where-Object {$true -eq $false} | ForEach-Object { 
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
                if($transitionStyle -ine 'sweep')
                {
                    CreateFlange -SizeExternalDiameter $c1Size -Unit $c1Unit  -transitionAngle $transitionAngle -transitionStyle $transitionStyle
                }

                if($c1Size -lt 55 -and  $transitionAngle -lt 46)
                {
                    CreateDyson -SizeExternalDiameter $c1Size -Unit $c1Unit  -transitionAngle $transitionAngle -transitionStyle $transitionStyle
                }
            }
        }
    }
}

$Script:CustomAdapters | Where-Object {$_.Enabled -eq $true }|  ForEach-Object {
    $adapter = $_
    Write-Verbose "Adapter $($adapter.Scenario)"
$adapter.End1 | ForEach-Object {
    $End1 = $_
    Write-Verbose "End1 $($End1.Scenario)"
$adapter.End2 | ForEach-Object {
    $End2 = $_
    Write-Verbose "End2 $($End2.Scenario)"
$adapter.transitionStyles | ForEach-Object { 
    $transitionStyle = $_
    Write-Verbose "transitionStyle $($transitionStyle) | Adapter $($adapter.Scenario)"
$adapter.transitionAngles | ForEach-Object { 
    $transitionAngle = [decimal]$_
    Write-Verbose "transitionAngle $($transitionAngle) | transitionStyle $($transitionStyle) | Adapter $($adapter.Scenario)"
$End1.End1_Diameter | ForEach-Object { 
    $end1_Diameter = [decimal]$_
    Write-Verbose "End1_Diameter $($End1.End1_Diameter) | transitionAngle $($transitionAngle) | transitionStyle $($transitionStyle) | Adapter $($adapter.Scenario)"
$End2.End2_Diameter | ForEach-Object { 
    $end2_Diameter = [decimal]$_
    Write-Host "End2_Diameter $($end2_Diameter) | End1_Diameter $($end1_Diameter) | transitionAngle $($transitionAngle) | transitionStyle $($transitionStyle) | Adapter $($adapter.Scenario)"

    # Sweep at 0deg should be tapered
    $tranStyle = (IIF -If ($transitionStyle -ieq 'sweep' -and $transitionAngle -eq 0) -Right 'tapered' -Wrong $transitionStyle)
    Write-Host "transitionStyle $($tranStyle) | transitionAngle $($transitionAngle)"
    
    $modelDescription = (($transitionAngle -eq 0) | IIf -Right '' -Wrong (($tranStyle -eq "sweep") | IIf -Right "$($transitionAngle)degsweep" -Wrong "$($transitionAngle)deg"))
    $folder = $adapter.Folder
       
    if($End2.End2_Nozzle_Shape -eq 'nozzle' -and $End2.End2_Nozzle_Chamfer_Angle -eq 0 -and $End2.Nozzle_Chamfer_Percentage -gt 0 ){
        $End2.End2_Nozzle_Chamfer_Angle -eq $transitionAngle;
    }

    $scenario = (AppendIf -value $adapter.Scenario | AppendIf -value $End1.Scenario | AppendIf -value $End2.Scenario)

    
    $transLength = IIF $adapter.Transition_Length -gt 0 `
        -Right $adapter.Transition_Length `
        -Wrong ([Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($End1.End1_Diameter - $c2Size)), 40),5))
     
    if($adapter.Scenario -eq 'hose_nozle'){
        $folder = Join-Path $folder "$($End2.Scenario)"
    }

    if($adapter.Scenario -eq 'funnel' -or $adapter.Scenario -eq 'funnel_offcenter'){
        Write-Verbose 'setting Funnel settings'
        if($end2_Diameter -ge $end1_Diameter/2 -or $end2_Diameter -le $end1_Diameter/8)
        {
            Write-Verbose "Skipping Funnel End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }

        #Give the cone a 45deg
        $transLength = [Math]::Min([Math]::Max([Math]::Ceiling([Math]::Abs($end1_Diameter - $end2_Diameter)),5),100)
        $End1.End1_Flange_Outer_Diameter = $end1_Diameter + 20
        $End2.End2_Nozzle_Radius = $end2_Diameter/2
        $End2.End2_Nozzle_Length = [Math]::Min([Math]::Min($end1_Diameter, $transLength + $end2_Diameter), 180 - $transLength)

        if($scenario -eq 'funnel_offcenter'){
            $adapter.Transition_xOffset = ($end1_Diameter - $end2_Diameter)/-2;
        }

        $modelDescription = "$($end1_Diameter)mm_to_$($end2_Diameter)mm"
        $folder = Join-Path $adapter.Folder "$($end1_Diameter)mm"
    }    

    if($adapter.Scenario -eq 'magneticadapter'){
            #End1_Style='mag'; End1_Measurement='inner'; End1_Diameter=50; End1_Wall_Thickness=2; End1_Length=15;
            #End1_Magnets_Count=8; End1_Magnet_Diameter=10.5; End1_Magnet_Thickness=4; End1_Magnet_Border=3; End1_Magnet_Flange_Thickness=7.5; End1_Ring='recessed'; 

        $c2Size = 40
        $c2Unit = 'metric'
        $transLength = [Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($End1.End1_Diameter - $c2Size)), 40),5)
        

        $filename = "$($end1_Diameter)mm_$($End1.End1_MagentCount)Magnets_$($End1.End1_MagentDiameter-0.5)x$($End1.End1_Magnet_Thickness-1)mm_to_$($c2Size)$($c2Unit)_transition$($transLength)mm"
        $folder = Join-Path $folder "$($end1_Diameter)mm\$($modelDescription)"
    }


    $filename = ($scenario | AppendIf -value $modelDescription)

    #$targetFolder Join-Path $script:SourceFolder "generated\flange"
    CreateFolderIfNeeded $folder
   
    $target = Join-Path $folder "$($filename).stl"
    if((Test-Path $target) -and !$Script:ForceRegeneration)
    {
        Write-Verbose "Skipping $($filename)"
        return 
    }

    Write-Host "Generating generic adapter $($filename)"

    #invoke openscad
    $cmdArgs = ""
    $cmdArgs = "-o `"$($target)`""

    $cmdArgs = AddArgs $cmdArgs $adapter.Wall_Thickness " -D `"Wall_Thickness=$($adapter.Wall_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Draw_Alignment_Ring " -D `"Draw_Alignment_Ring=`"`"$($adapter.Draw_Alignment_Ring)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Alignment_Depth " -D `"Alignment_Depth=$($adapter.Alignment_Depth)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Alignment_Upper_Width " -D `"Alignment_Upper_Width=$($adapter.Alignment_Upper_Width)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Alignment_Lower_Width " -D `"Alignment_Lower_Width=$($adapter.Alignment_Lower_Width)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Alignment_Side_Clearance " -D `"Alignment_Side_Clearance=$($adapter.Alignment_Side_Clearance)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Alignment_Side_Clearance " -D `"Alignment_Side_Clearance=$($adapter.Alignment_Side_Clearance)`""

    $cmdArgs = AddArgs $cmdArgs $End1.End1_Style " -D `"End1_Style=`"`"$($End1.End1_Style)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Wall_Thickness " -D `"End1_Wall_Thickness=$($End1.End1_Wall_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Measurement " -D `"End1_Measurement=`"`"$($End1.End1_Measurement)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $end1_Diameter " -D `"End1_Diameter=$($end1_Diameter)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Length " -D `"End1_Length=$($End1.End1_Length)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Taper " -D `"End1_Taper=$($End1.End1_Taper)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_StopThickness " -D `"End1_StopThickness=$($End1.End1_StopThickness)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_StopLength " -D `"End1_StopLength=$($End1.End1_StopLength)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Magnets_Count " -D `"End1_Magnets_Count=$($End1.End1_Magnets_Count)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Magnet_Diameter " -D `"End1_Magnet_Diameter=$($End1.End1_Magnet_Diameter)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Magnet_Thickness " -D `"End1_Magnet_Thickness=$($End1.End1_Magnet_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Magnet_Border " -D `"End1_Magnet_Border=$($End1.End1_Magnet_Border)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Flange_Thickness " -D `"End1_Flange_Thickness=$($End1.End1_Flange_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Flange_Screw_Count " -D `"End1_Flange_Screw_Count=$($End1.End1_Flange_Screw_Count)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Flange_Screw_Diameter " -D `"End1_Flange_Screw_Diameter=$($End1.End1_Flange_Screw_Diameter)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Flange_Screw_Position " -D `"End1_Flange_Screw_Position=$($End1.End1_Flange_Screw_Position)`""
    $cmdArgs = AddArgs $cmdArgs $End1.End1_Flange_Width " -D `"End1_Flange_Width=$($End1.End1_Flange_Width)`""

    $cmdArgs = AddArgs $cmdArgs $tranStyle " -D `"Transition_Style=`"`"$($tranStyle)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $transLength " -D `"Transition_Length=$($transLength)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Transition_Bend_Radius " -D `"Transition_Bend_Radius=$($adapter.Transition_Bend_Radius)`""
    $cmdArgs = AddArgs $cmdArgs $transitionAngle " -D `"Transition_Angle=$($transitionAngle)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Transition_xOffset " -D `"Transition_xOffset=$($adapter.Transition_xOffset)`""
    $cmdArgs = AddArgs $cmdArgs $adapter.Transition_yOffset " -D `"Transition_yOffset=$($adapter.Transition_yOffset)`""
    
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Style " -D `"End2_Style=`"`"$($End2.End2_Style)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Wall_Thickness " -D `"End2_Wall_Thickness=$($End2.End2_Wall_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Measurement " -D `"End2_Measurement=`"`"$($End2.End2_Measurement)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $end2_Diameter " -D `"End2_Diameter=$($end2_Diameter)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Length " -D `"End2_Length=$($End2.End2_Length)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Taper " -D `"End2_Taper=$($End2.End2_Taper)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_StopThickness " -D `"End2_StopThickness=$($End2.End2_StopThickness)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_StopLength " -D `"End2_StopLength=$($End2.End2_StopLength)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Magnets_Count " -D `"End2_Magnets_Count=$($End2.End2_Magnets_Count)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Magnet_Diameter " -D `"End2_Magnet_Diameter=$($End2.End2_Magnet_Diameter)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Magnet_Thickness " -D `"End2_Magnet_Thickness=$($End2.End2_Magnet_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Magnet_Border " -D `"End2_Magnet_Border=$($End2.End2_Magnet_Border)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Magnet_Flange_Thickness " -D `"End2_Magnet_Flange_Thickness=$($End2.End2_Magnet_Flange_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Ring " -D `"End2_Ring=`"`"$($End2.End2_Ring)`"`"`""

    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Shape " -D `"End2_Nozzle_Shape=`"`"$($End2.End2_Nozzle_Shape)`"`"`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Square_Width " -D `"End2_Nozzle_Square_Width=$($End2.End2_Nozzle_Square_Width)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Square_Depth " -D `"End2_Nozzle_Square_Depth=$($End2.End2_Nozzle_Square_Depth)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Tip_Wall_Thickness " -D `"End2_Nozzle_Tip_Wall_Thickness=$($End2.End2_Nozzle_Tip_Wall_Thickness)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Radius " -D `"End2_Nozzle_Radius=$($End2.End2_Nozzle_Radius)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Length " -D `"End2_Nozzle_Length=$($End2.End2_Nozzle_Length)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_xOffset " -D `"End2_Nozzle_xOffset=$($End2.End2_Nozzle_xOffset)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_yOffset " -D `"End2_Nozzle_yOffset=$($End2.End2_Nozzle_yOffset)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Chamfer_Percentage " -D `"End2_Nozzle_Chamfer_Percentage=$($End2.End2_Nozzle_Chamfer_Percentage)`""
    $cmdArgs = AddArgs $cmdArgs $End2.End2_Nozzle_Chamfer_Angle " -D `"End2_Nozzle_Chamfer_Angle=$($End2.End2_Nozzle_Chamfer_Angle)`""
 
    $cmdArgs += " $($script:ScadScriptPath)"
    Write-Host  $cmdArgs
    $executionTime =  $cmdArgs | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
    
    Write-host "done $executionTime" 
}}}}}}}