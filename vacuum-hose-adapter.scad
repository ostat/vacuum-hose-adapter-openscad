// Hose connector
// version 2024-04-30
// repo https://github.com/ostat/vacuum-hose-adapter-openscad
//
// I give permission to use this script as you want, you are also free to sell models generated using this script. When sharing or selling models generated please provide attribution, with a link to the repo.
//
// I don't approve of you hosting or uploading this script it to any site or 3d modeling site.

include <modules/vacuum-hose-adapter.scad>

//TODO Ideas
//All pre and post transition length. so a flat section before and after the taper.abs

/* [Connector 1] */
//Wall thickness
End1_Wall_Thickness = 2; //0.01
//The style of the end
End1_Style="hose"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector]
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "outer"; //[inner, outer]
// End 1 diameter of the adapter (mm, inch)
End1_Diameter = [100,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End1_Length = [40,0];  //0.1
//Rotation around the z axis. Useful for non symmetrical connectors.
End1_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End1_Taper = 1;  //0.1

/* [Connector 1 - Hose connector] */
//Thickness of hose stop
End1_StopThickness = 0;  //1
//Length of hose stop
End1_StopLength = 0;  //1
//Should the stop be tapered both sides. Might easier to print.
End1_Stop_Symmetrical = false;
//Number of barbs
End1_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End1_Barbs_Thickness = 0; //0.1
//Should the barbs be tapered both sides. Might be easier to print.
End1_Barbs_Symmetrical = false;
//End Cap Inner Diameter.
End1_Hose_EndCap_Diameter = 0;  //0.1
//Thickness of end cap.
End1_Hose_EndCap_Thickness = 0;  //0.1
//End cap grid size for holes
End1_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End1_Hose_EndCap_GridWallThickness = 0;  //0.1

/* [Connector 1 - Flange] */
//Width of Flange added to the connector diameter
End1_Flange_Width = 20;
//Thickness of the flange
End1_Flange_Thickness = 5;
//Position of the screws added to the connector diameter, 0 = middle of flange
End1_Flange_Screw_Position= 0;
//Minium amount of the material around the magnet holes(mm), 0 = End1_Flange_Width / 4
End1_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End1_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End1_Flange_Screw_Diameter = 5;  //0.1

/* [Connector 1 - Magnetic Connector] */
//Number of magnets in the connector
End1_Magnets_Count = 8;
//The diameter of the magnets (mm)
End1_Magnet_Diameter = 10.5;  //0.1
//The thickness of the magnets (mm)
End1_Magnet_Thickness = 2.5;  //0.1
//Minium amount of the material around the magnets (mm)
End1_Magnet_Border = 2;  //0.1
//Raises the magnet so it is fully enclosed (mm)
End1_Magnet_ZOffset = 0;  //0.1
// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 6;  //0.1
// Include a flange alignment ring
End1_Ring = "no"; //[no: No alignment ring, protruding: protruding ring, recessed: Recessed ring]
// Magnetic ring Twist lock bolt size (draft setting)
End1_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* [Connector 1 - Extension] */
//Length of the extension
End1_Extension_Length = 0;
//Size of the grid in the extension. 0: diameter/6
End1_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extension. 0: no grid, -1: uses wall thickness
End1_Extension_GridWallThickness = 0;  //0.1
End1_Extension_Text = "asd-\u0020-asd";
End1_Extension_Text_Size = 0;


/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "bend+taper"; //[flat, taper+bend: Taper then bend, bend+taper: Bend then taper, organicbend: Tapered bend, hull: Hull for multiple end count, none: no transition]
//Length of the transition between the two ends
Transition_Length = 0;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1
//Angle of bend through the transition section.
Transition_Angle = 0;  //1
// offset for the connector, not supported on taperedbend.
Transition_Offset = [0,0]; // 0.1

/* [Transition Multiple connector settings] */
// Duplicate the second connector. Adjust angle and bend radius to make it work.
Transition_End2_Count = 1;  //[1, 2, 3, 4, 5, 6]
// MulitConnector, connector in hull length.
Transition_HullLength = 0; // 0.1
// MulitConnector, add centre connector.
Transition_HullCenter = "disabled"; //[disabled,end1,end2,end3]
Transition_HullCenterLength = 0;
// MulitConnector, connector in hull offset.
Transition_HullyOffset = 0; // 0.1
// MulitConnector, center connector height. default is 2*lengthInHull
Transition_HullCenterHeight = 0;

Transition_End2_Angle = 0;

/* [Transition Support For Angled Pipes] */
// Include a flat section on the transition to assist with printing
Transition_Base_Type="none"; // [none, oval, rectangle]
//Support Base Additional Thickness;
Transition_Base_Thickness=0;
//Support Base Width, Default is half diameter
Transition_Base_Width=0;
// Support Base Length Default is 2/3 diameter
Transition_Base_Length=0;
// Support Base Angle position, default half of Bend Radius;
Transition_Base_Angle=0;

/* [Connector 2] */
//Wall thickness
End2_Wall_Thickness = 2; //0.01
End2_Style="hose"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector, none: None]
// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm, inch)
End2_Diameter = [60,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End2_Length = [40 ,0];  //0.1
//Rotation around the z axis. Useful for non symmetrical connectors.
End2_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End2_Taper = 1;  //0.1

/*[Connector 2 - Hose connector] */
//Thickness of hose stop
End2_StopThickness = 0;  //1
//Length of hose stop
End2_StopLength = 0;  //1
//Should the stop be tapered both sides. Might easier to print.
End2_Stop_Symmetrical = false;
//Number of barbs
End2_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End2_Barbs_Thickness = 0; //0.1
//Should the barbs be tapered both sides. Might be easier to print.
End2_Barbs_Symmetrical = false;
//Thickness of end cap, 0 means disabled
End2_Hose_EndCap_Thickness = 0;  //0.1
//End Cap Inner Diameter.
End2_Hose_EndCap_Diameter = 0;  //0.1
//End cap grid size for holes
End2_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End2_Hose_EndCap_GridWallThickness = 0;  //0.1

/* [Connector 2 - Flange] */
//Width of Flange added to the connector diameter
End2_Flange_Width = 20;
//Thickness of the flange
End2_Flange_Thickness = 5;
//Position of the screws added to the connector diameter, 0 = middle of flange
End2_Flange_Screw_Position= 0;
//Minium amount of the material around the magnets (mm), 0 = End1_Flange_Width / 4
End2_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End2_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End2_Flange_Screw_Diameter = 5;  //0.1

/* [Connector 2 - Magnetic Flange] */
//Number of magnets in the flange
End2_Magnets_Count = 6;  //1
//The diameter of the magnets
End2_Magnet_Diameter = 12;  //0.1
//The thickness of the magnets
End2_Magnet_Thickness = 3;  //0.1
//Size of the material around the magnets
End2_Magnet_Border = 2;  //0.1
//Raises the magnet so it is fully enclosed (mm)
End2_Magnet_ZOffset = 0;  //0.1
//Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;  //0.1
//Include a flange alignment ring
End2_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]
//Magnetic ring twist lock bolt size (draft setting)
End2_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* [Connector 2 - Nozzle] */
// Is the measurement the adapter's outside or inside diameter?
End2_Nozzle_Shape = "square"; //[square, circle]
End2_Nozzle_Size = [10,5,10]; //0.1
End2_Nozzle_Tip_Wall_Thickness = 0; //0.1
End2_Nozzle_Radius = 0; //0.1
End2_Nozzle_Offset = [0,0]; //0.1
End2_Nozzle_Chamfer_Percentage = 0; //0.1
End2_Nozzle_Chamfer_Angle = 0; //0.1

