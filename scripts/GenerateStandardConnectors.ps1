#version 2023-01-16
$Script:ForceRegeneration = $false

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ScadScriptPath = Join-Path $SourceFolder 'vacuum-hose-adapter-openscad.scad'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'

$script:inchmm = 25.4
$script:maxHeight = 210 - 5 #subtract 5 for buffer

$SetFilePath = $true

$VerbosePreference = 'SilentlyContinue'

$Script:VacuumHoseSizes =
@(
    @{System = 'imperial';   Name = '1in';            Diameter = 1       },
    @{System = 'imperial';   Name = '1.25in';         Diameter = 1.25    },
   #@{System = 'imperial';   Name = '1+3_8in';        Diameter = 1+3/8   },
    @{System = 'imperial';   Name = '1+7_16in';       Diameter = 1+7/16  },
    @{System = 'imperial';   Name = '1.5in';          Diameter = 1.5     },
    @{System = 'imperial';   Name = '1+7_8in';        Diameter = 1+7/8   },
    @{System = 'imperial';   Name = '2in';            Diameter = 2       },
    @{System = 'imperial';   Name = '2.25in';         Diameter = 2.25    },
    @{System = 'imperial';   Name = '2.5in';          Diameter = 2.5     },
    @{System = 'imperial';   Name = '3in';            Diameter = 3       },
    @{System = 'imperial';   Name = '3.5in';          Diameter = 3.5     },
    @{System = 'imperial';   Name = '4in';            Diameter = 4       },
    @{System = 'imperial';   Name = '4.5in';          Diameter = 4.5     },
    @{System = 'imperial';   Name = '5in';            Diameter = 5       },
    @{System = 'imperial';   Name = '6in';            Diameter = 6       },
   #@{System = 'metric';     Name = '32mm';           Diameter = 32      },
    @{System = 'metric';     Name = '35mm(1+3_8in)';  Diameter = 35      },
   #@{System = 'metric';     Name = '38mm';           Diameter = 38      },
    @{System = 'metric';     Name = '40mm';           Diameter = 40      },
    @{System = 'metric';     Name = '50mm';           Diameter = 50      },
    @{System = 'metric';     Name = '60mm';           Diameter = 60      },
    @{System = 'metric';     Name = '100mm';          Diameter = 100     },
    @{System = 'metric';     Name = '120mm';          Diameter = 120     },
    @{System = 'metric';     Name = '125mm';          Diameter = 125     },
    @{System = 'metric';     Name = '150mm';          Diameter = 150     }
)
$Script:VacuumHosesExternal = $Script:VacuumHoseSizes | ForEach-Object {
    $hose = $_
    if($hose['System'] -ieq 'imperial')
    {
        $hoseSize = $hose['Diameter'] * $script:inchmm
        #$hoseUnit = "in($($hoseSize)mm)"
        $hoseUnit = "mm($($hose['Name']))"
    }
    else
    {
        $hoseSize = $hose['Diameter']
        $hoseUnit = "mm"
    }

    return @{
        Scenario = "$($hoseSize)$($hoseUnit)-OD-len40mm"; Type='VacuumHose';
        Style='hose'; Measurement='outer'; Diameter=$hoseSize; Length=40;
        Taper=3; StopThickness=4; StopLength=8;
    };
}
$Script:VacuumHosesInternal = $Script:VacuumHoseSizes | ForEach-Object {
    $hose = $_
    if($hose['System'] -ieq 'imperial')
    {
        $hoseSize = $hose['Diameter'] * $script:inchmm
        #$hoseUnit = "in($($hoseSize)mm)"
        $hoseUnit = "mm($($hose['Name']))"
    }
    else
    {
        $hoseSize = $hose['Diameter']
        $hoseUnit = "mm"
    }
    return @{
        Scenario = "$($hoseSize)$($hoseUnit)-ID-len40mm"; Type='VacuumHose';
        Style='hose'; Measurement='inner'; Diameter=$hoseSize; Length=40;
        Taper=-2;
    };
}
$Script:VacuumHosesInternalShort = $Script:VacuumHoseSizes | ForEach-Object {
    $hose = $_
    if($hose['System'] -ieq 'imperial')
    {
        $hoseSize = $hose['Diameter'] * $script:inchmm
        #$hoseUnit = "in($($hoseSize)mm)"
        $hoseUnit = "mm($($hose['Name']))"
    }
    else
    {
        $hoseSize = $hose['Diameter']
        $hoseUnit = "mm"
    }
    return @{
        Scenario = "$($hoseSize)$($hoseUnit)-ID-len20mm"; Type='VacuumHose';
        Style='hose'; Measurement='inner'; Diameter=$hoseSize; Length=20;
        Taper=-2;
    };
}

