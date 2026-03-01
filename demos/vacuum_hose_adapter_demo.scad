// include instead of use, so we get the pitch
use <../modules/vacuum-hose-adapter.scad>
include <../modules/functions_general.scad>

scenario = "demo"; //[demo,demo2,demo_fixed, endcommon_wallthickness,endcommon_diameter,endcommon_measurement,endcommon_length,endcommon_taper,endcommon_rotation,  hose_demo,hose_stopthickness,hose_stoplength,hose_stopsymmetrical,hose_threads,hose_barbsthickness,hose_barbscount,hose_barbssymmetrical,hose_endcapthickness,hose_endcapdiameter, flange_demo,flange_width,flange_thickness,flange_screwposition,flange_screwborder,flange_screwcount,flange_screwdiameter, magnetic_flangedemo,magnetic_magnetcount,magnetic_magnetdiameter,magnetic_magnetthickness,magnetic_magnetborder,magnetic_flangethickness,magnetic_alignmentring,magnetic_twistlock, nozzle_demo,nozzle_shape,nozzle_size,nozzle_tipwallthickness,nozzle_radius,nozzle_offset,nozzle_chamferpercentage,nozzle_chamferangle,     allignmentring_demo,allignmentring_depth,allignmentring_upperwidth,allignmentring_lowerwidth,allignmentring_sideclearance,allignmentring_depthclearance, camlock_sample,camlock_demo, centec_female_sample,centec_female_demo,centec_male_sample,centec_male_demo, dyson_sample,dyson_demo, dw735_sample,dw735_demo,makita_male_sample,makita_male_demo, osvacm32_sample,osvacm32_demo,osvacm_sample,osvacm_demo,osvacf32_sample,osvacf32_demo,osvacf_sample,osvacf_demo, transition_demo,transition_bendtaper,transition_taperbend,transition_organicbend,transition_flat, transition_hull,transition_hulllength,transition_hulloffset,transition_hullcenter, transition_length,transition_angle,transition_bendradius,transition_offset,transition_EndCount,  transitionbase,transitionbase_thickness,transitionbase_length,transitionbase_width,transitionbase_angle, transitionext_demo,transitionextpre_length,transitionextpre_gridSize,transitionextpre_wallthickness,transitionextpost_length,transitionextpost_gridSize,transitionextpost_wallthickness]
showtext = true;
colour = "";
//used to highlight the section of interest.
deemphasizeAlpha = 0.5;
//used to highlight the section of interest.
deemphasizeColor = "grey";
deemphasize = [deemphasizeColor,deemphasizeAlpha];
coloredDeemphasize = ["",deemphasizeAlpha];
//Include help info in the logs
help=false;
showCaliper = false;
setViewPort=true;

/* [Hidden] */
$fn=64;

function con1_key(key) = connector(1, key);
function con2_key(key) = connector(2, key);
function con3_key(key) = connector(3, key);
function connector(number, key) = str("connector", number, key);

/* [Hidden] */
// keys for dictionary-style settings (match gridfinity style)
idrawAlignmentRing        = "drawAlignmentRing";
ialignmentDepth           = "alignmentDepth";
ialignmentUpperWidth      = "alignmentUpperWidth";
ialignmentLowerWidth      = "alignmentLowerWidth";
ialignmentSideClearance   = "alignmentSideClearance";
ialignmentDepthClearance  = "alignmentDepthClearance";

iconStyle          = "Style";
iconWallThickness  = "WallThickness";
iconMeasurement    = "Measurement";
iconDiameter       = "Diameter";
iconLength         = "Length";
iconTaper          = "Taper";
iconRotation       = "Rotation";

iconEndCapDiameter = "EndCapDiameter";
iconEndCapThickness= "EndCapThickness";
iconStopThickness  = "StopThickness";
iconStopLength     = "StopLength";
iconStopSymmetrical= "StopSymmetrical";
iconBarbsCount     = "BarbsCount";
iconBarbsThickness = "BarbsThickness";
iconBarbsSymmetrical="BarbsSymmetrical";
iconEnableThreads  = "EnableThreads";
iconThreadPitch    = "ThreadPitch";
iconThreadToothAngle = "ThreadToothAngle";
iconThreadToothHeight= "ThreadToothHeight";

iconMagnetCount    = "MagnetCount";
iconMagnetDiameter = "MagnetDiameter";
iconMagnetThickness= "MagnetThickness";
iconMagnetBorder   = "MagnetBorder";
iconMagnetFlangeThickness = "MagnetFlangeThickness";
iconRing           = "Ring";
iconMagnetTwistLockSize = "MagnetTwistLockSize";

iconFlangeWidth    = "FlangeWidth";
iconFlangeThickness= "FlangeThickness";
iconFlangeScrewPosition = "FlangeScrewPosition";
iconFlangeScrewBorder   = "FlangeScrewBorder";
iconFlangeScrewCount    = "FlangeScrewCount";
iconFlangeScrewDiameter = "FlangeScrewDiameter";

iconNozzleShape   = "NozzleShape";
iconNozzleSize    = "NozzleSize";
iconNozzleTipWallThickness = "NozzleTipWallThickness";
iconNozzleRadius  = "NozzleRadius";
iconNozzleOffset  = "NozzleOffset";
iconNozzleChamferPercentage = "NozzleChamferPercentage";
iconNozzleChamferAngle      = "NozzleChamferAngle";

iconExtensionLength      = "ExtensionLength";
iconExtensionGridSize    = "ExtensionGridSize";
iconExtensionGridWallThickness = "ExtensionGridWallThickness";
iconExtensionText        = "ExtensionText";
iconExtensionTextSize    = "ExtensionTextSize";

itransitionStyle         = "transitionStyle";
itransitionLength        = "transitionLength";
itransitionBendRadius    = "transitionBendRadius";
itransitionAngle         = "transitionAngle";
itransitionOffset        = "transitionOffset";
itransitionBaseType      = "transitionBaseType";
itransitionBaseThickness = "transitionBaseThickness";
itransitionBaseWidth     = "transitionBaseWidth";
itransitionBaseLength    = "transitionBaseLength";
itransitionBaseAngle     = "transitionBaseAngle";
itransitionEnd2Count     = "transitionEnd2Count";
itransitionHullLength    = "transitionHullLength";
itransitionHullCenterLength = "transitionHullCenterLength";
itransitionHullyOffset   = "transitionHullyOffset";
itransitionHullCenter    = "transitionHullCenter";
itransitionHullCenterHeight = "transitionHullCenterHeight";

isliceDebug              = "sliceDebug";
ishowCaliper             = "showCaliper";
iend1Color               = "end1Color";
iend2Color               = "end2Color";
iend3Color               = "end3Color";
itransitionColor         = "transitionColor";
iextensionColor          = "extensionColor";

irotate                  = "rotate";
itranslate               = "translate";
irendercount             = "rendercount";
irenderseparation        = "renderseparation";
itextposition            = "textposition";
irotaterender1           = "rotaterender1";
irotaterender2           = "rotaterender2";

iscenarioName=0;
iscenarioCount=1;
iscenarioVp=2;
iscenariokv=3;

istepName=0;
istepkv=1;

//Copied from the constants file
iSettingsVersion = 5;

selectedScenario = getDerviedScenario(scenario);
vp=selectedScenario[0][iscenarioVp];
$vpr = setViewPort ? let(vpr = getcustomVpr(vp)) is_list(vpr) ? vpr : [90,0,0] : $vpr;
//shows translation (i.e. won't be affected by rotate and zoom)
$vpt = setViewPort ? let(vpt = getcustomVpt(vp)) is_list(vpt) ? vpt : [0,0,-10] : $vpt;
//shows the camera distance [Note: Requires version 2015.03]
$vpd = setViewPort ? let(vpd = getcustomVpd(vp)) is_num(vpd) ? vpd : 500 : $vpd;
 //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpf = setViewPort ? let(vpf = getcustomVpf(vp)) is_num(vpf) ? vpf : 25 : $vpf;
module end_of_customizer_opts() {}

echo("start",vp=vp, vpr = getcustomVpr(vp), vpt = getcustomVpt(vp), vpd = getcustomVpd(vp), vpf = getcustomVpf(vp));