/* [Connector 2 - Extension] */
//Length of the extension
End2_Extension_Length = 0;
//Size of the grid in the extension. 0: diameter/6
End2_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extension. 0: no grid, -1: uses wall thickness
End2_Extension_GridWallThickness = 0;  //0.1
End2_Extension_Text = "";
End2_Extension_Text_Size = 0;


/* [Connector 3] */
//Wall thickness
End3_Wall_Thickness = 2; //0.01
End3_Style="nozzle"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector, none: None]
// Is the measurement the adapter's outside or inside diameter?
End3_Measurement = "outer"; //[inner, outer]
// End 3 diameter of the adapter (mm, inch)
End3_Diameter = [40,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End3_Length = [40 ,0];  //0.1
//Rotation around the z axis. Useful for non symmetrical connectors.
End3_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End3_Taper = 0;  //0.1

/*[Connector 3 - Hose connector] */
//Thickness of hose stop
End3_StopThickness = 0;  //1
//Length of hose stop
End3_StopLength = 0;  //1
//Should the stop be tapered both sides. Might easier to print.
End3_Stop_Symmetrical = false;
//Number of barbs
End3_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End3_Barbs_Thickness = 0; //0.1
//Should the barbs be tapered both sides. Might be easier to print.
End3_Barbs_Symmetrical = false;
//Thickness of end cap, 0 means disabled
End3_Hose_EndCap_Thickness = 0;  //0.1
//End Cap Inner Diameter.
End3_Hose_EndCap_Diameter = 0;  //0.1
//End cap grid size for holes
End3_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End3_Hose_EndCap_GridWallThickness = 0;  //0.1


/* [Connector 3 - Flange] */
//Width of Flange added to the connector diameter
End3_Flange_Width = 20;
//Thickness of the flange
End3_Flange_Thickness = 5;
//Position of the screws added to the connector diameter, 0 = middle of flange
End3_Flange_Screw_Position= 0;
//Minium amount of the material around the magnets (mm), 0 = End1_Flange_Width / 4
End3_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End3_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End3_Flange_Screw_Diameter = 5;  //0.1

/* [Connector 3 - Magnetic connector] */
//Number of magnets in the flange
End3_Magnets_Count = 6;  //1
//The diameter of the magnets
End3_Magnet_Diameter = 12;  //0.1
//The thickness of the magnets
End3_Magnet_Thickness = 3;  //0.1
//Size of the material around the magnets
End3_Magnet_Border = 2;  //0.1
//Raises the magnet so it is fully enclosed (mm)
End3_Magnet_ZOffset = 0;  //0.1
// Inner diameter of the Magnet flange
End3_Magnet_Flange_Thickness = 10;  //0.1
// Include a flange alignment ring
End3_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]
// Magnetic ring twist lock bolt size (draft setting)
End3_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* [Connector 3 - Nozzle] */
// Is the measurement the adapter's outside or inside diameter?
End3_Nozzle_Shape = "square"; //[square, circle]
End3_Nozzle_Size = [10,5,10]; //0.1
End3_Nozzle_Tip_Wall_Thickness = 0; //0.1
End3_Nozzle_Radius = 0; //0.1
End3_Nozzle_Offset = [0,0]; //0.1
End3_Nozzle_Chamfer_Percentage = 0; //0.1
End3_Nozzle_Chamfer_Angle = 0; //0.1

