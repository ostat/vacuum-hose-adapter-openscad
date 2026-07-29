//Festool
include <../constants.scad>
use <../module_twist_lock_hose.scad>
include <../modules_pipe.scad>

festoolCleantec_debug = false;

if(festoolCleantec_debug){
  $fn = 64;
  //Test female connector
  translate([0,-35,0])
  FestoolCleantecLugConnector(help=true);

  //Test male connector
  translate([0,35,0])
  FestoolCleantecSlotConnector(help=true);
}

/* [Hidden] */
lugCount = 3;

festoolCleantecLug_Version = "0.1";
festoolCleantecLug_MinLength = 26;
festoolCleantecLug_Measurement = "outer";
festoolCleantecLug_OuterDiameter = 40; // 39.6 measured
festoolCleantecLug_OuterDiameter_tip = 39.4; // 39.5 measured
festoolCleantecLug_InnerDiameter = 36; // measured
festoolCleantecLug_WallThickness_tip_measurement = 1.3; // 1.5 measured
festoolCleantecLug_WallThickness_base_measurement = 2.6; // measured


festoolCleantecLug_flange_stop = 5; // 44.81measured
festoolCleantecLug_Doublelug_measurement = 4.8; // measured
festoolCleantecLug_outer_clip_size = [12.5,9.0]; // width, height.  measured
festoolCleantecLug_outer_clip_tapers = [1,0,1,0]; // width, height.  measured

festoolCleantecLugSettings = ["festoolcleanteclug", [
  [iSettingsLength, festoolCleantecLug_MinLength+festoolCleantecLug_flange_stop],
  [iSettingsMeasurement, festoolCleantecLug_Measurement],
  [iSettingsDiameter, festoolCleantecLug_OuterDiameter+festoolCleantecLug_flange_stop],
  [iSettingsWallThickness, festoolCleantecLug_WallThickness_base_measurement+festoolCleantecLug_flange_stop/2],
  [iSettingsTaper ,0],
  [iSettingsVersion, festoolCleantecLug_Version]
  ]];
  
festoolCleantecslot_Version = "0.1";
festoolCleantecslot_MinLength = 25; // measured
festoolCleantecslot_Measurement = "inner";
festoolCleantecslot_InnerDiameter = 39.5; // measured
festoolCleantecslot_WallThickness = 2.5; // measured

festoolCleantecSlotSettings = ["festoolcleantecslot", [
  [iSettingsLength, festoolCleantecslot_MinLength],
  [iSettingsMeasurement, festoolCleantecslot_Measurement],
  [iSettingsDiameter, festoolCleantecslot_InnerDiameter],
  [iSettingsWallThickness, festoolCleantecslot_WallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, festoolCleantecslot_Version]
  ]];


module FestoolCleantecSlotConnector(
  innerDiameter = festoolCleantecslot_InnerDiameter,
  length = festoolCleantecslot_MinLength,
  wallThickness = festoolCleantecslot_WallThickness*2,
  slotCount = lugCount,
  help){
   
   BayonetSlotConnector(
    innerDiameter = innerDiameter,
    length = length,
    wallThickness = wallThickness,
    slotCount = slotCount,
    slotOffset =6,
    slotAxialLength = 6.35,
    slotDepth = 2,
    lockBumpDepth = 1.9,
    slotWidth = 10.2,
    lockAngle = 35,
    help = help);
}

module FestoolCleantecLugConnector(
  innerDiameter = festoolCleantecLug_OuterDiameter - festoolCleantecLug_WallThickness_base_measurement*2,
  length = festoolCleantecLug_MinLength,
  wallThickness = festoolCleantecLug_WallThickness_base_measurement,
  lugCount = lugCount,
  help
){
  //settings.
  outerLugOffset = 5.2;       //measured
  outerLugAxialLength = 8.6;  //measured
  outerLugHeight = 1.5;       //estimated
  outerLugWidth = 11;         //measured
  
  innerLugOffset = 5.2;       //measured
  innerLugAxialLength = 6.5;  //measured
  innerLugHeight = 1.5;       //estimated
  innerLugWidth = 11;         //measured
  
  
  echo("FestoolCleantecLugConnector", festoolCleantecLug_OuterDiameter=festoolCleantecLug_OuterDiameter, innerDiameter=innerDiameter, festoolCleantecLug_WallThickness_base_measurement=festoolCleantecLug_WallThickness_base_measurement);
  union(){
    stopper_size = festoolCleantecLug_flange_stop;
  Stopper(
    diameter = innerDiameter,
    outer = true,
    totalLength = stopper_size,
    taper1 = 0.5,
    taper2 = 0,
    wallThickness = stopper_size/2,
    stopThickness = stopper_size/2,
    zPosition = length-fudgeFactor,
    help = help);
  BayonetLugConnector(
    innerDiameter1 = festoolCleantecLug_OuterDiameter_tip-festoolCleantecLug_WallThickness_tip_measurement*2,
    innerDiameter2 = innerDiameter,
    length = length,
    wallThickness1 = festoolCleantecLug_WallThickness_tip_measurement,
    wallThickness2 = wallThickness,
    lugCount = lugCount,
    hoseEndTaper=0.4,
    outerLugEnabled = true,
    outerLugWidth = outerLugWidth,
    outerLugHeight = outerLugHeight,
    outerLugAxialLength = outerLugAxialLength,
    outerLugOffset = outerLugOffset,
    //outerLugTopBottomTaperz = [outerLugHeight, outerLugHeight],        // Tob bottom of lug taper
    innerLugEnabled = true,
    innerLugWidth = innerLugWidth,          // Circumferential size of the lug.
    innerLugHeight = innerLugHeight, 
    innerLugAxialLength = innerLugAxialLength,   // Axial size of the lug
    innerLugOffset = innerLugOffset,         // Distance from connector face to the start (or center) of the lug.
    //innerLugTopBottomTaperz = [innerLugHeight, innerLugHeight],        // Tob bottom of lug taper
    help = help);
    
    
  
  }
}