// Default settings as key/value pairs (dictionary-style)
defaultDemoSetting = [
  [idrawAlignmentRing,        "no"],
  [ialignmentDepth,           2],
  [ialignmentUpperWidth,      3],
  [ialignmentLowerWidth,      0.5],
  [ialignmentSideClearance,   0.25],
  [ialignmentDepthClearance,  0.75],

  [con1_key(iconStyle),          "hose"],
  [con1_key(iconWallThickness),  2],
  [con1_key(iconMeasurement),    "inner"],
  [con1_key(iconDiameter),       40],
  [con1_key(iconLength),         15],
  [con1_key(iconTaper),          0],
  [con1_key(iconRotation),       0],

  [con1_key(iconEndCapDiameter),  0],
  [con1_key(iconEndCapThickness), 0],
  [con1_key(iconStopThickness),   0],
  [con1_key(iconStopLength),      0],
  [con1_key(iconStopSymmetrical), false],
  [con1_key(iconBarbsCount),      0],
  [con1_key(iconBarbsThickness),  0],
  [con1_key(iconBarbsSymmetrical),false],
  [con1_key(iconEnableThreads),   false],
  [con1_key(iconThreadPitch),     0],
  [con1_key(iconThreadToothAngle),30],
  [con1_key(iconThreadToothHeight),0],

  [con1_key(iconMagnetCount),          8],
  [con1_key(iconMagnetDiameter),       19.5],
  [con1_key(iconMagnetThickness),      2.5],
  [con1_key(iconMagnetBorder),         2],
  [con1_key(iconMagnetFlangeThickness),6],
  [con1_key(iconRing),                 "no"],
  [con1_key(iconMagnetTwistLockSize),  "0"],

  [con1_key(iconFlangeWidth),      20],
  [con1_key(iconFlangeThickness),  5],
  [con1_key(iconFlangeScrewPosition),0],
  [con1_key(iconFlangeScrewBorder), 5],
  [con1_key(iconFlangeScrewCount),  4],
  [con1_key(iconFlangeScrewDiameter),5],

  [con1_key(iconExtensionLength),         0],
  [con1_key(iconExtensionGridSize),       0],
  [con1_key(iconExtensionGridWallThickness),0],
  [con1_key(iconExtensionText),           ""],
  [con1_key(iconExtensionTextSize),       0],

  [itransitionStyle,        "bend+taper"],
  [itransitionLength,       10],
  [itransitionBendRadius,   0],
  [itransitionAngle,        0],
  [itransitionOffset,       [0,0]],
  [itransitionBaseType,     "none"],
  [itransitionBaseThickness,0],
  [itransitionBaseWidth,    0],
  [itransitionBaseLength,   0],
  [itransitionBaseAngle,    0],
  [itransitionEnd2Count,    1],
  [itransitionHullLength,   0],
  [itransitionHullCenterLength,0],
  [itransitionHullyOffset,  0],
  [itransitionHullCenter,   "disabled"],
  [itransitionHullCenterHeight,0],

  [con2_key(iconStyle),         "hose"],
  [con2_key(iconWallThickness), 2],
  [con2_key(iconMeasurement),   "outer"],
  [con2_key(iconDiameter),      30],
  [con2_key(iconLength),        20],
  [con2_key(iconTaper),         0],
  [con2_key(iconRotation),      0],

  [con2_key(iconEndCapDiameter),  0],
  [con2_key(iconEndCapThickness), 0],
  [con2_key(iconStopThickness),   0],
  [con2_key(iconStopLength),      0],
  [con2_key(iconStopSymmetrical), false],
  [con2_key(iconBarbsCount),      0],
  [con2_key(iconBarbsThickness),  0],
  [con2_key(iconBarbsSymmetrical),false],
  [con2_key(iconEnableThreads),   false],
  [con2_key(iconThreadPitch),     0],
  [con2_key(iconThreadToothAngle),30],
  [con2_key(iconThreadToothHeight),0],

  [con2_key(iconMagnetCount),          6],
  [con2_key(iconMagnetDiameter),       12],
  [con2_key(iconMagnetThickness),      3],
  [con2_key(iconMagnetBorder),         2],
  [con2_key(iconMagnetFlangeThickness),10],
  [con2_key(iconRing),                 "no"],
  [con2_key(iconMagnetTwistLockSize),  "0"],

  [con2_key(iconFlangeWidth),      20],
  [con2_key(iconFlangeThickness),  5],
  [con2_key(iconFlangeScrewPosition),0],
  [con2_key(iconFlangeScrewBorder), 5],
  [con2_key(iconFlangeScrewCount),  4],
  [con2_key(iconFlangeScrewDiameter),5],

  [con2_key(iconNozzleShape),            "square"],
  [con2_key(iconNozzleSize),             [10,5,10]],
  [con2_key(iconNozzleTipWallThickness), 0],
  [con2_key(iconNozzleRadius),           0],
  [con2_key(iconNozzleOffset),           [0,0]],
  [con2_key(iconNozzleChamferPercentage),0],
  [con2_key(iconNozzleChamferAngle),     0],

  [con2_key(iconExtensionLength),         0],
  [con2_key(iconExtensionGridSize),       0],
  [con2_key(iconExtensionGridWallThickness),0],
  [con2_key(iconExtensionText),           ""],
  [con2_key(iconExtensionTextSize),       0],

  [con3_key(iconStyle),         "hose"],
  [con3_key(iconWallThickness), 2],
  [con3_key(iconMeasurement),   "outer"],
  [con3_key(iconDiameter),      30],
  [con3_key(iconLength),        20],
  [con3_key(iconTaper),         0],
  [con3_key(iconRotation),      0],

  [con3_key(iconEndCapDiameter),  0],
  [con3_key(iconEndCapThickness), 0],
  [con3_key(iconStopThickness),   0],
  [con3_key(iconStopLength),      0],
  [con3_key(iconStopSymmetrical), false],
  [con3_key(iconBarbsCount),      0],
  [con3_key(iconBarbsThickness),  0],
  [con3_key(iconBarbsSymmetrical),false],
  [con3_key(iconEnableThreads),   false],
  [con3_key(iconThreadPitch),     0],
  [con3_key(iconThreadToothAngle),30],
  [con3_key(iconThreadToothHeight),0],

  [con3_key(iconMagnetCount),          6],
  [con3_key(iconMagnetDiameter),       12],
  [con3_key(iconMagnetThickness),      3],
  [con3_key(iconMagnetBorder),         2],
  [con3_key(iconMagnetFlangeThickness),10],
  [con3_key(iconRing),                 "no"],
  [con3_key(iconMagnetTwistLockSize),  "0"],

  [con3_key(iconFlangeWidth),      20],
  [con3_key(iconFlangeThickness),  5],
  [con3_key(iconFlangeScrewPosition),0],
  [con3_key(iconFlangeScrewBorder), 5],
  [con3_key(iconFlangeScrewCount),  4],
  [con3_key(iconFlangeScrewDiameter),5],

  [con3_key(iconNozzleShape),            "square"],
  [con3_key(iconNozzleSize),             [10,5,10]],
  [con3_key(iconNozzleTipWallThickness), 0],
  [con3_key(iconNozzleRadius),           0],
  [con3_key(iconNozzleOffset),           [0,0]],
  [con3_key(iconNozzleChamferPercentage),0],
  [con3_key(iconNozzleChamferAngle),     0],

  [con3_key(iconExtensionLength),         0],
  [con3_key(iconExtensionGridSize),       0],
  [con3_key(iconExtensionGridWallThickness),0],
  [con3_key(iconExtensionText),           ""],
  [con3_key(iconExtensionTextSize),       0],

  [isliceDebug,     false],
  [ishowCaliper,    false],
  [iend1Color,      ["",-1]],
  [iend2Color,      ["",-1]],
  [iend3Color,      ["",-1]],
  [itransitionColor,["",-1]],
  [iextensionColor, ["",-1]],

  [irotate,         [0,0,0]],
  [itranslate,      [0,0,0]],
  [irendercount,    1],
  [irenderseparation,[]],
  [itextposition,   []],
  [irotaterender1,  [0,0,0]],
  [irotaterender2,  [0,0,0]]
];

function isMulti(scenario) = search("multi",scenario) == [0, 1, 2, 3, 4];
function iscustomVP(scenarioVp, length = 0) = is_list(scenarioVp) && len(scenarioVp) >= length;
function getcustomVpr(scenarioVp) = iscustomVP(scenarioVp, 1) ? let(vpr = scenarioVp[0]) is_list(vpr) && len(vpr)==3 ? vpr : false : false;
function getcustomVpt(scenarioVp) = iscustomVP(scenarioVp, 2) ? let(vpt = scenarioVp[1]) is_list(vpt) && len(vpt)==3? vpt : false : false;
function getcustomVpd(scenarioVp) = iscustomVP(scenarioVp, 3) ? let(vpd = scenarioVp[2]) is_num(vpd) ? vpd : false : false;
function getcustomVpf(scenarioVp) = iscustomVP(scenarioVp, 4) ? let(vpf = scenarioVp[3]) is_num(vpf) ? vpf : false : false;