/* [Connector 3 - Extension] */
//Length of the extension
End3_Extension_Length = 0;
//Size of the grid in the extension. 0: diameter/6
End3_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extension. 0: no grid, -1: uses wall thickness
End3_Extension_GridWallThickness = 0;  //0.1
End3_Extension_Text = "";
End3_Extension_Text_Size = 0;

/* [Alignment Ring] */
//draw just the alignment ring
Draw_Alignment_Ring = "no"; //[end1: Draw end 1, end2: Draw end 2, no: Don't draw]
//Alignment depth in to flange (mm)
Alignment_Depth = 2; //0.1
//Alignment upper width at widest part (mm)
Alignment_Upper_Width = 3; //0.1
//Alignment lower width at narrowest part (mm)
Alignment_Lower_Width = 0.5; //0.1
//Alignment side clearance, to give nice fit (mm).
Alignment_Side_Clearance = 0.25;  //0.01
//Alignment Depth Clearance, to prevent hitting bottom (mm).
Alignment_Depth_Clearance = .75;  //0.01

/* [other] */
//Slice model in half to be able to easy see inside
Enable_Debug_Slice = false;
//Will only show if debug is also enabled
Enable_Calipers_Slice = false;
Enable_Help = false;
End1_Color = ["",1];  //0.1
End2_Color = ["",1];  //0.1
End3_Color = ["",1];  //0.1
Transition_Color = ["",1]; //The color, then the alpha value
Extension_Color = ["",1]; //The color, then the alpha value

/* [Model detail] */
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 3;
// minimum size of a fragment.  Low is more fragments
fs = 0.1;
// number of fragments, overrides $fa and $fs
fn = 0;

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

