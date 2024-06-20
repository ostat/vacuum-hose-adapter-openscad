// include instead of use, so we get the pitch
use <../vacuum-hose-adapter-openscad.scad>
include <../modules/functions_general.scad>
include <../modules/functions_string.scad>

scenario = "demo"; //[demo,demo2,demo_fixed, endcommon_wallthickness,endcommon_diameter,endcommon_measurement,endcommon_length,endcommon_taper,endcommon_rotation,  hose_demo,hose_stopthickness,hose_stoplength,hose_stopsymmetrical,hose_barbsthickness,hose_barbscount,hose_barbssymmetrical,hose_endcapthickness,hose_endcapdiameter, flange_demo,flange_width,flange_thickness,flange_screwposition,flange_screwborder,flange_screwcount,flange_screwdiameter, magnetic_flangedemo,magnetic_magnetcount,magnetic_magnetdiameter,magnetic_magnetthickness,magnetic_magnetborder,magnetic_flangethickness,magnetic_alignmentring,magnetic_twistlock, nozzle_demo,nozzle_shape,nozzle_size,nozzle_tipwallthickness,nozzle_radius,nozzle_offset,nozzle_chamferpercentage,nozzle_chamferangle,     allignmentring_demo,allignmentring_depth,allignmentring_upperwidth,allignmentring_lowerwidth,allignmentring_sideclearance,allignmentring_depthclearance, camlock_sample,camlock_demo, centec_female_sample,centec_female_demo,centec_male_sample,centec_male_demo, dyson_sample,dyson_demo, dw735_sample,dw735_demo,makita_male_sample,makita_male_demo, osvacm32_sample,osvacm32_demo,osvacm_sample,osvacm_demo,osvacf32_sample,osvacf32_demo,osvacf_sample,osvacf_demo, transition_demo,transition_bendtaper,transition_taperbend,transition_organicbend,transition_flat, transition_hull,transition_hulllength,transition_hulloffset,transition_hullcenter, transition_length,transition_angle,transition_bendradius,transition_offset,transition_EndCount,  transitionbase,transitionbase_thickness,transitionbase_length,transitionbase_width,transitionbase_angle, transitionext_demo,transitionextpre_length,transitionextpre_gridSize,transitionextpre_wallthickness,transitionextpost_length,transitionextpost_gridSize,transitionextpost_wallthickness]
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
     
//Array index
idrawAlignmentRing = 0;
ialignmentDepth = 1;
ialignmentUpperWidth = 2;
ialignmentLowerWidth = 3;
ialignmentSideClearance = 4;
ialignmentDepthClearance = 5;

ic1 = 6;
iconnector1Style = 0+ic1;
iconnector1WallThickness = 1+ic1;
iconnector1Measurement = 2+ic1;
iconnector1Diameter = 3+ic1;
iconnector1Length = 4+ic1;
iconnector1Taper = 5+ic1;
iconnector1Rotation = 6+ic1;

ic1hose=7+ic1;
iconnector1EndCapDiameter = 0+ic1hose;
iconnector1EndCapThickness = 1+ic1hose;
iconnector1StopThickness = 2+ic1hose;
iconnector1StopLength = 3+ic1hose;
iconnector1StopSymmetrical = 4+ic1hose;
iconnector1BarbsCount = 5+ic1hose;
iconnector1BarbsThickness = 6+ic1hose;
iconnector1BarbsSymmetrical = 7+ic1hose;

ic1magnet=8+ic1hose;
iconnector1MagnetCount = 0+ic1magnet;
iconnector1MagnetDiameter = 1+ic1magnet;
iconnector1MagnetThickness = 2+ic1magnet;
iconnector1MagnetBorder = 3+ic1magnet;
iconnector1MagnetFlangeThickness = 4+ic1magnet;
iconnector1Ring = 5+ic1magnet;
iconnector1MagnetTwistLockSize = 6+ic1magnet;

ic1flange = 7+ic1magnet;
iconnector1FlangeWidth = 0+ic1flange;
iconnector1FlangeThickness = 1+ic1flange;
iconnector1FlangeScrewPosition = 2+ic1flange;
iconnector1FlangeScrewBorder = 3+ic1flange;
iconnector1FlangeScrewCount = 4+ic1flange;
iconnector1FlangeScrewDiameter = 5+ic1flange;

ic1Extension = 6+ic1flange;
iconnector1ExtensionLength = 0+ic1Extension;
iconnector1ExtensionGridSize = 1+ic1Extension;
iconnector1ExtensionGridWallThickness = 2+ic1Extension;
iconnector1ExtensionText = 3+ic1Extension;
iconnector1ExtensionTextSize = 4+ic1Extension;

it=5+ic1Extension;
itransitionStyle = 0+it;
itransitionLength = 1+it;
itransitionBendRadius = 2+it;
itransitionAngle = 3+it;
itransitionOffset = 4+it;
itransitionBaseType = 5+it;
itransitionBaseThickness = 6+it;
itransitionBaseWidth = 7+it;
itransitionBaseLength = 8+it;
itransitionBaseAngle = 9+it;
itransitionEnd2Count = 10+it;
itransitionHullLength = 11+it;
itransitionHullCenterLength = 12+it;
itransitionHullyOffset = 13+it;
itransitionHullCenter = 14+it;
itransitionHullCenterHeight = 15+it;

ic2=16+it;
iconnector2Style = 0+ic2;
iconnector2WallThickness = 1+ic2;
iconnector2Measurement = 2+ic2;
iconnector2Diameter = 3+ic2;
iconnector2Length = 4+ic2;
iconnector2Taper = 5+ic2;
iconnector2Rotation = 6+ic2;

ic2hose = 7+ic2;
iconnector2EndCapDiameter = 0+ic2hose;
iconnector2EndCapThickness = 1+ic2hose;
iconnector2StopThickness = 2+ic2hose;
iconnector2StopLength = 3+ic2hose;
iconnector2StopSymmetrical = 4+ic2hose;
iconnector2BarbsCount = 5+ic2hose;
iconnector2BarbsThickness = 6+ic2hose;
iconnector2BarbsSymmetrical = 7+ic2hose;

ic2magnet = 8+ic2hose;
iconnector2MagnetCount = 0+ic2magnet;
iconnector2MagnetDiameter = 1+ic2magnet;
iconnector2MagnetThickness = 2+ic2magnet;
iconnector2MagnetBorder = 3+ic2magnet;
iconnector2MagnetFlangeThickness = 4+ic2magnet;
iconnector2Ring = 5+ic2magnet;
iconnector2MagnetTwistLockSize = 6+ic2magnet;

ic2flange = 7+ic2magnet;
iconnector2FlangeWidth = 0+ic2flange;
iconnector2FlangeThickness = 1+ic2flange;
iconnector2FlangeScrewPosition = 2+ic2flange;
iconnector2FlangeScrewBorder = 3+ic2flange;
iconnector2FlangeScrewCount = 4+ic2flange;
iconnector2FlangeScrewDiameter = 5+ic2flange;

ic2nozzle=6+ic2flange;
iconnector2NozzleShape = 0+ic2nozzle;
iconnector2NozzleSize = 1+ic2nozzle;
iconnector2NozzleTipWallThickness = 2+ic2nozzle;
iconnector2NozzleRadius = 3+ic2nozzle;
iconnector2NozzleOffset = 4+ic2nozzle;
iconnector2NozzleChamferPercentage = 5+ic2nozzle;
iconnector2NozzleChamferAngle = 6+ic2nozzle;

ic2Extension = 7+ic2nozzle;
iconnector2ExtensionLength = 0+ic2Extension;
iconnector2ExtensionGridSize = 1+ic2Extension;
iconnector2ExtensionGridWallThickness = 2+ic2Extension;
iconnector2ExtensionText = 3+ic2Extension;
iconnector2ExtensionTextSize = 4+ic2Extension;

ic3=5+ic2Extension;
iconnector3Style = 0+ic3;
iconnector3WallThickness = 1+ic3;
iconnector3Measurement = 2+ic3;
iconnector3Diameter = 3+ic3;
iconnector3Length = 4+ic3;
iconnector3Taper = 5+ic3;
iconnector3Rotation = 6+ic3;

ic3hose = 7+ic3;
iconnector3EndCapDiameter = 0+ic3hose;
iconnector3EndCapThickness = 1+ic3hose;
iconnector3StopThickness = 2+ic3hose;
iconnector3StopLength = 3+ic3hose;
iconnector3StopSymmetrical = 4+ic3hose;
iconnector3BarbsCount = 5+ic3hose;
iconnector3BarbsThickness = 6+ic3hose;
iconnector3BarbsSymmetrical = 7+ic3hose;

