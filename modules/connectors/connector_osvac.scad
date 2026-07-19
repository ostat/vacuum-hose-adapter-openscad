//osVAC
//Female documentation https://www.thingiverse.com/thing:4562762
//Male documentation https://www.thingiverse.com/thing:4562789
use <../thirdparty/ub.scad>
include <../constants.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>
use <../module_twist_lock_hose.scad>

osvac_debug = false;

if(osvac_debug){
  $fn = 64;
  //Test female connector
  translate([0,-35,0])
  osVacFemaleConnector(help=true);

  //Test male connector
  //translate([0,35,0])
  //osVacMaleConnector(help=true);
}

/* [Hidden] */
clipCount = 3;

osvacmVersion = "0.1";
osvacmMinLength = 30;
osvacmMeasurement = "inner";
osvacmOuterDiameter = 37.8;
osvacmInnerDiameter = 32;
osvacmWallThickness = (osvacmOuterDiameter - osvacmInnerDiameter)/2;

osvacm32Settings = ["osvacm32", [
  [iSettingsLength, osvacmMinLength],
  [iSettingsMeasurement, osvacmMeasurement],
  [iSettingsDiameter, osvacmInnerDiameter],
  [iSettingsWallThickness, osvacmWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacmVersion]
  ]];
osvacmSettings = ["osvacm", [
  [iSettingsLength, osvacmMinLength],
  [iSettingsMeasurement, osvacmMeasurement],
  [iSettingsWallThickness, osvacmWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacmVersion]
  ]];

osvacfVersion = "0.1";
osvacfMinLength = 34.10;
osvacfMeasurement = "inner";
osvacfOuterDiameter = 47.265;
osvacfInnerDiameter = 32;
osvacfInnerWallDiameter = 38.2;
osvacfWallThickness = (osvacfOuterDiameter - osvacfInnerDiameter)/2;
osvacf32Settings = ["osvacf32", [
  [iSettingsLength, osvacfMinLength],
  [iSettingsMeasurement, osvacfMeasurement],
  [iSettingsDiameter, osvacfInnerDiameter],
  [iSettingsWallThickness, osvacfWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacfVersion]
  ]];
osvacfSettings = ["osvacf", [
  [iSettingsLength, osvacfMinLength],
  [iSettingsMeasurement, osvacfMeasurement],
  [iSettingsWallThickness, osvacfWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacfVersion]
  ]];

//Test male connector
//osVacMaleConnector(innerDiameter = 50, help=true);

//Test female connector
//osVacFemaleConnector(innerDiameter = 50, help=true);

module osVacFemaleConnector(
  innerDiameter = osvacfInnerDiameter,
  length = osvacfMinLength,
  wallThickness = osvacfWallThickness,
  help,
  $fn = 64){
  innerTaperSize = (osvacfInnerWallDiameter-osvacfInnerDiameter)/2;
  innerWallDiameter = innerDiameter + innerTaperSize*2;
  outerDiameter = innerDiameter + wallThickness*2;
  //finalShaftLength = 5;

  innerShaftLength = 30.5;
  cutoutz = 3.7;
  cutoutHeight = 6.35;
  cutoutDepthz = innerShaftLength - cutoutz;
  cutoutDepthx = 2;
  cutoutBumpDepthx = 1.6;
  cutoutRadius = innerWallDiameter/2+cutoutDepthx;
  cutoutWidth = 10.2;
  
  //The distence is base on a f32,
  //The spec defines it as the ARC Length for 35deg on an F32
  lockAngle = 35;
  
  finalShaftLength = length - innerShaftLength;
  
  translate([0,0,innerShaftLength])
  pipe(
    diameter = innerDiameter,
    length = finalShaftLength,
    wallThickness = wallThickness,
    chamfer1 = [innerTaperSize,0]);

    BayonetSlotConnector(
    //outerDiameter = innerDiameter + innerTaperSize,
    innerDiameter = innerWallDiameter,
    length = innerShaftLength,
    wallThickness = wallThickness-innerTaperSize,
    slotCount = 3,                // Number of equally spaced slots.
    slotWidth = cutoutWidth,             // Circumferential size of the slot (Usually outerLugWidth + clearance).
    slotOffset = cutoutz,             // Distance from connector face to the start (or center) of the slot.
    slotAxialLength = cutoutHeight,       // Axial size of the lug
    slotDepth = cutoutDepthx,                // Radial depth of the slot (Must clear lug radial projection)
    lockAngle = lockAngle,               // Axial size of the lug
    lockBumpDepth = cutoutBumpDepthx,          // Depth of lock bump that creates the lock when twisted
    help=true);

  HelpTxt("osVacFemaleConnector",[
    "innerDiameter", innerDiameter,
    "outerDiameter", outerDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "innerTaperSize", innerTaperSize,
    "innerWallDiameter", innerWallDiameter,
    "finalShaftLength", finalShaftLength,
    "innerShaftLength", innerShaftLength,
    "cutoutHeight", cutoutHeight,
    "cutoutz", cutoutz,
    "cutoutDepthz", cutoutDepthz,
    "cutoutDepthx", cutoutDepthx,
    "cutoutBumpDepthx", cutoutBumpDepthx,
    "cutoutRadius", cutoutRadius,
    "cutoutWidth", cutoutWidth,
    "osvacfWallThickness", osvacfWallThickness,
    "osvacfMinLength", osvacfMinLength,
    "osvacfInnerDiameter", osvacfInnerDiameter
    ],help);
}

module osVacMaleConnector(
  innerDiameter = osvacmInnerDiameter,
  length = osvacmMinLength,
  wallThickness = osvacmWallThickness,
  help
){
  outerDiameter = innerDiameter+wallThickness*2;

  hoseEndTaper=0.7;
  clipHeight = 6.95;
  clipz = 3.2;
  clipr = 1;//not right
  clipThickness = 2;
  clipWidth = 9.8;
  clipTopTaperz = 5.8;
  clipTopTaperHeight = clipHeight - clipTopTaperz;

  BayonetLugConnector(
    outerDiameter = outerDiameter,
    length = length,
    wallThickness = wallThickness,
    hoseEndTaper=hoseEndTaper,
    lugCount = 3,                 // Number of equally spaced lugs.
    outerLugEnabled = true,
    outerLugWidth = clipWidth,          // Circumferential size of the lug.
    outerLugHeight = clipThickness,           // Radial projection from the base surface.
    outerLugAxialLength = clipHeight,   // Axial size of the lug
    outerLugSideRadius = clipHeight,           // side radius of the lug
    outerLugOffset = clipz,         // Distance from connector face to the start (or center) of the lug.
    outerLugTopBottomRadius = [clipThickness,clipThickness],        // Top/bottom of lug radius
    outerLugTopBottomChamferRadius = [clipHeight/2,clipHeight/2], // Top/bottom of lug champfer corner radius
    //outerLugTopBottomTaperz = [clipThickness,0],        // Tob bottom of lug taper
    help = help);

  HelpTxt("osVacMaleConnector",[
    "innerDiameter", innerDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "outerDiameter", outerDiameter,
    "hoseEndTaper", hoseEndTaper,
    "clipz", clipz,
    "clipr", clipr,
    "clipThickness", clipThickness,
    "clipWidth", clipWidth,
    "clipTopTaperHeight", clipTopTaperHeight,
    "osvacmWallThickness", osvacmWallThickness,
    "osvacmMinLength", osvacmMinLength,
    "osvacmInnerDiameter", osvacmInnerDiameter
    ],help);
}