//execution point
HoseAdapter(
  connector1 = UserConnectorSettings(
    connector=1,
    style=End1_Style,
    wallThickness=End1_Wall_Thickness,
    measurement=End1_Measurement,
    diameter=End1_Diameter,
    length=End1_Length,
    rotation=End1_Rotation,
    taper=End1_Taper,
    endCapDiameter=End1_Hose_EndCap_Diameter,
    endCapThickness=End1_Hose_EndCap_Thickness,
    endCapGridSize=End1_Hose_EndCap_GridSize,
    endCapGridWallThickness=End1_Hose_EndCap_GridWallThickness,
    stopThickness=End1_StopThickness,
    stopLength=End1_StopLength,
    stopSymmetrical=End1_Stop_Symmetrical,
    barbsCount=End1_Barbs_Count,
    barbsThickness=End1_Barbs_Thickness,
    barbsSymmetrical=End1_Barbs_Symmetrical,
    magnetCount=End1_Magnets_Count,
    magnetDiameter=End1_Magnet_Diameter,
    magnetThickness=End1_Magnet_Thickness,
    magnetBorder=End1_Magnet_Border,
    magnetZOffset=End1_Magnet_ZOffset,
    magnetFlangeThickness=End1_Magnet_Flange_Thickness,
    magnetTwistLockSize=End1_Magnet_Twist_Lock_Size,
    alignmentRing=End1_Ring,
    flangeWidth=End1_Flange_Width,
    flangeThickness=End1_Flange_Thickness,
    flangeScrewPosition=End1_Flange_Screw_Position,
    flangeScrewBorder=End1_Flange_Screw_Border,
    flangeScrewCount=End1_Flange_Screw_Count,
    flangeScrewDiameter=End1_Flange_Screw_Diameter,
    extensionLength=End1_Extension_Length,
    extensionGridSize=End1_Extension_GridSize,
    extensionGridWallThickness=End1_Extension_GridWallThickness,
    extensionText=End1_Extension_Text,
    extensionTextSize=End1_Extension_Text_Size),

  connector2 = UserConnectorSettings(
    connector=2,
    style=End2_Style,
    wallThickness=End2_Wall_Thickness,
    measurement=End2_Measurement,
    diameter=End2_Diameter,
    length=End2_Length,
    rotation=End2_Rotation,
    taper=End2_Taper,
    endCapDiameter=End2_Hose_EndCap_Diameter,
    endCapThickness=End2_Hose_EndCap_Thickness,
    endCapGridSize=End2_Hose_EndCap_GridSize,
    endCapGridWallThickness=End2_Hose_EndCap_GridWallThickness,
    stopThickness=End2_StopThickness,
    stopLength=End2_StopLength,
    stopSymmetrical=End2_Stop_Symmetrical,
    barbsCount=End2_Barbs_Count,
    barbsThickness=End2_Barbs_Thickness,
    barbsSymmetrical=End2_Barbs_Symmetrical,
    magnetCount=End2_Magnets_Count,
    magnetDiameter=End2_Magnet_Diameter,
    magnetThickness=End2_Magnet_Thickness,
    magnetBorder=End2_Magnet_Border,
    magnetZOffset=End2_Magnet_ZOffset,
    magnetFlangeThickness=End2_Magnet_Flange_Thickness,
    magnetTwistLockSize=End2_Magnet_Twist_Lock_Size,
    alignmentRing=End2_Ring,
    flangeWidth=End2_Flange_Width,
    flangeThickness=End2_Flange_Thickness,
    flangeScrewPosition=End2_Flange_Screw_Position,
    flangeScrewBorder=End2_Flange_Screw_Border,
    flangeScrewCount=End2_Flange_Screw_Count,
    flangeScrewDiameter=End2_Flange_Screw_Diameter,
    nozzleShape=End2_Nozzle_Shape,
    nozzleSize=End2_Nozzle_Size,
    nozzleTipWallThickness=End2_Nozzle_Tip_Wall_Thickness,
    nozzleRadius=End2_Nozzle_Radius,
    nozzleOffset=End2_Nozzle_Offset,
    nozzleChamferPercentage=End2_Nozzle_Chamfer_Percentage,
    nozzleChamferAngle=End2_Nozzle_Chamfer_Angle,
    extensionLength=End2_Extension_Length,
    extensionGridSize=End2_Extension_GridSize,
    extensionGridWallThickness=End2_Extension_GridWallThickness,
    extensionText=End2_Extension_Text,
    extensionTextSize=End2_Extension_Text_Size),

  connector3 = UserConnectorSettings(
    connector=3,
    style=End3_Style,
    wallThickness=End3_Wall_Thickness,
    measurement=End3_Measurement,
    diameter=End3_Diameter,
    length=End3_Length,
    rotation=End3_Rotation,
    taper=End3_Taper,
    endCapDiameter=End3_Hose_EndCap_Diameter,
    endCapThickness=End3_Hose_EndCap_Thickness,
    endCapGridSize=End3_Hose_EndCap_GridSize,
    endCapGridWallThickness=End3_Hose_EndCap_GridWallThickness,
    stopThickness=End3_StopThickness,
    stopLength=End3_StopLength,
    stopSymmetrical=End3_Stop_Symmetrical,
    barbsCount=End3_Barbs_Count,
    barbsThickness=End3_Barbs_Thickness,
    barbsSymmetrical=End3_Barbs_Symmetrical,
    magnetCount=End3_Magnets_Count,
    magnetDiameter=End3_Magnet_Diameter,
    magnetThickness=End3_Magnet_Thickness,
    magnetBorder=End3_Magnet_Border,
    magnetZOffset=End3_Magnet_ZOffset,
    magnetFlangeThickness=End3_Magnet_Flange_Thickness,
    magnetTwistLockSize=End3_Magnet_Twist_Lock_Size,
    alignmentRing=End3_Ring,
    flangeWidth=End3_Flange_Width,
    flangeThickness=End3_Flange_Thickness,
    flangeScrewPosition=End3_Flange_Screw_Position,
    flangeScrewBorder=End3_Flange_Screw_Border,
    flangeScrewCount=End3_Flange_Screw_Count,
    flangeScrewDiameter=End3_Flange_Screw_Diameter,
    nozzleShape=End3_Nozzle_Shape,
    nozzleSize=End3_Nozzle_Size,
    nozzleTipWallThickness=End3_Nozzle_Tip_Wall_Thickness,
    nozzleRadius=End3_Nozzle_Radius,
    nozzleOffset=End3_Nozzle_Offset,
    nozzleChamferPercentage=End3_Nozzle_Chamfer_Percentage,
    nozzleChamferAngle=End3_Nozzle_Chamfer_Angle,
    extensionLength=End3_Extension_Length,
    extensionGridSize=End3_Extension_GridSize,
    extensionGridWallThickness=End3_Extension_GridWallThickness,
    extensionText=End3_Extension_Text,
    extensionTextSize=End3_Extension_Text_Size),

  transitionStyle = Transition_Style,
  transitionLength = Transition_Length,
  transitionBendRadius = Transition_Bend_Radius,
  transitionAngle = Transition_Angle,
  transitionOffset = Transition_Offset,
  transitionBaseType = Transition_Base_Type,
  transitionBaseThickness = Transition_Base_Thickness,
  transitionBaseWidth = Transition_Base_Width,
  transitionBaseLength = Transition_Base_Length,
  transitionBaseAngle = Transition_Base_Angle,
  transitionEnd2Count = Transition_End2_Count,
  transitionEnd2Angle = Transition_End2_Angle,
  transitionHullLength = Transition_HullLength,
  transitionHullCenterLength = Transition_HullCenterLength,
  transitionHullyOffset = Transition_HullyOffset,
  transitionHullCenter = Transition_HullCenter,
  transitionHullCenterHeight= Transition_HullCenterHeight,

  drawAlignmentRing = Draw_Alignment_Ring,
  alignmentDepth = Alignment_Depth,
  alignmentUpperWidth = Alignment_Upper_Width,
  alignmentLowerWidth = Alignment_Lower_Width,
  alignmentSideClearance = Alignment_Side_Clearance,
  alignmentDepthClearance = Alignment_Depth_Clearance,

  sliceDebug = Enable_Debug_Slice,
  showCaliper = Enable_Calipers_Slice,
  end1Color = End1_Color,
  end2Color = End2_Color,
  end3Color = End3_Color,
  transitionColor = Transition_Color,
  extensionColor = Extension_Color,
  help = Enable_Help
);