$Script:PvcHoseSizes =
@(
    @{System = 'metic';     Name = '4mm';     ExternalDiameter = 4;       WallThickness = 0.75;    },
    @{System = 'imperial';  Name = '5_32in';  ExternalDiameter = 5/32;    WallThickness = 1/32;    },
    @{System = 'metic';     Name = '5mm';     ExternalDiameter = 5;       WallThickness = 0.75;    },
    @{System = 'imperial';  Name = '13_64in'; ExternalDiameter = 13/64;   WallThickness = 1/32;    },
    @{System = 'metic';     Name = '6mm';     ExternalDiameter = 6;       WallThickness = 1;       },
    @{System = 'imperial';  Name = '15_64in'; ExternalDiameter = 15/64;   WallThickness = 5/128;   },
    @{System = 'metic';     Name = '7mm';     ExternalDiameter = 7;       WallThickness = 1;       },
    @{System = 'imperial';  Name = '9_32in';  ExternalDiameter = 9/32;    WallThickness = 5/128;   },
    @{System = 'metic';     Name = '8mm';     ExternalDiameter = 8;       WallThickness = 1.25;    },
    @{System = 'imperial';  Name = '5_16in';  ExternalDiameter = 5/16;    WallThickness = 3/64;    },
    @{System = 'metic';     Name = '9mm';     ExternalDiameter = 9;       WallThickness = 1.25;    },
    @{System = 'imperial';  Name = '23_64in'; ExternalDiameter = 23/64;   WallThickness = 3/64;    },
    @{System = 'metic';     Name = '10mm';    ExternalDiameter = 10;      WallThickness = 1.25;    },
    @{System = 'imperial';  Name = '25_64in'; ExternalDiameter = 25/64;   WallThickness = 3/64;    },
    @{System = 'metic';     Name = '11mm';    ExternalDiameter = 11;      WallThickness = 1.5;     },
    @{System = 'imperial';  Name = '7_16in';  ExternalDiameter = 7/16;    WallThickness = 1/16;    },
    @{System = 'metic';     Name = '12mm';    ExternalDiameter = 12;      WallThickness = 1.5;     },
    @{System = 'imperial';  Name = '15_32in'; ExternalDiameter = 15/32;   WallThickness = 1/16;    },
    @{System = 'metic';     Name = '13mm';    ExternalDiameter = 13;      WallThickness = 1.5;     },
    @{System = 'imperial';  Name = '33_64in'; ExternalDiameter = 33/64;   WallThickness = 1/16;    },
    @{System = 'metic';     Name = '14mm';    ExternalDiameter = 14;      WallThickness = 1.75;    },
    @{System = 'imperial';  Name = '35_64in'; ExternalDiameter = 35/64;   WallThickness = 9/128;   },
    @{System = 'metic';     Name = '15mm';    ExternalDiameter = 15;      WallThickness = 1.75;    },
    @{System = 'imperial';  Name = '19_64in'; ExternalDiameter = 19/64;   WallThickness = 9/128;   },
    @{System = 'metic';     Name = '16mm';    ExternalDiameter = 16;      WallThickness = 1.75;    },
    @{System = 'imperial';  Name = '5_8in';   ExternalDiameter = 5/8;     WallThickness = 9/128;   },
    @{System = 'metic';     Name = '18mm';    ExternalDiameter = 18;      WallThickness = 2;       },
    @{System = 'imperial';  Name = '45_64in'; ExternalDiameter = 45/64;   WallThickness = 5/64;    },
    @{System = 'metic';     Name = '19mm';    ExternalDiameter = 19;      WallThickness = 2;       },
    @{System = 'metic';     Name = '20mm';    ExternalDiameter = 20;      WallThickness = 2;       },
    @{System = 'imperial';  Name = '25_32in'; ExternalDiameter = 25/32;   WallThickness = 5/64;    },
    @{System = 'metic';     Name = '22mm';    ExternalDiameter = 22;      WallThickness = 2;       },
    @{System = 'imperial';  Name = '55_64in'; ExternalDiameter = 55/64;   WallThickness = 5/64;    },
    @{System = 'metic';     Name = '24mm';    ExternalDiameter = 24;      WallThickness = 2.5;     },
    @{System = 'metic';     Name = '25mm';    ExternalDiameter = 25;      WallThickness = 2.5;     },
    @{System = 'imperial';  Name = '15_16in'; ExternalDiameter = 15/16;   WallThickness = 13/128;  },
    @{System = 'metic';     Name = '26mm';    ExternalDiameter = 26;      WallThickness = 2.5;     },
    @{System = 'imperial';  Name = '1in';     ExternalDiameter = 1;       WallThickness = 13/128;  }
)

$Script:PvcHoses = $Script:PvcHoseSizes | ForEach-Object {
    $hose = $_
    if($hose['System'] -ieq 'imperial')
    {
        $hoseSize = $hose['ExternalDiameter'] * $script:inchmm
        $hoseWall = $hose['WallThickness'] * $script:inchmm
        #$hoseUnit = "in($($hoseSize)mm)"
        $hoseUnit = "mm($($hose['Name']))"
    }
    else
    {
        $hoseSize = $hose['ExternalDiameter']
        $hoseWall = $hose['WallThickness']
        $hoseUnit = "mm"
    }

    return @{
        Type='PvcHose';
        MeasurementSystem = $hose['System'];
        Scenario = "$($hoseSize)$($hoseUnit)";
        Style='hose'; Measurement='outer'; Diameter=$hoseSize;
        Wall_Thickness = $hoseWall;
        Length=20;
        Barbs_Count=3; Barbs_Thickness=0; Barbs_Symmetrical=1; Stop_Symmetrical=1;
    };
}


$Script:MagneticAdapters = @(
    @{
        Scenario = 'magneticadapter_50mm'
        Style='mag'; Measurement='inner'; Diameter=50; Wall_Thickness=2; Length=15;
        Magnets_Count=8; Magnet_Diameter=10.5; Magnet_Thickness=4; Magnet_Border=3; Magnet_Flange_Thickness=7.5; Ring='recessed';
    },
    @{
        Scenario = 'magneticadapter_75mm'
        Style='mag'; Measurement='inner'; Diameter=75; Wall_Thickness=2; Length=15;
        Magnets_Count=12; Magnet_Diameter=10.5; Magnet_Thickness=4; Magnet_Border=3; Magnet_Flange_Thickness=7.5; Ring='recessed';
    },
    @{
        Scenario = 'magneticadapter_100mm'
        Style='mag'; Measurement='inner'; Diameter=100; Wall_Thickness=2; Length=15;
        Magnets_Count=12; Magnet_Diameter=10.5; Magnet_Thickness=4; Magnet_Border=3; Magnet_Flange_Thickness=7.5; Ring='recessed';
    });

# For nozzles
# Diameter should be what the transition will target.
# Length should be min length from start of end  to start of nozzle.
$Script:Nozzels =
@(
@{
    Scenario = 'nozzle_square_short'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=40; Length=20;
    Nozzle_Shape='square'; Nozzle_Square_Width=40; Nozzle_Square_Depth=7; Nozzle_Radius=2; Nozzle_Length=0;
},
@{
    Scenario = 'nozzle_square_large'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=80; Length=50;
    Nozzle_Shape='square'; Nozzle_Square_Width=70; Nozzle_Square_Depth=50; Nozzle_Radius=10; Nozzle_Length=10;
},
@{
    Scenario = 'nozzle_floorSweep'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=70; Length=50;
    Nozzle_Shape='square'; Nozzle_Square_Width=15; Nozzle_Square_Depth=70; Nozzle_Radius=5; Nozzle_Length=0;
    Nozzle_xOffset = -8; Wall_Thickness=1.2;
},
@{
    Scenario = 'nozzle_square_wide'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=140; Length=60;
    Nozzle_Shape='square'; Nozzle_Square_Width=140; Nozzle_Square_Depth=10; Nozzle_Radius=5; Nozzle_Length=20; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=80;  Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_square_long'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=40; Length=60;
    Nozzle_Shape='square'; Nozzle_Square_Width=40; Nozzle_Square_Depth=20; Nozzle_Radius=5; Nozzle_Length=60; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=60;  Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_square_thin'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=25; Length=10;
    Nozzle_Shape='square'; Nozzle_Square_Width=8; Nozzle_Square_Depth=20; Nozzle_Radius=3; Nozzle_Length=90; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=60;  Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_square_thin_max'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=25; Length=10;
    Nozzle_Shape='square'; Nozzle_Square_Width=8; Nozzle_Square_Depth=20; Nozzle_Radius=3; Nozzle_Length=$script:maxHeight; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=60;  Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_round'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=15; Length=20;
    Nozzle_Shape='circle'; Nozzle_Radius=5; Nozzle_Length=80; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=80;  Nozzle_Chamfer_Angle=25;
},
@{
    Scenario = 'nozzle_round_max'; Type='nozzle'
    Style='nozzle'; Measurement='outer'; Diameter=15; Length=20;
    Nozzle_Shape='circle'; Nozzle_Radius=5; Nozzle_Length=$script:maxHeight; Nozzle_Tip_Wall_Thickness=1.2; Nozzle_Chamfer_Percentage=80; Nozzle_Chamfer_Angle=25;
};
)