function getScenario(scenario) =
//[0]: seenarioName,scenarioCount,[vpr,vpt,vpd,vpf],[[key,value]]
//[1]: name,[[key,value]]
    scenario == "demo" ? [["Hose Adapters",13,[[],[0,0,26],550],[[irendercount,4], [irenderseparation,[85,0,35]], [itextposition,[0,-80,-10]]]],
      ["Hose connector", [[con1_key(iconStyle),"hose"], [con2_key(iconDiameter),25], [con1_key(iconStopThickness),2], [con1_key(iconStopLength),3], [con1_key(iconTaper),1], [con2_key(iconBarbsCount),3], [con1_key(iconMeasurement),"inner"]]],
      ["Magnetic Flange", [[con1_key(iconStyle), "mag"], [con1_key(iconMagnetCount),6], [con1_key(iconDiameter),45], [con1_key(iconMagnetTwistLockSize), "3cnc"], [con2_key(iconDiameter),50]]],
      ["Flange", [[con1_key(iconStyle), "flange"]]],
      ["Dyson V6 connector", [[con1_key(iconStyle),"dyson"], [itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenterHeight,45]]],
      ["CAMLOCK connector", [[con1_key(iconStyle), "camlock"],[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionLength,10], [itransitionHullCenter,true], [itransitionHullCenterLength,5], [itransitionHullCenterHeight,40], [itransitionHullLength,20], [irotaterender1,[0,0,-45]], [irotaterender2,[0,0,-45]]]],
      ["Dewalt DW735x", [[con1_key(iconStyle),"dw735"], [itransitionBendRadius,10], [itransitionStyle,"taper+bend"], [itransitionAngle,90], [con1_key(iconDiameter),80], [con2_key(iconDiameter),50]]],
      ["Centec Quick Connect Female", [[con1_key(iconStyle), "centec_female"]]],
      ["Centec Quick Connect Male", [[con1_key(iconStyle), "centec_male"]]],
      ["osVAC32 Male", [[con1_key(iconStyle), "osvacm32"]]],
      ["osVAC Male", [[con1_key(iconStyle), "osvacm"]]],
      ["osVAC32 Female", [[con1_key(iconStyle), "osvacf32"]]],
      ["osVAC Female", [[con1_key(iconStyle), "osvacf"]]],
      ["Nozzle", [[itransitionStyle,"bend+taper"], [itransitionBendRadius,10], [itransitionAngle,30], [itransitionLength,3], [con2_key(iconStyle),"nozzle"], [con2_key(iconDiameter),0], [con2_key(iconNozzleShape),"square"], [con2_key(iconNozzleChamferPercentage),50], [con2_key(iconNozzleChamferAngle),45], [con2_key(iconNozzleSize),[10,5,50]]]]    ]
    : scenario == "demo2" ? [["Hose Adapters",13,[[],[10,-0,40],450],[[irendercount, 2],[itextposition,[0,-50,0]]],"demo"]]

    : scenario == "demo_fixed" ? [["Fixed Adapters",9,[[],[10,-0,40],450],[[irendercount, 2],[con2_key(iconDiameter), 50], [itransitionColor,coloredDeemphasize], [iend2Color,coloredDeemphasize], [irenderseparation,[85,0,35]],[itextposition,[0,-50,0]]]],
      ["Dyson V6 connector", [[con1_key(iconStyle),"dyson"]]],
      ["CAMLOCK connector", [[con1_key(iconStyle), "camlock"]]],
      ["Dewalt DW735x", [[con1_key(iconStyle),"dw735"], [itransitionBendRadius,10], [itransitionStyle,"taper+bend"], [itransitionAngle,45]]],
      ["Centec Quick Connect Female", [[con1_key(iconStyle), "centec_female"]]],
      ["Centec Quick Connect Male", [[con1_key(iconStyle), "centec_male"]]],
      ["osVAC32 Male", [[con1_key(iconStyle), "osvacm32"]]],
      ["osVAC Male", [[con1_key(iconStyle), "osvacm"]]],
      ["osVAC32 Female", [[con1_key(iconStyle), "osvacf32"]]],
      ["osVAC Female", [[con1_key(iconStyle), "osvacf"]]]   ]


    //Connector settings
    //endcommon_wallthickness,endcommon_diameter,endcommon_measurement,endcommon_length,endcommon_taper,endcommon_rotation
    : scenario == "endcommon_wallthickness" ? [["End WallThickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["1mm", [[con1_key(iconMeasurement), "inner"],[con1_key(iconWallThickness), 1]]],
        ["2mm", [[con1_key(iconMeasurement), "inner"],[con1_key(iconWallThickness), 2]]],
        ["3mm", [[con1_key(iconMeasurement), "inner"],[con1_key(iconWallThickness), 3]]],
        ["1mm", [[con1_key(iconMeasurement), "outer"],[con1_key(iconWallThickness), 1]]],
        ["2mm", [[con1_key(iconMeasurement), "outer"],[con1_key(iconWallThickness), 2]]],
        ["3mm", [[con1_key(iconMeasurement), "outer"],[con1_key(iconWallThickness), 3]]]
    ]
    : scenario == "endcommon_diameter" ? [["End Diameter",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["20mm", [[con1_key(iconDiameter), 20]]],
        ["30mm", [[con1_key(iconDiameter), 30]]],
        ["40mm", [[con1_key(iconDiameter), 40]]]
    ]
    : scenario == "endcommon_measurement" ? [["End Measurement",2,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["inner", [[con1_key(iconMeasurement), "inner"]]],
        ["outer", [[con1_key(iconMeasurement), "outer"]]]
    ]
    : scenario == "endcommon_length" ? [["End length",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["10mm", [[con1_key(iconLength), 10]]],
        ["20mm", [[con1_key(iconLength), 20]]],
        ["35mm", [[con1_key(iconLength), 35]]]
    ]
    : scenario == "endcommon_taper" ? [["End taper",5,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["no taper", [[con1_key(iconTaper), 0]]],
        ["1mm", [[con1_key(iconMeasurement), "inner"], [con1_key(iconTaper), 1]]],
        ["3mm", [[con1_key(iconMeasurement), "inner"], [con1_key(iconTaper), 3]]],
        ["-1mm", [[con1_key(iconMeasurement), "outer"], [con1_key(iconTaper), -1]]],
        ["-3mm", [[con1_key(iconMeasurement), "outer"], [con1_key(iconTaper), -3]]]
    ]
    : scenario == "endcommon_rotation" ? [["End Rotation",4,[[60,0,0],[10,-0,25],300],[[irendercount, 2],[itextposition,[0,-30,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"], [con1_key(iconDiameter), 30], [con1_key(iconFlangeThickness), 5], [con1_key(iconFlangeScrewPosition), 15], [con1_key(iconFlangeScrewBorder), 7.5], [con1_key(iconFlangeScrewDiameter), 5], [con1_key(iconFlangeScrewCount), 1],[con2_key(iconDiameter), 25], [itransitionEnd2Count,1], [itransitionAngle, 45], [itransitionStyle, "taper+bend"]]],
        ["no rotation", [[con1_key(iconRotation), 0]]],
        ["180deg", [[con1_key(iconRotation), 180]]],
        ["270deg", [[con1_key(iconRotation), 270]]],
        ["315deg", [[con1_key(iconRotation), 315]]]
    ]

    //hose settings
    //hose_demo,hose_stopthickness,hose_stoplength,hose_stopsymmetrical,hose_barbsthickness,hose_barbscount,hose_barbssymmetrical,hose_endcapthickness,hose_endcapdiameter
    : scenario == "hose_demo" ? [["Hose",5,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40], [con1_key(iconStyle), "hose"]]],
      ["50mm with internal stop", [[con1_key(iconDiameter), 50],[con1_key(iconStopLength), 3], [con1_key(iconStopThickness), 2],[con1_key(iconTaper), -1]]],
      ["50mm with external stop", [[con1_key(iconDiameter), 50],[con1_key(iconStopLength), 3], [con1_key(iconStopThickness), 2],[con1_key(iconTaper), 1]]],
      ["25mm with barbs", [[con1_key(iconDiameter), 25], [con1_key(iconBarbsCount), 3],[con1_key(iconMeasurement), "outer"]]],
      ["closed cap", [[con1_key(iconDiameter), 25],[con1_key(iconLength), 3], [con1_key(iconMeasurement), "inner"], [con1_key(iconEndCapThickness), 3], [con1_key(iconEndCapDiameter), 0]]],
      ["", [[con1_key(iconStyle), "hose"]]]
    ]
    : scenario == "hose_stopthickness" ? [["Stop Thickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconStopLength),2]]],
        ["1mm outer", [[con1_key(iconStopThickness), 1],[con1_key(iconTaper), 1]]],
        ["2mm outer", [[con1_key(iconStopThickness), 2],[con1_key(iconTaper), 1]]],
        ["3mm outer", [[con1_key(iconStopThickness), 3],[con1_key(iconTaper), 1]]],
        ["1mm inner", [[con1_key(iconStopThickness), 1],[con1_key(iconTaper), -1]]],
        ["2mm inner", [[con1_key(iconStopThickness), 2],[con1_key(iconTaper), -1]]],
        ["3mm inner", [[con1_key(iconStopThickness), 3],[con1_key(iconTaper), -1]]]
    ]
    : scenario == "hose_stoplength" ? [["Stop Length",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter),40],[con1_key(iconStopThickness), 2]]],
        ["2mm outer", [[con1_key(iconStopLength), 2],[con1_key(iconTaper), 1]]],
        ["3mm outer", [[con1_key(iconStopLength), 3],[con1_key(iconTaper), 1]]],
        ["4mm outer", [[con1_key(iconStopLength), 4],[con1_key(iconTaper), 1]]],
        ["2mm inner", [[con1_key(iconStopLength), 2],[con1_key(iconTaper), -1]]],
        ["3mm inner", [[con1_key(iconStopLength), 3],[con1_key(iconTaper), -1]]],
        ["4mm inner", [[con1_key(iconStopLength), 4],[con1_key(iconTaper), -1]]]
    ]
    : scenario == "hose_stopsymmetrical" ? [["Stop Symmetrical",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter),40], [con1_key(iconStopThickness), 2],[con1_key(iconStopLength), 3]]],
        ["true outer", [[con1_key(iconStopSymmetrical), true],[con1_key(iconTaper), 1]]],
        ["false outer", [[con1_key(iconStopSymmetrical), false],[con1_key(iconTaper), 1]]],
        ["true inner", [[con1_key(iconStopSymmetrical), true],[con1_key(iconTaper), -1]]],
        ["false inner ", [[con1_key(iconStopSymmetrical), false],[con1_key(iconTaper), -1]]]
    ]
    : scenario == "hose_barbscount" ? [["Barbs Count",8,[[],[10,-0,25],260],[[irendercount,2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconLength),35]]],
        ["0 outer", [[con1_key(iconBarbsCount), 0],[con1_key(iconMeasurement), "outer"]]],
        ["1 outer", [[con1_key(iconBarbsCount), 1],[con1_key(iconMeasurement), "outer"]]],
        ["2 outer", [[con1_key(iconBarbsCount), 2],[con1_key(iconMeasurement), "outer"]]],
        ["3 outer", [[con1_key(iconBarbsCount), 3],[con1_key(iconMeasurement), "outer"]]],
        ["0 inner", [[con1_key(iconBarbsCount), 0],[con1_key(iconMeasurement), "inner"]]],
        ["1 inner", [[con1_key(iconBarbsCount), 1],[con1_key(iconMeasurement), "inner"]]],
        ["2 inner", [[con1_key(iconBarbsCount), 2],[con1_key(iconMeasurement), "inner"]]],
        ["3 inner", [[con1_key(iconBarbsCount), 3],[con1_key(iconMeasurement), "inner"]]]
    ]
    : scenario == "hose_threads" ? [["Threads",4,[[],[10,-0,25],260],[[irendercount,2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconLength),35], [con1_key(iconEnableThreads), true]]],
        ["small outer", [[con1_key(iconThreadPitch), 5],[con1_key(iconThreadToothAngle), 45],[con1_key(iconThreadToothHeight), 5],[con1_key(iconMeasurement), "outer"]]],
        ["small inner", [[con1_key(iconThreadPitch), 5],[con1_key(iconThreadToothAngle), 45],[con1_key(iconThreadToothHeight), 5],[con1_key(iconMeasurement), "inner"], [isliceDebug, true]]],
        ["large outer", [[con1_key(iconThreadPitch), 8],[con1_key(iconThreadToothAngle), 45],[con1_key(iconThreadToothHeight), 8],[con1_key(iconMeasurement), "outer"]]],
        ["large inner", [[con1_key(iconThreadPitch), 8],[con1_key(iconThreadToothAngle), 45],[con1_key(iconThreadToothHeight), 8],[con1_key(iconMeasurement), "inner"], [isliceDebug, true]]]
    ]
    : scenario == "hose_barbsthickness" ? [["Barbs Thickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconLength), 35], [con1_key(iconBarbsCount), 2]]],
        ["1 outer", [[con1_key(iconBarbsThickness), 1],[con1_key(iconMeasurement), "outer"]]],
        ["2 outer", [[con1_key(iconBarbsThickness), 2],[con1_key(iconMeasurement), "outer"]]],
        ["3 outer", [[con1_key(iconBarbsThickness), 3],[con1_key(iconMeasurement), "outer"]]],
        ["1 inner", [[con1_key(iconBarbsThickness), 1],[con1_key(iconMeasurement), "inner"]]],
        ["2 inner", [[con1_key(iconBarbsThickness), 2],[con1_key(iconMeasurement), "inner"]]],
        ["4 inner", [[con1_key(iconBarbsThickness), 3],[con1_key(iconMeasurement), "inner"]]]
    ]
    : scenario == "hose_barbssymmetrical" ? [["Barbs Symmetrical",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconLength), 35], [con1_key(iconBarbsCount), 2]]],
        ["on outer", [[con1_key(iconBarbsSymmetrical), true],[con1_key(iconMeasurement), "outer"]]],
        ["off outer", [[con1_key(iconBarbsSymmetrical), false],[con1_key(iconMeasurement), "outer"]]],
        ["on inner", [[con1_key(iconBarbsSymmetrical), true],[con1_key(iconMeasurement), "inner"]]],
        ["off inner", [[con1_key(iconBarbsSymmetrical), false],[con1_key(iconMeasurement), "inner"]]]
    ]
    : scenario == "hose_endcapthickness" ? [["Hose End Cap",4,[[125,0,0],[10,-0,25],260],[[con1_key(iconStyle),"hose"],[irendercount,2],[itextposition,[0,-55,-20]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconEndCapDiameter), 0]]],
        ["thickness 0mm", [[con1_key(iconEndCapThickness), 0]]],
        ["thickness 1mm", [[con1_key(iconEndCapThickness), 1]]],
        ["thickness 2mm", [[con1_key(iconEndCapThickness), 2]]],
        ["thickness 3mm", [[con1_key(iconEndCapThickness), 3]]]
    ]
    : scenario == "hose_endcapdiameter" ? [["Hose End Cap",3,[[125,0,0],[10,-0,25],260],[[con1_key(iconStyle), "hose"],[irendercount, 2],[itextposition,[0,-55,-20]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [con1_key(iconDiameter),40],[con1_key(iconEndCapDiameter), 0]]],
        ["diameter 0mm", [[con1_key(iconEndCapThickness), 3]]],
        ["diameter 5mm",  [[con1_key(iconEndCapThickness), 3], [con1_key(iconEndCapDiameter), 5]]],
        ["diameter 10mm", [[con1_key(iconEndCapThickness), 3], [con1_key(iconEndCapDiameter), 10]]]
    ]

    //flange
    //flange_demo,flange_width,flange_thickness,flange_screwposition,flange_screwborder,flange_screwcount,flange_screwdiameter
    : scenario == "flange_demo" ? [["Flange",4,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"], [con1_key(iconFlangeThickness), 5], [con1_key(iconFlangeScrewPosition), 15], [con1_key(iconFlangeScrewBorder), 7.5], [con1_key(iconFlangeScrewDiameter), 5]]],
      ["single screw", [[con1_key(iconFlangeScrewCount), 1]]],
      ["4 screws", [[con1_key(iconFlangeScrewCount), 4]]],
      ["4 screws, 25mm", [[con1_key(iconFlangeScrewCount), 4], [con1_key(iconFlangeScrewPosition), 25]]],
      ["6 screws", [[con1_key(iconFlangeScrewCount), 6], [con1_key(iconFlangeWidth), 15]]]
    ]
    : scenario == "flange_width" ? [["Flange Width",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"]]],
        ["diameter 10mm", [[con1_key(iconFlangeWidth), 10]]],
        ["diameter 15mm", [[con1_key(iconFlangeWidth), 15]]],
        ["diameter 20mm", [[con1_key(iconFlangeWidth), 20]]]
    ]
    : scenario == "flange_thickness" ? [["Flange Thickness",3,[[125,0,0],[10,-0,25],350],[[con1_key(iconStyle), "flange"],[irendercount, 2],[itextposition,[0,-55,-20]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconFlangeScrewPosition), 10]]],
        ["diameter 1mm", [[con1_key(iconFlangeThickness), 1]]],
        ["diameter 2mm", [[con1_key(iconFlangeThickness), 2]]],
        ["diameter 5mm", [[con1_key(iconFlangeThickness), 5]]]
    ]
    : scenario == "flange_screwposition" ? [["Flange Screw Position",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"], [con1_key(iconFlangeWidth), 20]]],
        ["default", [[con1_key(iconFlangeScrewPosition), 0]]],
        ["diameter 15mm", [[con1_key(iconFlangeScrewPosition), 15]]],
        ["diameter 25mm", [[con1_key(iconFlangeScrewPosition), 25]]]
    ]
    : scenario == "flange_screwborder" ? [["Flange Screw Border",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"]]],
        ["diameter 5mm", [[con1_key(iconFlangeScrewBorder), 5]]],
        ["diameter 10mm", [[con1_key(iconFlangeScrewBorder), 10]]],
        ["diameter 15mm", [[con1_key(iconFlangeScrewBorder), 15]]]
    ]
    : scenario == "flange_screwcount" ? [["Flange Screw Count",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"]]],
        ["1", [[con1_key(iconFlangeScrewCount), 1]]],
        ["4", [[con1_key(iconFlangeScrewCount), 4]]],
        ["6", [[con1_key(iconFlangeScrewCount), 6]]]
    ]
    : scenario == "flange_screwdiameter" ? [["Flange Screw Diameter",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "flange"]]],
        ["4", [[con1_key(iconFlangeScrewDiameter), 4]]],
        ["8", [[con1_key(iconFlangeScrewDiameter), 8]]],
        ["12", [[con1_key(iconFlangeScrewDiameter), 12]]]
    ]

    //magnet
    //magnetic_flangedemo,magnetic_magnetcount,magnetic_magnetdiameter,magnetic_magnetthickness,magnetic_magnetborder,magnetic_flangethickness,magnetic_alignmentring,magnetic_twistlock
    : scenario == "magnetic_flangedemo" ? [["Magnetic Flange",4,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconFlangeThickness), 5], [con1_key(iconFlangeScrewPosition), 15], [con1_key(iconFlangeScrewBorder), 7.5], [con1_key(iconFlangeScrewDiameter), 5]]],
      ["single screw", [[con1_key(iconFlangeScrewCount), 1]]],
      ["4 screws", [[con1_key(iconFlangeScrewCount), 4]]],
      ["4 screws, 25mm", [[con1_key(iconFlangeScrewCount), 4], [con1_key(iconFlangeScrewPosition), 25]]],
      ["6 screws", [[con1_key(iconFlangeScrewCount), 6], [con1_key(iconFlangeWidth), 15]]]
    ]
    : scenario == "magnetic_magnetcount" ? [["Magnetic Flange, Magnet Count",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["6", [[con1_key(iconMagnetCount), 6]]],
      ["8", [[con1_key(iconMagnetCount), 8]]],
      ["12", [[con1_key(iconMagnetCount), 12]]]
    ]
    : scenario == "magnetic_magnetdiameter" ? [["Magnetic Flange, Magnet Diameter",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["6mm", [[con1_key(iconMagnetDiameter), 6]]],
      ["8mm", [[con1_key(iconMagnetDiameter), 8]]],
      ["12mm", [[con1_key(iconMagnetDiameter), 12]]]
    ]
    : scenario == "magnetic_magnetthickness" ? [["Magnetic Flange, Magnet Thickness",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["2.5mm", [[con1_key(iconMagnetThickness), 2.5]]],
      ["4mm", [[con1_key(iconMagnetThickness), 4]]],
      ["5mm", [[con1_key(iconMagnetThickness), 5]]]
    ]
    : scenario == "magnetic_magnetborder" ? [["Magnetic Flange, Magnet Border",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["2mm", [[con1_key(iconMagnetBorder), 2]]],
      ["4mm", [[con1_key(iconMagnetBorder), 4]]],
      ["6mm", [[con1_key(iconMagnetBorder), 6]]]
    ]
    : scenario == "magnetic_flangethickness" ? [["Magnetic Flange, Flange Thickness",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["5mm", [[con1_key(iconMagnetFlangeThickness), 5]]],
      ["7.5mm", [[con1_key(iconMagnetFlangeThickness), 7.5]]],
      ["10mm", [[con1_key(iconMagnetFlangeThickness), 10]]]
    ]
    : scenario == "magnetic_alignmentring" ? [["Magnetic Flange, Alignment Ring",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60]]],
      ["disabled", [[con1_key(iconRing), "no"]]],
      ["protruding", [[con1_key(iconRing), "protruding"]]],
      ["recessed", [[con1_key(iconRing), "recessed"]]]
    ]
    : scenario == "magnetic_twistlock" ? [["Magnetic Flange, Twist Lock",7,[[170,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-200,-355]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconStyle), "mag"], [con1_key(iconDiameter), 60], [con1_key(iconMagnetCount), 6]]],
      ["none", [[con1_key(iconMagnetTwistLockSize), "0"]]],
      ["M3", [[con1_key(iconMagnetTwistLockSize), "3"]]],
      ["M3 with CNC Kitchen insert", [[con1_key(iconMagnetTwistLockSize), "3cnc"]]],
      ["M4", [[con1_key(iconMagnetTwistLockSize), "4"]]],
      ["M4 with CNC Kitchen insert", [[con1_key(iconMagnetTwistLockSize), "4cnc"]]],
      ["M5", [[con1_key(iconMagnetTwistLockSize), "5"]]],
      ["M5 with CNC Kitchen insert", [[con1_key(iconMagnetTwistLockSize), "5cnc"]]],
    ]

    //allignmentring_demo
    //allignmentring_demo,allignmentring_depth,allignmentring_upperwidth,allignmentring_lowerwidth,allignmentring_sideclearance,allignmentring_depthclearance
    : scenario == "allignmentring_demo" ? [["Alignment Ring",1,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["", []]
    ]
    : scenario == "allignmentring_depth" ? [["Alignment Ring, Depth",4,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["1mm", [[ialignmentDepth, 1]]],
      ["2mm", [[ialignmentDepth, 2]]],
      ["3mm", [[ialignmentDepth, 3]]],
      ["4mm", [[ialignmentDepth, 4]]]
    ]
    : scenario == "allignmentring_upperwidth" ? [["Alignment Ring, Upper Width",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["2mm", [[ialignmentUpperWidth, 2]]],
      ["3mm", [[ialignmentUpperWidth, 3]]],
      ["4mm", [[ialignmentUpperWidth, 4]]],
    ]
    : scenario == "allignmentring_lowerwidth" ? [["Alignment Ring, Lower Width",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.5mm", [[ialignmentLowerWidth, 0.5]]],
      ["1mm", [[ialignmentLowerWidth, 1]]],
      ["1.5mm", [[ialignmentLowerWidth, 1.5]]],
    ]
    : scenario == "allignmentring_sideclearance" ? [["Alignment Ring, Side Clearance",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.1mm", [[ialignmentSideClearance, 0.1]]],
      ["0.25mm", [[ialignmentSideClearance, 0.25]]],
      ["0.5mm", [[ialignmentSideClearance, 0.5]]],
    ]
    : scenario == "allignmentring_depthclearance" ? [["Alignment Ring, Depth Clearance",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [con1_key(iconDiameter), 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.5mm", [[ialignmentDepthClearance, 0.5]]],
      ["0.75mm", [[ialignmentDepthClearance, 0.75]]],
      ["1mm", [[ialignmentDepthClearance, 1]]],
    ]

    //nozzle
    //nozzle_demo,nozzle_shape,nozzle_size,nozzle_tipwallthickness,nozzle_radius,nozzle_offset,nozzle_chamferpercentage,nozzle_chamferangle
    : scenario == "nozzle_demo" ? [["Nozzle",1,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]],[con1_key(iconStyle), "hose"], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"]]],
      ["", [[con1_key(iconStyle), "hose"]]]
    ]
    : scenario == "nozzle_shape" ? [["Nozzle Shape",2,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize],[con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"]]],
      ["", [[con2_key(iconNozzleShape), "square"]]],
      ["", [[con2_key(iconNozzleShape), "circle"]]]
    ]
    : scenario == "nozzle_size" ? [["Nozzle Size",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"],[con2_key(iconNozzleShape), "square"]]],
      ["10mm x 10mm x 20mm", [[con2_key(iconNozzleSize), [10,10,20]]]],
      ["20mm x 10mm x 20mm", [[con2_key(iconNozzleSize), [20,10,20]]]],
      ["20mm x 20mm x 20mm", [[con2_key(iconNozzleSize), [20,20,20]]]],
      ["20mm x 20mm x 40mm", [[con2_key(iconNozzleSize), [20,20,40]]]]
    ]
    : scenario == "nozzle_tipwallthickness" ? [["Nozzle Tip Wall Thickness",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"],[con2_key(iconNozzleShape), "square"]]],
      ["0.5mm", [[con2_key(iconNozzleTipWallThickness), 0.5]]],
      ["1mm", [[con2_key(iconNozzleTipWallThickness), 1]]],
      ["2mm", [[con2_key(iconNozzleTipWallThickness), 2]]]
    ]
    : scenario == "nozzle_radius" ? [["Nozzle Radius",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"],[con2_key(iconNozzleShape), "square"]]],
      ["1mm", [[con2_key(iconNozzleRadius), 1]]],
      ["2mm", [[con2_key(iconNozzleRadius), 2]]],
      ["5mm", [[con2_key(iconNozzleRadius), 5]]]
    ]
    : scenario == "nozzle_offset" ? [["Nozzle Offset",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"],[con2_key(iconNozzleShape), "square"]]],
      ["5mm x 0mm", [[con2_key(iconNozzleOffset), [5,0]]]],
      ["10mm x 0mm", [[con2_key(iconNozzleOffset), [10,0]]]],
      ["20mm x 10mm", [[con2_key(iconNozzleOffset), [20,10]]]],
      ["20mm x 20mm", [[con2_key(iconNozzleOffset), [20,20]]]]
    ]
    : scenario == "nozzle_chamferpercentage" ? [["Nozzle Chamfer Percentage",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"], [con2_key(iconNozzleShape), "square"], [con2_key(iconNozzleChamferAngle), 45]]],
      ["25%", [[con2_key(iconNozzleChamferPercentage), 25]]],
      ["50%", [[con2_key(iconNozzleChamferPercentage), 50]]],
      ["100%", [[con2_key(iconNozzleChamferPercentage), 100]]]
    ]
    : scenario == "nozzle_chamferangle" ? [["Nozzle Chamfer Angle",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [con1_key(iconStyle), "hose"], [con1_key(iconLength), 5], [con2_key(iconDiameter), 20], [con2_key(iconStyle), "nozzle"], [con2_key(iconNozzleShape), "square"], [con2_key(iconNozzleChamferPercentage), 50]]],
      ["10", [[con2_key(iconNozzleChamferAngle), 10]]],
      ["30", [[con2_key(iconNozzleChamferAngle), 30]]],
      ["45", [[con2_key(iconNozzleChamferAngle), 45]]]
    ]

    : scenario == "base_smple" ? [["Sample",1,[[],[0,0,20],250],[[itextposition,[0,-40,20]], [irotate, [0,0,-90]],[itransitionColor, coloredDeemphasize], [iend2Color, coloredDeemphasize], [itransitionStyle,"none"], [con2_key(iconStyle), "none"], [con1_key(iconExtensionLength), 10]]],
      ["", []]
    ]
    : scenario == "base_dmo" ? [["Sample",5,[[90,0,0],[0,0,60],350],[[irendercount,2], [itextposition,[0,-40,-30]], [irenderseparation,[80,0,0]], [itransitionColor,coloredDeemphasize], [iend2Color,coloredDeemphasize]]],
      ["Hose Adapter", []],
      ["Bent Hose Adapter", [[itransitionBendRadius,10], [itransitionAngle,45], [con2_key(iconBarbsCount),3], [con2_key(iconMeasurement),"outer"]]],
      ["Nozzle", [[itransitionStyle,"bend+taper"], [itransitionBendRadius,10], [itransitionAngle,30], [itransitionLength,3], [con2_key(iconStyle),"nozzle"], [con2_key(iconDiameter),0], [con2_key(iconNozzleShape),"square"], [con2_key(iconNozzleChamferPercentage),50], [con2_key(iconNozzleChamferAngle),45],[con2_key(iconNozzleSize),[10,5,50]]]],
      ["Double Adapter", [[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenterHeight,45]]],
      ["Triple Adapter", [[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [irotaterender1,[0,0,-45]], [irotaterender2,[0,0,-45]]]]
    ]
    //camlock
    //camlock_sample,base_dmo
    : scenario == "camlock_sample" ? [["CamLock Quick Connect",1,[],[[con1_key(iconStyle), "camlock"], [con1_key(iconExtensionText), str("Camlock - v" ,retrieveConnectorSetting("camlock", iSettingsVersion))]],"base_smple"]]
    : scenario == "camlock_demo" ? [["CamLock Quick Connect",5,[],[[con1_key(iconStyle), "camlock"]],"base_dmo"]]
    //centec
    //centec_female_sample,centec_female_demo,centec_male_sample,centec_male_demo
    : scenario == "centec_female_sample" ? [["Centec Female",1,[],[[con1_key(iconStyle), "centec_female"], [con1_key(iconExtensionText), str("Centec Female - v" ,retrieveConnectorSetting("centec_female", iSettingsVersion))]],"base_smple"]]
    : scenario == "centec_female_demo" ? [["Centec Female Quick Connect",5,[],[[con1_key(iconStyle), "centec_female"]],"base_dmo"]]
    : scenario == "centec_male_sample" ? [["Centec Male",1,[],[[con1_key(iconStyle), "centec_male"], [con1_key(iconExtensionText), str("Centec Male - V" ,retrieveConnectorSetting("centec_male", iSettingsVersion))]],"base_smple"]]
    : scenario == "centec_male_demo" ? [["Centec Male Quick Connect",5,[],[[con1_key(iconStyle), "centec_male"]],"base_dmo"]]
    //dyson
    //dyson_sample,dyson_demo
    : scenario == "dyson_sample" ? [["Dyson V6",1,[],[[con1_key(iconStyle), "dyson"], [con1_key(iconExtensionText), str("Dyson V6 - v" ,retrieveConnectorSetting("dyson", iSettingsVersion))]],"base_smple"]]
    : scenario == "dyson_demo" ? [["Dyson",5,[],[[con1_key(iconStyle), "dyson"]],"base_dmo"]]
    //dw735
    //dw735_sample,dw735_demo
    : scenario == "dw735_sample" ? [["Dewalt 735",1,[],[[con1_key(iconStyle), "dw735"], [con1_key(iconExtensionText), str("Dewalt 735 - v" ,retrieveConnectorSetting("dw735", iSettingsVersion))]],"base_smple"]]
    : scenario == "dw735_demo" ? [["Dewalt 735",5,[],[[con1_key(iconStyle), "dw735"]],"base_dmo"]]
    //makita_male
    //makita_male_sample,makita_male_demo
    : scenario == "makita_male_sample" ? [["Makita QC",1,[],[[con1_key(iconStyle), "makita_male"], [con1_key(iconExtensionText), str("Makita QC - v" ,retrieveConnectorSetting("makita_male", iSettingsVersion))]],"base_smple"]]
    : scenario == "makita_male_demo" ? [["Makita QC",5,[],[[con1_key(iconStyle), "makita_male"]],"base_dmo"]]
    //osvacm32_sample,osvacm32_demo,osvacm_sample,osvacm_demo,osvacf32_sample,osvacf32_demo,osvacf_sample,osvacf_demo
    : scenario == "osvacm32_sample" ? [["osVAC32 Male",1,[],[[con1_key(iconStyle), "osvacm32"], [con1_key(iconExtensionText), str("osVAC32 Male - v" ,retrieveConnectorSetting("osvacm32", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacm32_demo" ? [["osVAC32 Male",5,[],[[con1_key(iconStyle), "osvacm32"]],"base_dmo"]]
    : scenario == "osvacm_sample" ? [["osVAC Male",1,[],[[con1_key(iconStyle), "osvacm"], [con1_key(iconExtensionText), str("osVAC Male - v" ,retrieveConnectorSetting("osvacm", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacm_demo" ? [["osVAC Male",5,[],[[con1_key(iconStyle), "osvacm"]],"base_dmo"]]
    : scenario == "osvacf32_sample" ? [["osVAC32 Female",1,[],[[con1_key(iconStyle), "osvacf32"], [con1_key(iconExtensionText), str("osVAC32 Female - v" ,retrieveConnectorSetting("osvacf32", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacf32_demo" ? [["osVAC32 Female",5,[],[[con1_key(iconStyle), "osvacf32"]],"base_dmo"]]
    : scenario == "osvacf_sample" ? [["osVAC Female",1,[],[[con1_key(iconStyle), "osvacf"], [con1_key(iconExtensionText), str("osVAC Female - v" ,retrieveConnectorSetting("osvacf", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacf_demo" ? [["osVAC Female",5,[],[[con1_key(iconStyle), "osvacf"]],"base_dmo"]]

    //transition
    //transition_demo,transition_bendtaper,transition_taperbend,transition_organicbend,transition_flat,
    : scenario == "transition_demo" ? [["Transition",9,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [itransitionBendRadius,20],[itransitionAngle,20], [iend1Color, coloredDeemphasize], [iend2Color, coloredDeemphasize], [iend3Color, coloredDeemphasize]]],
      ["hull 3", [[itransitionStyle, "hull"],[itransitionEnd2Count, 1], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [con2_key(iconDiameter), 20], [con3_key(iconDiameter), 30], [itransitionHullLength, 10]]],
      ["bend+taper", [[itransitionStyle, "bend+taper"]]],
      ["taper+bend", [[itransitionStyle, "taper+bend"]]],
      ["organicbend", [[itransitionStyle, "organicbend"]]],
      ["hull 1", [[itransitionStyle, "hull"]]],
      ["hull 2", [[itransitionStyle, "hull"],[itransitionEnd2Count, 2]]],
      ["hull 3", [[itransitionStyle, "hull"],[itransitionEnd2Count, 1], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [con2_key(iconDiameter), 20], [con3_key(iconDiameter), 30], [itransitionHullLength, 10]]],
      ["hull 4", [[itransitionStyle, "hull"],[itransitionEnd2Count, 2], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [con2_key(iconDiameter), 20], [con3_key(iconDiameter), 30], [itransitionHullLength, 10], [irotaterender1,[0,0,-25]], [irotaterender2,[0,0,-25]]]],
      ["flat", [[itransitionStyle, "flat"]]]
    ]

    : scenario == "transition_bendtaper" ? [["Transition Bend + Taper",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[100,0,0]], [itransitionBendRadius,10], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "bend+taper"]]],
      ["0deg 1 end", [[itransitionAngle,0], [itransitionEnd2Count,1]]],
      ["45deg 1 end", [[itransitionAngle,45], [itransitionEnd2Count,1]]],
      ["90deg, 1 end, oval base", [[itransitionAngle,90], [itransitionEnd2Count,1], [itransitionBaseType,"oval"]]],
      ["45deg, 2 end", [[itransitionAngle,45], [itransitionEnd2Count,2]]],
    ]
    : scenario == "transition_taperbend" ? [["Transition Taper + Bend",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[90,0,0]], [itransitionBendRadius,10], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "taper+bend"]]],
      ["0deg 1 end", [[itransitionAngle,0], [itransitionEnd2Count,1]]],
      ["45deg 1 end", [[itransitionAngle,45], [itransitionEnd2Count,1]]],
      ["90deg, 1 end, oval base", [[itransitionAngle,90], [itransitionEnd2Count,1], [itransitionBaseType,"oval"]]],
      ["45deg, 2 end", [[itransitionAngle,45], [itransitionEnd2Count,2]]],
    ]
    : scenario == "transition_organicbend" ? [["Transition Organic Bend",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [itransitionBendRadius,10], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "organicbend"]]],
      ["0deg 1 end", [[itransitionAngle,0], [itransitionEnd2Count,1]]],
      ["45deg 1 end", [[itransitionAngle,45], [itransitionEnd2Count,1]]],
      ["90deg, 1 end, oval base", [[itransitionAngle,90], [itransitionEnd2Count,1], [itransitionBaseType,"oval"]]],
      ["45deg, 2 end", [[itransitionAngle,45], [itransitionEnd2Count,2]]],
    ]
    : scenario == "transition_flat" ? [["Transition Flat",2,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "flat"]]],
      ["5mm", [[itransitionLength,5]]],
      ["10mm", [[itransitionBendRadius,10]]],
    ]
    //transition_hull
    //transition_hull,transition_hulllength,transition_hulloffset,transition_hullcenter
    : scenario == "transition_hull" ? [["Transition Hull",4,[[60,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[100,0,0]], [itransitionBendRadius,10], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "hull"]]],
      ["45deg 2 end", [[itransitionAngle,45], [itransitionEnd2Count,2]]],
      ["45deg 3 end (2 with center)", [[itransitionAngle,45], [itransitionEnd2Count,2], [itransitionHullCenter, true], [itransitionHullCenterHeight, 45], [itransitionHullLength, 20]]],
      ["45deg 5 end (4 with center)", [[itransitionAngle,45], [itransitionEnd2Count,4], [itransitionHullCenter, true], [itransitionHullCenterHeight, 45], [itransitionHullLength, 20]]],
      ["90deg, 2 end", [[itransitionAngle,90], [itransitionEnd2Count,2]]],
    ]
    : scenario == "transition_hulllength" ? [["Transition Hull Length",4,[[60,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[100,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "hull"], [itransitionAngle,45], [itransitionEnd2Count,2], [itransitionHullCenter, true], [itransitionHullCenterHeight, 45], [itransitionBendRadius,10]]],
      ["0mm", [[itransitionHullCenter, false], [itransitionHullLength, 0]]],
      ["15mm", [ [itransitionHullLength, 15]]],
      ["20mm", [ [itransitionHullLength, 20]]],
      ["30mm", [ [itransitionHullLength, 30]]],
    ]
    : scenario == "transition_hulloffset" ? [["Transition Hull Offset",4,[[60,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[100,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "hull"], [itransitionAngle,45], [itransitionEnd2Count,2]]],
      ["0mm", [[itransitionHullyOffset, 0]]],
      ["1mm", [ [itransitionHullyOffset, 1]]],
      ["2mm", [ [itransitionHullyOffset, 2]]],
      ["5mm", [ [itransitionHullyOffset, 5]]],
    ]
    : scenario == "transition_hullcenter" ? [["Transition Hull Center",4,[[60,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[100,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "hull"], [itransitionAngle,45], [itransitionEnd2Count,2], [itransitionHullyOffset, 2],[itransitionHullLength, 15]]],
      ["disabled", [[itransitionHullCenter, false]]],
      ["enabled 30mm (too low)", [[itransitionHullCenter, true], [itransitionHullCenterHeight, 30]]],
      ["enabled 40mm", [[itransitionHullCenter, true], [itransitionHullCenterHeight, 40]]],
      ["enabled 50mm", [[itransitionHullCenter, true], [itransitionHullCenterHeight, 50]]],
     ]

    //transition_length,transition_angle,transition_bendradius,transition_offset,transition_EndCount
    : scenario == "transition_length" ? [["Transition Length",6,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[itransitionLength,0]]],
      ["10mm", [[itransitionLength,10]]],
      ["20mm", [[itransitionLength,20]]],
      ["0mm 15deg", [[itransitionLength,0], [itransitionAngle,15]]],
      ["10mm 15deg", [[itransitionLength,10], [itransitionAngle,15]]],
      ["20mm 15deg", [[itransitionLength,20], [itransitionAngle,15]]]
    ]
    : scenario == "transition_angle" ? [["Transition Angle",5,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0deg", [[itransitionAngle,0]]],
      ["15deg", [[itransitionAngle,15]]],
      ["30deg", [[itransitionAngle,30]]],
      ["45deg", [[itransitionAngle,45]]],
      ["90deg", [[itransitionAngle,90]]]
    ]
    : scenario == "transition_bendradius" ? [["Transition Bend Radius",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]],[itransitionAngle,45], [irenderseparation,[60,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize]]],
      ["10mm", [[itransitionBendRadius,10]]],
      ["25mm", [[itransitionBendRadius,25]]],
      ["50mm", [[itransitionBendRadius,50]]],
    ]
    : scenario == "transition_offset" ? [["Transition Offset",5,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[60,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize]]],
      ["0mm x 0mm", [[itransitionOffset,[0,0]]]],
      ["5mm x 0mm", [[itransitionOffset,[5,0]]]],
      ["0mm x 5mm", [[itransitionOffset,[0,5]]]],
      ["-5mm x 0mm", [[itransitionOffset,[-5,0]]]],
      ["0mm x -5mm", [[itransitionOffset,[0,-5]]]],
    ]
    : scenario == "transition_EndCount" ? [["Transition End Count",4,[[60,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[100,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize], [itransitionAngle,60],[itransitionBendRadius,30]]],
      ["1", [[itransitionEnd2Count,1]]],
      ["2", [[itransitionEnd2Count,2]]],
      ["3", [[itransitionEnd2Count,3]]],
      ["4", [[itransitionEnd2Count,4]]]
    ]
    //transitionbase
    //transitionbase,transitionbase_thickness,transitionbase_length,transitionbase_width,transitionbase_angle
    : scenario == "transitionbase" ? [["Transition Base",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionAngle,90], [irenderseparation,[70,0,0]], [iend1Color, deemphasize], [iend2Color, deemphasize], [irotaterender1,[0,0,-45]]]],
      ["none", [[itransitionBaseType,"none"]]],
      ["oval", [[itransitionBaseType,"oval"]]],
      ["rectangle", [[itransitionBaseType,"rectangle"], [itransitionBaseThickness,0]]]
    ]
    : scenario == "transitionbase_thickness" ? [["Transition Base Thickness",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [iend1Color,deemphasize], [iend2Color,deemphasize], [irotaterender1,[0,0,-45]], [itransitionAngle,90], [irenderseparation,[70,0,0]], [itransitionBaseType,"oval"]]],
      ["0mm", [[itransitionBaseThickness,0]]],
      ["2mm", [[itransitionBaseThickness,2]]],
      ["5mm", [[itransitionBaseThickness,5]]]
    ]
    : scenario == "transitionbase_length" ? [["Transition Base Length",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [iend1Color,deemphasize], [iend2Color,deemphasize], [irotaterender1, [0,0,-45]], [itransitionAngle,90], [irenderseparation,[70,0,0]], [itransitionBaseType,"oval"]]],
      ["10mm", [[itransitionBaseLength,10]]],
      ["15mm", [[itransitionBaseLength,15]]],
      ["20mm", [[itransitionBaseLength,20]]]
    ]
    : scenario == "transitionbase_width" ? [["Transition Base Width",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [iend1Color,deemphasize], [iend2Color,deemphasize], [irotaterender1, [0,0,-45]], [itransitionAngle,90], [irenderseparation,[70,0,0]], [itransitionBaseType,"oval"]]],
      ["10mm", [[itransitionBaseWidth,10]]],
      ["15mm", [[itransitionBaseWidth,15]]],
      ["20mm", [[itransitionBaseWidth,20]]]
    ]
    : scenario == "transitionbase_angle" ? [["Transition Base Angle",3,[[90,0,0],[0,0,60],350],[[irendercount,2] ,[itextposition,[0,-30,-50]], [iend1Color,deemphasize], [iend2Color,deemphasize], [irotaterender1,[0,0,-45]], [itransitionAngle,90], [irenderseparation,[70,0,0]], [itransitionBaseType,"oval"]]],
      ["30deg", [[itransitionBaseAngle,30]]],
      ["45deg", [[itransitionBaseAngle,45]]],
      ["60deg", [[itransitionBaseAngle,60]]]
    ]

    //transition extensions
    //transitionext_demo, transitionextpre_length,transitionextpre_gridSize,transitionextpre_wallthickness, transitionextpost_length,transitionextpost_gridSize,transitionextpost_wallthickness
    : scenario == "transitionext_demo" ? [["Transition Extension",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [itransitionBendRadius,10], [itransitionAngle,45], [itransitionEnd2Count,2], [iend1Color, deemphasize], [iend2Color, deemphasize], [itransitionStyle, "hull"]]],
     ["", []],
     ["Pre 10mm", [[con1_key(iconExtensionLength),10]]],
     ["Pre and Post 10mm", [[con1_key(iconExtensionLength),10], [con2_key(iconExtensionLength),10]]],
     ["Pre grid", [[con1_key(iconExtensionLength),10], [con2_key(iconExtensionLength),10], [con1_key(iconExtensionGridWallThickness),-1]]]
    ]
    : scenario == "transitionextpre_length" ? [["Pre Transition Extension Length",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con1_key(iconExtensionLength),0]]],
      ["5mm", [[con1_key(iconExtensionLength),5]]],
      ["10mm", [[con1_key(iconExtensionLength),10]]]
    ]
    : scenario == "transitionextpre_gridSize" ? [["Pre Transition Extension Grid Size",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [con1_key(iconExtensionLength),5],[con1_key(iconExtensionGridWallThickness),2], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con1_key(iconExtensionGridSize),0]]],
      ["5mm", [[con1_key(iconExtensionGridSize),5]]],
      ["10mm", [[con1_key(iconExtensionGridSize),10]]]
    ]
    : scenario == "transitionextpre_wallthickness" ? [["Pre Transition Extension WallThickness",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [con1_key(iconExtensionLength),5], [con1_key(iconExtensionGridSize),5], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con1_key(iconExtensionGridWallThickness),0]]],
      ["2mm", [[con1_key(iconExtensionGridWallThickness),2]]],
      ["3mm", [[con1_key(iconExtensionGridWallThickness),3]]],
      ["5mm", [[con1_key(iconExtensionGridWallThickness),5]]]
    ]
        : scenario == "transitionextpost_length" ? [["Post Transition Extension Length",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con2_key(iconExtensionLength),0]]],
      ["5mm", [[con2_key(iconExtensionLength),5]]],
      ["10mm", [[con2_key(iconExtensionLength),10]]]
    ]
    : scenario == "transitionextpost_gridSize" ? [["Post Transition Extension Grid Size",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [con2_key(iconExtensionLength),5],[con2_key(iconExtensionGridWallThickness),2], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con2_key(iconExtensionGridSize),0]]],
      ["5mm", [[con2_key(iconExtensionGridSize),5]]],
      ["10mm", [[con2_key(iconExtensionGridSize),10]]]
    ]
    : scenario == "transitionextpost_wallthickness" ? [["Post Transition Extension WallThickness",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [con2_key(iconExtensionLength),5], [con2_key(iconExtensionGridSize),5], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[con2_key(iconExtensionGridWallThickness),0]]],
      ["2mm", [[con2_key(iconExtensionGridWallThickness),2]]],
      ["3mm", [[con2_key(iconExtensionGridWallThickness),3]]],
      ["5mm", [[con2_key(iconExtensionGridWallThickness),5]]]
    ]

    : assert(false, str("unknow scenario - '", scenario, "'"));

function getDerviedScenario(scenario_key) =
  let(selectedScenario = getScenario(scenario_key),
      baseScenario = len(selectedScenario) == 1 ? getScenario(selectedScenario[0][4]) : [],
      //If the length of the scenario is of length 1, there are no steps, so it must be a cloan
      derivedScenario = len(selectedScenario) != 1 ? [] : [
        //Loop each line in the scenario, line 1 is the common/overrides for the scenario.
        for (i = [0:len(baseScenario)-1])
          if (i == 0 )
            //For the first line,
            [for (y = [0:4])
              //Scenario settings
              if(y == iscenarioName) is_string(selectedScenario[0][y]) && len(selectedScenario[0][y]) > 0 ? selectedScenario[0][y] : baseScenario[0][y]
              else if(y == iscenarioVp) is_list(selectedScenario[0][y]) && len(selectedScenario[0][y]) == 3 ? selectedScenario[0][y] : baseScenario[0][y]
              else if(y == iscenariokv) concat(baseScenario[0][iscenariokv],selectedScenario[0][iscenariokv])
              else if(y == 4) selectedScenario[0][4]
              else baseScenario[0][y]
            ]
          else baseScenario[i]
        ]
      )
    echo("getDerviedScenario", selectedScenario=selectedScenario)
    echo("getDerviedScenario", baseScenario=baseScenario)
    echo("getDerviedScenario", derivedScenario=derivedScenario)
    len(selectedScenario) != 1 ? selectedScenario : derivedScenario;

function getCurrentStep(scenario, stepIndex=-1) =
  let(
    selectedScenario = getDerviedScenario(scenario),
    scenarioDefaults = selectedScenario[0],
    stepIndex = stepIndex > -1
      ? stepIndex+1
      : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1),
    animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]),
    currentStepSettings = DictSetRange(
      defaultDemoSetting,
      concat(scenarioDefaults[iscenariokv],animationStep[istepkv])
    )
  )
    echo("getCurrentStep", selectedScenario=selectedScenario)
    echo("getCurrentStep", scenarioDefaults=scenarioDefaults)
    echo("getCurrentStep", currentStepSettings=currentStepSettings)
   currentStepSettings;

function getSize(currentStepSettings) = let(
  css = currentStepSettings,
  c1 = [css[con1_key(iconDiameter)] + css[con1_key(iconWallThickness)]*2 + css[con1_key(iconTaper)]*2 +
      (css[con1_key(iconStyle)] == "mag" ? (css[con1_key(iconMagnetDiameter)] + css[con1_key(iconMagnetBorder)]*4) + (css[con1_key(iconRing)] != "no" ? css[ialignmentUpperWidth]*2 : 0 ): 0) +
      (css[con1_key(iconStyle)] == "flange" ? css[con1_key(iconFlangeWidth)] :0)
      , css[con1_key(iconLength)]],
  c2 = [css[con2_key(iconDiameter)] + css[con2_key(iconWallThickness)]*2 + css[con2_key(iconTaper)]*2 +
      (css[con2_key(iconStyle)] == "mag" ? (css[con2_key(iconMagnetDiameter)] + css[con2_key(iconMagnetBorder)]*4) + (css[con2_key(iconRing)] != "no" ? css[ialignmentUpperWidth]*2 : 0 ): 0) +
      (css[con2_key(iconStyle)] == "flange" ? css[con2_key(iconFlangeWidth)] :0)
      , css[con2_key(iconLength)]],
) [c1,c2];

function getSize(css) =
  let(
    c1 = [DictGet(css, con1_key(iconDiameter)) + DictGet(css, con1_key(iconWallThickness))*2 + DictGet(css, con1_key(iconTaper))*2 +
        (DictGet(css, con1_key(iconStyle)) == "mag" ? (DictGet(css, con1_key(iconMagnetDiameter)) + DictGet(css, con1_key(iconMagnetBorder))*4) + (DictGet(css, con1_key(iconRing)) != "no" ? DictGet(css, ialignmentUpperWidth)*2 : 0 ): 0) +
        (DictGet(css, con1_key(iconStyle)) == "flange" ? DictGet(css, con1_key(iconFlangeWidth)) : 0)
      , DictGet(css, con1_key(iconLength))],
    c2 = [DictGet(css, con2_key(iconDiameter)) + DictGet(css, con2_key(iconWallThickness))*2 + DictGet(css, con2_key(iconTaper))*2 +
        (DictGet(css, con2_key(iconStyle)) == "mag" ? (DictGet(css, con2_key(iconMagnetDiameter)) + DictGet(css, con2_key(iconMagnetBorder))*4) + (DictGet(css, con2_key(iconRing)) != "no" ? DictGet(css, ialignmentUpperWidth)*2 : 0 ): 0) +
        (DictGet(css, con2_key(iconStyle)) == "flange" ? DictGet(css, con2_key(iconFlangeWidth)) : 0)
      , DictGet(css, con2_key(iconLength))],
  ) [c1,c2];


function GetRenderSeparation(css) =
  let(rendSep = DictGet(css, irenderseparation))
    (is_list(rendSep) && len(rendSep) == 3)
      ? rendSep
      : let(size = getSize(css)) [max(size[0].x, size[1].x), max(size[0].y, size[1].y), 0];

module RenderScenario(scenario, showtext=true, stepIndex=-1, sliceDebug = false, showCaliper = false, showadapter=true){
  selectedScenario = getDerviedScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  assert(scenarioDefaults[iscenarioName] != "unknown scenario", "unknown scenario");

  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);
  currentStepSettings = DictSetRange(defaultDemoSetting, concat(scenarioDefaults[iscenariokv],animationStep[istepkv]));

  echo("🟩RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, selectedScenarioLen=len(selectedScenario), defaultDemoSettingLen=len(defaultDemoSetting), currentStepSettings=currentStepSettings);
  echo(DictToString(currentStepSettings));

  if(!isMulti(scenario) && len(selectedScenario)-1 != selectedScenario[0][1])
    echo("🟥RenderScenario - warning steps is not correct, update for PS script to function",scenarioStepsConfig = selectedScenario[0][1], steps=len(selectedScenario)-1);

  renderText =
    len(scenarioDefaults[iscenarioName])>0 && len(animationStep[istepName])>0 ? str(scenarioDefaults[iscenarioName], " - ", animationStep[istepName])
    : len(scenarioDefaults[iscenarioName])>0 ? str(scenarioDefaults[iscenarioName])
    : len(scenarioDefaults[istepName])>0 ? str(scenarioDefaults[istepName])
    : "";

  if(showtext && $preview)
  color("DimGray")
  translate($vpt)
  rotate($vpr)
  translate(let(tp = DictGet(currentStepSettings, itextposition)) is_list(tp) && len(tp)==3 ? tp : [0,-45,60])
   linear_extrude(height = 0.1)
   text(renderText, size=6,halign="center");

  echo(connector1Length = DictGet(currentStepSettings, con1_key(iconLength)), connector1BarbsThickness = DictGet(currentStepSettings, con1_key(iconBarbsThickness)));

  if(showadapter)
    rotate(DictGet(currentStepSettings, irotate))
    translate(DictGet(currentStepSettings, itranslate))
    HoseAdapter(
   connector1 = UserConnectorSettings(
        connector=1,
        style = DictGet(currentStepSettings, con1_key(iconStyle)),
        wallThickness = DictGet(currentStepSettings, con1_key(iconWallThickness)),
        measurement = DictGet(currentStepSettings, con1_key(iconMeasurement)),
        diameter = DictGet(currentStepSettings, con1_key(iconDiameter)),
        length = DictGet(currentStepSettings, con1_key(iconLength)),
        rotation = DictGet(currentStepSettings, con1_key(iconRotation)),
        taper = DictGet(currentStepSettings, con1_key(iconTaper)),

        endCapDiameter  = DictGet(currentStepSettings, con1_key(iconEndCapDiameter)),
        endCapThickness = DictGet(currentStepSettings, con1_key(iconEndCapThickness)),
        stopThickness   = DictGet(currentStepSettings, con1_key(iconStopThickness)),
        stopLength      = DictGet(currentStepSettings, con1_key(iconStopLength)),
        stopSymmetrical = DictGet(currentStepSettings, con1_key(iconStopSymmetrical)),
        barbsCount      = DictGet(currentStepSettings, con1_key(iconBarbsCount)),
        barbsThickness  = DictGet(currentStepSettings, con1_key(iconBarbsThickness)),
        barbsSymmetrical= DictGet(currentStepSettings, con1_key(iconBarbsSymmetrical)),
        enableThreads   = DictGet(currentStepSettings, con1_key(iconEnableThreads)),
        threadPitch     = DictGet(currentStepSettings, con1_key(iconThreadPitch)),
        threadToothAngle= DictGet(currentStepSettings, con1_key(iconThreadToothAngle)),
        threadToothHeight=DictGet(currentStepSettings, con1_key(iconThreadToothHeight)),

        magnetCount     = DictGet(currentStepSettings, con1_key(iconMagnetCount)),
        magnetDiameter  = DictGet(currentStepSettings, con1_key(iconMagnetDiameter)),
        magnetThickness = DictGet(currentStepSettings, con1_key(iconMagnetThickness)),
        magnetBorder    = DictGet(currentStepSettings, con1_key(iconMagnetBorder)),
        magnetFlangeThickness = DictGet(currentStepSettings, con1_key(iconMagnetFlangeThickness)),
        //alignmentRing = DictGet(currentStepSettings, con1_key(iconRing)),
        magnetTwistLockSize  = DictGet(currentStepSettings, con1_key(iconMagnetTwistLockSize)),

        flangeWidth     = DictGet(currentStepSettings, con1_key(iconFlangeWidth)),
        flangeThickness = DictGet(currentStepSettings, con1_key(iconFlangeThickness)),
        flangeScrewPosition = DictGet(currentStepSettings, con1_key(iconFlangeScrewPosition)),
        flangeScrewBorder   = DictGet(currentStepSettings, con1_key(iconFlangeScrewBorder)),
        flangeScrewCount    = DictGet(currentStepSettings, con1_key(iconFlangeScrewCount)),
        flangeScrewDiameter = DictGet(currentStepSettings, con1_key(iconFlangeScrewDiameter)),

        extensionLength         = DictGet(currentStepSettings, con1_key(iconExtensionLength)),
        extensionGridSize       = DictGet(currentStepSettings, con1_key(iconExtensionGridSize)),
        extensionGridWallThickness = DictGet(currentStepSettings, con1_key(iconExtensionGridWallThickness)),
        extensionText           = DictGet(currentStepSettings, con1_key(iconExtensionText)),
        extensionTextSize       = DictGet(currentStepSettings, con1_key(iconExtensionTextSize))
      ),

      connector2 = UserConnectorSettings(
        connector=2,
        style = DictGet(currentStepSettings, con2_key(iconStyle)),
        wallThickness = DictGet(currentStepSettings, con2_key(iconWallThickness)),
        measurement = DictGet(currentStepSettings, con2_key(iconMeasurement)),
        diameter = DictGet(currentStepSettings, con2_key(iconDiameter)),
        length = DictGet(currentStepSettings, con2_key(iconLength)),
        rotation = DictGet(currentStepSettings, con2_key(iconRotation)),
        taper = DictGet(currentStepSettings, con2_key(iconTaper)),

        endCapDiameter  = DictGet(currentStepSettings, con2_key(iconEndCapDiameter)),
        endCapThickness = DictGet(currentStepSettings, con2_key(iconEndCapThickness)),
        stopThickness = DictGet(currentStepSettings, con2_key(iconStopThickness)),
        stopLength = DictGet(currentStepSettings, con2_key(iconStopLength)),
        stopSymmetrical = DictGet(currentStepSettings, con2_key(iconStopSymmetrical)),
        barbsCount = DictGet(currentStepSettings, con2_key(iconBarbsCount)),
        barbsThickness = DictGet(currentStepSettings, con2_key(iconBarbsThickness)),
        barbsSymmetrical = DictGet(currentStepSettings, con2_key(iconBarbsSymmetrical)),
        enableThreads = DictGet(currentStepSettings, con2_key(iconEnableThreads)),
        threadPitch = DictGet(currentStepSettings, con2_key(iconThreadPitch)),
        threadToothAngle = DictGet(currentStepSettings, con2_key(iconThreadToothAngle)),
        threadToothHeight = DictGet(currentStepSettings, con2_key(iconThreadToothHeight)),

        magnetCount = DictGet(currentStepSettings, con2_key(iconMagnetCount)),
        magnetDiameter = DictGet(currentStepSettings, con2_key(iconMagnetDiameter)),
        magnetThickness = DictGet(currentStepSettings, con2_key(iconMagnetThickness)),
        magnetBorder = DictGet(currentStepSettings, con2_key(iconMagnetBorder)),
        magnetFlangeThickness = DictGet(currentStepSettings, con2_key(iconMagnetFlangeThickness)),
        //ring = DictGet(currentStepSettings, con2_key(iconRing)),
        magnetTwistLockSize = DictGet(currentStepSettings, con2_key(iconMagnetTwistLockSize)),

        flangeWidth = DictGet(currentStepSettings, con2_key(iconFlangeWidth)),
        flangeThickness = DictGet(currentStepSettings, con2_key(iconFlangeThickness)),
        flangeScrewPosition = DictGet(currentStepSettings, con2_key(iconFlangeScrewPosition)),
        flangeScrewBorder = DictGet(currentStepSettings, con2_key(iconFlangeScrewBorder)),
        flangeScrewCount = DictGet(currentStepSettings, con2_key(iconFlangeScrewCount)),
        flangeScrewDiameter = DictGet(currentStepSettings, con2_key(iconFlangeScrewDiameter)),

        extensionLength = DictGet(currentStepSettings, con2_key(iconExtensionLength)),
        extensionGridSize = DictGet(currentStepSettings, con2_key(iconExtensionGridSize)),
        extensionGridWallThickness = DictGet(currentStepSettings, con2_key(iconExtensionGridWallThickness)),
        extensionText = DictGet(currentStepSettings, con2_key(iconExtensionText)),
        extensionTextSize = DictGet(currentStepSettings, con2_key(iconExtensionTextSize)),
      ),

      connector3 = UserConnectorSettings(
        connector=3,
        style = DictGet(currentStepSettings, con3_key(iconStyle)),
        wallThickness = DictGet(currentStepSettings, con3_key(iconWallThickness)),
        measurement = DictGet(currentStepSettings, con3_key(iconMeasurement)),
        diameter = DictGet(currentStepSettings, con3_key(iconDiameter)),
        length = DictGet(currentStepSettings, con3_key(iconLength)),
        rotation = DictGet(currentStepSettings, con3_key(iconRotation)),
        taper = DictGet(currentStepSettings, con3_key(iconTaper)),

        endCapDiameter  = DictGet(currentStepSettings, con3_key(iconEndCapDiameter)),
        endCapThickness = DictGet(currentStepSettings, con3_key(iconEndCapThickness)),
        stopThickness = DictGet(currentStepSettings, con3_key(iconStopThickness)),
        stopLength = DictGet(currentStepSettings, con3_key(iconStopLength)),
        stopSymmetrical = DictGet(currentStepSettings, con3_key(iconStopSymmetrical)),
        barbsCount = DictGet(currentStepSettings, con3_key(iconBarbsCount)),
        barbsThickness = DictGet(currentStepSettings, con3_key(iconBarbsThickness)),
        barbsSymmetrical = DictGet(currentStepSettings, con3_key(iconBarbsSymmetrical)),
        enableThreads = DictGet(currentStepSettings, con3_key(iconEnableThreads)),
        threadPitch = DictGet(currentStepSettings, con3_key(iconThreadPitch)),
        threadToothAngle = DictGet(currentStepSettings, con3_key(iconThreadToothAngle)),
        threadToothHeight = DictGet(currentStepSettings, con3_key(iconThreadToothHeight)),

        magnetCount = DictGet(currentStepSettings, con3_key(iconMagnetCount)),
        magnetDiameter = DictGet(currentStepSettings, con3_key(iconMagnetDiameter)),
        magnetThickness = DictGet(currentStepSettings, con3_key(iconMagnetThickness)),
        magnetBorder = DictGet(currentStepSettings, con3_key(iconMagnetBorder)),
        magnetFlangeThickness = DictGet(currentStepSettings, con3_key(iconMagnetFlangeThickness)),
        //ring = DictGet(currentStepSettings, con3_key(iconRing)),
        magnetTwistLockSize = DictGet(currentStepSettings, con3_key(iconMagnetTwistLockSize)),

        flangeWidth = DictGet(currentStepSettings, con3_key(iconFlangeWidth)),
        flangeThickness = DictGet(currentStepSettings, con3_key(iconFlangeThickness)),
        flangeScrewPosition = DictGet(currentStepSettings, con3_key(iconFlangeScrewPosition)),
        flangeScrewBorder = DictGet(currentStepSettings, con3_key(iconFlangeScrewBorder)),
        flangeScrewCount = DictGet(currentStepSettings, con3_key(iconFlangeScrewCount)),
        flangeScrewDiameter = DictGet(currentStepSettings, con3_key(iconFlangeScrewDiameter)),

        extensionLength = DictGet(currentStepSettings, con3_key(iconExtensionLength)),
        extensionGridSize = DictGet(currentStepSettings, con3_key(iconExtensionGridSize)),
        extensionGridWallThickness = DictGet(currentStepSettings, con3_key(iconExtensionGridWallThickness)),
        extensionText = DictGet(currentStepSettings, con3_key(iconExtensionText)),
        extensionTextSize = DictGet(currentStepSettings, con3_key(iconExtensionTextSize)),
      ),

      drawAlignmentRing = DictGet(currentStepSettings, idrawAlignmentRing),
      alignmentDepth = DictGet(currentStepSettings, ialignmentDepth),
      alignmentUpperWidth = DictGet(currentStepSettings, ialignmentUpperWidth),
      alignmentLowerWidth = DictGet(currentStepSettings, ialignmentLowerWidth),
      alignmentSideClearance = DictGet(currentStepSettings, ialignmentSideClearance),
      alignmentDepthClearance = DictGet(currentStepSettings, ialignmentDepthClearance),

      transitionStyle = DictGet(currentStepSettings, itransitionStyle),
      transitionLength = DictGet(currentStepSettings, itransitionLength),
      transitionBendRadius = DictGet(currentStepSettings, itransitionBendRadius),
      transitionAngle = DictGet(currentStepSettings, itransitionAngle),
      transitionOffset = DictGet(currentStepSettings, itransitionOffset),
      transitionBaseType = DictGet(currentStepSettings, itransitionBaseType),
      transitionBaseThickness = DictGet(currentStepSettings, itransitionBaseThickness),
      transitionBaseWidth = DictGet(currentStepSettings, itransitionBaseWidth),
      transitionBaseLength = DictGet(currentStepSettings, itransitionBaseLength),
      transitionBaseAngle = DictGet(currentStepSettings, itransitionBaseAngle),
      transitionEnd2Count = DictGet(currentStepSettings, itransitionEnd2Count),
      transitionHullLength = DictGet(currentStepSettings, itransitionHullLength),
      transitionHullCenterLength = DictGet(currentStepSettings, itransitionHullCenterLength),

      transitionHullyOffset = DictGet(currentStepSettings, itransitionHullyOffset),
      transitionHullCenter = DictGet(currentStepSettings, itransitionHullCenter),
      transitionHullCenterHeight = DictGet(currentStepSettings, itransitionHullCenterHeight),

      sliceDebug = sliceDebug || DictGet(currentStepSettings, isliceDebug),
      end1Color = DictGet(currentStepSettings, iend1Color),
      end2Color = DictGet(currentStepSettings, iend2Color),
      end3Color = DictGet(currentStepSettings, iend3Color),
      transitionColor = DictGet(currentStepSettings, itransitionColor),
      extensionColor = DictGet(currentStepSettings, iextensionColor),
      showCaliper = showCaliper || DictGet(currentStepSettings, ishowCaliper),
      help=help);
}

color_conditional(colour)
union(){
  if(isMulti(scenario)){
    echo("🟦 Is Multi render", currentStep=currentStep, separation=separation, rendercount= DictGet(currentStep, irendercount));

    multiScenario = getScenario(scenario);
    for(i =[1:len(multiScenario)-1])
    {
      multiStep = multiScenario[i];
      if(len(multiStep) == 4)
      {
        echo(multiStep=multiStep);
        //["demo",1, [0, 0, 0], 5]],
        translate(multiStep[2])
        RenderScenario(scenario = multiStep[0], height = multiStep[3], stepIndex = multiStep[1], showtext = false);
      }
      else{
        RenderScenario(scenario, stepIndex=i-1, showtext = false);
      }
    }
  } else{
    currentStep = getCurrentStep(scenario);
    separation = GetRenderSeparation(currentStep);
    echo("🟦 Not Multi render", rendercount= DictGet(currentStep, irendercount), currentStep=currentStep, separation=separation);

    if( DictGet(currentStep, irendercount) == 4) {
      if(showtext)
      //translate([0,0,-45])
      translate(let(tp =  DictGet(currentStep, itextposition)) is_list(tp) && len(tp)==3 ? tp : [0,0,-45])
      RenderScenario(scenario, showtext = true, showadapter = false);

      union(){
        translate([separation.x*-0.6,0,separation.z])
        rotate( DictGet(currentStep, irotaterender1))
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,separation.z])
        rotate( DictGet(currentStep, irotaterender1))
        RenderScenario(scenario, showtext=false, sliceDebug = true, showCaliper=true);
      }

      union(){
        translate([separation.x*-0.6,0,-separation.z])
        rotate([60,0,0])
        rotate( DictGet(currentStep, irotaterender2))
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,-separation.z])
        rotate([-60,0,0])
        rotate( DictGet(currentStep, irotaterender2))
        RenderScenario(scenario, showtext=false);
      }
    }
    else if( DictGet(currentStep, irendercount) == 2) {
      if(showtext)
      translate(let(tp =  DictGet(currentStep, itextposition)) is_list(tp) && len(tp)==3 ? tp : [0,-45,-0])
      RenderScenario(scenario, showtext = true, showadapter = false);

      union(){
        translate([separation.x*-0.6,0,0])
        rotate( DictGet(currentStep, irotaterender1))
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,0])
        rotate( DictGet(currentStep, irotaterender2))
        RenderScenario(scenario, showtext=false, sliceDebug = true, showCaliper=true);

      }
    } else {
      RenderScenario(scenario);
    }
  }
}