ic3magnet = 8+ic3hose;
iconnector3MagnetCount = 0+ic3magnet;
iconnector3MagnetDiameter = 1+ic3magnet;
iconnector3MagnetThickness = 2+ic3magnet;
iconnector3MagnetBorder = 3+ic3magnet;
iconnector3MagnetFlangeThickness = 4+ic3magnet;
iconnector3Ring = 5+ic3magnet;
iconnector3MagnetTwistLockSize = 6+ic3magnet;

ic3flange = 7+ic3magnet;
iconnector3FlangeWidth = 0+ic3flange;
iconnector3FlangeThickness = 1+ic3flange;
iconnector3FlangeScrewPosition = 2+ic3flange;
iconnector3FlangeScrewBorder = 3+ic3flange;
iconnector3FlangeScrewCount = 4+ic3flange;
iconnector3FlangeScrewDiameter = 5+ic3flange;

ic3nozzle=6+ic3flange;
iconnector3NozzleShape = 0+ic3nozzle;
iconnector3NozzleSize = 1+ic3nozzle;
iconnector3NozzleTipWallThickness = 2+ic3nozzle;
iconnector3NozzleRadius = 3+ic3nozzle;
iconnector3NozzleOffset = 4+ic3nozzle;
iconnector3NozzleChamferPercentage = 5+ic3nozzle;
iconnector3NozzleChamferAngle = 6+ic3nozzle;

ic3Extension = 7+ic3nozzle;
iconnector3ExtensionLength = 0+ic3Extension;
iconnector3ExtensionGridSize = 1+ic3Extension;
iconnector3ExtensionGridWallThickness = 2+ic3Extension;
iconnector3ExtensionText = 3+ic3Extension;
iconnector3ExtensionTextSize = 4+ic3Extension;

iother=5+ic3Extension;
isliceDebug = 0+iother;
ishowCaliper = 1+iother;
iend1Color = 2+iother;
iend2Color = 3+iother;
iend3Color = 4+iother;
itransitionColor = 5+iother;
iextensionColor = 6+iother;

irenderer=7+iother;
itranslate = 0+irenderer;
irotate = 1+irenderer;
irendercount = 2+irenderer;
irenderseparation = 3+irenderer;
itextposition = 4+irenderer;
irotaterender1 = 5+irenderer;
irotaterender2 = 6+irenderer;

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