$Script:CustomAdapters =
@(,
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\hoseadapter\');
        Scenario = "hoseadapter";
        Enabled = $true;
        Transition_Length = 0;
        transitionAngles = (0, 30, 45, 90);
        transitionStyles = ("bend+taper", "organicbend")
        End1 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal
        End2 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal + $Script:VacuumHosesInternalShort
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\hosesplitter\');
        Scenario = "hosesplitter";
        Enabled = $true;
        Transition_Length = 0;
        Transition_End2_Count = 2;
        transitionAngles = (30, 45);
        transitionStyles = ("hull"); # ("hull","taper+bend", "bend+taper", "organicbend")
        End1 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal
        End2 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\flange\');
        Scenario = "flange";
        Enabled = $true;
        Transition_Length = 0;
        transitionAngles = (0, 30, 45, 90);
        transitionStyles = ("bend+taper");
        End1 = $Script:VacuumHosesExternal | ForEach-Object {
                 $hose = $_
                 return @{
                    Scenario = $hose.Scenario
                    Style='flange'; Measurement='outer'; Wall_Thickness=2; Length=10; Diameter=$hose.Diameter;
                    Flange_Thickness=5; Flange_Screw_Count=6; Flange_Screw_Diameter=5; Flange_Width=30; #Flange_Screw_Border=5;
                 };
        };
        End2 = @{
            Style='hose'; Length=20; Measurement='outer'; Wall_Thickness=2; Diameter=0;
        };
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\pvchoseadapter\');
        Scenario = "pvchoseadapter";
        Enabled = $true;
        Transition_Length = 0;
        transitionAngles = (0);
        transitionStyles = ("bend+taper")
        End1 = $Script:VacuumHosesExternal
        End2 = $Script:PvcHoses
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\barbedhoses\');
        Scenario = "barbedhoses";
        Enabled = $true;
        Transition_Length = 0;
        transitionAngles = 0; #(0, 30, 45);
        transitionStyles = "bend+taper";#("bend+taper", "organicbend")
        End1 = $Script:PvcHoses
        End2 = $Script:PvcHoses
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\barbedsplitter\');
        Scenario = "barbedsplitter";
        Enabled = $true;
        Transition_Length = 0;
        Transition_End2_Count = 2;
        transitionAngles = (30, 45);
        transitionStyles = "hull";#("hull","taper+bend", "bend+taper", "organicbend")
        End1 = $Script:PvcHoses | Where-Object {$_.MeasurementSystem -eq 'metic'}
        End2 = $Script:PvcHoses | Where-Object {$_.MeasurementSystem -eq 'metic'}
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\funnel\');
        Enabled = $true
        Scenario = 'funnel';
        Transition_Length = 0;
        transitionAngles = 0;
        transitionStyles = 'bend+taper';
        End1 = @{
            Diameter=@(25,30,40,50,60,70,80,90,100,125,150,175,200);
            Style='flange'; Measurement='inner'; Wall_Thickness=1.5; Length=3;
            Flange_Thickness=1.5; Flange_Screw_Count=1; Flange_Screw_Diameter=5; Flange_Width=7; Flange_Screw_Position=10; Flange_Screw_Border=5;
        };
        End2 = @(@{
            Diameter=@(5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,65,70,85,90,95,100)
            Style='nozzle'; Type='funnel'; Measurement='inner'; Length=2;  Wall_Thickness=1.5;
            Nozzle_Shape='circle'; Nozzle_Radius=0; Nozzle_Length=30; Nozzle_Tip_Wall_Thickness=0.6; Nozzle_Chamfer_Percentage=100; Nozzle_Chamfer_Angle=30;
        },@{
            Diameter=@(5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,65,70,85,90,95,100)
            Style='nozzle'; Type='funnel_offcenter';  Measurement='inner'; Length=2;  Wall_Thickness=1.5;
            Nozzle_Shape='circle'; Nozzle_Radius=0; Nozzle_Length=30; Nozzle_Tip_Wall_Thickness=0.6; Nozzle_Chamfer_Percentage=100;  Nozzle_Chamfer_Angle=30;
        });
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\dyson');
        Scenario = 'dyson'
        Enabled = $true
        Transition_Length = 0;
        transitionAngles = (0, 30, 45);
        transitionStyles = ("bend+taper", "organicbend");
        End1 = @{
            Scenario = 'dyson'
            Style='dyson'; Measurement='inner'; Diameter=34; Wall_Thickness=2.25; ; Length=46; #values only used to calculate transition
        };
        End2 = $Script:VacuumHosesInternal + $Script:VacuumHosesExternal + $Script:PvcHoses + $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\centec\');
        Scenario = 'centec'
        Enabled = $true
        Transition_Length = 0;
        transitionAngles = (0, 30, 45);
        transitionStyles = ("bend+taper", "organicbend");
        End1 = @{
            Scenario = 'centec'
            Style='centec'; Measurement='inner'; Diameter=(22.625*2)+6; Wall_Thickness=2; Length=27; #values only used to calculate transition
        };
        End2 = $Script:VacuumHosesInternal + $Script:VacuumHosesExternal + $Script:PvcHoses + $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\camlock\');
        Scenario = 'camlock'
        Enabled = $true
        Transition_Length = 0;
        transitionAngles = (0, 30, 45);
        transitionStyles = ("bend+taper", "organicbend");
        End1 = @{
            Scenario = 'camlock'
            Style='camlock'; Measurement='outer'; Diameter=48.5; Wall_Thickness=2; Length=38; #values only used to calculate transition
        };
        End2 = $Script:VacuumHosesInternal + $Script:VacuumHosesExternal + $Script:PvcHoses + $Script:Nozzels
    },

    @{
        Folder = (Join-Path $script:SourceFolder 'generated\hose_nozzle');
        Scenario = "hose_nozzle";
        Enabled = $true;
        Transition_Length = 0;
        transitionAngles = (0, 30, 45);
        transitionStyles = ("bend+taper", "organicbend");
        End1 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal
        End2 = $Script:Nozzels
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\magneticadapter\');
        Enabled = $true
        Scenario = 'magneticadapter'
        Transition_Length = 0;
        transitionAngles = (0, 30, 45);
        transitionStyles = ("bend+taper", "organicbend");
        Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=0.5; Alignment_Side_Clearance=0.25; Alignment_Depth_Clearance=0.75;
        End1 = $Script:MagneticAdapters
        End2 = $Script:VacuumHosesExternal + $Script:VacuumHosesInternal + $Script:VacuumHosesInternalShort + @{
                Scenario = 'cap'
                Style='hose'; Measurement='inner'; Diameter=100; Wall_Thickness=2; Length=3;
                Hose_EndCap_Thickness=3;
             } + @{
                Scenario = 'cap_with_hole'
                Style='hose'; Measurement='inner'; Diameter=100; Wall_Thickness=2; Length=3;
                Hose_EndCap_Thickness=3; Hose_EndCap_Diameter=5;
             } + @{
                Scenario = 'cap_with_hook'
                Style='flange'; Measurement='inner'; Diameter=100; Wall_Thickness=2; Length=3;
                Flange_Width=30; Flange_Thickness=3; Flange_Screw_Position = 55; Flange_Screw_Border=5; Flange_Screw_Count=1; Flange_Screw_Diameter=10;
             }
    },
    @{
        Folder = (Join-Path $script:SourceFolder 'generated\dw735\');
        Enabled = $true
        Scenario = 'dw735'
        Transition_Length = 0;
        transitionAngles = (0, 45, 90);
        transitionStyles = ("taper+bend", "bend+taper", "organicbend");
        Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=0.5; Alignment_Side_Clearance=0.25; Alignment_Depth_Clearance=0.75;
        End1 = @{
            Style='dw735'; Measurement='inner'; Diameter=71; Wall_Thickness=3; Length=17; #values only used to calculate transition
        }
        End2 = $Script:MagneticAdapters + $Script:VacuumHosesExternal + $Script:VacuumHosesInternal

    }
    #,@{
    #     targetFolder = (Join-Path $script:SourceFolder 'generated\dyson\custom');
    #     scenario = 'dyson3'
    #     Wall_Thickness = 2;
    #     Draw_Alignment_Ring='no'; Alignment_Depth=2; Alignment_Upper_Width=2; Alignment_Lower_Width=.05; Alignment_Side_Clearance=0.25;#[decimal]$Alignment_Side_Clearance=0.75,
    #
    #     Style='dyson'; Measurement='outer'; Diameter=40; Length=20;
    #     Taper=2; StopThickness=0; StopLength=0;
    #     Magnets_Count=0; Magnet_Diameter=0; Magnet_Thickness=0; Magnet_Border=0;
    #     Flange_Thickness=5; Screw_Count=6; Screw_Diameter=5; Flange_Outer_Diameter=0;
    #
    #     Transition_Style='organicbend'; Transition_Length=10; Transition_Bend_Radius=10; Transition_Angle=0;
    #
    #     Style='hose'; Measurement='outer'; Diameter=50; Length=20;
    #     Taper=2; StopThickness=0; StopLength=0;
    #     Magnets_Count=0; Magnet_Diameter=0; Magnet_Thickness=0; Magnet_Border=0; Magnet_Flange_Thickness=0; Ring='recessed'; Nozzle_Chamfer_Percentage=0; Nozzle_Chamfer_Angle=0;
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

Function DefaultIfNull{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    $value,
    $default)
    if ($value -eq $null) { return $default } else { return $value }
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

Function OpenSCAD-AddArgs($ArgName, $ArgValue) {
    Write-Verbose "ArgName: $($ArgName) ArgValue: $($ArgValue)"

    if ($ArgValue -eq $null) {
        return ''
    } elseif ($ArgValue -is [string]) {
        if (![string]::IsNullOrEmpty($ArgValue)) {
            return " -D `"$($ArgName)=`"`"$($ArgValue)`"`"`""
        }
    } elseif ($ArgValue -is [int] -or $ArgValue -is [double] -or $ArgValue -is [decimal] -or $ArgValue -is [long]) {
        return " -D `"$($ArgName)=$($argValue)`""
    } else {
        throw "unsupported type $($ArgValue.GetType().FullName)"
    }
}

$Script:CustomAdapters | Sort-Object { Get-Random } | Where-Object {$_.Enabled} | ForEach-Object {
    $_adapter = $_
    Write-Host "Adapter $($_adapter.Scenario)"
$_adapter.End1 | Sort-Object { Get-Random } | ForEach-Object {
    $_end1 = $_
    Write-Verbose "End1 $($_end1.Scenario)"
$_adapter.End2 | Sort-Object { Get-Random } | ForEach-Object {
    $_end2 = $_
    Write-Verbose "End2 $($_end2.Scenario)"
$_adapter.transitionStyles | ForEach-Object {
    $_transitionStyle = $_
    Write-Verbose "transitionStyle $($_transitionStyle) | Adapter $($_adapter.Scenario)"
$_adapter.transitionAngles | ForEach-Object {
    $_transitionAngle = [decimal]$_
    Write-Verbose "transitionAngle $($_transitionAngle) | transitionStyle $($_transitionStyle) | Adapter $($_adapter.Scenario)"
$_end1.Diameter | Sort-Object { Get-Random } | ForEach-Object {
    $_end1Diameter = [decimal]$_
    Write-Verbose "End1_Diameter $($_end1.Diameter) | transitionAngle $($_transitionAngle) | transitionStyle $($_transitionStyle) | Adapter $($_adapter.Scenario)"
$_end2.Diameter | Sort-Object { Get-Random } | ForEach-Object {
    $_end2Diameter = [decimal]$_

    Write-Verbose "Adapter $($_adapter.Scenario) $($_adapter.Folder )"
    $folder                           = $_adapter.Folder
    $alignment_DrawAlignmentRing      = $_adapter.Draw_Alignment_Ring
    $alignment_Depth                  = $_adapter.Alignment_Depth
    $alignment_UpperWidth             = $_adapter.Alignment_Upper_Width
    $alignment_LowerWidth             = $_adapter.Alignment_Lower_Width
    $alignment_SideClearance          = $_adapter.Alignment_Side_Clearance
    $alignment_DepthClearance         = $_adapter.Alignment_Depth_Clearance

    $end1_Style                       = $_end1.Style
    $end1_WallThickness               = $_end1.Wall_Thickness
    $end1_Measurement                 = $_end1.Measurement
    $end1_Diameter                    = $_end1Diameter
    $end1_Length                      = $_end1.Length
    $end1_Taper                       = $_end1.Taper
    $end1_StopThickness               = $_end1.StopThickness
    $end1_StopLength                  = $_end1.StopLength
    $end1_StopSymmetrical             = $_end1.Stop_Symmetrical
    $end1_BarbsCount                  = $_end1.Barbs_Count
    $end1_BarbsThickness              = $_end1.Barbs_Thickness
    $end1_BarbsSymmetrical            = $_end1.Barbs_Symmetrical
    $end1_HoseEndCapDiameter          = $_end1.Hose_EndCap_Diameter
    $end1_HoseEndCapThickness         = $_end1.Hose_EndCap_Thickness

    $end1_MagnetsCount                = $_end1.Magnets_Count
    $end1_MagnetDiameter              = $_end1.Magnet_Diameter
    $end1_MagnetThickness             = $_end1.Magnet_Thickness
    $end1_MagnetBorder                = $_end1.Magnet_Border
    $end1_MagnetFlangeThickness       = $_end1.Magnet_Flange_Thickness
    $end1_Ring                        = $_end1.Ring

    $end1_FlangeWidth                 = $_end1.Flange_Width
    $end1_FlangeThickness             = $_end1.Flange_Thickness
    $end1_FlangeScrewPosition         = $_end1.Flange_Screw_Position
    $end1_FlangeScrewBorder           = $_end1.Flange_Screw_Border
    $end1_FlangeScrewCount            = $_end1.Flange_Screw_Count
    $end1_FlangeScrewDiameter         = $_end1.Flange_Screw_Diameter

    $adapter_TransitionStyle          = $_transitionStyle
    $adapter_TransitionLength         = $_adapter.TransitionLength
    $adapter_TransitionBendRadius     = $_adapter.Transition_Bend_Radius
    $adapter_TransitionAngle          = $_transitionAngle
    $adapter_TransitionXOffset        = $_adapter.Transition_xOffset
    $adapter_TransitionYOffset        = $_adapter.Transition_yOffset
    $adapter_TransitionBaseType       = $_adapter.Transition_Base_Type
    $adapter_TransitionBaseThickness  = $_adapter.Transition_Base_Thickness
    $adapter_TransitionBaseWidth      = $_adapter.Transition_Base_Width
    $adapter_TransitionBaseLength     = $_adapter.Transition_Base_Length
    $adapter_TransitionBaseAngle      = $_adapter.Transition_Base_Angle
    $adapter_TransitionEnd2Count      = $_adapter.Transition_End2_Count

    $end2_Style                       = $_end2.Style
    $end2_WallThickness               = $_end2.Wall_Thickness
    $end2_Measurement                 = $_end2.Measurement
    $end2_Diameter                    = $_end2Diameter
    $end2_Length                      = $_end2.Length
    $end2_Taper                       = $_end2.Taper
    $end2_StopThickness               = $_end2.StopThickness
    $end2_StopLength                  = $_end2.StopLength
    $end2_StopSymmetrical             = $_end2.Stop_Symmetrical
    $end2_BarbsCount                  = $_end2.Barbs_Count
    $end2_BarbsThickness              = $_end2.Barbs_Thickness
    $end2_BarbsSymmetrical            = $_end2.Barbs_Symmetrical
    $end2_HoseEndCapDiameter          = $_end2.Hose_EndCap_Diameter
    $end2_HoseEndCapThickness         = $_end2.Hose_EndCap_Thickness

    $end2_MagnetsCount                = $_end2.Magnets_Count
    $end2_MagnetDiameter              = $_end2.Magnet_Diameter
    $end2_MagnetThickness             = $_end2.Magnet_Thickness
    $end2_MagnetBorder                = $_end2.Magnet_Border
    $end2_MagnetFlangeThickness       = $_end2.Magnet_Flange_Thickness
    $end2_Ring                        = $_end2.Ring


    $end2_FlangeWidth                 = $_end2.Flange_Width
    $end2_FlangeThickness             = $_end2.Flange_Thickness
    $end2_FlangeScrewPosition         = $_end2.Flange_Screw_Position
    $end2_FlangeScrewBorder           = $_end2.Flange_Screw_Border
    $end2_FlangeScrewCount            = $_end2.Flange_Screw_Count
    $end2_FlangeScrewDiameter         = $_end2.Flange_Screw_Diameter

    $end2_NozzleShape                 = $_end2.Nozzle_Shape
    $end2_NozzleSquareWidth           = $_end2.Nozzle_Square_Width
    $end2_NozzleSquareDepth           = $_end2.Nozzle_Square_Depth
    $end2_NozzleTipWallThickness      = $_end2.Nozzle_Tip_Wall_Thickness
    $end2_NozzleRadius                = $_end2.Nozzle_Radius
    $end2_NozzleLength                = $_end2.Nozzle_Length
    $end2_NozzleXOffset               = $_end2.Nozzle_xOffset
    $end2_NozzleYOffset               = $_end2.Nozzle_yOffset
    $end2_NozzleChamferPercentage     = $_end2.Nozzle_Chamfer_Percentage
    $end2_NozzleChamferAngle          = $_end2.Nozzle_Chamfer_Angle

    Write-Verbose "$($_adapter.Scenario)  End2_Diameter $($end2_Diameter) | End1_Diameter $($end1_Diameter) | transitionAngle $($adapter_TransitionAngle) | transitionStyle $($adapter_TransitionStyle) | Adapter $($_adapter.Scenario)"

    # organicbend at 0deg should be tapered
    $adapter_TransitionStyle = (IIF -If ($adapter_TransitionStyle -ieq 'organicbend' -and $adapter_TransitionAngle -eq 0) -Right 'bend+taper' -Wrong $adapter_TransitionStyle)
    Write-Verbose "transitionStyle $($adapter_TransitionStyle) | transitionAngle $($adapter_TransitionAngle)"

    $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf `
            -Right '' `
            -Wrong "$($adapter_TransitionAngle)deg_$($adapter_TransitionStyle)")
            #-Wrong (($adapter_TransitionStyle -eq "organicbend") | IIf `
            #    -Right "$($adapter_TransitionAngle)deg_organicbend" `
            #    -Wrong "$($adapter_TransitionAngle)deg_bend"))
    $adapter_TransitionBaseType = (($adapter_TransitionAngle -gt 45) | IIF -Right 'oval' -Wrong $adapter_TransitionBaseType)

    $end2_NozzleChamferAngle = IIF ($end2_NozzleShape -eq 'nozzle' -and $end2_NozzleChamferAngle -eq 0 -and $end2_NozzleChamferPercentage -gt 0 ) `
        -Right $adapter_TransitionAngle `
        -Wrong $end2_NozzleChamferAngle

    $scenario = (AppendIf -value $_adapter.Scenario | AppendIf -value $_end1.Scenario | AppendIf -value $_end2.Scenario)
    $filename = $scenario

    $adapter_TransitionLength = IIF ($adapter_TransitionLength -gt 0 -or $_end2.Type -eq 'nozzle') `
        -Right $adapter_TransitionLengthh `
        -Wrong ([Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($end1_Diameter - $end2_Diameter)), 40),2))
        #-Wrong ([Math]::Max([Math]::Min([Math]::Ceiling([Math]::Abs($end1_Diameter - $end2_Diameter)+$end2_Length), $script:maxHeight - ($End1. End1_Length)), $end2_Length))

    if($_adapter.Scenario -eq 'hoseadapter'){
        if($adapter_TransitionAngle -eq 0 -and $end2_Diameter -gt $end1_Diameter)
        {
            Write-Verbose "Skipping hoseadapter transitionAngle:$($adapter_TransitionAngle) End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }
        $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong $modelDescription)

        $addend1_Stop = ($end1_Diameter -gt $end2_Diameter -and $end1_Measurement -ieq 'outer')
        $addend2_Stop = ($end2_Diameter -gt $end1_Diameter -and $end2_Measurement -ieq 'outer')
        $end1_StopThickness = ($addend1_Stop | IIF -Right 4 -Wrong 0)
        $end1_StopLength = ($addend1_Stop | IIF -Right 8 -Wrong 0)
        $end2_StopThickness = ($addend1_Stop | IIF -Right 4 -Wrong 0)
        $end2_StopLength = ($addend1_Stop | IIF -Right 8 -Wrong 0)
        $filename = "$($_end1.Scenario)_to_$($_end2.Scenario)_transition$($adapter_TransitionLength)mm"

        $folder = Join-Path $folder "$modelDescription\$($_end1.Scenario)"
        if([Math]::Max($end1_Diameter, $end2_Diameter) -ge [Math]::Min($end1_Diameter, $end2_Diameter) * 2)
        {
            Write-Host "Skipping hoseadapter, too large of a difference, transitionAngle:$($adapter_TransitionAngle) End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)" -ForegroundColor Yellow
            $tmpFilename = "$($filename | AppendIf -value $modelDescription).stl"
            $tmpTarget = Join-Path $folder $tmpFilename
            if( Test-Path -LiteralPath $tmpTarget)
            {
                Write-Host "renaming '$($tmpTarget)' transitionAngle:$($adapter_TransitionAngle)" -ForegroundColor Yellow
                Rename-Item -LiteralPath $tmpTarget -NewName "$($tmpFilename).difference"
            }
            return
        }
        Write-Verbose "hoseadapter - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter"
    }

    if($_adapter.Scenario -eq 'hosesplitter' -or $_adapter.Scenario -eq 'barbedsplitter'){
        if($end2_Diameter -gt $end1_Diameter)
        {
            Write-Verbose "Skipping $($_adapter.Scenario) transitionAngle:$($adapter_TransitionAngle) End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }
        $end1_StopThickness = 0
        $end1_StopLength = 0
        $end2_StopThickness = 0
        $end2_StopLength = 0
        $adapter_TransitionBendRadius = 5;
        $filename = "$($_end1.Scenario)_to_$($_end2.Scenario)_transition$($adapter_TransitionLength)mm"
        $folder = Join-Path $folder "$($adapter_TransitionStyle)\$($_end1.Scenario)"
        Write-Verbose "$($_adapter.Scenario) - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter"
    }

    if($_adapter.Scenario -eq 'barbedhoses'){
        if($adapter_TransitionAngle -eq 0 -and $end2_Diameter -ge $end1_Diameter)
        {
            Write-Verbose "Skipping barbedhoses transitionAngle:$($adapter_TransitionAngle) End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }
        $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong $modelDescription)
        $end1_StopThickness = (($end1_Diameter -gt $end2_Diameter -and $adapter_TransitionAngle -eq 0) | IIF -Right ($end1_WallThickness*1.5) -Wrong 0)
        $end1_StopLength = (($end1_Diameter -gt $end2_Diameter -and $adapter_TransitionAngle -eq 0) | IIF -Right ($end1_WallThickness*1.5) -Wrong 0)
        $end2_StopThickness = (($end2_Diameter -gt $end1_Diameter -and $adapter_TransitionAngle -eq 0) | IIF -Right ($end2_WallThickness*1.5) -Wrong 0)
        $end2_StopLength = (($end2_Diameter -gt $end1_Diameter -and $adapter_TransitionAngle -eq 0) | IIF -Right ($end2_WallThickness*1.5) -Wrong 0)
        $filename = "$($_end1.Scenario)_to_$($_end2.Scenario)_transition$($adapter_TransitionLength)mm"

        $folder = Join-Path $_adapter.Folder "$modelDescription\$($_end1.Scenario)"
        Write-Verbose "barbedhoses - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter"
    }

    if($_adapter.Scenario -eq 'pvchoseadapter'){
        $end1_StopThickness = 4
        $end1_StopLength = 8
        $filename = "$($_end1.Scenario)_to_$($_end2.Scenario)_transition$($adapter_TransitionLength)mm"

        $folder = Join-Path $_adapter.Folder "$modelDescription\$($_end1.Scenario)"
        Write-Verbose "pvchoseadapter - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter"
    }

    if($_adapter.Scenario -eq 'hose_nozzle'){
        Write-Verbose "hose_nozzle - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter End2_Nozzle_Length$($end2_NozzleLength)"

        #$end2_Length = IIF ($adapter_TransitionAngle -gt 0 -and $adapter_TransitionStyle -ieq 'organicbend') `
        #    -Right $end2_Length `
        #    -Wrong ([Math]::Max([Math]::Min([math]::Max($adapter_TransitionLength, $end2_Length), $script:maxHeight - ($end1_Length + $end2_NozzleLength)), $end2_Length))

        #$end2_Diameter = IIF ($adapter_TransitionAngle -gt 0-and $adapter_TransitionStyle -ieq 'organicbend') `
        #    -Right ([Math]::Min(($end1_Diameter  + $end1_Taper/2), $end2_Diameter)) `
        #    -Wrong ($end1_Diameter + $end1_Taper/2)

        #if there is no angle, move the transition length in to end2 to give a smoother transition.
        $end2_Length = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
            -Right $end2_Length `
            -Wrong ([math]::Max([math]::Max($adapter_TransitionLength, $end2_Length), [math]::Abs($end1_Diameter - $end2_Diameter)))

        $adapter_TransitionLength = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
            -Right (DefaultIfNull $adapter_TransitionLength 1) `
            -Wrong 1

        #limit the length of nozzle using max length
        $end2_NozzleLength = ([Math]::Min($end2_NozzleLength, $script:maxHeight - ($end1_Length + $end2_Length + $adapter_TransitionLength)))

        $end2_Diameter = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
            -Right ([Math]::Min(($end1_Diameter  + $end1_Taper/2), $end2_Diameter)) `
            -Wrong ($end1_Diameter + $end1_Taper/2)


        Write-Verbose "hose_nozzle - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter End2_Nozzle_Length$($end2_NozzleLength)"
        $folder = Join-Path $folder "$($_end1.Scenario)"
        write-Verbose "hose_nozle $folder"
    }

    if($_adapter.Scenario -eq 'funnel'){
        Write-Verbose 'setting Funnel settings'
        if($end2_Diameter -ge $end1_Diameter/2 -or $end2_Diameter -le $end1_Diameter/8)
        {
            Write-Verbose "Skipping Funnel End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }

        #Give the cone a 45deg
        $adapter_TransitionLength = [Math]::Min([Math]::Max([Math]::Ceiling([Math]::Abs($end1_Diameter - $end2_Diameter)),5),100)
        $end1_FlangeOuterDiameter = $end1_Diameter + 20
        $end2_NozzleRadius = $end2_Diameter/2
        $end2_NozzleLength = [Math]::Min([Math]::Min($end1_Diameter, $adapter_TransitionLength + $end2_Diameter), $script:maxHeight - $adapter_TransitionLength)

        if($_end2.Type -eq 'funnel_offcenter'){
            $adapter_TransitionXOffset = ($end1_Diameter - $end2_Diameter)/-2;
        }

        $modelDescription = "$($end1_Diameter)mm_to_$($end2_Diameter)mm"
        $folder = Join-Path $folder "$($_end2.Type)\$($end1_Diameter)mm"
    }

    if($_adapter.Scenario -eq 'magneticadapter'){
        if($adapter_TransitionAngle -gt 0 -and ($_end2.Scenario -eq 'cap' -or $_end2.Scenario -eq 'cap_with_hole' -or $_end2.Scenario -eq 'cap_with_hook'))
        {
            Write-Verbose "Skipping magnetic cap, due to trans angle transitionAngle:$($adapter_TransitionAngle) End1_Diameter: $($end1_Diameter) End2_Diameter: $($end2_Diameter)"
            return
        }
        if($_end2.Scenario -and ($_end2.Scenario -eq 'cap' -or $_end2.Scenario -eq 'cap_with_hole'-or $_end2.Scenario -eq 'cap_with_hook'))
        {
           $adapter_TransitionStyle = (($_end2.Scenario -eq 'cap_with_hook') | IIf -Right 'flat' -Wrong 'none')
           $adapter_Transitionlength = $end2_length*-1
           $end2_Diameter = $end1_Diameter
           $end1_length = $end1_MagnetFlangeThickness
           $modelDescription = 'cap'
        }
        else{
           $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong $modelDescription)
        }
        Write-Verbose "magneticadapter - transitionAngle:$($adapter_TransitionAngle) TransitionLength:$($adapter_TransitionLength) End1_Length:$($end1_Length) End2_Length:$($end2_Length) end1_Diameter:$end1_Diameter end2_Diameter:$end2_Diameter"
        Write-Verbose "magneticadapter - Magent_Count:$($end1_MagnetsCount) Magent_Diameter:$($end1_MagnetDiameter) Magnet_Thickness:$($end1_MagnetThickness) End2Scenario:$($_end2.Scenario)"
        $filename = "$($_end2.Scenario)_to_$($end1_Diameter)mm-$($end1_MagnetsCount)Magnets-$($end1_MagnetDiameter)x$($end1_MagnetThickness)mm_transition$($adapter_TransitionLength)mm"
        $folder = Join-Path $_adapter.Folder "$($end1_Diameter)mm\$($modelDescription)"
        write-Verbose "magneticadapter $folder"
    }

    if($_adapter.Scenario -eq 'camlock' -or $_adapter.Scenario -eq 'dyson'  -or $_adapter.Scenario -eq 'centec'){
        $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong $modelDescription)
        $scenario = (AppendIf -value $_end1.Scenario | AppendIf -value $_end2.Scenario)

        $end1_StopThickness = 0
        $end1_StopLength = 0
        $end2_StopThickness = 0
        $end2_StopLength = 0

        $filename = $scenario
        if($_end2.Type -ieq 'VacuumHose'){
            $folder = Join-Path $folder "Hoses\$($modelDescription)"
        }
        if($_end2.Type -eq 'nozzle'){
            $folder = (Join-Path $folder "nozzles\$($_end2.Scenario)");

            #for nozles, the transition length is in end2 to give a more dynamic transition.
            $end2_Length = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
                -Right $end2_Length `
                -Wrong ([math]::Max([math]::Max($adapter_TransitionLength, $end2_Length), [math]::Abs($end1_Diameter - $end2_Diameter)))

            $adapter_TransitionLength = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
                -Right (DefaultIfNull $adapter_TransitionLength 0) `
                -Wrong 2

            #limit the length of nozzle using max length
            $end2_NozzleLength = ([Math]::Min($end2_NozzleLength, $script:maxHeight - ($end1_Length + $end2_Length + $adapter_TransitionLength)))

            $end2_Diameter = IIF ($adapter_TransitionStyle -ieq 'organicbend') `
                -Right ([Math]::Min(($end1_Diameter  + $end1_Taper/2), $end2_Diameter)) `
                -Wrong ($end1_Diameter + $end1_Taper/2)
        }
        if($_end2.Type -eq 'PvcHose'){
            $folder = (Join-Path $folder "pvc\$($modelDescription)");
        }
        write-Verbose "$($_adapter.Scenario) - $($_end2.Type) - $folder"
    }

    if($_adapter.Scenario -eq 'dw735'){
        write-host "dw735 - end1_Length - $($end1_Length) $($end2_Diameter)-$($end1_Diameter)=$([math]::Max($end2_Diameter - $end1_Diameter, 0)) - $($_adapter.Scenario) - $($_end2.Type) - $($_end2.Style) $folder"
        $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong $modelDescription)
        $dW735MinLength = 17
        $flangeWidth = (($_end2.Style -ieq 'mag') | IIF -Right 20 -Wrong 0)

        $minLengths = [array] `
            (($adapter_TransitionAngle -gt 45 -and $adapter_TransitionStyle -ieq 'bend+taper') | IIf -Right ([math]::Max(($flangeWidth + ($end2_Diameter-$end1_Diameter)/2), 0))  -Wrong 0), `
            (($adapter_TransitionAngle -gt 45 -and $adapter_TransitionStyle -ieq 'taper+bend') | IIf -Right ([math]::Max(($flangeWidth - $adapter_TransitionLength), 0))  -Wrong 0), `
            0;

        $end1_Length = $dW735MinLength + @($minLengths | measure -Maximum).Maximum
        $scenario = (AppendIf -value $_end1.Scenario | AppendIf -value $_end2.Scenario)

        $filename = $scenario
        if($_end2.Type -ieq 'VacuumHose'){
            $folder = Join-Path $folder "Hoses\$($modelDescription)"
        }
        if($_end2.Style -ieq 'mag'){
            $folder = Join-Path $folder "Magnetic\$($modelDescription)"
        }
        write-host "end1_Length - '$($end1_Length)' - $($_adapter.Scenario) - $($_end2.Type) - $folder"

        write-Verbose "$($_adapter.Scenario) - $($_end2.Type) - $folder"
    }

    if($_adapter.Scenario -eq 'flange'){
        $modelDescription = (($adapter_TransitionAngle -eq 0) | IIf -Right 'straight' -Wrong "$($adapter_TransitionAngle)deg")
        $end2_Diameter = $end1_Diameter
        $adapter_TransitionLength = 0
        $folder = Join-Path $folder "$($modelDescription)"
        #$FlangeOuter = IIF($End1.Flange_Outer_Diameter -eq 0, $($End1_Diameter+30),$End1.Flange_Outer_Diameter)
        #$filename = "$($End1_Style)_$($End2_Style)_$($scenario)"
        write-Verbose "flange $folder"
    }

    $filename = ($filename | AppendIf -value $modelDescription)

    CreateFolderIfNeeded $folder

    $target = Join-Path $folder "$($filename).stl"
    if((Test-Path $target) -and !$Script:ForceRegeneration)
    {
        Write-Host "Skipping exising file $($filename)" -ForegroundColor Green
        return
    }

    Write-Host "Generating $($_adapter.Scenario) adapter $($target)"

    #invoke openscad
    $cmdArgs = ""
    if($SetFilePath)
    {
        $cmdArgs = "-o `"$($target)`""
    }

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Draw_Alignment_Ring' -ArgValue $adapter_DrawAlignmentRing
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Alignment_Depth' -ArgValue $adapter_AlignmentDepth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Alignment_Upper_Width' -ArgValue $adapter_AlignmentUpperWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Alignment_Lower_Width' -ArgValue $adapter_AlignmentLowerWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Alignment_Side_Clearance' -ArgValue $adapter_AlignmentSideClearance
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Alignment_Depth_Clearance' -ArgValue $adapter_AlignmentDepthClearance

    #End1 settings
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Style' -ArgValue $end1_Style
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Wall_Thickness' -ArgValue $end1_WallThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Measurement' -ArgValue $end1_Measurement
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Diameter' -ArgValue $end1_Diameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Length' -ArgValue $end1_Length
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Taper' -ArgValue $end1_Taper
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_StopThickness' -ArgValue $end1_StopThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_StopLength' -ArgValue $end1_StopLength
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Stop_Symmetrical' -ArgValue $end1_StopSymmetrical
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Barbs_Count' -ArgValue $end1_BarbsCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Barbs_Thickness' -ArgValue $end1_BarbsThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Barbs_Symmetrical' -ArgValue $end1_BarbsSymmetrical
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Hose_EndCap_Diameter' -ArgValue $end1_HoseEndCapDiameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Hose_EndCap_Thickness' -ArgValue $end1_HoseEndCapThickness

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Magnets_Count' -ArgValue $end1_MagnetsCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Magnet_Diameter' -ArgValue $end1_MagnetDiameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Magnet_Thickness' -ArgValue $end1_MagnetThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Magnet_Border' -ArgValue $end1_MagnetBorder
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Magnet_Flange_Thickness' -ArgValue $end1_MagnetFlangeThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Ring' -ArgValue $end1_Ring

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Width' -ArgValue $end1_FlangeWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Thickness' -ArgValue $end1_FlangeThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Screw_Position' -ArgValue $end1_FlangeScrewPosition
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Screw_Border' -ArgValue $end1_FlangeScrewBorder
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Screw_Count' -ArgValue $end1_FlangeScrewCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End1_Flange_Screw_Diameter' -ArgValue $end1_FlangeScrewDiameter

    #Transition settings
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Style' -ArgValue $adapter_TransitionStyle
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Length' -ArgValue $adapter_TransitionLength
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Bend_Radius' -ArgValue $adapter_TransitionBendRadius
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Angle' -ArgValue $adapter_transitionAngle
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_xOffset' -ArgValue $adapter_TransitionXOffset
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_yOffset' -ArgValue $adapter_TransitionYOffset
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Base_Type' -ArgValue $adapter_TransitionBaseType
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Base_Thickness' -ArgValue $adapter_TransitionBaseThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Base_Width' -ArgValue $adapter_TransitionBaseWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Base_Length' -ArgValue $adapter_TransitionBaseLength
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_Base_Angle' -ArgValue $adapter_TransitionBaseAngle
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'Transition_End2_Count' -ArgValue $adapter_TransitionEnd2Count

    #End2 settings
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Style' -ArgValue $end2_Style
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Wall_Thickness' -ArgValue $end2_WallThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Measurement' -ArgValue $end2_Measurement
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Diameter' -ArgValue $end2_Diameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Length' -ArgValue $end2_Length
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Taper' -ArgValue $end2_Taper
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_StopThickness' -ArgValue $end2_StopThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_StopLength' -ArgValue $end2_StopLength
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Stop_Symmetrical' -ArgValue $end2_StopSymmetrical
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Barbs_Count' -ArgValue $end2_BarbsCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Barbs_Thickness' -ArgValue $end2_BarbsThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Barbs_Symmetrical' -ArgValue $end2_BarbsSymmetrical
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Hose_EndCap_Diameter' -ArgValue $end2_HoseEndCapDiameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Hose_EndCap_Thickness' -ArgValue $end2_HoseEndCapThickness

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Magnets_Count' -ArgValue $end2_MagnetsCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Magnet_Diameter' -ArgValue $end2_MagnetDiameter
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Magnet_Thickness' -ArgValue $end2_MagnetThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Magnet_Border' -ArgValue $end2_MagnetBorder
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Magnet_Flange_Thickness' -ArgValue $end2_MagnetFlangeThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Ring' -ArgValue $end2_Ring

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Width' -ArgValue $end2_FlangeWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Thickness' -ArgValue $end2_FlangeThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Screw_Position' -ArgValue $end2_FlangeScrewPosition
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Screw_Border' -ArgValue $end2_FlangeScrewBorder
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Screw_Count' -ArgValue $end2_FlangeScrewCount
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Flange_Screw_Diameter' -ArgValue $end2_FlangeScrewDiameter

    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Shape' -ArgValue $end2_NozzleShape
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Square_Width' -ArgValue $end2_NozzleSquareWidth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Square_Depth' -ArgValue $end2_NozzleSquareDepth
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Tip_Wall_Thickness' -ArgValue $end2_NozzleTipWallThickness
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Radius' -ArgValue $end2_NozzleRadius
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Length' -ArgValue $end2_NozzleLength
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_xOffset' -ArgValue $end2_NozzleXOffset
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_yOffset' -ArgValue $end2_NozzleYOffset
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Chamfer_Percentage' -ArgValue $end2_NozzleChamferPercentage
    $cmdArgs += OpenSCAD-AddArgs -ArgName 'End2_Nozzle_Chamfer_Angle' -ArgValue $end2_NozzleChamferAngle

    $cmdArgs += " $($script:ScadScriptPath)"
    Write-Host  $cmdArgs
    $executionTime =  $cmdArgs | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }

    Write-host "done $executionTime"
}}}}}}}