defaultDemoSetting = [
    //drawAlignmentRing, alignmentDepth, alignmentUpperWidth, alignmentLowerWidth, alignmentSideClearance, alignmentDepthClearance
    "no", 2, 3, 0.5,0.25, 0.75,
    //connector1Style, connector1WallThickness, connector1Measurement, iconnector1Diameter, iconnector1Length, connector1Taper, connector1Rotation
    "hose", 2, "inner", 40, 15, 0, 0,
    //connector1EndCapDiameter, connector1EndCapThickness, connector1StopThickness, connector1StopLength, connector1StopSymmetrical,
    0,0,0,0,false,
    //connector1BarbsCount, connector1BarbsThickness, connector1BarbsSymmetrical
    0,0,0,
    //connector1MagnetCount, connector1MagnetDiameter, connector1MagnetThickness, connector1MagnetBorder, connector1MagnetFlangeThickness, connector1Ring,connector1MagnetTwistLockSize
    8,19.5,2.5,2,6,"no","0",
    //connector1FlangeWidth, connector1FlangeThickness, connector1FlangeScrewPosition, connector1FlangeScrewBorder, connector1FlangeScrewCount, connector1FlangeScrewDiameter,
    20,5,0,5,4,5,
    //connector1ExtensionLength, connector1ExtensionGridSize, connector1ExtensionGridWallThickness, connector1ExtensionText, connector1ExtensionTextSize
    0,0,0,"",0,

    //transitionStyle, transitionLength, transitionBendRadius, transitionAngle, transitionOffset,
    "bend+taper", 10,0,0,[0,0],
    //transitionBaseType, transitionBaseThickness, transitionBaseWidth, transitionBaseLength, transitionBaseAngle, 
    "none",0,0,0,0,
    //transitionEnd2Count, transitionHullLength, transitionHullCenterLength, transitionHullyOffset, transitionHullCenter, transitionHullCenterHeight,
    1,0,0,0,"disabled",0,
    
    //connector2Style, connector2WallThickness, connector2Measurement, connector2Diameter, connector2Length, connector2Taper, connector2Rotation
    "hose", 2, "outer", 30,20,0,0,
    //connector2EndCapDiameter, connector2EndCapThickness, connector2StopThickness, connector2StopLength, connector2StopSymmetrical, 
    0,0,0,0,false,
    //connector2BarbsCount, connector2BarbsThickness, connector2BarbsSymmetrical,
    0,0,0,
    //connector2MagnetCount, connector2MagnetDiameter, connector2MagnetThickness, connector2MagnetBorder, connector2MagnetFlangeThickness, connector2Ring,connector2MagnetTwistLockSize
    6,12,3,2,10,"no","0",
    //connector2FlangeWidth, connector2FlangeThickness, connector2FlangeScrewPosition, connector2FlangeScrewBorder, connector2FlangeScrewCount, connector2FlangeScrewDiameter,
    20,5,0,5,4,5,
    //connector2NozzleShape, connector2NozzleSize, connector2NozzleTipWallThickness, connector2NozzleRadius,
    "square",[10,5,10],0,0,
    //connector2NozzleOffset, connector2NozzleChamferPercentage, connector2NozzleChamferAngle,
    [0,0],0,0,
    //connector2ExtensionLength, connector2ExtensionGridSize, connector2ExtensionGridWallThickness, connector2ExtensionText, connector2ExtensionTextSize
    0,0,0,"",0,
    
    //connector3Style, connector3WallThickness, connector3Measurement, connector3Diameter, connector3Length, connector3Taper, connector3Rotation
    "hose", 2, "outer", 30,20,0,0,
    //connector3EndCapDiameter, connector3EndCapThickness, connector3StopThickness, connector3StopLength, connector3StopSymmetrical, 
    0,0,0,0,false,
    //connector3BarbsCount, connector3BarbsThickness, connector3BarbsSymmetrical,
    0,0,0,
    //connector3MagnetCount, connector3MagnetDiameter, connector3MagnetThickness, connector3MagnetBorder, connector3MagnetFlangeThickness, connector3Ring,connector3MagnetTwistLockSize
    6,12,3,2,10,"no","0",
    //connector3FlangeWidth, connector3FlangeThickness, connector3FlangeScrewPosition, connector3FlangeScrewBorder, connector3FlangeScrewCount, connector3FlangeScrewDiameter,
    20,5,0,5,4,5,
    //connector3NozzleShape, connector3NozzleSize, connector3NozzleTipWallThickness, connector3NozzleRadius,
    "square",[10,5,10],0,0,
    //connector3NozzleOffset, connector3NozzleChamferPercentage, connector3NozzleChamferAngle,
    [0,0],0,0,
    //connector3ExtensionLength, connector3ExtensionGridSize, connector3ExtensionGridWallThickness, connector3ExtensionText, connector3ExtensionTextSize
    0,0,0,"",0,

    //sliceDebug, showCaliper, end1Color, end2Color, end3Color, transitionColor, extensionColor
    false, false, ["",-1], ["",-1], ["",-1],["",-1], ["",-1],
        
    //rotate, translate, rendercount, renderseparation, textposition, rotaterende1, rotaterende2
    [0,0,0], [0,0,0], 1, [], [], [0,0,0], [0,0,0]];

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
      ["Hose connector", [[iconnector1Style,"hose"], [iconnector2Diameter,25], [iconnector1StopThickness,2], [iconnector1StopLength,3], [iconnector1Taper,1], [iconnector2BarbsCount,3], [iconnector1Measurement,"inner"]]],
      ["Magnetic Flange", [[iconnector1Style, "mag"], [iconnector1MagnetCount,6], [iconnector1Diameter,45], [iconnector1MagnetTwistLockSize, "3cnc"], [iconnector2Diameter,50]]],
      ["Flange", [[iconnector1Style, "flange"]]],
      ["Dyson V6 connector", [[iconnector1Style,"dyson"], [itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenterHeight,45]]],
      ["CAMLOCK connector", [[iconnector1Style, "camlock"],[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionLength,10], [itransitionHullCenter,true], [itransitionHullCenterLength,5], [itransitionHullCenterHeight,40], [itransitionHullLength,20], [irotaterender1,[0,0,-45]], [irotaterender2,[0,0,-45]]]],
      ["Dewalt DW735x", [[iconnector1Style,"dw735"], [itransitionBendRadius,10], [itransitionStyle,"taper+bend"], [itransitionAngle,90], [iconnector1Diameter,80], [iconnector2Diameter,50]]],
      ["Centec Quick Connect Female", [[iconnector1Style, "centec_female"]]],
      ["Centec Quick Connect Male", [[iconnector1Style, "centec_male"]]],
      ["osVAC32 Male", [[iconnector1Style, "osvacm32"]]],
      ["osVAC Male", [[iconnector1Style, "osvacm"]]],
      ["osVAC32 Female", [[iconnector1Style, "osvacf32"]]],
      ["osVAC Female", [[iconnector1Style, "osvacf"]]],
      ["Nozzle", [[itransitionStyle,"bend+taper"], [itransitionBendRadius,10], [itransitionAngle,30], [itransitionLength,3], [iconnector2Style,"nozzle"], [iconnector2Diameter,0], [iconnector2NozzleShape,"square"], [iconnector2NozzleChamferPercentage,50], [iconnector2NozzleChamferAngle,45], [iconnector2NozzleSize,[10,5,50]]]]    ]
    : scenario == "demo2" ? [["Hose Adapters",13,[[],[10,-0,40],450],[[irendercount, 2],[itextposition,[0,-50,0]]],"demo"]]
    
    : scenario == "demo_fixed" ? [["Fixed Adapters",9,[[],[10,-0,40],450],[[irendercount, 2],[iconnector2Diameter, 50], [itransitionColor,coloredDeemphasize], [iend2Color,coloredDeemphasize], [irenderseparation,[85,0,35]],[itextposition,[0,-50,0]]]],
      ["Dyson V6 connector", [[iconnector1Style,"dyson"]]],
      ["CAMLOCK connector", [[iconnector1Style, "camlock"]]],
      ["Dewalt DW735x", [[iconnector1Style,"dw735"], [itransitionBendRadius,10], [itransitionStyle,"taper+bend"], [itransitionAngle,45]]],
      ["Centec Quick Connect Female", [[iconnector1Style, "centec_female"]]],
      ["Centec Quick Connect Male", [[iconnector1Style, "centec_male"]]],
      ["osVAC32 Male", [[iconnector1Style, "osvacm32"]]],
      ["osVAC Male", [[iconnector1Style, "osvacm"]]],
      ["osVAC32 Female", [[iconnector1Style, "osvacf32"]]],
      ["osVAC Female", [[iconnector1Style, "osvacf"]]]   ]

      
    //Connector settings
    //endcommon_wallthickness,endcommon_diameter,endcommon_measurement,endcommon_length,endcommon_taper,endcommon_rotation
    : scenario == "endcommon_wallthickness" ? [["End WallThickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["1mm", [[iconnector1Measurement, "inner"],[iconnector1WallThickness, 1]]],
        ["2mm", [[iconnector1Measurement, "inner"],[iconnector1WallThickness, 2]]],
        ["3mm", [[iconnector1Measurement, "inner"],[iconnector1WallThickness, 3]]],
        ["1mm", [[iconnector1Measurement, "outer"],[iconnector1WallThickness, 1]]],
        ["2mm", [[iconnector1Measurement, "outer"],[iconnector1WallThickness, 2]]],
        ["3mm", [[iconnector1Measurement, "outer"],[iconnector1WallThickness, 3]]]
    ]
    : scenario == "endcommon_diameter" ? [["End Diameter",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["20mm", [[iconnector1Diameter, 20]]],
        ["30mm", [[iconnector1Diameter, 30]]],
        ["40mm", [[iconnector1Diameter, 40]]]
    ]
    : scenario == "endcommon_measurement" ? [["End Measurement",2,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["inner", [[iconnector1Measurement, "inner"]]],
        ["outer", [[iconnector1Measurement, "outer"]]]
    ]
    : scenario == "endcommon_length" ? [["End length",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["10mm", [[iconnector1Length, 10]]],
        ["20mm", [[iconnector1Length, 20]]],
        ["35mm", [[iconnector1Length, 35]]]
    ]
    : scenario == "endcommon_taper" ? [["End taper",5,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize]]],
        ["no taper", [[iconnector1Taper, 0]]],
        ["1mm", [[iconnector1Measurement, "inner"], [iconnector1Taper, 1]]],
        ["3mm", [[iconnector1Measurement, "inner"], [iconnector1Taper, 3]]],
        ["-1mm", [[iconnector1Measurement, "outer"], [iconnector1Taper, -1]]],
        ["-3mm", [[iconnector1Measurement, "outer"], [iconnector1Taper, -3]]]
    ]
    : scenario == "endcommon_rotation" ? [["End Rotation",4,[[60,0,0],[10,-0,25],300],[[irendercount, 2],[itextposition,[0,-30,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"], [iconnector1Diameter, 30], [iconnector1FlangeThickness, 5], [iconnector1FlangeScrewPosition, 15], [iconnector1FlangeScrewBorder, 7.5], [iconnector1FlangeScrewDiameter, 5], [iconnector1FlangeScrewCount, 1],[iconnector2Diameter, 25], [itransitionEnd2Count,1], [itransitionAngle, 45], [itransitionStyle, "taper+bend"]]],
        ["no rotation", [[iconnector1Rotation, 0]]],
        ["180deg", [[iconnector1Rotation, 180]]],
        ["270deg", [[iconnector1Rotation, 270]]],
        ["315deg", [[iconnector1Rotation, 315]]]
    ]

    //hose settings
    //hose_demo,hose_stopthickness,hose_stoplength,hose_stopsymmetrical,hose_barbsthickness,hose_barbscount,hose_barbssymmetrical,hose_endcapthickness,hose_endcapdiameter
    : scenario == "hose_demo" ? [["Hose",5,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40], [iconnector1Style, "hose"]]],
      ["50mm with internal stop", [[iconnector1Diameter, 50],[iconnector1StopLength, 3], [iconnector1StopThickness, 2],[iconnector1Taper, -1]]],
      ["50mm with external stop", [[iconnector1Diameter, 50],[iconnector1StopLength, 3], [iconnector1StopThickness, 2],[iconnector1Taper, 1]]],
      ["25mm with barbs", [[iconnector1Diameter, 25], [iconnector1BarbsCount, 3],[iconnector1Measurement, "outer"]]],
      ["closed cap", [[iconnector1Diameter, 25],[iconnector1Length, 3], [iconnector1Measurement, "inner"], [iconnector1EndCapThickness, 3], [iconnector1EndCapDiameter, 0]]],
      ["", [[iconnector1Style, "hose"]]]
    ]
    : scenario == "hose_stopthickness" ? [["Stop Thickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1StopLength,2]]],
        ["1mm outer", [[iconnector1StopThickness, 1],[iconnector1Taper, 1]]],
        ["2mm outer", [[iconnector1StopThickness, 2],[iconnector1Taper, 1]]],
        ["3mm outer", [[iconnector1StopThickness, 3],[iconnector1Taper, 1]]],
        ["1mm inner", [[iconnector1StopThickness, 1],[iconnector1Taper, -1]]],
        ["2mm inner", [[iconnector1StopThickness, 2],[iconnector1Taper, -1]]],
        ["3mm inner", [[iconnector1StopThickness, 3],[iconnector1Taper, -1]]]
    ]
    : scenario == "hose_stoplength" ? [["Stop Length",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter,40],[iconnector1StopThickness, 2]]],
        ["2mm outer", [[iconnector1StopLength, 2],[iconnector1Taper, 1]]],
        ["3mm outer", [[iconnector1StopLength, 3],[iconnector1Taper, 1]]],
        ["4mm outer", [[iconnector1StopLength, 4],[iconnector1Taper, 1]]],
        ["2mm inner", [[iconnector1StopLength, 2],[iconnector1Taper, -1]]],
        ["3mm inner", [[iconnector1StopLength, 3],[iconnector1Taper, -1]]],
        ["4mm inner", [[iconnector1StopLength, 4],[iconnector1Taper, -1]]]
    ]
    : scenario == "hose_stopsymmetrical" ? [["Stop Symmetrical",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter,40], [iconnector1StopThickness, 2],[iconnector1StopLength, 3]]],
        ["true outer", [[iconnector1StopSymmetrical, true],[iconnector1Taper, 1]]],
        ["false outer", [[iconnector1StopSymmetrical, false],[iconnector1Taper, 1]]],
        ["true inner", [[iconnector1StopSymmetrical, true],[iconnector1Taper, -1]]],
        ["false inner ", [[iconnector1StopSymmetrical, false],[iconnector1Taper, -1]]]
    ]
    : scenario == "hose_barbscount" ? [["Barbs Count",8,[[],[10,-0,25],260],[[irendercount,2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1Length,35]]],
        ["0 outer", [[iconnector1BarbsCount, 0],[iconnector1Measurement, "outer"]]],
        ["1 outer", [[iconnector1BarbsCount, 1],[iconnector1Measurement, "outer"]]],
        ["2 outer", [[iconnector1BarbsCount, 2],[iconnector1Measurement, "outer"]]],
        ["3 outer", [[iconnector1BarbsCount, 3],[iconnector1Measurement, "outer"]]],
        ["0 inner", [[iconnector1BarbsCount, 0],[iconnector1Measurement, "inner"]]],
        ["1 inner", [[iconnector1BarbsCount, 1],[iconnector1Measurement, "inner"]]],
        ["2 inner", [[iconnector1BarbsCount, 2],[iconnector1Measurement, "inner"]]],
        ["3 inner", [[iconnector1BarbsCount, 3],[iconnector1Measurement, "inner"]]]
    ]
    : scenario == "hose_barbsthickness" ? [["Barbs Thickness",6,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1Length, 35], [iconnector1BarbsCount, 2]]],
        ["1 outer", [[iconnector1BarbsThickness, 1],[iconnector1Measurement, "outer"]]],
        ["2 outer", [[iconnector1BarbsThickness, 2],[iconnector1Measurement, "outer"]]],
        ["3 outer", [[iconnector1BarbsThickness, 3],[iconnector1Measurement, "outer"]]],
        ["1 inner", [[iconnector1BarbsThickness, 1],[iconnector1Measurement, "inner"]]],
        ["2 inner", [[iconnector1BarbsThickness, 2],[iconnector1Measurement, "inner"]]],
        ["4 inner", [[iconnector1BarbsThickness, 3],[iconnector1Measurement, "inner"]]]
    ]
    : scenario == "hose_barbssymmetrical" ? [["Barbs Symmetrical",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1Length, 35], [iconnector1BarbsCount, 2]]],
        ["on outer", [[iconnector1BarbsSymmetrical, true],[iconnector1Measurement, "outer"]]],
        ["off outer", [[iconnector1BarbsSymmetrical, false],[iconnector1Measurement, "outer"]]],
        ["on inner", [[iconnector1BarbsSymmetrical, true],[iconnector1Measurement, "inner"]]],
        ["off inner", [[iconnector1BarbsSymmetrical, false],[iconnector1Measurement, "inner"]]]
    ]
    : scenario == "hose_endcapthickness" ? [["Hose End Cap",4,[[125,0,0],[10,-0,25],260],[[iconnector1Style,"hose"],[irendercount,2],[itextposition,[0,-55,-20]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1EndCapDiameter, 0]]],
        ["thickness 0mm", [[iconnector1EndCapThickness, 0]]],
        ["thickness 1mm", [[iconnector1EndCapThickness, 1]]],
        ["thickness 2mm", [[iconnector1EndCapThickness, 2]]],
        ["thickness 3mm", [[iconnector1EndCapThickness, 3]]]
    ]    
    : scenario == "hose_endcapdiameter" ? [["Hose End Cap",3,[[125,0,0],[10,-0,25],260],[[iconnector1Style, "hose"],[irendercount, 2],[itextposition,[0,-55,-20]], [itransitionColor,deemphasize],[iend2Color,deemphasize], [iconnector1Diameter,40],[iconnector1EndCapDiameter, 0]]],
        ["diameter 0mm", [[iconnector1EndCapThickness, 3]]],
        ["diameter 5mm",  [[iconnector1EndCapThickness, 3], [iconnector1EndCapDiameter, 5]]],
        ["diameter 10mm", [[iconnector1EndCapThickness, 3], [iconnector1EndCapDiameter, 10]]]
    ]     

    //flange
    //flange_demo,flange_width,flange_thickness,flange_screwposition,flange_screwborder,flange_screwcount,flange_screwdiameter
    : scenario == "flange_demo" ? [["Flange",4,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"], [iconnector1FlangeThickness, 5], [iconnector1FlangeScrewPosition, 15], [iconnector1FlangeScrewBorder, 7.5], [iconnector1FlangeScrewDiameter, 5]]],
      ["single screw", [[iconnector1FlangeScrewCount, 1]]],
      ["4 screws", [[iconnector1FlangeScrewCount, 4]]],
      ["4 screws, 25mm", [[iconnector1FlangeScrewCount, 4], [iconnector1FlangeScrewPosition, 25]]],
      ["6 screws", [[iconnector1FlangeScrewCount, 6], [iconnector1FlangeWidth, 15]]]
    ]
    : scenario == "flange_width" ? [["Flange Width",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"]]],
        ["diameter 10mm", [[iconnector1FlangeWidth, 10]]],
        ["diameter 15mm", [[iconnector1FlangeWidth, 15]]],
        ["diameter 20mm", [[iconnector1FlangeWidth, 20]]]
    ]     
    : scenario == "flange_thickness" ? [["Flange Thickness",3,[[125,0,0],[10,-0,25],350],[[iconnector1Style, "flange"],[irendercount, 2],[itextposition,[0,-55,-20]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1FlangeScrewPosition, 10]]],
        ["diameter 1mm", [[iconnector1FlangeThickness, 1]]],
        ["diameter 2mm", [[iconnector1FlangeThickness, 2]]],
        ["diameter 5mm", [[iconnector1FlangeThickness, 5]]]
    ]  
    : scenario == "flange_screwposition" ? [["Flange Screw Position",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"], [iconnector1FlangeWidth, 20]]],
        ["default", [[iconnector1FlangeScrewPosition, 0]]],
        ["diameter 15mm", [[iconnector1FlangeScrewPosition, 15]]],
        ["diameter 25mm", [[iconnector1FlangeScrewPosition, 25]]]
    ]
    : scenario == "flange_screwborder" ? [["Flange Screw Border",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"]]],
        ["diameter 5mm", [[iconnector1FlangeScrewBorder, 5]]],
        ["diameter 10mm", [[iconnector1FlangeScrewBorder, 10]]],
        ["diameter 15mm", [[iconnector1FlangeScrewBorder, 15]]]
    ]
    : scenario == "flange_screwcount" ? [["Flange Screw Count",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"]]],
        ["1", [[iconnector1FlangeScrewCount, 1]]],
        ["4", [[iconnector1FlangeScrewCount, 4]]],
        ["6", [[iconnector1FlangeScrewCount, 6]]]
    ]
    : scenario == "flange_screwdiameter" ? [["Flange Screw Diameter",3,[[125,0,0],[10,-0,25],350],[[irendercount, 2],[itextposition,[0,-55,-30]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "flange"]]],
        ["4", [[iconnector1FlangeScrewDiameter, 4]]],
        ["8", [[iconnector1FlangeScrewDiameter, 8]]],
        ["12", [[iconnector1FlangeScrewDiameter, 12]]]
    ]
    
    //magnet
    //magnetic_flangedemo,magnetic_magnetcount,magnetic_magnetdiameter,magnetic_magnetthickness,magnetic_magnetborder,magnetic_flangethickness,magnetic_alignmentring,magnetic_twistlock
    : scenario == "magnetic_flangedemo" ? [["Magnetic Flange",4,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1FlangeThickness, 5], [iconnector1FlangeScrewPosition, 15], [iconnector1FlangeScrewBorder, 7.5], [iconnector1FlangeScrewDiameter, 5]]],
      ["single screw", [[iconnector1FlangeScrewCount, 1]]],
      ["4 screws", [[iconnector1FlangeScrewCount, 4]]],
      ["4 screws, 25mm", [[iconnector1FlangeScrewCount, 4], [iconnector1FlangeScrewPosition, 25]]],
      ["6 screws", [[iconnector1FlangeScrewCount, 6], [iconnector1FlangeWidth, 15]]]
    ]
    : scenario == "magnetic_magnetcount" ? [["Magnetic Flange, Magnet Count",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["6", [[iconnector1MagnetCount, 6]]],
      ["8", [[iconnector1MagnetCount, 8]]],
      ["12", [[iconnector1MagnetCount, 12]]]
    ]  
    : scenario == "magnetic_magnetdiameter" ? [["Magnetic Flange, Magnet Diameter",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["6mm", [[iconnector1MagnetDiameter, 6]]],
      ["8mm", [[iconnector1MagnetDiameter, 8]]],
      ["12mm", [[iconnector1MagnetDiameter, 12]]]
    ]   
    : scenario == "magnetic_magnetthickness" ? [["Magnetic Flange, Magnet Thickness",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["2.5mm", [[iconnector1MagnetThickness, 2.5]]],
      ["4mm", [[iconnector1MagnetThickness, 4]]],
      ["5mm", [[iconnector1MagnetThickness, 5]]]
    ]   
    : scenario == "magnetic_magnetborder" ? [["Magnetic Flange, Magnet Border",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["2mm", [[iconnector1MagnetBorder, 2]]],
      ["4mm", [[iconnector1MagnetBorder, 4]]],
      ["6mm", [[iconnector1MagnetBorder, 6]]]
    ]   
    : scenario == "magnetic_flangethickness" ? [["Magnetic Flange, Flange Thickness",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["5mm", [[iconnector1MagnetFlangeThickness, 5]]],
      ["7.5mm", [[iconnector1MagnetFlangeThickness, 7.5]]],
      ["10mm", [[iconnector1MagnetFlangeThickness, 10]]]
    ]      
    : scenario == "magnetic_alignmentring" ? [["Magnetic Flange, Alignment Ring",3,[[125,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-60,-35]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60]]],
      ["disabled", [[iconnector1Ring, "no"]]],
      ["protruding", [[iconnector1Ring, "protruding"]]],
      ["recessed", [[iconnector1Ring, "recessed"]]]
    ]    
    : scenario == "magnetic_twistlock" ? [["Magnetic Flange, Twist Lock",7,[[170,0,0],[10,-0,25],450],[[irendercount, 2],[itextposition,[0,-200,-355]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Style, "mag"], [iconnector1Diameter, 60], [iconnector1MagnetCount, 6]]],
      ["none", [[iconnector1MagnetTwistLockSize, "0"]]],
      ["M3", [[iconnector1MagnetTwistLockSize, "3"]]],
      ["M3 with CNC Kitchen insert", [[iconnector1MagnetTwistLockSize, "3cnc"]]],
      ["M4", [[iconnector1MagnetTwistLockSize, "4"]]],
      ["M4 with CNC Kitchen insert", [[iconnector1MagnetTwistLockSize, "4cnc"]]],
      ["M5", [[iconnector1MagnetTwistLockSize, "5"]]],
      ["M5 with CNC Kitchen insert", [[iconnector1MagnetTwistLockSize, "5cnc"]]],
    ]    
    
    //allignmentring_demo
    //allignmentring_demo,allignmentring_depth,allignmentring_upperwidth,allignmentring_lowerwidth,allignmentring_sideclearance,allignmentring_depthclearance
    : scenario == "allignmentring_demo" ? [["Alignment Ring",1,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["", []]
    ]
    : scenario == "allignmentring_depth" ? [["Alignment Ring, Depth",4,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["1mm", [[ialignmentDepth, 1]]],
      ["2mm", [[ialignmentDepth, 2]]],
      ["3mm", [[ialignmentDepth, 3]]],
      ["4mm", [[ialignmentDepth, 4]]]
    ]   
    : scenario == "allignmentring_upperwidth" ? [["Alignment Ring, Upper Width",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["2mm", [[ialignmentUpperWidth, 2]]],
      ["3mm", [[ialignmentUpperWidth, 3]]],
      ["4mm", [[ialignmentUpperWidth, 4]]],
    ]      
    : scenario == "allignmentring_lowerwidth" ? [["Alignment Ring, Lower Width",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.5mm", [[ialignmentLowerWidth, 0.5]]],
      ["1mm", [[ialignmentLowerWidth, 1]]],
      ["1.5mm", [[ialignmentLowerWidth, 1.5]]],
    ] 
    : scenario == "allignmentring_sideclearance" ? [["Alignment Ring, Side Clearance",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.1mm", [[ialignmentSideClearance, 0.1]]],
      ["0.25mm", [[ialignmentSideClearance, 0.25]]],
      ["0.5mm", [[ialignmentSideClearance, 0.5]]],
    ]
    : scenario == "allignmentring_depthclearance" ? [["Alignment Ring, Depth Clearance",3,[[170,0,0],[10,-0,25],250],[[irendercount, 2],[itextposition,[0,50,-255]], [itransitionColor, deemphasize], [iend2Color, deemphasize], [iconnector1Diameter, 40], [idrawAlignmentRing, "end1"], [irotaterender2,[90,0,0]]]],
      ["0.5mm", [[ialignmentDepthClearance, 0.5]]],
      ["0.75mm", [[ialignmentDepthClearance, 0.75]]],
      ["1mm", [[ialignmentDepthClearance, 1]]],
    ]        
    
    //nozzle 
    //nozzle_demo,nozzle_shape,nozzle_size,nozzle_tipwallthickness,nozzle_radius,nozzle_offset,nozzle_chamferpercentage,nozzle_chamferangle
    : scenario == "nozzle_demo" ? [["Nozzle",1,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]],[iconnector1Style, "hose"], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"]]],
      ["", [[iconnector1Style, "hose"]]]
    ]
    : scenario == "nozzle_shape" ? [["Nozzle Shape",2,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize],[iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"]]],
      ["", [[iconnector2NozzleShape, "square"]]],
      ["", [[iconnector2NozzleShape, "circle"]]]
    ]
    : scenario == "nozzle_size" ? [["Nozzle Size",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"],[iconnector2NozzleShape, "square"]]],
      ["10mm x 10mm x 20mm", [[iconnector2NozzleSize, [10,10,20]]]],
      ["20mm x 10mm x 20mm", [[iconnector2NozzleSize, [20,10,20]]]],
      ["20mm x 20mm x 20mm", [[iconnector2NozzleSize, [20,20,20]]]],
      ["20mm x 20mm x 40mm", [[iconnector2NozzleSize, [20,20,40]]]]
    ]  
    : scenario == "nozzle_tipwallthickness" ? [["Nozzle Tip Wall Thickness",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"],[iconnector2NozzleShape, "square"]]],
      ["0.5mm", [[iconnector2NozzleTipWallThickness, 0.5]]],
      ["1mm", [[iconnector2NozzleTipWallThickness, 1]]],
      ["2mm", [[iconnector2NozzleTipWallThickness, 2]]]
    ]  
    : scenario == "nozzle_radius" ? [["Nozzle Radius",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"],[iconnector2NozzleShape, "square"]]],
      ["1mm", [[iconnector2NozzleRadius, 1]]],
      ["2mm", [[iconnector2NozzleRadius, 2]]],
      ["5mm", [[iconnector2NozzleRadius, 5]]]
    ]  
    : scenario == "nozzle_offset" ? [["Nozzle Offset",4,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"],[iconnector2NozzleShape, "square"]]],
      ["5mm x 0mm", [[iconnector2NozzleOffset, [5,0]]]],
      ["10mm x 0mm", [[iconnector2NozzleOffset, [10,0]]]],
      ["20mm x 10mm", [[iconnector2NozzleOffset, [20,10]]]],
      ["20mm x 20mm", [[iconnector2NozzleOffset, [20,20]]]]
    ]   
    : scenario == "nozzle_chamferpercentage" ? [["Nozzle Chamfer Percentage",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"], [iconnector2NozzleShape, "square"], [iconnector2NozzleChamferAngle, 45]]],
      ["25%", [[iconnector2NozzleChamferPercentage, 25]]],
      ["50%", [[iconnector2NozzleChamferPercentage, 50]]],
      ["100%", [[iconnector2NozzleChamferPercentage, 100]]]
    ]
    : scenario == "nozzle_chamferangle" ? [["Nozzle Chamfer Angle",3,[[],[10,-0,25],260],[[irendercount, 2],[itextposition,[0,-35,0]], [itransitionColor, deemphasize], [iend1Color, deemphasize], [iconnector1Style, "hose"], [iconnector1Length, 5], [iconnector2Diameter, 20], [iconnector2Style, "nozzle"], [iconnector2NozzleShape, "square"], [iconnector2NozzleChamferPercentage, 50]]],
      ["10", [[iconnector2NozzleChamferAngle, 10]]],
      ["30", [[iconnector2NozzleChamferAngle, 30]]],
      ["45", [[iconnector2NozzleChamferAngle, 45]]]
    ]    
        
    : scenario == "base_smple" ? [["Sample",1,[[],[0,0,20],250],[[itextposition,[0,-40,20]], [irotate, [0,0,-90]],[itransitionColor, coloredDeemphasize], [iend2Color, coloredDeemphasize], [itransitionStyle,"none"], [iconnector2Style, "none"], [iconnector1ExtensionLength, 10]]],
      ["", []]
    ]
    : scenario == "base_dmo" ? [["Sample",5,[[90,0,0],[0,0,60],350],[[irendercount,2], [itextposition,[0,-40,-30]], [irenderseparation,[80,0,0]], [itransitionColor,coloredDeemphasize], [iend2Color,coloredDeemphasize]]],
      ["Hose Adapter", []],
      ["Bent Hose Adapter", [[itransitionBendRadius,10], [itransitionAngle,45], [iconnector2BarbsCount,3], [iconnector2Measurement,"outer"]]],
      ["Nozzle", [[itransitionStyle,"bend+taper"], [itransitionBendRadius,10], [itransitionAngle,30], [itransitionLength,3], [iconnector2Style,"nozzle"], [iconnector2Diameter,0], [iconnector2NozzleShape,"square"], [iconnector2NozzleChamferPercentage,50], [iconnector2NozzleChamferAngle,45],[iconnector2NozzleSize,[10,5,50]]]],
      ["Double Adapter", [[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenterHeight,45]]],
      ["Triple Adapter", [[itransitionAngle,45], [itransitionStyle,"hull"],[itransitionEnd2Count,2], [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [irotaterender1,[0,0,-45]], [irotaterender2,[0,0,-45]]]]
    ]
    //camlock 
    //camlock_sample,base_dmo
    : scenario == "camlock_sample" ? [["CamLock Quick Connect",1,[],[[iconnector1Style, "camlock"], [iconnector1ExtensionText, str("Camlock - v" ,retriveConnectorSetting("camlock", iSettingsVersion))]],"base_smple"]]
    : scenario == "camlock_demo" ? [["CamLock Quick Connect",5,[],[[iconnector1Style, "camlock"]],"base_dmo"]]
    //centec 
    //centec_female_sample,centec_female_demo,centec_male_sample,centec_male_demo
    : scenario == "centec_female_sample" ? [["Centec Female",1,[],[[iconnector1Style, "centec_female"], [iconnector1ExtensionText, str("Centec Female - v" ,retriveConnectorSetting("centec_female", iSettingsVersion))]],"base_smple"]]
    : scenario == "centec_female_demo" ? [["Centec Female Quick Connect",5,[],[[iconnector1Style, "centec_female"]],"base_dmo"]]
    : scenario == "centec_male_sample" ? [["Centec Male",1,[],[[iconnector1Style, "centec_male"], [iconnector1ExtensionText, str("Centec Male - V" ,retriveConnectorSetting("centec_male", iSettingsVersion))]],"base_smple"]]
    : scenario == "centec_male_demo" ? [["Centec Male Quick Connect",5,[],[[iconnector1Style, "centec_male"]],"base_dmo"]]
    //dyson 
    //dyson_sample,dyson_demo
    : scenario == "dyson_sample" ? [["Dyson V6",1,[],[[iconnector1Style, "dyson"], [iconnector1ExtensionText, str("Dyson V6 - v" ,retriveConnectorSetting("dyson", iSettingsVersion))]],"base_smple"]]
    : scenario == "dyson_demo" ? [["Dyson",5,[],[[iconnector1Style, "dyson"]],"base_dmo"]] 
    //dw735 
    //dw735_sample,dw735_demo
    : scenario == "dw735_sample" ? [["Dewalt 735",1,[],[[iconnector1Style, "dw735"], [iconnector1ExtensionText, str("Dewalt 735 - v" ,retriveConnectorSetting("dw735", iSettingsVersion))]],"base_smple"]]
    : scenario == "dw735_demo" ? [["Dewalt 735",5,[],[[iconnector1Style, "dw735"]],"base_dmo"]] 
    //makita_male 
    //makita_male_sample,makita_male_demo
    : scenario == "makita_male_sample" ? [["Makita QC",1,[],[[iconnector1Style, "makita_male"], [iconnector1ExtensionText, str("Makita QC - v" ,retriveConnectorSetting("makita_male", iSettingsVersion))]],"base_smple"]]
    : scenario == "makita_male_demo" ? [["Makita QC",5,[],[[iconnector1Style, "makita_male"]],"base_dmo"]] 
    //osvacm32_sample,osvacm32_demo,osvacm_sample,osvacm_demo,osvacf32_sample,osvacf32_demo,osvacf_sample,osvacf_demo
    : scenario == "osvacm32_sample" ? [["osVAC32 Male",1,[],[[iconnector1Style, "osvacm32"], [iconnector1ExtensionText, str("osVAC32 Male - v" ,retriveConnectorSetting("osvacm32", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacm32_demo" ? [["osVAC32 Male",5,[],[[iconnector1Style, "osvacm32"]],"base_dmo"]] 
    : scenario == "osvacm_sample" ? [["osVAC Male",1,[],[[iconnector1Style, "osvacm"], [iconnector1ExtensionText, str("osVAC Male - v" ,retriveConnectorSetting("osvacm", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacm_demo" ? [["osVAC Male",5,[],[[iconnector1Style, "osvacm"]],"base_dmo"]] 
    : scenario == "osvacf32_sample" ? [["osVAC32 Female",1,[],[[iconnector1Style, "osvacf32"], [iconnector1ExtensionText, str("osVAC32 Female - v" ,retriveConnectorSetting("osvacf32", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacf32_demo" ? [["osVAC32 Female",5,[],[[iconnector1Style, "osvacf32"]],"base_dmo"]] 
    : scenario == "osvacf_sample" ? [["osVAC Female",1,[],[[iconnector1Style, "osvacf"], [iconnector1ExtensionText, str("osVAC Female - v" ,retriveConnectorSetting("osvacf", iSettingsVersion))]],"base_smple"]]
    : scenario == "osvacf_demo" ? [["osVAC Female",5,[],[[iconnector1Style, "osvacf"]],"base_dmo"]] 
    
    //transition
    //transition_demo,transition_bendtaper,transition_taperbend,transition_organicbend,transition_flat,
    : scenario == "transition_demo" ? [["Transition",9,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [irenderseparation,[80,0,0]], [itransitionBendRadius,20],[itransitionAngle,20], [iend1Color, coloredDeemphasize], [iend2Color, coloredDeemphasize], [iend3Color, coloredDeemphasize]]],
      ["hull 3", [[itransitionStyle, "hull"],[itransitionEnd2Count, 1], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [iconnector2Diameter, 20], [iconnector3Diameter, 30], [itransitionHullLength, 10]]],
      ["bend+taper", [[itransitionStyle, "bend+taper"]]],
      ["taper+bend", [[itransitionStyle, "taper+bend"]]],
      ["organicbend", [[itransitionStyle, "organicbend"]]],
      ["hull 1", [[itransitionStyle, "hull"]]],
      ["hull 2", [[itransitionStyle, "hull"],[itransitionEnd2Count, 2]]],
      ["hull 3", [[itransitionStyle, "hull"],[itransitionEnd2Count, 1], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [iconnector2Diameter, 20], [iconnector3Diameter, 30], [itransitionHullLength, 10]]],
      ["hull 4", [[itransitionStyle, "hull"],[itransitionEnd2Count, 2], [itransitionAngle,45],  [itransitionHullCenter,true], [itransitionHullCenterHeight,45], [itransitionHullLength,20], [iconnector2Diameter, 20], [iconnector3Diameter, 30], [itransitionHullLength, 10], [irotaterender1,[0,0,-25]], [irotaterender2,[0,0,-25]]]],
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
     ["Pre 10mm", [[iconnector1ExtensionLength,10]]],
     ["Pre and Post 10mm", [[iconnector1ExtensionLength,10], [iconnector2ExtensionLength,10]]],
     ["Pre grid", [[iconnector1ExtensionLength,10], [iconnector2ExtensionLength,10], [iconnector1ExtensionGridWallThickness,-1]]]
    ]
    : scenario == "transitionextpre_length" ? [["Pre Transition Extension Length",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector1ExtensionLength,0]]],
      ["5mm", [[iconnector1ExtensionLength,5]]],
      ["10mm", [[iconnector1ExtensionLength,10]]]
    ]
    : scenario == "transitionextpre_gridSize" ? [["Pre Transition Extension Grid Size",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iconnector1ExtensionLength,5],[iconnector1ExtensionGridWallThickness,2], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector1ExtensionGridSize,0]]],
      ["5mm", [[iconnector1ExtensionGridSize,5]]],
      ["10mm", [[iconnector1ExtensionGridSize,10]]]
    ]
    : scenario == "transitionextpre_wallthickness" ? [["Pre Transition Extension WallThickness",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iconnector1ExtensionLength,5], [iconnector1ExtensionGridSize,5], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector1ExtensionGridWallThickness,0]]],
      ["2mm", [[iconnector1ExtensionGridWallThickness,2]]],
      ["3mm", [[iconnector1ExtensionGridWallThickness,3]]],
      ["5mm", [[iconnector1ExtensionGridWallThickness,5]]]
    ]
        : scenario == "transitionextpost_length" ? [["Post Transition Extension Length",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector2ExtensionLength,0]]],
      ["5mm", [[iconnector2ExtensionLength,5]]],
      ["10mm", [[iconnector2ExtensionLength,10]]]
    ]
    : scenario == "transitionextpost_gridSize" ? [["Post Transition Extension Grid Size",3,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iconnector2ExtensionLength,5],[iconnector2ExtensionGridWallThickness,2], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector2ExtensionGridSize,0]]],
      ["5mm", [[iconnector2ExtensionGridSize,5]]],
      ["10mm", [[iconnector2ExtensionGridSize,10]]]
    ]
    : scenario == "transitionextpost_wallthickness" ? [["Post Transition Extension WallThickness",4,[[90,0,0],[0,0,60],400],[[irendercount,2] ,[itextposition,[0,-30,-50]], [itransitionBendRadius,10], [irenderseparation,[80,0,0]], [iconnector2ExtensionLength,5], [iconnector2ExtensionGridSize,5], [iend1Color,deemphasize], [iend2Color,deemphasize]]],
      ["0mm", [[iconnector2ExtensionGridWallThickness,0]]],
      ["2mm", [[iconnector2ExtensionGridWallThickness,2]]],
      ["3mm", [[iconnector2ExtensionGridWallThickness,3]]],
      ["5mm", [[iconnector2ExtensionGridWallThickness,5]]]
    ]

    : assert(false, str("unknow scenario - '", scenario, "'"));

function getDerviedScenario(scenario) = 
  let(selectedScenario = getScenario(scenario),
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
    len(selectedScenario) != 1 
      ? selectedScenario : 
      derivedScenario; 
      
function getCurrentStep(scenario, stepIndex=-1) = let(
  selectedScenario = getDerviedScenario(scenario),
  scenarioDefaults = selectedScenario[0],
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1),
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]),
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting)
) currentStepSettings;

function getSize(currentStepSettings) = let(
  css = currentStepSettings,
  c1 = [css[iconnector1Diameter] + css[iconnector1WallThickness]*2 + css[iconnector1Taper]*2 + 
      (css[iconnector1Style] == "mag" ? (css[iconnector1MagnetDiameter] + css[iconnector1MagnetBorder]*4) + (css[iconnector1Ring] != "no" ? css[ialignmentUpperWidth]*2 : 0 ): 0) + 
      (css[iconnector1Style] == "flange" ? css[iconnector1FlangeWidth] :0)
      , css[iconnector1Length]],
  c2 = [css[iconnector2Diameter] + css[iconnector2WallThickness]*2 + css[iconnector2Taper]*2 + 
      (css[iconnector2Style] == "mag" ? (css[iconnector2MagnetDiameter] + css[iconnector2MagnetBorder]*4) + (css[iconnector2Ring] != "no" ? css[ialignmentUpperWidth]*2 : 0 ): 0) +  
      (css[iconnector2Style] == "flange" ? css[iconnector2FlangeWidth] :0)
      , css[iconnector2Length]],        
) [c1,c2];


function GetRenderSeparation(currentStepSettings) = let(
  rendSep = currentStepSettings[irenderseparation])
  (is_list(rendSep) && len(rendSep) == 3) 
    ? rendSep 
    : let(size = getSize(currentStepSettings)) [max(size[0].x, size[1].x),max(size[0].y, size[1].y),0];

module RenderScenario(scenario, showtext=true, stepIndex=-1, sliceDebug = false, showCaliper = false, showadapter=true){
  selectedScenario = getDerviedScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  assert(scenarioDefaults[iscenarioName] != "unknown scenario", "unknown scenario");
    
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);

  echo("🟩RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, selectedScenarioLen=len(selectedScenario), defaultDemoSettingLen=len(defaultDemoSetting), currentStepSettings=currentStepSettings);
  
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
  translate(let(tp = currentStepSettings[itextposition]) is_list(tp) && len(tp)==3 ? tp : [0,-45,60])
   linear_extrude(height = 0.1)
   text(renderText, size=6,halign="center");

  echo(iconnector1Length=iconnector1Length, connector1Length = currentStepSettings[iconnector1Length], iconnector1BarbsThickness=iconnector1BarbsThickness, connector1BarbsThickness = currentStepSettings[iconnector1BarbsThickness]);
  
  if(showadapter)
    rotate(currentStepSettings[irotate]) 
    translate(currentStepSettings[itranslate])
    HoseAdapter(
        drawAlignmentRing = currentStepSettings[idrawAlignmentRing],
        alignmentDepth = currentStepSettings[ialignmentDepth],
        alignmentUpperWidth = currentStepSettings[ialignmentUpperWidth],
        alignmentLowerWidth = currentStepSettings[ialignmentLowerWidth],
        alignmentSideClearance = currentStepSettings[ialignmentSideClearance],
        alignmentDepthClearance = currentStepSettings[ialignmentDepthClearance],

        connector1Style = currentStepSettings[iconnector1Style],
        connector1WallThickness  = currentStepSettings[iconnector1WallThickness ],
        connector1Measurement = currentStepSettings[iconnector1Measurement],
        connector1Diameter = currentStepSettings[iconnector1Diameter],
        connector1Length = currentStepSettings[iconnector1Length],
        connector1Taper = currentStepSettings[iconnector1Taper],
        connector1Rotation = currentStepSettings[iconnector1Rotation],
        
        connector1EndCapDiameter  = currentStepSettings[iconnector1EndCapDiameter ],
        connector1EndCapThickness = currentStepSettings[iconnector1EndCapThickness],
        connector1StopThickness = currentStepSettings[iconnector1StopThickness],
        connector1StopLength = currentStepSettings[iconnector1StopLength],
        connector1StopSymmetrical = currentStepSettings[iconnector1StopSymmetrical],
        connector1BarbsCount = currentStepSettings[iconnector1BarbsCount],
        connector1BarbsThickness = currentStepSettings[iconnector1BarbsThickness],
        connector1BarbsSymmetrical = currentStepSettings[iconnector1BarbsSymmetrical],

        connector1MagnetCount = currentStepSettings[iconnector1MagnetCount],
        connector1MagnetDiameter = currentStepSettings[iconnector1MagnetDiameter],
        connector1MagnetThickness = currentStepSettings[iconnector1MagnetThickness],
        connector1MagnetBorder = currentStepSettings[iconnector1MagnetBorder],
        connector1MagnetFlangeThickness = currentStepSettings[iconnector1MagnetFlangeThickness],
        connector1Ring = currentStepSettings[iconnector1Ring],
        connector1MagnetTwistLockSize = currentStepSettings[iconnector1MagnetTwistLockSize],
        
        connector1FlangeWidth = currentStepSettings[iconnector1FlangeWidth],
        connector1FlangeThickness = currentStepSettings[iconnector1FlangeThickness],
        connector1FlangeScrewPosition = currentStepSettings[iconnector1FlangeScrewPosition],
        connector1FlangeScrewBorder = currentStepSettings[iconnector1FlangeScrewBorder],
        connector1FlangeScrewCount = currentStepSettings[iconnector1FlangeScrewCount],
        connector1FlangeScrewDiameter = currentStepSettings[iconnector1FlangeScrewDiameter],

        connector1ExtensionLength = currentStepSettings[iconnector1ExtensionLength],
        connector1ExtensionGridSize = currentStepSettings[iconnector1ExtensionGridSize],
        connector1ExtensionGridWallThickness = currentStepSettings[iconnector1ExtensionGridWallThickness],
        connector1ExtensionText = currentStepSettings[iconnector1ExtensionText],
        connector1ExtensionTextSize=currentStepSettings[iconnector1ExtensionTextSize],

        transitionStyle = currentStepSettings[itransitionStyle],
        transitionLength = currentStepSettings[itransitionLength],
        transitionBendRadius = currentStepSettings[itransitionBendRadius],
        transitionAngle = currentStepSettings[itransitionAngle],
        transitionOffset = currentStepSettings[itransitionOffset],
        transitionBaseType = currentStepSettings[itransitionBaseType],
        transitionBaseThickness = currentStepSettings[itransitionBaseThickness],
        transitionBaseWidth = currentStepSettings[itransitionBaseWidth],
        transitionBaseLength = currentStepSettings[itransitionBaseLength],
        transitionBaseAngle = currentStepSettings[itransitionBaseAngle],
        transitionEnd2Count = currentStepSettings[itransitionEnd2Count],
        transitionHullLength = currentStepSettings[itransitionHullLength],
        transitionHullCenterLength = currentStepSettings[itransitionHullCenterLength],
  
        transitionHullyOffset = currentStepSettings[itransitionHullyOffset],
        transitionHullCenter = currentStepSettings[itransitionHullCenter],
        transitionHullCenterHeight = currentStepSettings[itransitionHullCenterHeight],

        connector2Style = currentStepSettings[iconnector2Style],
        connector2WallThickness  = currentStepSettings[iconnector2WallThickness ],
        connector2Measurement = currentStepSettings[iconnector2Measurement],
        connector2Diameter = currentStepSettings[iconnector2Diameter],
        connector2Length = currentStepSettings[iconnector2Length],
        connector2Taper = currentStepSettings[iconnector2Taper],
        connector2Rotation = currentStepSettings[iconnector2Rotation],

        connector2EndCapDiameter  = currentStepSettings[iconnector2EndCapDiameter ],
        connector2EndCapThickness = currentStepSettings[iconnector2EndCapThickness],
        connector2StopThickness = currentStepSettings[iconnector2StopThickness],
        connector2StopLength = currentStepSettings[iconnector2StopLength],
        connector2StopSymmetrical = currentStepSettings[iconnector2StopSymmetrical],
        connector2BarbsCount = currentStepSettings[iconnector2BarbsCount],
        connector2BarbsThickness = currentStepSettings[iconnector2BarbsThickness],
        connector2BarbsSymmetrical = currentStepSettings[iconnector2BarbsSymmetrical],

        connector2MagnetCount = currentStepSettings[iconnector2MagnetCount],
        connector2MagnetDiameter = currentStepSettings[iconnector2MagnetDiameter],
        connector2MagnetThickness = currentStepSettings[iconnector2MagnetThickness],
        connector2MagnetBorder = currentStepSettings[iconnector2MagnetBorder],
        connector2MagnetFlangeThickness = currentStepSettings[iconnector2MagnetFlangeThickness],
        connector2Ring = currentStepSettings[iconnector2Ring],
        connector2MagnetTwistLockSize = currentStepSettings[iconnector2MagnetTwistLockSize],
        
        connector2FlangeWidth = currentStepSettings[iconnector2FlangeWidth],
        connector2FlangeThickness = currentStepSettings[iconnector2FlangeThickness],
        connector2FlangeScrewPosition = currentStepSettings[iconnector2FlangeScrewPosition],
        connector2FlangeScrewBorder = currentStepSettings[iconnector2FlangeScrewBorder],
        connector2FlangeScrewCount = currentStepSettings[iconnector2FlangeScrewCount],
        connector2FlangeScrewDiameter = currentStepSettings[iconnector2FlangeScrewDiameter],
        
        connector2NozzleShape = currentStepSettings[iconnector2NozzleShape],
        connector2NozzleSize = currentStepSettings[iconnector2NozzleSize],
        connector2NozzleTipWallThickness = currentStepSettings[iconnector2NozzleTipWallThickness],
        connector2NozzleRadius = currentStepSettings[iconnector2NozzleRadius],
        connector2NozzleOffset = currentStepSettings[iconnector2NozzleOffset],
        connector2NozzleChamferPercentage = currentStepSettings[iconnector2NozzleChamferPercentage],
        connector2NozzleChamferAngle = currentStepSettings[iconnector2NozzleChamferAngle],

        connector2ExtensionLength = currentStepSettings[iconnector2ExtensionLength],
        connector2ExtensionGridSize = currentStepSettings[iconnector2ExtensionGridSize],
        connector2ExtensionGridWallThickness = currentStepSettings[iconnector2ExtensionGridWallThickness],
        connector2ExtensionText = currentStepSettings[iconnector2ExtensionText],
        connector2ExtensionTextSize=currentStepSettings[iconnector2ExtensionTextSize],

        connector3Style = currentStepSettings[iconnector3Style],
        connector3WallThickness  = currentStepSettings[iconnector3WallThickness ],
        connector3Measurement = currentStepSettings[iconnector3Measurement],
        connector3Diameter = currentStepSettings[iconnector3Diameter],
        connector3Length = currentStepSettings[iconnector3Length],
        connector3Taper = currentStepSettings[iconnector3Taper],
        connector3Rotation = currentStepSettings[iconnector3Rotation],

        connector3EndCapDiameter  = currentStepSettings[iconnector3EndCapDiameter ],
        connector3EndCapThickness = currentStepSettings[iconnector3EndCapThickness],
        connector3StopThickness = currentStepSettings[iconnector3StopThickness],
        connector3StopLength = currentStepSettings[iconnector3StopLength],
        connector3StopSymmetrical = currentStepSettings[iconnector3StopSymmetrical],
        connector3BarbsCount = currentStepSettings[iconnector3BarbsCount],
        connector3BarbsThickness = currentStepSettings[iconnector3BarbsThickness],
        connector3BarbsSymmetrical = currentStepSettings[iconnector3BarbsSymmetrical],

        connector3MagnetCount = currentStepSettings[iconnector3MagnetCount],
        connector3MagnetDiameter = currentStepSettings[iconnector3MagnetDiameter],
        connector3MagnetThickness = currentStepSettings[iconnector3MagnetThickness],
        connector3MagnetBorder = currentStepSettings[iconnector3MagnetBorder],
        connector3MagnetFlangeThickness = currentStepSettings[iconnector3MagnetFlangeThickness],
        connector3Ring = currentStepSettings[iconnector3Ring],
        connector3MagnetTwistLockSize = currentStepSettings[iconnector3MagnetTwistLockSize],
        
        connector3FlangeWidth = currentStepSettings[iconnector3FlangeWidth],
        connector3FlangeThickness = currentStepSettings[iconnector3FlangeThickness],
        connector3FlangeScrewPosition = currentStepSettings[iconnector3FlangeScrewPosition],
        connector3FlangeScrewBorder = currentStepSettings[iconnector3FlangeScrewBorder],
        connector3FlangeScrewCount = currentStepSettings[iconnector3FlangeScrewCount],
        connector3FlangeScrewDiameter = currentStepSettings[iconnector3FlangeScrewDiameter],
        
        connector3NozzleShape = currentStepSettings[iconnector3NozzleShape],
        connector3NozzleSize = currentStepSettings[iconnector3NozzleSize],
        connector3NozzleTipWallThickness = currentStepSettings[iconnector3NozzleTipWallThickness],
        connector3NozzleRadius = currentStepSettings[iconnector3NozzleRadius],
        connector3NozzleOffset = currentStepSettings[iconnector3NozzleOffset],
        connector3NozzleChamferPercentage = currentStepSettings[iconnector3NozzleChamferPercentage],
        connector3NozzleChamferAngle = currentStepSettings[iconnector3NozzleChamferAngle],

        connector3ExtensionLength = currentStepSettings[iconnector3ExtensionLength],
        connector3ExtensionGridSize = currentStepSettings[iconnector3ExtensionGridSize],
        connector3ExtensionGridWallThickness = currentStepSettings[iconnector3ExtensionGridWallThickness],
        connector3ExtensionText = currentStepSettings[iconnector3ExtensionText],
        connector3ExtensionTextSize=currentStepSettings[iconnector3ExtensionTextSize],

        sliceDebug = sliceDebug || currentStepSettings[isliceDebug],
        end1Color = currentStepSettings[iend1Color],
        end2Color = currentStepSettings[iend2Color],
        end3Color = currentStepSettings[iend3Color],
        transitionColor = currentStepSettings[itransitionColor],
        extensionColor = currentStepSettings[iextensionColor],
        showCaliper = showCaliper || currentStepSettings[ishowCaliper],
        help=help);
}

color(colour)
union(){
  if(isMulti(scenario)){
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
    echo(currentStep=currentStep, separation=separation);

    if(currentStep[irendercount] == 4) {
      if(showtext)
      //translate([0,0,-45])
      translate(let(tp = currentStep[itextposition]) is_list(tp) && len(tp)==3 ? tp : [0,0,-45])
      RenderScenario(scenario, showtext = true, showadapter = false);
            
      union(){
        translate([separation.x*-0.6,0,separation.z])
        rotate(currentStep[irotaterender1])
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,separation.z])
        rotate(currentStep[irotaterender1])
        RenderScenario(scenario, showtext=false, sliceDebug = true, showCaliper=true);
      }
      
      union(){
        translate([separation.x*-0.6,0,-separation.z])
        rotate([60,0,0])
        rotate(currentStep[irotaterender2])
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,-separation.z])
        rotate([-60,0,0])
        rotate(currentStep[irotaterender2])
        RenderScenario(scenario, showtext=false);
      }
    }
    else if(currentStep[irendercount] == 2) {
      if(showtext)
      translate(let(tp = currentStep[itextposition]) is_list(tp) && len(tp)==3 ? tp : [0,-45,-0])
      RenderScenario(scenario, showtext = true, showadapter = false);

      union(){
        translate([separation.x*-0.6,0,0])
        rotate(currentStep[irotaterender1])
        RenderScenario(scenario, showtext = false);
        translate([separation.x*0.6,0,0])
        rotate(currentStep[irotaterender2])
        RenderScenario(scenario, showtext=false, sliceDebug = true, showCaliper=true);
        
      }
    } else {
      RenderScenario(scenario);
    }
  }
}

