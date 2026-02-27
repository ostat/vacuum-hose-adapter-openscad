///////////////////////////////////////
//Combined version of 'vacuum-hose-adapter-basic.scad'. Generated 2026-02-27 21:28
//Content hash 51EA59EF18E90C4846065B82ED90FF857B21510ED4975D5E256A4151C1A511C3
///////////////////////////////////////
// Hose connector
// version 2024-04-30
// repo https://github.com/ostat/vacuum-hose-adapter-openscad
//
// I give permision to use this script as you want, you are also free to sell models generated using this script. When sharing or selling models generated please provide attribution, with a link to the repo.
//
// I don't approve of you hosting or uploading this script it to any site or 3d modeling site.


//TODO Ideas
//All pre and post trasition length. so a flat section before and after the taper.abs

/* [Connector 1] */
//Wall thickness
End1_Wall_Thickness = 2; //0.01
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "outer"; //[inner, outer]
// End 1 diameter of the adapter (mm, inch)
End1_Diameter = [100,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End1_Length = [40,0];  //0.1
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
//Should the barbes be tapered both sides. Might be easier to print.
End1_Barbs_Symmetrical = false;

/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "bend+taper"; //[flat, taper+bend: Taper then bend, bend+taper: Bend then taper, organicbend: Tapered bend]
//Length of the transition between the two ends
Transition_Length = 0;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1
//Angle of bend through the transition section.
Transition_Angle = 0;  //1

/* [Connector 2] */
//Wall thickness
End2_Wall_Thickness = 2; //0.01
// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm, inch)
End2_Diameter = [60,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End2_Length = [40 ,0];  //0.1
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
//Should the barbes be tapered both sides. Might be easier to print.
End2_Barbs_Symmetrical = false;

/* [other] */
//Slice model inhalf to be able to easy see inside
Enable_Debug_Slice = false;
//Will only show if debug is also enabled
Enable_Calipers_Slice = false;
Enable_Help = false;
End1_Color = [DefaultEnd1Color,1];  //0.1
End2_Color = [DefaultEnd2Color,1];  //0.1
Transition_Color = [DefaultTransitionColor,1]; //The color, then the alpha value
Extension_Color = [DefaultExtensionColor,1]; //The color, then the alpha value

/* [Model detail] */
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 3;
// minimum size of a fragment.  Low is more fragments
fs = 0.1;
// number of fragments, overrides $fa and $fs
fn = 0;

/* [Hidden] */
module end_of_customizer_opts() {}
//Combined from path vacuum-hose-adapter.scad







// Hose connector
// version 2024-04-30
// repo https://github.com/ostat/vacuum-hose-adapter-openscad
//
// I give permision to use this script as you want, you are also free to sell models generated using this script. When sharing or selling models generated please provide attribution, with a link to the repo.
//
// I don't approve of you hosting or uploading this script it to any site or 3d modeling site.



//TODO Ideas
//All pre and post trasition length. so a flat section before and after the taper.abs

/* Hidden */
DefaultEnd1Color = "LightPink";
DefaultEnd2Color = "SkyBlue";
DefaultEnd3Color = "MediumPurple";
DefaultTransitionColor = "LightGreen";
DefaultExtensionColor = "MediumSeaGreen";

/* Connector 1 */
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
//Rotation around the z axis. Userfull for non symeterical connectors.
End1_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End1_Taper = 1;  //0.1

/* Connector 1 - Hose connector */
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
//Should the barbes be tapered both sides. Might be easier to print.
End1_Barbs_Symmetrical = false;
//End Cap Inner Diameter.
End1_Hose_EndCap_Diameter = 0;  //0.1
//Thickness of endcap.
End1_Hose_EndCap_Thickness = 0;  //0.1
//End cap grid size for holes
End1_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End1_Hose_EndCap_GridWallThickness = 0;  //0.1

/* Connector 1 - Flange */
//Width of Flange added to the connector diamater
End1_Flange_Width = 20;
//Thickness of the flange
End1_Flange_Thickness = 5;
//Position of the screws added to the connector diamater, 0 = middle of flange
End1_Flange_Screw_Position= 0;
//Minium amount of the material around the magnet holes(mm), 0 = End1_Flange_Width / 4
End1_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End1_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End1_Flange_Screw_Diameter = 5;  //0.1

/* Connector 1 - Magnetic Connector */
//Number of magnets in the connector
End1_Magnets_Count = 8;
//The diameter of the magnets (mm)
End1_Magnet_Diameter = 10.5;  //0.1
//The thickness of the magnets (mm)
End1_Magnet_Thickness = 2.5;  //0.1
//Minium amount of the material around the magnets (mm)
End1_Magnet_Border = 2;  //0.1
//Raises the magent so it is fully enclosed (mm)
End1_Magnet_ZOffset = 0;  //0.1
// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 6;  //0.1
// Include a flange alignment ring
End1_Ring = "no"; //[no: No alignment ring, protruding: protruding ring, recessed: Recessed ring]
// Magnetic ring Twist lock bolt size (draft setting)
End1_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* Connector 1 - Extension */
//Length of the extnetion
End1_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End1_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
End1_Extension_GridWallThickness = 0;  //0.1
End1_Extension_Text = "asd-\u0020-asd";
End1_Extension_Text_Size = 0;


/* Transition */
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

/* Transition Multiple connector settings */
// Dupliacte the second connector. Adjust angle and bend radius to make it work.
Transition_End2_Count = 1;  //[1, 2, 3, 4, 5, 6]
// MulitConnector, connector in hull length.
Transition_HullLength = 0; // 0.1
// MulitConnector, add center connector.
Transition_HullCenter = "disabled"; //[disabled,end1,end2,end3]
Transition_HullCenterLength = 0;
// MulitConnector, connector in hull offset.
Transition_HullyOffset = 0; // 0.1
// MulitConnector, center connector height. default is 2*lengthInHull
Transition_HullCenterHeight = 0;

Transition_End2_Angle = 0;

/* Transition Support For Angled Pipes */
// Include a flate section on the transition to assist with printing
Transition_Base_Type="none"; // [none, oval, rectangle]
//Support Base Additional Thickness;
Transition_Base_Thickness=0;
//Support Base Width, Default is half diameter
Transition_Base_Width=0;
// Support Base Length Default is 2/3 diameter
Transition_Base_Length=0;
// Support Base Angle position, default half of Bend Radius;
Transition_Base_Angle=0;

/* Connector 2 */
//Wall thickness
End2_Wall_Thickness = 2; //0.01
End2_Style="hose"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector, none: None]
// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm, inch)
End2_Diameter = [60,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End2_Length = [40 ,0];  //0.1
//Rotation around the z axis. Userfull for non symeterical connectors.
End2_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End2_Taper = 1;  //0.1

/*Connector 2 - Hose connector */
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
//Should the barbes be tapered both sides. Might be easier to print.
End2_Barbs_Symmetrical = false;
//Thickness of endcap, 0 means disabled
End2_Hose_EndCap_Thickness = 0;  //0.1
//End Cap Inner Diameter.
End2_Hose_EndCap_Diameter = 0;  //0.1
//End cap grid size for holes
End2_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End2_Hose_EndCap_GridWallThickness = 0;  //0.1

/* Connector 2 - Flange */
//Width of Flange added to the connector diamater
End2_Flange_Width = 20;
//Thickness of the flange
End2_Flange_Thickness = 5;
//Position of the screws added to the connector diamater, 0 = middle of flange
End2_Flange_Screw_Position= 0;
//Minium amount of the material around the magnets (mm), 0 = End1_Flange_Width / 4
End2_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End2_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End2_Flange_Screw_Diameter = 5;  //0.1

/* Connector 2 - Magnetic Flange */
//Number of magnets in the flange
End2_Magnets_Count = 6;  //1
//The diameter of the magnets
End2_Magnet_Diameter = 12;  //0.1
//The thickness of the magnets
End2_Magnet_Thickness = 3;  //0.1
//Size of the material around the magnets
End2_Magnet_Border = 2;  //0.1
//Raises the magent so it is fully enclosed (mm)
End2_Magnet_ZOffset = 0;  //0.1
//Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;  //0.1
//Include a flange alignment ring
End2_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]
//Magnetic ring twist lock bolt size (draft setting)
End2_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* Connector 2 - Nozzle */
// Is the measurement the adapter's outside or inside diameter?
End2_Nozzle_Shape = "square"; //[square, circle]
End2_Nozzle_Size = [10,5,10]; //0.1
End2_Nozzle_Tip_Wall_Thickness = 0; //0.1
End2_Nozzle_Radius = 0; //0.1
End2_Nozzle_Offset = [0,0]; //0.1
End2_Nozzle_Chamfer_Percentage = 0; //0.1
End2_Nozzle_Chamfer_Angle = 0; //0.1

/* Connector 2 - Extension */
//Length of the extnetion
End2_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End2_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
End2_Extension_GridWallThickness = 0;  //0.1
End2_Extension_Text = "";
End2_Extension_Text_Size = 0;


/* Connector 3 */
//Wall thickness
End3_Wall_Thickness = 2; //0.01
End3_Style="nozzle"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector, none: None]
// Is the measurement the adapter's outside or inside diameter?
End3_Measurement = "outer"; //[inner, outer]
// End 3 diameter of the adapter (mm, inch)
End3_Diameter = [40,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End3_Length = [40 ,0];  //0.1
//Rotation around the z axis. Userfull for non symeterical connectors.
End3_Rotation= 0;
//Taper of the start connector, use negative to taper other direction.
End3_Taper = 0;  //0.1

/*Connector 3 - Hose connector */
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
//Should the barbes be tapered both sides. Might be easier to print.
End3_Barbs_Symmetrical = false;
//Thickness of endcap, 0 means disabled
End3_Hose_EndCap_Thickness = 0;  //0.1
//End Cap Inner Diameter.
End3_Hose_EndCap_Diameter = 0;  //0.1
//End cap grid size for holes
End3_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End3_Hose_EndCap_GridWallThickness = 0;  //0.1


/* Connector 3 - Flange */
//Width of Flange added to the connector diamater
End3_Flange_Width = 20;
//Thickness of the flange
End3_Flange_Thickness = 5;
//Position of the screws added to the connector diamater, 0 = middle of flange
End3_Flange_Screw_Position= 0;
//Minium amount of the material around the magnets (mm), 0 = End1_Flange_Width / 4
End3_Flange_Screw_Border = 5;  //0.1
//Number of Screw holes flange
End3_Flange_Screw_Count = 4;
//The diameter of the screws (mm)
End3_Flange_Screw_Diameter = 5;  //0.1

/* Connector 3 - Magnetic Flange */
//Number of magnets in the flange
End3_Magnets_Count = 6;  //1
//The diameter of the magnets
End3_Magnet_Diameter = 12;  //0.1
//The thickness of the magnets
End3_Magnet_Thickness = 3;  //0.1
//Size of the material around the magnets
End3_Magnet_Border = 2;  //0.1
//Raises the magent so it is fully enclosed (mm)
End3_Magnet_ZOffset = 0;  //0.1
// Inner diameter of the Magnet flange
End3_Magnet_Flange_Thickness = 10;  //0.1
// Include a flange alignment ring
End3_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]
// Magnetic ring twist lock bolt size (draft setting)
End3_Magnet_Twist_Lock_Size = "0";  //["0":none,"3":M3,"3cnc":M3 with CNC Kitchen insert,"4":M4,"4cnc":M4 with CNC Kitchen insert,"5":M5,"5cnc":M5 with CNC Kitchen insert]

/* Connector 3 - Nozzle */
// Is the measurement the adapter's outside or inside diameter?
End3_Nozzle_Shape = "square"; //[square, circle]
End3_Nozzle_Size = [10,5,10]; //0.1
End3_Nozzle_Tip_Wall_Thickness = 0; //0.1
End3_Nozzle_Radius = 0; //0.1
End3_Nozzle_Offset = [0,0]; //0.1
End3_Nozzle_Chamfer_Percentage = 0; //0.1
End3_Nozzle_Chamfer_Angle = 0; //0.1

/* Connector 3 - Extension */
//Length of the extnetion
End3_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End3_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
End3_Extension_GridWallThickness = 0;  //0.1
End3_Extension_Text = "";
End3_Extension_Text_Size = 0;

/* Alignment Ring */
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

/* other */
//Slice model inhalf to be able to easy see inside
Enable_Debug_Slice = false;
//Will only show if debug is also enabled
Enable_Calipers_Slice = false;
Enable_Help = false;
End1_Color = [DefaultEnd1Color,1];  //0.1
End2_Color = [DefaultEnd2Color,1];  //0.1
End3_Color = [DefaultEnd3Color,1];  //0.1
Transition_Color = [DefaultTransitionColor,1]; //The color, then the alpha value
Extension_Color = [DefaultExtensionColor,1]; //The color, then the alpha value

/* Model detail */
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 3;
// minimum size of a fragment.  Low is more fragments
fs = 0.1;
// number of fragments, overrides $fa and $fs
fn = 0;

/* Hidden */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

function getColor(colorSetting, defaultColor) =
  assert(is_list(colorSetting), str("colorSetting must be a list colorSetting=", colorSetting, " defaultColor", defaultColor))
  assert(len(colorSetting) == 2, "colorSetting be length 2")
  let(
    c = colorSetting[0] == "" ? defaultColor : colorSetting[0],
    a = is_num(colorSetting[1]) && colorSetting[1] >=0 && colorSetting[1] <=1 ? colorSetting[1] : 1) [c,a];

module adapterAlignmentRing(
  centerDiameter = 0,
  alignmentDepth = 0,
  alignmentUpperWidth = 0,
  alignmentLowerWidth = 0,
  alignmentSideClearance = 0,
  alignmentDepthClearance = 0,
  magnetBorder = 0,
  debug = false,
  showCaliper=false,
  help){

  difference(){
    AlignmentRing(
      centerDiameter = centerDiameter,
      alignmentDepth = alignmentDepth,
      alignmentUpperWidth = alignmentUpperWidth,
      alignmentLowerWidth = alignmentLowerWidth,
      alignmentSideClearance = alignmentSideClearance,
      alignmentDepthClearance = alignmentDepthClearance,
      magnetBorder = magnetBorder);

    if($preview&&debug){
      cubeSziex = centerDiameter+max(alignmentUpperWidth, alignmentLowerWidth);
      cubeSziey = centerDiameter/2+max(alignmentUpperWidth, alignmentLowerWidth);
      cubeSziez = alignmentDepth*2;
      translate([-cubeSziex/2, -cubeSziey, -cubeSziez/2])
        cube([cubeSziex,cubeSziey,cubeSziez]);
      }
    }

    if($preview&&showCaliper){
      color("Gold")
      union(){
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, size = 5,h = 0.1,
          //center=false,
          l=centerDiameter+max(alignmentUpperWidth, alignmentLowerWidth),
          end=0, in=1,
          translate= [0,10,0],
          txt2 = "centerDiameter");
        translate([(centerDiameter)/2,0,0])
        rotate([90,90,0])
        Caliper(messpunkt = false, help=0, size = 5,h = 0.1,
          l=(alignmentDepth-alignmentDepthClearance)*2,
          end=0, in=4,
          cx= 0,
          translate= [0,5,0],
          txt2 = "alignmentDepth");
        }
    }

  HelpTxt("adapterAlignmentRing",[
    "centerDiameter", centerDiameter,
    "magnetBorder", magnetBorder,
    "alignmentDepth", alignmentDepth,
    "alignmentUpperWidth", alignmentUpperWidth,
    "alignmentLowerWidth", alignmentLowerWidth,
    "alignmentSideClearance", alignmentSideClearance,
    "alignmentDepthClearance", alignmentDepthClearance,
    "debug", debug]
    ,help);
}

module adapter(
    con =[],
    connectorPos = 1,
    transitionAngle = 0,
    debug = false,
    showCaliper=false,
    help
){
  assert(is_list(con), "con must be a list")
  assert(is_num(con[iLength]), str("length must be a number :", con[iLength]));
  assert(is_num(con[iStopLength]), "stopLength must be a number");
  assert(is_list(con[iAdapterColor]), "adapterColor must be a list")
  assert(len(con[iAdapterColor]) == 2, "adapterColor be length 2")

  //Create the start connector
  if(con[iLength] > 0)
  {
    difference()
    {
      color(con[iAdapterColor][0], con[iAdapterColor][1])
      rotate([0,0,con[iRotation]])
      union(){
        if(con[iStyle] == "mag")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          MagneticConnector(
              innerStartDiameter = con[iInnerStartDiameter],
              innerEndDiameter = con[iInnerEndDiameter],
              length = con[iLength],
              wallThickness = con[iWallThickness],
              magnetDiameter = con[iMagnetDiameter],
              magnetThickness = con[iMagnetThickness],
              magnetBorder = con[iMagnetBorder],
              magnetZOffset = con[iMagnetZOffset],
              flangeThickness = con[iMagnetFlangeThickness],
              magnetCount = con[iMagnetCount],
              alignmentRing = con[iAlignmentRing],
              alignmentDepth = con[iAlignmentDepth],
              alignmentUpperWidth = con[iAlignmentUpperWidth],
              alignmentLowerWidth = con[iAlignmentLowerWidth],
              alignmentSideClearance = con[iAlignmentSideClearance],
              alignmentDepthClearance = con[iAlignmentDepthClearance],
              twistLockSize = con[iMagnetTwistLockSize],
              $fn = $fn);
        }
        else if(con[iStyle] == "flange")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          FlangeConnector(
            innerStartDiameter = con[iInnerStartDiameter],
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            flangeThickness = con[iFlangeThickness],
            flangeWidth = con[iFlangeWidth],
            screwPosition = con[iFlangeScrewPosition],
            screwBorder = con[iFlangeScrewBorder],
            screwCount = con[iFlangeScrewCount],
            screwDiameter = con[iFlangeScrewDiameter],
            help = help,
            $fn = $fn);
        }

        else if(con[iStyle] == "hose")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          HoseConnector(
            innerStartDiameter = con[iInnerStartDiameter],
            innerEndDiameter = con[iInnerEndDiameter],
            connectorMeasurement = con[iMeasurement],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            stopLength = con[iStopLength],
            stopWidth = con[iStopThickness],
            stopSymmetrical = con[iStopSymmetrical],
            barbsCount  = con[iBarbsCount],
            barbsThickness = con[iBarbsThickness],
            barbsSymmetrical = con[iBarbsSymmetrical],
            endCapDiameter = con[iEndCapDiameter],
            endCapThickness = con[iEndCapThickness],
            endCapGridSize = con[iEndCapGridSize],
            endCapGridWallThickness = con[iEndCapGridWallThickness],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "dyson")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          DysonConnector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            IncludeOrientationClip = true,
            $fn = $fn);
        }
        else if(con[iStyle] == "camlock")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          CamlockConnector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            $fn = $fn);
        }
        else if(con[iStyle] == "dw735")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          Dw735Connector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            connectorCount = transitionAngle > 0 ? 6 : 1,
            $fn = $fn);
        }
        else if(con[iStyle] == "centec_female")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          CenTecFemaleConnector($fn = $fn);
        }
        else if(con[iStyle] == "centec_male")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          CenTecMaleConnector($fn = $fn);
        }
        else if(con[iStyle] == "makita_male")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          MakitaMaleConnector(
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "osvacm" || con[iStyle] == "osvacm32")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          osVacMaleConnector(
            innerDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "osvacf" || con[iStyle] == "osvacf32")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          osVacFemaleConnector(
            innerDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "nozzle")
        {
          Nozzle(
            innerStartDiameter = con[iInnerStartDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            nozzleShape = con[iNozzleShape],
            nozzleSize = con[iNozzleSize],
            nozzleTipWallThickness = con[iNozzleTipWallThickness],
            nozzleRadius = con[iNozzleRadius],
            nozzleOffset = con[iNozzleOffset],
            nozzleChamferPercentage = con[iNozzleChamferPercentage],
            nozzleChamferAngle = con[iNozzleChamferAngle],
            help = help,
            $fn = $fn);
        } else if(con[iStyle] == "none"){ }
        else {
         assert(false, str("style not supported style: ", con[iStyle]));
        }
      }
      if($preview&&debug&&con[iStyle]!="none"){
        cubeSziex = max(con[iInnerStartDiameter],con[iInnerEndDiameter])*2;
        cubeSziey = max(con[iInnerStartDiameter],con[iInnerEndDiameter])*1.5;
        cubeSziez = con[iLength]+con[iStopLength]+fudgeFactor*4
          +(con[iStyle] == "nozzle"? con[iNozzleSize].z+fudgeFactor : 0)
          +(con[iStyle] == "mag"? con[iAlignmentDepth]: 0);
        translate([-cubeSziex/2, -cubeSziey, -fudgeFactor*2])
        cube([cubeSziex,cubeSziey,cubeSziez]);
      }
    }
  }

  if($preview&&showCaliper&&con[iStyle]!="none"){
    color("Gold")
    translate([0, 0, con[iLength]+con[iStopLength]])
    mirror ([0,0,1])
    mirror (connectorPos == 1 ? [0,0,0] : [1,0,0])
    union(){
      endStyle = con[iMeasurement] == "inner" ? 3 : 4;
      addwidth = con[iMeasurement] == "outer" ? con[iWallThickness]*2 : 0;
      translate(con[iStyle] == "nozzle" ? [0,0,con[iLength]] :[0,0,con[iLength]/2])
      rotate([90,0,0])
       Caliper(messpunkt = false, help=0, size = 7,h = 0.1,
          l=con[iInnerDiameter] + addwidth,
          end=endStyle,
          in=connectorPos == 1 ? 1 : 0,
          txt2 = str("con", con[iConnector], " ", con[iMeasurement]));
      if(con[iInnerDiameter] != con[iInnerStartDiameter]){
        translate([0,0,0])
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, size = 5,h = 0.1,
            l=con[iInnerStartDiameter] + addwidth,
            end=endStyle,
            in=connectorPos == 1 ? 1 : 0,
            txt2 = str("con", con[iConnector], " start ", con[iMeasurement]));
      }
      if(con[iInnerDiameter] != con[iInnerEndDiameter]){
        translate([0,0,con[iLength]])
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, size = 5,h = 0.1,
            l=con[iInnerEndDiameter] + addwidth,
            end=3,
            in=connectorPos == 1 ? 1 : 0,
            txt2 = str("con", con[iConnector], " end ", con[iMeasurement]));
      }

      barWidth = con[iWallThickness]*8;
      position = con[iInnerDiameter]/2 + con[iWallThickness]*2;
      translate([(connectorPos == 1 ? position  : -position), 0, con[iLength]/2])
      rotate([90,0,0])
      Caliper(messpunkt = false, help=0, h = 0.1,
            center=true,
            l=con[iLength],
            cx= 0,
            end=0,
            size = 8,
            in=connectorPos == 1 ? 2 : 3,
            translate= connectorPos == 1 ? [15,0,0] : [-15,0,0],
            txt2 = str("con", con[iConnector], " length"));

      if(con[iStyle] == "nozzle")
      {
        translate([(connectorPos == 1 ? position  : -position), 0,-con[iNozzleSize].z/2])
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, h = 0.1,
              l=con[iNozzleSize].z,
              cx= 0,
              end=0,
              size = 8,
              in=connectorPos == 1 ? 2 : 3,
              translate= connectorPos == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("nozzle ", con[iConnector], " length"));
      }
    }
  }
  HelpTxt("adapter",[
    "con", con,
    "transitionAngle", transitionAngle,
    "debug", debug]
    ,help);
}

module transitionExtension(
  connector,
  innerDiameter = 0,
  wallThickness = 0,
  length = 0 ,
  gridSize = 0,
  gridWallThickness = 0,
  transitionColor = ["LightGreen",1],
  debug = false,
  showCaliper=false,
  txt="",
  txtSize=0,
  includeHook = 0,
  help){
  assert(is_list(transitionColor), "transitionColor must be a list");
  assert(len(transitionColor) == 2, "transitionColor be length 2");
  assert(is_num(connector) && (connector ==1 || connector ==2), "connector must be 1 or 2");
  assert(is_num(innerDiameter), "innerDiameter must be a number");
  assert(is_num(wallThickness), "wallThickness must be a number");
  assert(is_num(length), "length must be a number");
  assert(is_num(gridSize), "gridSize must be a number");
  assert(is_num(gridWallThickness), "gridWallThickness must be a number");

  //gridWallThickness, -1 use wall thickness
  gridWallThickness = gridWallThickness < 0
    ? min(wallThickness, length)
    : min(gridWallThickness, length);

  //gridWallThickness == 0 will disable grid
  gridSize = gridWallThickness <= 0
    ? 0
    : gridSize <=0
      ? innerDiameter/6 - gridWallThickness
      : gridSize;

  if(length > 0)
  {
    difference(){
      color(transitionColor[0], transitionColor[1])
      union(){
      HoseConnector(
        innerStartDiameter = innerDiameter,
        innerEndDiameter = innerDiameter,
        connectorMeasurement = "inner",
        length,
        endCapThickness = gridWallThickness,
        wallThickness = wallThickness,
        endCapGridSize = gridSize,
        endCapGridWallThickness = gridWallThickness,
        help);

        if(includeHook == 1){
          hootLength = min(15, length);
          hookSize = wallThickness*2;
          intersection(){
            difference(){
              Stopper(
                diameter = (innerDiameter+wallThickness),
                outer = (innerDiameter+wallThickness*2)+hookSize*2,
                totalLength = hootLength,
                taper1 = 0.25,
                taper2 = 0.25,
                wallThickness = wallThickness/2,
                stopThickness = hookSize);

              translate([0,0,wallThickness])
              Stopper(
                diameter = (innerDiameter-wallThickness),
                outer = (innerDiameter+wallThickness),
                totalLength = hootLength-wallThickness*2,
                taper1 = 0.3,
                taper2 = 0.3,
                wallThickness = wallThickness/2,
                stopThickness = hookSize);
              }

              cubeSize = [innerDiameter+hookSize,5,hootLength];
              translate([-cubeSize.x,-cubeSize.y/2,0])
              cube([innerDiameter+hookSize,cubeSize.y,cubeSize.z]);
          }
        /*
          difference(){
            cylinder(h=length, d=(innerDiameter+wallThickness*2)+hookSize);
            translate([0,0,-fudgeFactor])
            cylinder(h=length+fudgeFactor*2, d=(innerDiameter+wallThickness));
          }*/
        }
      }
      if($preview&&debug){
        cubeSize = [innerDiameter*2,innerDiameter*1.5, length+fudgeFactor*4];
        translate([-cubeSize.x/2, (connector == 1 ? -cubeSize.y : 0), -fudgeFactor*2])
        cube(cubeSize);
      }

      if(is_string(txt) && len(txt) > 0){
        textExtrude = min(wallThickness,1);
        border = length * .2; //border above and below the text
        translate([0,0,border])
        RoundText(
          textvalue = txt,
          font = "Liberation:style=Bold",
          fontSize = txtSize > 0 ? txtSize : length-border*2,
          radius = innerDiameter/2+wallThickness - textExtrude/2,
          textExtrude = textExtrude,
          forceRound = true,
          center = true,
          $fn=64);
      }
    }

    if($preview&&showCaliper){
    /*render on left side
      color("Gold")
      translate(connector == 1 ? [0, 0, length] : [0, 0, length] )
      mirror(connector == 1 ? [0,0,1] : [0,0,1])
      rotate(connector == 1 ? [0,0,180] : [0,0,0])
      union(){
        barWidth = wallThickness*8;
        position = innerDiameter/2 + wallThickness*2;
        translate([(connector == 1 ? position  : -position), 0, length/2])
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, h = 0.1,
              center=true,
              l=length,
              cx= -1,
              end=0,
              size = 8,
              in=connector == 1 ? 3 : 2,
              translate= connector == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("Extension ", connector, " length"));
      }
    }
    */
      color("Aquamarine")
      translate(connector == 1 ? [0, 0, 0] : [0, 0, 0] )
      mirror(connector == 1 ? [0,0,0] : [0,0,0])
      rotate(connector == 1 ? [0,0,0] : [0,0,180])
      union(){
        barWidth = wallThickness*8;
        position = innerDiameter/2 + wallThickness*2;
        translate([(connector == 1 ? position  : -position), 0, length/2])
        rotate([90,0,0])
        Caliper(messpunkt = false, help=0, h = 0.1,
              center=true,
              l=length,
              cx=0,
              end=0,
              size=6,
              in=connector == 1 ? 2 : 3,
              translate= connector == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("Extension ", connector, " length"));
      }
    }
  }
  HelpTxt("transitionExtension",[
    "innerDiameter", innerDiameter,
    "wallThickness", wallThickness,
    "length", length,
    "gridSize", gridSize,
    "gridWallThickness", gridWallThickness,
    "transitionColor", transitionColor,
    "debug", debug,
    "showCaliper", showCaliper]
    ,help);
}

module transition(
  style,
  length,
  connector1InnerEndDiameter,
  connector2InnerStartDiameter,
  connector3InnerStartDiameter,
  connector1WallThickness,
  connector2WallThickness,
  connector3WallThickness,
  thickness,
  bendRadius,
  angle,
  baseType,
  baseThickness,
  baseWidth,
  baseLength,
  baseAngle,
  connector2Count,
  connector2Angle,
  lengthInHull,
  hullLength,
  hullCenterLength,
  edgeOffset,
  hullCenter,
  centerHeight,
  Offset,
  debug = false,
  transitionColor = ["LightGreen",1],
  showCaliper = false,
  help
){
  assert(is_list(transitionColor), "adapterColor must be a list");
  assert(len(transitionColor) == 2, "adapterColor be length 2");

  multiConnectorAngle = connector2Angle > 0 ? connector2Angle : 360/connector2Count;

  difference()
  {
    union()
    {
      if(style == "flat")
      {
        transDiameter = min(connector1InnerEndDiameter,  connector2InnerStartDiameter);
        transThickness = abs(connector1InnerEndDiameter - connector2InnerStartDiameter)/2 + max(connector1WallThickness,connector2WallThickness);
        color(transitionColor[0], transitionColor[1])
        StraightPipe(
            diameter = transDiameter,
            length = length,
            wallThickness = transThickness);
      }
      if(style == "organicbend")
      {
        //Bent pipe that tapers through the bend.
        color(transitionColor[0], transitionColor[1])
        TaperedBentPipe(
          bendRadius = bendRadius,
          end1InnerPipeDiameter = connector1InnerEndDiameter,
          end2InnerPipeDiameter = connector2InnerStartDiameter,
          end1WallThickness = connector1WallThickness,
          end2WallThickness = connector2WallThickness,
          pipeAngle = angle,
          baseType = baseType,
          baseThickness = baseThickness,
          baseWidth = baseWidth,
          baseLength = baseLength,
          baseAngle = baseAngle,
          end2Count = connector2Count,
          end2Angle = connector2Angle);
      }
      else if(style == "hull")
      {
        color(transitionColor[0], transitionColor[1])
        BentPipeHull(
          inner1PipeRadius = connector1InnerEndDiameter/2,
          inner2PipeRadius = connector2InnerStartDiameter/2,
          inner3PipeRadius = connector3InnerStartDiameter/2,
          end1WallThickness = connector1WallThickness,
          end2WallThickness = connector2WallThickness,
          end3WallThickness = connector3WallThickness,
          pipeAngle = angle,
          end2Count = connector2Count,
          end2Angle = connector2Angle,
          lengthInHull = lengthInHull,
          lengthOutHull = hullLength,
          lengthOutHullCenter = hullCenterLength,
          edgeOffset = edgeOffset,
          addCenter = hullCenter,
          centerHeight= centerHeight
        );
      }
      else if(style == "bend+taper")
      {
        //Tapered transition
        //the bent pipe section, diameter matches connector 1.
        if(angle > 0)
        {
          color(transitionColor[0], transitionColor[1])
          BentPipe(
            bendRadius = bendRadius,
            innerPipeDiameter = connector1InnerEndDiameter,
            wallThickness = connector1WallThickness,
            pipeAngle = angle,
            baseType = baseType,
            baseThickness = baseThickness,
            baseWidth = baseWidth,
            baseLength = baseLength,
            baseAngle = baseAngle,
            end2Count = connector2Count,
            end2Angle = connector2Angle);
        }

        //Tapered section position to the end of the bent pipe
        for (rotation = [0:connector2Count-1])
        {
          //color("SpringGreen")
          color(transitionColor[0], transitionColor[1])
          rotate([0, 0, rotation*multiConnectorAngle])
          translate([-bendRadius, 0, 0])
            rotate([0, -angle, 0])
            translate([bendRadius, 0, 0])
              Pipe(
                diameter1 = connector1InnerEndDiameter,
                diameter2 = connector2InnerStartDiameter,
                length = length,
                wallThickness1 = connector1WallThickness,
                wallThickness2 = connector2WallThickness,
                Offset = Offset);
        }
      }
      else if(style == "taper+bend")
      {
        //Tapered section position to the end of the bent pipe
        //color("SpringGreen")
        color(transitionColor[0], transitionColor[1])
        Pipe(
          diameter1 = connector1InnerEndDiameter,
          diameter2 = connector2InnerStartDiameter,
          length = length,
          wallThickness1 = connector1WallThickness,
          wallThickness2 = connector2WallThickness,
          Offset = Offset);

        if(angle > 0)
        {
          //the bent pipe section, diameter matches connector 2.
          translate([Offset.x, Offset.y, 0])
          color(transitionColor[0], transitionColor[1])
          BentPipe(
            bendRadius = bendRadius,
            innerPipeDiameter = connector2InnerStartDiameter,
            wallThickness = connector2WallThickness,
            pipeAngle = angle,
            zPosition = length,
            baseType = baseType,
            baseThickness = baseThickness,
            baseWidth = baseWidth,
            baseLength = baseLength,
            baseAngle = baseAngle,
            end2Count = connector2Count,
            end2Angle = connector2Angle);
        }
      }
    }
    if($preview&&debug){
      cubeSize = max(connector1InnerEndDiameter,connector2InnerStartDiameter)*3;
      translate([-cubeSize/2, -cubeSize , -fudgeFactor*2])
          cube([cubeSize, cubeSize, cubeSize ]);
      //translate([-100/2, -200, -fudgeFactor*2])
      //    cube([200,200,200]);
    }

    if(showCaliper){
    }
  }

  HelpTxt("transition",[
    "style", style,
    "length", length,
    "connector1InnerEndDiameter", connector1InnerEndDiameter,
    "connector2InnerStartDiameter", connector2InnerStartDiameter,
    "connector3InnerStartDiameter", connector3InnerStartDiameter,
    "connector1WallThickness", connector1WallThickness,
    "connector2WallThickness", connector2WallThickness,
    "connector3WallThickness", connector3WallThickness,
    "thickness", thickness,
    "bendRadius", bendRadius,
    "angle", angle,
    "baseType", baseType,
    "baseThickness", baseThickness,
    "baseWidth", baseWidth,
    "baseLength", baseLength,
    "baseAngle", baseAngle,
    "connector2Count", connector2Count,
    "connector2Angle", connector2Angle,
    "lengthInHull", lengthInHull,
    "hullLength", hullLength,
    "hullCenterLength", hullCenterLength,
    "edgeOffset", edgeOffset,
    "hullCenter", hullCenter,
    "centerHeight", centerHeight,
    "offset", Offset,
    "debug", debug]
    ,help);
}

module HoseAdapter(
  connector1 = UserConnectorSettings(
    connector=1),
  connector2 = UserConnectorSettings(
    connector=2),
  connector3 = UserConnectorSettings(
    connector=3),

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
){
  $gha=[["connector1",[0,0,0]],["connector2",[0,0,0]],["trasnition",[0,0,0]]];

  end1 = getConnectorSettings(
    userSettings=connector1,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end1Color, DefaultEnd1Color),
    con1Measurement=connector1[iMeasurement],
    con1WallThickness=connector1[iWallThickness]);

  end2 = getConnectorSettings(
    userSettings=connector2,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end2Color, DefaultEnd2Color),
    con1Measurement=end1[iMeasurement],
    con1OuterEndDiameter=end1[iOuterEndDiameter],
    con1WallThickness=end1[iWallThickness]);

  end3 = getConnectorSettings(
    userSettings=connector3,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end3Color, DefaultEnd3Color),
    con1Measurement=end1[iMeasurement],
    con1OuterEndDiameter=end1[iOuterEndDiameter],
    con1WallThickness=end1[iWallThickness]);

  echoConnector("end1", end1, help);
  echoConnector("end2", end2, help);
  echoConnector("end3", end3, transitionHullCenter == "end3" ? help : false);

  //Transition settings
  //Total length of connector 1
  endConnector1 = end1[iLength] + end1[iStopLength];


      // transitionLength is not wanted for sweep
  _transitionAngle = (transitionStyle == "flat") ? 0 : transitionAngle;
  _transitionStyle = _transitionAngle == 0 && transitionStyle == "organicbend" ? "bend+taper" : transitionStyle;
  _transitionLength = _transitionStyle == "organicbend" //|| _transitionStyle == "hull"
    ? 0
    : transitionLength == 0
      ? max(
          abs(end1[iOuterEndDiameter] - end2[iOuterEndDiameter])/2,
          abs(end1[iInnerEndDiameter] - end2[iInnerEndDiameter])/2)+(end1[iWallThickness]/2+end2[iWallThickness]/2)
      : transitionLength;

      //Calculate the bend radius
      //organicbend, the '0' value must be max of connector 1 or 2 diameter, plus the wall thickness * 2 otherwise it will clip, then add provided radius.
      //transition the '0' value must be end 1 diameter/2 + wall thickenss *2 to prevent clipping, then addd provided radius.

      //((end2[iInnerStartDiameter] + connector1WallThickness)/ sin(_transitionAngle / 2)/2)/ sin(_transitionAngle) + transitionBendRadius
      //For organic bend only
      taperedAverageDiameter = (max(end1[iOuterEndDiameter],end2[iOuterStartDiameter])*2 + min(end1[iOuterEndDiameter],end2[iOuterStartDiameter]))/3;

      hoseSpacer = end2[iWallThickness];
      shapeOverlap = ((end1[iOuterEndDiameter]/2-hoseSpacer)-(cos(_transitionAngle)*end2[iOuterEndDiameter]))/sin(_transitionAngle);
      lengthInHull = _transitionStyle == "hull"
        ? (shapeOverlap > 0 ? 0 : shapeOverlap * -1) + _transitionLength
        : 0;
      transitionCenterHeight = transitionHullCenterHeight == 0 ? lengthInHull * 2 : transitionHullCenterHeight;

      //Push end horizontially out from verticle center line
      edgeOffset = _transitionStyle == "hull"
        ? (shapeOverlap > 50
          ? (end1[iOuterEndDiameter] - end2[iOuterEndDiameter])/2-shapeOverlap/2 + transitionHullyOffset
          : (end1[iOuterEndDiameter] - end2[iOuterEndDiameter])/2 + transitionHullyOffset) * cos(_transitionAngle)
        : 0;

     function bend_radius(transitionAngle, transitionBendRadius, end1OuterEndDiameter, end2OuterEndDiameter, taperedAverageDiameter) =
         let(organic_bend_radius = transitionEnd2Count > 1
                ? -(taperedAverageDiameter/2)/(cos(transitionAngle)-1)-taperedAverageDiameter/2 + transitionBendRadius
                : taperedAverageDiameter + transitionBendRadius,
             bend_taper_radius = transitionEnd2Count > 1
                ? -(end1OuterEndDiameter/2)/(cos(transitionAngle)-1)-end1OuterEndDiameter/2 + transitionBendRadius
                : end1OuterEndDiameter/2 + transitionBendRadius,
             taper_bend_radius = transitionEnd2Count > 1
                ? -(end2OuterEndDiameter/2)/(cos(transitionAngle)-1)-end2OuterEndDiameter/2 + transitionBendRadius
                : end2OuterEndDiameter/2 + transitionBendRadius,
             hull_radius = 0 )
                  transitionStyle == "organicbend" ? organic_bend_radius
                  : _transitionStyle == "bend+taper" ? bend_taper_radius
                  : _transitionStyle == "taper+bend" ? taper_bend_radius
                  : _transitionStyle == "hull" ? hull_radius
                  : 0;
        
      //end hull settings
      bendRadius = bend_radius(
        transitionAngle=_transitionAngle,
        transitionBendRadius=transitionBendRadius,
        end1OuterEndDiameter=end1[iOuterEndDiameter],
        end2OuterEndDiameter=end2[iOuterEndDiameter],
        taperedAverageDiameter=taperedAverageDiameter);

  if(drawAlignmentRing == "end1" || drawAlignmentRing == "end2")
  {
    adapterAlignmentRing(
      centerDiameter = drawAlignmentRing == "end1"
        ? end1[iInnerStartDiameter] + end1[iMagnetBorder] + alignmentUpperWidth
        : end2[iInnerStartDiameter] + end2[iMagnetBorder] + alignmentUpperWidth,
      alignmentDepth = alignmentDepth,
      alignmentUpperWidth = alignmentUpperWidth,
      alignmentLowerWidth = alignmentLowerWidth,
      alignmentSideClearance = alignmentSideClearance,
      alignmentDepthClearance = alignmentDepthClearance,
      magnetBorder = drawAlignmentRing == "end1" ? end1[iMagnetBorder] : end2[iMagnetBorder],
      debug = sliceDebug,
      showCaliper = showCaliper,
      help = help);
  } else {
    difference()
    {
      union()
      {
        //End1
        translate([0, 0, endConnector1])
        mirror ([0,0,1])
        adapter(
          con = end1,
          connectorPos=1,
          transitionAngle =_transitionAngle,
          debug = sliceDebug,
          showCaliper = showCaliper,
          help = help);

        translate([0, 0, endConnector1])
        transitionExtension(
          connector = 1,
          innerDiameter = end1[iInnerEndDiameter],
          wallThickness = end1[iWallThickness],
          length = end1[iExtensionLength],
          gridSize = end1[iExtensionGridSize],
          gridWallThickness = end1[iExtensionGridWallThickness],
          txt = end1[iExtensionText],
          txtSize=end1[iExtensionTextSize],
          transitionColor = getColor(extensionColor, DefaultTransitionColor),
          debug = sliceDebug,
          showCaliper = showCaliper,
          help = help);

        translate([0, 0, endConnector1 + end1[iExtensionLength]])
        transition(
          style = _transitionStyle,
          length = _transitionLength,
          connector1InnerEndDiameter = end1[iInnerEndDiameter],
          connector2InnerStartDiameter = end2[iInnerEndDiameter],
          connector3InnerStartDiameter = getConnector3Setting(transitionHullCenter, end1, end2, end3)[iInnerEndDiameter],
          connector1WallThickness = end1[iWallThickness],
          connector2WallThickness = end2[iWallThickness],
          connector3WallThickness = getConnector3Setting(transitionHullCenter, end1, end2, end3)[iWallThickness],
          bendRadius = bendRadius,
          angle = _transitionAngle,
          baseType = transitionBaseType,
          baseThickness = transitionBaseThickness,
          baseWidth = transitionBaseWidth,
          baseLength = transitionBaseLength,
          baseAngle = transitionBaseAngle,
          connector2Count = transitionEnd2Count,
          connector2Angle = transitionEnd2Angle,
          lengthInHull = lengthInHull,
          hullLength = transitionHullLength,
          hullCenterLength = transitionHullCenterLength,
          edgeOffset = edgeOffset,
          hullCenter = transitionHullCenter != "disabled",
          centerHeight = transitionCenterHeight,
          Offset = transitionOffset,
          debug = sliceDebug,
          transitionColor = getColor(transitionColor, DefaultTransitionColor),
          showCaliper = showCaliper,
          help = help);

        // Create the end connector
        if(end2[iLength] > 0)
        {
          postRotation = [
            ((_transitionStyle == "taper+bend") ? transitionOffset.x
              : _transitionStyle == "hull" ? -end1[iOuterEndDiameter]/2
              : 0) - bendRadius,
            ((_transitionStyle == "taper+bend") ? transitionOffset.y : 0),
            ((_transitionStyle == "taper+bend" || _transitionStyle == "flat" || _transitionStyle == "none") ? _transitionLength
              : _transitionStyle == "hull" ? 0
              : 0) + endConnector1 + end1[iExtensionLength]];

          preRotation = [
            ((_transitionStyle == "bend+taper") ? transitionOffset.x
              : _transitionStyle == "hull" ? end1[iOuterEndDiameter]/2-edgeOffset
              : 0) + bendRadius,
            ((_transitionStyle == "bend+taper") ? transitionOffset.y : 0),
            ((_transitionStyle == "bend+taper") ? _transitionLength
              : _transitionStyle == "hull" ? transitionHullLength+lengthInHull+end2[iWallThickness]
              : 0)];

          multiConnectorAngle = transitionEnd2Angle > 0 ? transitionEnd2Angle : 360/transitionEnd2Count;

          for (rotation = [0:transitionEnd2Count-1])
          {
            if(sliceDebug == false || rotation ==0)
            rotate([0, 0, rotation*multiConnectorAngle])
            translate(postRotation)
            rotate([0, -_transitionAngle, 0])
            translate(preRotation)
            union(){
              translate([0, 0, end2[iExtensionLength]])
              mirror([0,0,1])
              mirror([0,1,0])
              transitionExtension(
                connector = 2,
                innerDiameter = end2[iInnerStartDiameter],
                wallThickness = end2[iWallThickness],
                length = end2[iExtensionLength],
                gridSize = end2[iExtensionGridSize],
                gridWallThickness = end2[iExtensionGridWallThickness],
                txt = end2[iExtensionText],
                txtSize=end2[iExtensionTextSize],
                transitionColor = getColor(extensionColor, DefaultTransitionColor),
                debug = sliceDebug,
                showCaliper = showCaliper,
                help = help);

              translate([0, 0, end2[iExtensionLength]])
              adapter(
                con = end2,
                connectorPos=2,
                transitionAngle =_transitionAngle,
                debug = sliceDebug,
                showCaliper = rotation == 0 ? showCaliper : false,
                help = help);
              }
          }

          if(_transitionStyle == "hull" && transitionHullCenter != "disabled")
          {
            translate([0, 0, endConnector1+end1[iExtensionLength]+end3[iStopLength]+transitionCenterHeight+transitionHullCenterLength])
              union(){
                translate([0, 0, end2[iExtensionLength]])
                mirror([0,0,1])
                mirror([0,1,0])
                transitionExtension(
                  connector = 2,
                  innerDiameter = end3[iInnerStartDiameter],
                  wallThickness = end3[iWallThickness],
                  length = end3[iExtensionLength],
                  gridSize = end3[iExtensionGridSize],
                  gridWallThickness = end3[iExtensionGridWallThickness],
                  txt = end3[iExtensionText],
                  txtSize=end3[iExtensionTextSize],
                  transitionColor = getColor(extensionColor, DefaultTransitionColor),
                  debug = sliceDebug,
                  showCaliper = showCaliper,
                  help = help);
                translate([0, 0, end2[iExtensionLength]])
                adapter(
                  con = getConnector3Setting(transitionHullCenter, end1, end2, end3),
                  connectorPos=3,
                  transitionAngle =_transitionAngle,
                  debug = sliceDebug,
                  showCaliper = showCaliper,
                  help = help);
                }
            }
        }
      }
    }
  }
}
//CombinedEnd from path vacuum-hose-adapter.scad
//Combined from path ub.scad


/*
cut  version of
works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
*/

/*Hidden*/
Version=23.305;//                <<< ---   VERSION  VERSION VERSION ••••••••••••••••
useVersion=undef;

/// render with Hires
hires=false;
fn=$fn?$fn:$preview?36:
                          hires?144:
                                72;


fs=$preview?.75:hires?.1:.2;
fa=$preview?10:hires?.5:1;

needs2D=["Rand","WKreis","Welle","Rund","Rundrum", "LinEx", "RotEx","SBogen","Bogen","HypKehle","Roof"]; /// modules needing 2D children

styles=[

"Condensed",
"Condensed Oblique",
"Condensed Bold",
"Condensed Bold Oblique",
"Condensed Bold Italic",
"SemiCondensed",
"SemiLight Condensed",
"SemiLight SemiCondensed",
"SemiBold SemiCondensed",
"SemiBold Condensed",
"Light Condensed",
"Light SemiCondensed",
"SemiLight",
"Light",
"ExtraLight",
"Light Italic",
"Bold",
"Bold SemiCondensed",
"Semibold",
"Semibold Italic",
"Bold Italic",
"Bold Oblique",
"Black",
"Black Italic",
"Book",
"Regular",
"Italic",
"Medium",
"Oblique",
];


co=[
["silver","lightgrey","darkgrey","grey","slategrey","red","orange","lime","cyan","lightblue","darkblue","purple",[.8,.8,.8,.3],[.8,.8,.8,.6],"cyan","magenta","yellow","black","white","red","green","blue",[0.77,0.75,0.72]],//std
["White","Yellow","Magenta","Red","Cyan","Lime","Blue","Gray","Silver","Olive","Purple","Maroon","Teal","Green","Navy","Black"],//VGA
["Gainsboro","LightGray","Silver","DarkGray","Gray","DimGray","LightSlateGray","SlateGray","DarkSlateGray","Black"],//grey
["Pink","LightPink","HotPink","DeepPink","PaleVioletRed","MediumVioletRed"],//pink
["LightSalmon","Salmon","DarkSalmon","LightCoral","IndianRed","Crimson","Firebrick","DarkRed","Red"],//red
["OrangeRed","Tomato","Coral","DarkOrange","Orange"],//orange
["Yellow","LightYellow","LemonChiffon","LightGoldenrodYellow","PapayaWhip","Moccasin","PeachPuff","PaleGoldenrod","Khaki","DarkKhaki","Gold"],//yellows
["Cornsilk","BlanchedAlmond","Bisque","NavajoWhite","Wheat","Burlywood","Tan","RosyBrown","SandyBrown","Goldenrod","DarkGoldenrod","Peru","Chocolate","SaddleBrown","Sienna","Brown","Maroon"],//browns
["DarkOliveGreen","Olive","OliveDrab","YellowGreen","LimeGreen","Lime","LawnGreen","Chartreuse","GreenYellow","SpringGreen","MediumSpringGreen","LightGreen","PaleGreen","DarkSeaGreen","MediumAquamarine","MediumSeaGreen","SeaGreen","ForestGreen","Green","DarkGreen"],//greens
["Cyan","LightCyan","PaleTurquoise","Aquamarine","Turquoise","MediumTurquoise","DarkTurquoise","LightSeaGreen","CadetBlue","DarkCyan","Teal"],//cyans
["LightSteelBlue","PowderBlue","LightBlue","SkyBlue","LightSkyBlue","DeepSkyBlue","DodgerBlue","CornflowerBlue","SteelBlue","RoyalBlue","Blue","MediumBlue","DarkBlue","Navy","MidnightBlue"],//blue
["Lavender","Thistle","Plum","Violet","Orchid","Magenta","MediumOrchid","MediumPurple","BlueViolet","DarkViolet","DarkOrchid","DarkMagenta","Purple","Indigo","DarkSlateBlue","SlateBlue","MediumSlateBlue"],//violetts
["White","Snow","Honeydew","MintCream","Azure","AliceBlue","GhostWhite","WhiteSmoke","Seashell","Beige","OldLace","FloralWhite","Ivory","AntiqueWhite","Linen","LavenderBlush","MistyRose"],//white
["Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple","magenta"],//rainbow
["magenta","Purple","Blue","dodgerblue","deepskyblue","cyan","turquoise","limegreen","lime","Greenyellow","Yellow","Orange","darkorange","Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple"]//rainbow2
];

/** \name stringChunk
\page Functions
stringChunk() separates charcter from a string
\param txt input string
\param start start of extraction
\param length number of characters to extract
*/

function stringChunk(txt,start=0,length,string="")=
  let(
    start=abs(start),
    length=is_undef(length)?len(str(txt))-start:length
  )
  len(string)<length&&start<len(txt)?stringChunk(txt=txt,length=length,start=start+1,string=str(string,str(txt)[start])):string;


// list of parent modules [["name",id]]
function parentList(n=-1,start=1)=  is_undef($parent_modules)||$parent_modules==start?undef:[for(i=[start:$parent_modules +n])[parent_module(i),i]];

function is_parent(parent= needs2D, i= 0)=
is_list(parent)?is_num(search(parent,parentList())[i])?true:
                                                      i<len(parent)-1?is_parent(parent=parent,i=i+1):
                                                                      false:
                is_num(search([parent],parentList())[0]);



function bool(n,bool)= b(n,bool);
function b(n,bool)=  is_list(n)?[for(i=[0:len(n)-1])b(n[i],bool)]:
                               is_num(n)?bool||is_undef(bool)?n?true:
                                                                false:
                                                              n?n:
                                                                0:
                                         bool?n?true:  // n = bool
                                                false:
                                              n?1:
                                                0;

function gradB(b,r)=360/(PI*r*2)*b; // winkel zur Bogen strecke b des Kreisradiuses r

function v3(v)= [
is_num(v.x)?v.x:is_num(v)?v:0,
is_num(v.y)?v.y:0,
is_num(v.z)?v.z:0,
 ];

/** \page Functions \name kreis
kreis() generates points on a circle or arc
\param r radius
\param rand dist second radius
\param grad angle
\param grad2 angle second arc
\param fn fragments

\param center center angle
\param sek  chord or center point
\param r2  y component
\param rand2  y component
\param rot rotate points
\param t translate points
\param z z value for polyhedron
\param d ovewrite radius with diameter
\param endPoint end angle with point
\param fs fragment size
\param fs2 fragment size second arc
\param fn2 fragments second arc
\param minF minimum fragments
*/

function Kreis(r=10,rand=+5,grad=360,grad2,fn=fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,fn,center,sek,r2,rand2,rcenter,rot,t);




function kreis(r=10,rand=+5,grad=360,grad2,fn=fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=fs,fs2,fn2,minF=1,fa=fa)=
let (
minF=bool(minF,bool=false),
grad2=is_undef(grad2)?grad:grad2,
r=is_num(d)?rcenter?(d+rand)/2:d/2:
            rcenter?r+rand/2:r,
rand2=is_undef(rand2)?rand:rand2,
r2=r2?
    rcenter?r2+rand2/2:r2
    :r,
ifn=is_num(fn)&&fn>0?max(1,ceil(abs(fn)))
                    :min(max(abs(grad)<180?1
                                       :abs(grad)==360?3
                                                      :2,ceil(abs(PI*r*2/360*grad/max(fs,0.001))),minF),round(abs(grad)/fa) ),
fs2=is_undef(fs2)?fs:fs2,

fn2=is_num(fn)&&fn>0?is_undef(fn2)?ifn:max(1,ceil(abs(fn2)))
                    :min(max(abs(grad2)<180?1:abs(grad2)==360?3:2,ceil(abs(PI*(r-rand)*2/360*grad2/max(fs2,0.001))),minF),round(grad/fa)),

step=grad/ifn,
step2=grad2/fn2,
t=is_list(t)?t:[t,0],
endPoint=rand?true:endPoint
)
is_num(z)?[
if(!sek&&!rand&&abs(grad)!=360&&grad)[0+t[0],0+t[1],z], // single points replacement
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1],
     z],
if(grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r  +t[0],
     cos(rot+(center?-grad/2-90:0)+iw*step)*r2 +t[1],
     z],
if(rand)for(i=[0:endPoint?fn2:fn2 -1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r  -rand )+t[0],
     cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2 -rand2)+t[1],
    z]
]:
[ // if 2D
if(!sek&&!rand&&abs(grad)!=360&&grad||r==0)[0+t[0],0+t[1]], // single points replacement
if(r&&grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r+t[0],
    cos(rot+(center?-grad/2-90:0)+iw*step)*r2+t[1]],
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1]],
if(rand)for(i=[0:endPoint?fn2:fn2-1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r-rand)+t[0],
    cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2-rand2)+t[1]]
];


/** \page Polygons
Pfeil() creates an arrow
\brief creates an arrow
\name Pfeil
\param l length [tail,head] or total length
\param b width  [tail,head] or teil and head is calculated by angle(grad)
\param shift shifting center and end points
\param grad arrow head angle
\param d form circular arrow
\param angle angle of circular arrow (optional)
\param center centers arrow
\param name  names arrow
\param help activate help
*/

//Pfeil(d=20,angle=-70,shift=-1);


module Pfeil(l=[+2,+3.5],b=+2,shift=0,grad=60,d=0,angle=0,center=true,name,help){
 shift=is_list(shift)?shift:[shift,-shift];
 l=is_list(l)?l:[l/2,l/2];
 b=is_list(b)?b:[b,2*(l[1]-(d?0:shift[0]))*tan(grad/2)];
 center=is_bool(center)?center?[1,1]:[0,0]:is_list(center)?center:[center,center];
 dir=sign(d)*(angle?sign(angle):1);
 d=d?max(abs(d),abs(b[1])):0;

 lD=[angle?min(abs(d)*PI/360*abs(angle),PI*abs(d)-l[1]-shift[0]-.01 ) :l[0],l[1]];// lenght circular arrow
 angle=angle?angle:gradB(r=d/2,b=l[0])*dir;

 gradB=d?gradB(b=lD[1]+ shift[1],r=d/2)  :0; // länge Pfeilspitze auf Kreis

 fnD=max(8,ceil(norm([b[1]/2,lD[1]])/$fs)); // fraqments gebogene Spitze
 fnDend=max(10,ceil(abs(lD[0])/$fs));

 spitze=false; // gebogene Spitze = false

 points=[
     [l[1],0],//spitze
     [shift[0],b[1]/2],
     [0,b[0]/2],
  if(!d)[-l[0],b[0]/2],//End oben
  if(!d)[-l[0]+shift[1],0],//End mitte
  if(!d)[-l[0],-b[0]/2],//End unten
     [0,-b[0]/2],
     [shift[0],-b[1]/2],
    ];


  pointsD=[
    [0,d/2-b[0]/2],
    each kreis(rand=0,grad=dir*gradB(r=d/2+b[0]/2*0,b=-lD[0]),d=d+b[0],center=0,fn=fnDend),
    [sin(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2,cos(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2],//shift End

    each kreis(rand=0,grad=dir*-gradB(r=d/2-b[0]/2*0,b=-lD[0]),d=d-b[0],center=0,rot=dir*gradB(r=d/2-b[0]/2*0,b=-lD[0]),fn=fnDend),

    [0,d/2+b[0]/2],
    for(i=[0:fnD ])    let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 +(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],
    for(i=[fnD :-1:0]) let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 -(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],

    ];

  if(d)translate(center.y?center.y<0?[0,d/2]:
                                  [0,0]:
                  [0,-d/2]){
      if(spitze)union(){
      Kreis(d=d,rand=b[0],b=-l[0],center=false,rcenter=true,rot=-90);
      T(y=d/2)polygon(points);
      }
      else polygon(pointsD);

  }
  else translate([center.x?center.x>0?0:-l[1]:l[0],center.y?center.y>0?0:-b[1]/2:b[1]/2]) polygon(points);

InfoTxt("Pfeil",["Winkel",2*atan((b[1]/2)/(l[1]-shift[0]))],name);
HelpTxt("Pfeil",[
    "l",l,
    "b",b,
    "shift",shift,
    "grad",grad,
    "d",d,
    "angle",angle,
    "center",center,
    "name",name],help);
}

/// display variable values
module InfoTxt(name,string,info,help=false){
  $tab=is_undef($tab)?0:$tab;
  info=is_undef(info)?is_undef($info)?false:
                                $info:
  info;

  //  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Function_Literals
 noInfo=is_undef($noInfo)?false:$noInfo;
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 joinArray= function(in,out="",pos=0) pos>=len(in)?out: // scad version > 2021
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);

 if(version()[0]<2021){
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",is_num(string[i+1])?negRed(string[i+1]):string[i+1],i<len(string)-2?", ":"")];

if(info)if(is_list(string))echo(
 str(is_bool(info)?"":"<b>",info," ",name," ",
infoText[0]
,infoText[1]?infoText[1]:""
,infoText[2]?infoText[2]:""
,infoText[3]?infoText[3]:""
,infoText[4]?infoText[4]:""
,infoText[5]?infoText[5]:""
,infoText[6]?infoText[6]:""
,infoText[7]?infoText[7]:""
,infoText[8]?infoText[8]:""
,infoText[9]?infoText[9]:""
));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
else { // current version info
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],i<len(string)-2?", ":"")];

if(info&&(!idx||idxON)&&!noInfo)if(is_list(string))echo(
 str(is_string(info)?$tab?"⏩\t":
                          "🟩\t••":
                     "",$tab?" ╞▷   ":
                             "",b($tab,false)>1?" ┗▶   ":
                                                " ",info," ",name," ",
joinArray(infoText)));

else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=help);
}


//Text("fhpbdlqQPXMALTfF",size=10,trueSize="cap",cy=+0);
//%square([100,10]);

//Text("HTAMpqf",radius=20,rot=0);
//Text("HTAMMMMMM",trueSize="textl",size=20,textmetrics=0,spacing=1);


module Text(text="»«",size=5,h,cx,cy,cz,center=0,spacing=1,fn,fs=fs,radius=0,rot=[0,0,0],font="Bahnschrift:style=bold",style,help,name,textmetrics=true,viewPos=false,trueSize="body")
{

text=str(text);
lenT=len(text);
textmetrics=version()[0]<2022?false:textmetrics;

Echo(str("Sizing inactive trueSize=",trueSizeSW),color="warning",condition=trueSize!="size"&&( (!textmetrics&&trueSize!="body")||(is_num(useVersion)&&useVersion<22.208) ) );

trueSizeSW=is_num(useVersion)&&useVersion<22.208?"size":trueSize;
inputSize=size;

style=is_string(style)?style:styles[style];
font=is_num(font)?fonts[font]:font;
fontstr=is_undef(style)?font:str(font,":style=",style);

hp=textmetrics?textmetrics(text="hpbdlq",font=fontstr,size=1,spacing=spacing).size.y:1;
cap=textmetrics?textmetrics(text="HTAME",font=fontstr,size=1,spacing=spacing).size.y:1;
textSize=textmetrics?textmetrics(text=text,font=fontstr,size=1,spacing=spacing).size:[lenT*spacing,1];
fontS=textmetrics?fontmetrics(font=fontstr,size=1).nominal:1;


size=trueSizeSW=="body"?size*.72:
     trueSizeSW=="hp"?size/hp:
     trueSizeSW=="cap"?size/cap:
     trueSizeSW=="text"?size/textSize.y:
     trueSizeSW=="textl"?size/textSize.x:
     trueSizeSW=="font"?size/(fontS.ascent-fontS.descent):
     size;

    h=is_parent(needs2D)?0:is_undef(h)?size:h;
    cx=center?is_undef(cx)?1:cx:is_undef(cx)?0:cx;
    cy=center?is_undef(cy)?1:cy:is_undef(cy)?0:cy;
    cz=center?is_undef(cz)?1:cz:is_undef(cz)?0:cz;



    txtSizeX=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.x:size*spacing*lenT;
    txtSizeY=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.y:size;
    fontSize=[for(i=[0:max(lenT-1,0)])textmetrics?
      textmetrics(text=stringChunk(txt=text,length=i),font=fontstr,size=size,spacing=spacing).advance.x + textmetrics(text=text[i],font=fontstr,size=size,spacing=1).advance.x/2*(cx?1:1)
      :
      (size*spacing)*i];


 valign=cy?b(cy,false)<0?"bottom":
                         b(cy,false)>1?"top":
                                       "center":
           "baseline";

 halign=bool(cx,false)>0?"center"
                        :bool(cx,false)<0?"right"
                                         :"left";

 if(text)
  if(!radius){
    if(h)
    rotate(rot)translate([0,0,cz?-abs(h)/2:h<0?h:0]) linear_extrude(abs(h),convexity=10){
    text(str(text),size=size,halign=halign,valign=valign,font=fontstr,spacing=spacing,$fn=fn,$fs=fs);
    }
    else rotate(rot)translate([0,0,cz?-h/2:0])text(text,size=size,halign=halign,valign=valign,spacing=spacing,font=fontstr,$fn=fn,$fs=fs);
  }
  else if (lenT){
   iRadius=radius+(cy?-txtSizeY/2:0);
    rotate(center?textmetrics?gradB(txtSizeX/2,iRadius):gradB(max(fontSize),iRadius)/2:0)
    for(i=[0:lenT-1])rotate(-gradB(fontSize[i],iRadius))
    if(h)
    translate([0,radius,0])rotate(rot)Tz(cz?-abs(h)/2:h<0?h:0){
    %color("Chartreuse")if(viewPos&&$preview)translate([0,-1])rotate(-30)circle($fn=3);// pos Marker
    linear_extrude(abs(h),convexity=10)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
    }
    else  translate([0,radius,cz?-h/2:0])rotate(rot)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
  }

 InfoTxt("Text",["font",font,"style",style,"trueSize",trueSizeSW,"size",str(inputSize," ⇒ ",size)],name);

 HelpTxt("Text",[
"text",str("\"",text,"\""),
"size",inputSize,
"h",str(h," /*0 for 2D*/"),
"cx",cx,
"cy",cy,
"cz",cz,
"center",center,
"spacing",spacing,
"fn",fn,
"fs",fs,
"radius",radius,
"rot",rot,
"font",str("\"",font,"\""),
"style",str("\"",style,"\""),
"name",name,
"textmetrics",textmetrics,
"viewPos",viewPos,
"trueSize",str("\"",trueSize,"\""," /* body,size,hp,cap,text,textl,font */")
],help);


}

/// short for translate[];
module T(x=0,y=0,z=0,help=false)
{
    //translate([x,y,z])children();
if(is_list(x))
    multmatrix(m=[
    [1,0,0,x[0]],
    [0,1,0,x[1]],
    [0,0,1,is_undef(x.z)?z:x[2]+z],
    [0,0,0,1]
    ])children();
else
    multmatrix(m=[
    [1,0,0,x],
    [0,1,0,y],
    [0,0,1,z],
    [0,0,0,1]
    ])children();


    MO(!$children);
    HelpTxt("T",["x",x,"y",y,"z",z],help);
}

/// missing object text
module MO(condition=true,warn=false){
$idx=is_undef($idx)?false:$idx;
Echo(str(parent_module(2)," has no children!"),color=warn?"warning":"red",condition=condition&&$parent_modules>1&&!$idx,help=false);
}

/// echo color differtiations
module Echo(title,color="#FF0000",size=2,condition=true,help=false){
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 if(condition&&(!idx||idxON))
     if(version()[0]<2021)echo(str("<H",size,"><font color=",color,">",title));
     else if (color=="#FF0000"||color=="red")echo(str("\n🔴\t»»» ",title));
     else if (color=="redring")echo(str("\n⭕\t»»» ",title));
     else if (color=="#FFA500"||color=="orange")echo(str("\n🟠\t»»» ",title));
     else if (color=="#00FF00"||color=="green"||color=="info")echo(str("🟢\t ",title));
     else if (color=="#0000FF"||color=="blue") echo(str("🔵\t ",title));
     else if (color=="#FF00FF"||color=="purple") echo(str("🟣\t ",title));
     else if (color=="#000000"||color=="black") echo(str("⬤\t ",title));
     else if (color=="#FFFFFF"||color=="white") echo(str("◯\t ",title));
     else if (color=="#FFFF00"||color=="yellow"||color=="warning") echo(str("⚠\t ",title));
         else echo(str("• ",title));

 HelpTxt("Echo",["title",title,"color",color,"size",size,"condition",condition],help);
}

//Clone and mirror object
module MKlon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx,my,mz,help=false)
{
    mx=is_undef(mx)?sign(abs(tx)):mx;
    my=is_undef(my)?sign(abs(ty)):my;
    mz=is_undef(mz)?!mx&&!my?1:sign(abs(tz)):mz;

  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children();

    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
        translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children();
    }
    MO(!$children);
    HelpTxt("MKlon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz,"mx",mx,"my",my,"mz",mz],help);

}

// Clone and mirror (replaced by MKlon)
module Mklon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx=0,my=0,mz=1)
{
    mx=tx?1:mx;
    my=ty?1:my;
    mz=tz?1:mz;
  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children();
    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children(); }
   MO(!$children);
}


// color by color lists
module Col(no=0,alpha=1,pal=0,name=0,help){
   palette=["std","VGA","grey","pink","red","orange","yellow","brown","green","cyan","blue","violett","white","rainbow"];

HelpTxt("Col",["no",no,"alpha",alpha,"pal",pal,"name",name],help);

    for(i=[0:1:$children-1]){
    $idx=i;
    color(co[pal][(no+i)%len(co[pal])],alpha)children(i);
    union(){
      $idx=0;
    InfoTxt("Col",["Color children ($idx)",str(i," Farb№: ",no+i,"- ",co[pal][(no+i)%len(co[pal])])," von ",len(co[pal])-1,"Palette",str(pal,"/",palette[pal],(no+i>len(co[pal])-1)?" — Out of Range":"")],name);
    }
    }
    MO(!$children);
}


/** \page Helper
 Caliper() shows a distance and can be used as annotation
 \brief Caliper shows a distance and can be used as annotation
 \param l length to show
 \param in direction
 \param center centered length
 \param messpunkt show / size of gizmo
 \param translate  translates the text and arrow
 \param end differnt end options [0:none,1:triangle, 2:square, 3:arrow in, 4:arrow out]
 \param h height while end=0,3,4 can be 2D if h=0
 \param on switch on=2 if Caliper should be rendered
 \param l2 arrow width
 \param txt  l+mm is used optional text
 \param txt2  optional second text
 \param size size
*/
//Caliper(end=0,messpunkt=0,in=1,translate=[20,-5],center=+1);

//Caliper(end=3);
//Caliper(end=3,txt2="X—Length",in=+1);


module Caliper(l=40,in=1,center=true,messpunkt=true,translate=[0,0,0],end=1,h,on=$preview,l2,txt,txt2,size=$vpd/15,render,s,t,cx,cy,help=false){

    on=render?render:on;
    s=s?s:size;
    txt=is_undef(txt)?str(l,end==2?"":"mm"):str(txt);
    center=is_bool(center)?center?1:0:center;
    textl=in>1?s/2.5:s/4*(len(str(txt)));// end=0,3,4 use own def
    line=s/20;
    translate=t?v3(t):v3(translate);
    //l2=is_undef(l2)?s:l2;


    if(on&&$preview||on==2)translate(translate)translate(in>1?center?[0,0]:[0,l/2]:center?[0,0]:[l/2,0]){
      if(end==1)Col(5){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=l/2,mz=0)polygon([[max(-5,-l/3),0],[0,s],[0,0]]);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=-l/2,mz=0)polygon([[max(-5,-l/3),0],[0,-s],[0,0]]);

        Text(h=h+.1,text=txt,center=true,size=s/4,trueSize="size",cx=cx,cy=cy);
        }
     else if(end==2)Col(3)union(){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)T(-(l-textl*2)/4,0)cube([max(l-textl*2,.01)/2,line,h],center=true);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)cube([line,s,h],center=true);
        translate([(l<textl+1&&in<2)?l/2+textl/2+1.5:0,
          l<s/2 +1&&in>1?l/2+s/4+1:0,0])
            Text(h=h+.1,text=txt,center=true,size=s/2,trueSize="size",cx=cx,cy=cy);
         if(l<textl+1&&in<2)translate([.25,0])square([l+.5,line],true);
         if(l<s+1&&in>=2) translate([0,.25])square([line,l+.5],true);

        }
        else Col(1) {
        h=is_undef(h)?.1:h;
          if(h) linear_extrude(h,convexity=5) Dimensioning();
          else Dimensioning();
        }
    }

Echo("Caliper will render",color="warning",condition=on==2);
if(h&&end&&on&&end<3)
Pivot(messpunkt=messpunkt,p0=translate,active=[1,1,1,1,norm(translate)]);

    HelpTxt("Caliper",[
    "l",l,
    "in",in,
    "size",size,
    "center",center,
    "messpunkt",messpunkt,
    "translate",translate,
    "end",end,
    "h",h,
    "on",on,
    "l2",l2,
    "txt",txt,
    "txt2",txt2]
    ,help);


  module Dimensioning (t=translate){
            s=s==$vpd/15?5:s;
            txt2=txt2?str(txt2):"";
            line=s/20;
            textS=len(txt2)?s/2*.72:s*.72;//text size
            l2=l2?l2:s/1.5;
            textl=in>1?(len(txt2)?3:1.5)*textS:1+textS*max(len(txt),len(txt2))*0.95;
            arrowL=min(l/6,s);
            textOut=l<textl+arrowL*2||(abs(translate.y)>l/2&& (in==2||in==3) )||(abs(translate.x)>l/2&&in!=2&&in!=3); // is text outside l
            textOffset=l<textl+arrowL*2?l/2+textl/2+1:0;
            diffT=in!=2&&in!=3? t.x:-t.y;

// text line
        if(l-textl>0)rotate(in?in==2?90:in==3?-90:180:0){
         if(!textOut&&l-textl - diffT*2>0) T(-l/2)T((l-textl)/4 +diffT/2,0)square([(l-textl)/2-diffT,line],center=true);
         if(!textOut&&l-textl + diffT*2>0) T( l/2)T(-(l-textl)/4 +diffT/2,0)square([(l-textl)/2+diffT,line],center=true);
        }
//End lines vertical
        translate(in!=2&&in!=3?[-translate.x,0]:[0,-translate.y])rotate(in?in==2?90:in==3?-90:180:0){
        MKlon(tx=l/2){
           T(end?end==4?-line/2:+line/2:0) square([line,s],center=true);
           if(end)rotate(end==4?180:0)Pfeil([0,arrowL],b=[line,l2],center=[-1,1],name=false);
        }
        if(textOut) square([l,line],true); // Verbindung Pfeile
// text pos
        translate(in!=2&&in!=3?[(in?1:-1) * -translate.x,0]:[(in==2?1:-1)*translate.y,0]){
          translate([textOffset,0])rotate(in>1?-90:180){
            if(len(txt2))translate([0,-textS/1.5])Text(h=0,text=txt2,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
            translate([0,len(txt2)?textS/1.5:0])Text(h=0,text=txt,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
          }
        }
// verbindung text ausserhalb
        tOutDist=(in!=2&&in!=3)? t.x *(in   ?-1:1) + textOffset :
                                 t.y *(in==3?-1:1) + textOffset ;

        if(textOut&&tOutDist)rotate(tOutDist<0?180:0)translate([0,-line/2])square([abs(tOutDist)-textl/2 ,line]);
        }

// verlängerungen translate auf 0.5
      mkL=end?end==4?l/2-line:l/2:l/2-line/2;
       if(abs(translate.y)>(l2/2+.5)&&in!=2&&in!=3)translate([-translate.x,0])MKlon(tx=mkL) mirror([0,translate.y>0?1:0,0])square([line,abs(translate.y)-.5],false);
       if(abs(translate.x)>(l2/2+.5)&&(in==2||in==3))translate([0,-translate.y])MKlon(ty=mkL) mirror([translate.x>0?1:0,0,0])square([abs(translate.x)-.5,line],false);
       //if(translate.x) mirror([translate.x>0?1:0,0,0])T(l/2,-line/2)square([abs(translate.x),line],false);

  }// end Dimensioning


}// end Caliper


// display the module variables in a copyable format
module HelpTxt(titel,string,help){
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;

   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);

helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){
if(help)if(is_list(string))echo(

str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:""
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""


// ," name=",name,
," help);"));
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help
if(help&&!idx)if(is_list(string))echo(

str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}
//CombinedEnd from path ub.scad
//Combined from path constants.scad


fudgeFactor = 0.015;

//Connector array settings
iSettingsLength = 0;
iSettingsMeasurement = 1;
iSettingsDiameter = 2;
iSettingsWallThickness = 3;
iSettingsTaper = 4;
iSettingsVersion = 5;
//CombinedEnd from path constants.scad
//Combined from path modules_utility.scad





// rotate as per a, v, but around point pt
module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();
}

// takes part of an array
function getRunningTextWidth(charsMetrics,position=0,end) = //= [for (i = [start:end]) list[i]];
  assert(is_list(charsMetrics), "charsMetricsmust be a list")
  assert(is_num(position), str("position must be a number", "provided '", position, "'"))
  assert(is_num(end), str("end must be a number", "provided '", end, "'"))
  position < end
    ? charsMetrics[position].size.y + getRunningTextWidth(charsMetrics, position + 1, end)
    : charsMetrics[position].size.y;

function subStr(s,length=5) =
  assert(is_string(s), "s must be a string")
  assert(is_num(length), "length must be a number")
  str(chr([for(i=[0 :min(length,len(s))-1])ord(s[i])]));

module RoundText(
  textvalue = "",
  font = "Liberation:style=Bold",
  fontSize = 6.5,
  radius = 20,
  textExtrude = 1,
  forceRound = false,
  center = true,
  $fn=64)
{
  _radius = forceRound ? radius - textExtrude : radius;
  charsCount = len(textvalue);
  charsMetrics = [for(i=[0:1:charsCount-1]) textmetrics(text=str(textvalue[i]),size=fontSize,font=font)];


  offsetAngle = center ? textmetrics(text=textvalue,size=fontSize,font=font).size.x/2 : 0;

  // takes part of an array
  rotate([0,0,-offsetAngle*180/(PI*_radius)])
  intersection(){
    union(){
      for(i=[0:1:charsCount-1]){
        char = textvalue[i];

        runningMetrix = textmetrics(text=subStr(textvalue, i+1),size=fontSize,font=font);
        runningLength = runningMetrix.size.x - charsMetrics[i].size.x/2;
        arcAngle=runningLength*180/(PI*_radius);
        rotate([0,0,arcAngle])
          translate( [_radius,0,0])
            rotate([90,0,90])
              linear_extrude(textExtrude * (forceRound ? 2:1))
                text(
                  textvalue[i],
                  //valign="center",
                  halign="center",
                  size=fontSize,
                  font=font);
        }
    }
    if(forceRound)
    {
      translate([0,0,-fontSize])
      difference(){
        cylinder(r=radius+textExtrude,h = fontSize*3,$fn=$fn);
        translate([0,0,-fudgeFactor])
        cylinder(r=radius,h = fontSize*3+fudgeFactor*2,$fn=$fn);
      }
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
//fn = overrides the #fn function for the corners
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0,
  fn = 64)
{
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];

  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = sideRadius > 0 ? sideRadius : cornerRadius;

  if(sideRadius < topRadius || sideRadius < bottomRadius)
  {
    echo("roundedCube", "Error, sideRadius must be >= than bottomRadius and topRadius", sideRadius=sideRadius, topRadius=topRadius, bottomRadius=bottomRadius);
  }

  positions=[
     [sideRadius                    ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)]
    ,[sideRadius                         ,max(size.y-sideRadius, sideRadius)]
    ];

  hull(){
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i])
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius,$fn=fn);
    }
  }
}


module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1);
      else
        cylinder(r=r,h=h-roundedr2);

      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2])
          roundedDisk(r,roundedr2,half=1);
      else
        translate([0,0,roundedr1])
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}

module roundedDisk(r,roundedr, half=0){
 hull(){
    translate([0,0,roundedr])
    rotate_extrude()
    translate([r-roundedr,0,0])
    difference(){
      circle(roundedr);
      //Remove inner half so we dont get error when r<roundedr*2
      translate([-roundedr*2,-roundedr,0])
      square(roundedr*2);

      if(half<0){
        //Remove top half
        translate([-roundedr,0,0])
        square(roundedr*2);
      }
      if(half>0){
        //Remove bottom half
        translate([-roundedr,-roundedr*2,0])
        square(roundedr*2);
      }
    }
  }
}
//CombinedEnd from path modules_utility.scad
//Combined from path modules_pipe.scad







//diameter1: Inner start diameter.
//diameter2: Inner end diameter.
//length: pipe length
//wallThickness1 Thickness of the walls at the start
//wallThickness2 Thickness of the walls at the end
//zPosition: Start Z position.

debug_pipe = false;

if(debug_pipe ){
Pipe(
    diameter1=100,
    diameter2=70,
    length=50,
    wallThickness = 2,
    Offset = [15,0]);
}
module Pipe(
    diameter,
    diameter1,
    diameter2,
    length,
    wallThickness,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    Offset = [0,0])
{
  diameter1 = is_undef(diameter) ? diameter1 : diameter;
  diameter2 = is_undef(diameter) ? diameter2 : diameter;
  wallThickness1 = is_undef(wallThickness) ? wallThickness1 : wallThickness;
  wallThickness2 = is_undef(wallThickness) ? wallThickness2 : wallThickness;

  //todo, add correction to ensure that the thickness of the walls never reduce to less than wallthickenss1 and wallThickness2
  //using wallThickness/2 is a sloppy approximation, really need to use trig to would out the correct value
  leadin = max(fudgeFactor, min(wallThickness1, wallThickness2, length)/2);

  //a = b × tan(α)
  //atan(a/b) = angle;

  startOuterLeadin = diameter1+wallThickness1*2 > diameter2+wallThickness2*2 ? leadin : fudgeFactor;
  startInnerLeadin = diameter1 > diameter2 ? fudgeFactor : leadin;
  endOuterLeadin = diameter2+wallThickness2*2> diameter1+wallThickness1*2 ? leadin : fudgeFactor;
  endInnerLeadin = diameter2 > diameter1 ? fudgeFactor : leadin;
  hasLeadinWallCorrection =
    startOuterLeadin != fudgeFactor ||
    startInnerLeadin != fudgeFactor ||
    endOuterLeadin != fudgeFactor ||
    endInnerLeadin != fudgeFactor;
  //echo("Pipe", hasLeadinWallCorrection=hasLeadinWallCorrection, startOuterLeadin=startOuterLeadin, startInnerLeadin=startInnerLeadin, endOuterLeadin=endOuterLeadin, endInnerLeadin=endInnerLeadin);
  difference ()
  {
    //outer cylinder
    translate([0,0,zPosition])
    hull()
    {
      if(Offset.x>0 || Offset.y>0 || hasLeadinWallCorrection) {
        //(diameter1 != diameter2 && diameter1+wallThickness1*2 != diameter2+wallThickness2*2)) {
        cylinder(h=startOuterLeadin, d=diameter1+wallThickness1*2);
        translate([Offset.x,Offset.y,length-endOuterLeadin])
          cylinder(h=endOuterLeadin, d=diameter2+wallThickness2*2);
      }
      else{
        cylinder(length,
          d1=diameter1+wallThickness1*2,
          d2=diameter2+wallThickness2*2);
      }
    }

    //Inner cylinder to remove
    translate([0,0,zPosition])
      union()
      {
      if(Offset.x > 0 || Offset.y>0 || hasLeadinWallCorrection) {
        //(diameter1 != diameter2 && diameter1+wallThickness1*2 != diameter2+wallThickness2*2)) {

        translate([0,0,-fudgeFactor])
        cylinder(startInnerLeadin+fudgeFactor*2, d=diameter1);

        translate([0,0,startInnerLeadin])
        hull() {
          cylinder(fudgeFactor, d=diameter1);
          translate([Offset.x,Offset.y,length-startInnerLeadin-endInnerLeadin])
            cylinder(fudgeFactor, d=diameter2);
        }
        translate([Offset.x,Offset.y,length-endInnerLeadin-fudgeFactor])
        cylinder(endInnerLeadin+fudgeFactor*2, d=diameter2);
      } else {
        // main removal
        cylinder(length, d1=diameter1, d2=diameter2);
      }
      // bottomtop glitch correction
      translate([0,0,-fudgeFactor])
        cylinder(fudgeFactor*2, d=diameter1);

      // top glitch correction
      translate([Offset.x,Offset.y,length-fudgeFactor])
        cylinder(fudgeFactor*2, d=diameter2);
    }
  }
}

module StraightPipe(
  diameter,
  length,
  wallThickness,
  zPosition = 0)
{
    Pipe (
        diameter1 = diameter,
        diameter2 = diameter,
        length = length,
        wallThickness1 = wallThickness,
        wallThickness2 = wallThickness,
        zPosition = zPosition);
}

module HalfConePipe(diameter, length, wallThickness1, wallThickness2, zPosition)
{
    Pipe (
        diameter1 = diameter,
        diameter2 = diameter,
        length = length,
        wallThickness1 = wallThickness1,
        wallThickness2 = wallThickness2,
        zPosition = zPosition);
}

module ConeRing(centerDiameter, length, wallThickness1, wallThickness2, zPosition)
{
    difference ()
    {
        //outer cylinder
        translate([0, 0, zPosition])
        cylinder(
            d1=centerDiameter+wallThickness1,
            d2=centerDiameter+wallThickness2,
            h=length);

        //Inner cylinder to remove
        translate([0, 0, zPosition-fudgeFactor])
        cylinder(
            d1=centerDiameter-wallThickness1,
            d2=centerDiameter-wallThickness2,
            h=length + 2*fudgeFactor);
    }
}

module BentPipeHull(
    inner1PipeRadius,
    inner2PipeRadius,
    inner3PipeRadius,
    end1WallThickness,
    end2WallThickness,
    end3WallThickness,
    pipeAngle = 0,
    zPosition=0,
    end2Count=1,
    end2Angle=0,
    lengthInHull=0,
    lengthOutHull=0,
    lengthOutHullCenter=0,
    edgeOffset = 0,
    addCenter = false,
    centerHeight= 0
)
{
  assert(is_num(inner1PipeRadius), "inner1PipeRadius must be a number");
  assert(is_num(inner2PipeRadius), "inner2PipeRadius must be a number");
  assert(is_num(inner3PipeRadius), "inner3PipeRadius must be a number");
  assert(is_num(end1WallThickness), "end1WallThickness must be a number");
  assert(is_num(end2WallThickness), "end2WallThickness must be a number");
  assert(is_num(end3WallThickness), "end3WallThickness must be a number");
  assert(is_num(pipeAngle), "pipeAngle must be a number");
  assert(is_num(zPosition), "zPosition must be a number");
  assert(is_num(end2Count), "end2Count must be a number");
  assert(is_num(lengthInHull), "lengthInHull must be a number");
  assert(is_num(lengthOutHull), "lengthOutHull must be a number");
  assert(is_num(edgeOffset), "edgeOffset must be a number");
  assert(is_bool(addCenter), "addCenter must be a boolean");
  assert(is_num(centerHeight), "centerHeight must be a number");

  outer1PipeRadius = inner1PipeRadius + end1WallThickness;
  outer2PipeRadius = inner2PipeRadius + end2WallThickness;
  outer3PipeRadius = inner3PipeRadius + end3WallThickness;
  //_edgeOffset = outer1PipeRadius - outer2PipeRadius - edgeOffset;
  _edgeOffset = edgeOffset;

  end1BaseHeight = end1WallThickness;
  end2BaseHeight = end2WallThickness;

  //echo("BentPipeHull", _edgeOffset = _edgeOffset, lengthInHull = lengthInHull, centerHeight=centerHeight, lengthOutHull=lengthOutHull, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, a= (cos(pipeAngle) * outer2PipeRadius*2));
  multRotationAngle = end2Angle > 0 ? end2Angle : 360/end2Count;

  difference(){
    //Outer shape
    union(){
      //The main body hull shape
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*multRotationAngle])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, lengthInHull])
          cylinder(r=outer2PipeRadius, h=end2WallThickness);
        }

        if(addCenter)
        {
          //end 2 center
          translate([0, 0, centerHeight-end3WallThickness])
          cylinder(r=outer3PipeRadius, h=end3WallThickness);
        }

        //end1
        cylinder(r=outer1PipeRadius, h=end1BaseHeight+fudgeFactor);
      }

      //Extentions tubes
      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        //echo("Outer shape", pipeAngle=pipeAngle, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, _edgeOffset=_edgeOffset, lengthInHull=lengthInHull, end2WallThickness=end2WallThickness );

        rotate([0,0,rotation*multRotationAngle])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, lengthInHull])
        cylinder(r=outer2PipeRadius, h=lengthOutHull+end2WallThickness+fudgeFactor);
      }

      if(addCenter)
      {
          translate([0, 0, centerHeight])
          cylinder(r=outer3PipeRadius, h=lengthOutHullCenter);
      }
    }

    //inner/negative shape
    union(){
      //The Inner Main body hull shape
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*multRotationAngle])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
          cylinder(r=inner2PipeRadius, h=end2WallThickness+fudgeFactor*2);
        }

        if(addCenter)
        {
        //End 2 center
          translate([0, 0, centerHeight-end3WallThickness-fudgeFactor])
          cylinder(r=inner3PipeRadius, h=end3WallThickness+fudgeFactor*2);
        }

        //End 1
        cylinder(r=inner1PipeRadius, h=end1BaseHeight+fudgeFactor*2);
      }

      //Extention tubes
      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        rotate([0,0,rotation*multRotationAngle])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
        cylinder(r=inner2PipeRadius, h=lengthOutHull+end2WallThickness*2+fudgeFactor*2);
      }

      if(addCenter)
      {
          translate([0, 0, centerHeight-fudgeFactor])
          cylinder(r=inner3PipeRadius, h=lengthOutHullCenter+fudgeFactor*2);
      }
    }

    //Clear start from clipping
    rotate([0, 0, pipeAngle])
    translate([0, 0, -fudgeFactor])
      cylinder(
          r=inner1PipeRadius,
          h=fudgeFactor*2);

  }
}

module BentPipe(
    bendRadius,
    innerPipeDiameter,
    wallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1,
    end2Angle=0
)
{
  outerPipeDiameter  = innerPipeDiameter + wallThickness * 2;

  baseSupportThickness = outerPipeDiameter/2 + baseThickness;
  baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
  baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
  baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

  //echo("BentPipe", bendRadius=bendRadius, innerPipeDiameter=innerPipeDiameter,wallThickness=wallThickness, pipeAngle=pipeAngle, zPosition=zPosition);
  //echo("BentPipe", baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);


  difference() {
    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){
        // printing base
        if (end2Count <= 1 && baseType != "none"){
          rotate([0,0,baseSupportAngle])
          translate([bendRadius,0,0])
          rotate([0,90,0])
          if (baseType == "rectangle")
            translate([0,0,baseSupportThickness*3/4]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness/2],center=true);
          else if (baseType == "oval")
            translate([0,0,baseSupportThickness/2])
            resize([baseSupportWidth,0,0])
            cylinder(h=baseSupportThickness/2,d=baseSupportLength);
        }

        rotate_extrude(angle=pipeAngle, convexity=10)
          translate([bendRadius, 0, 0])
          circle(d=outerPipeDiameter);
      }
    }

    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){

     rotate([0, 0, -1])
     rotate_extrude(angle=pipeAngle+2,convexity=10)
            translate([bendRadius, 0, 0])
            circle(d=innerPipeDiameter);

      //Clear start from clipping
      rotate([90, 0, pipeAngle])
      translate([bendRadius, 0, -baseSupportThickness])
      cylinder(
          d=innerPipeDiameter,
          h=baseSupportThickness);

    //Clear end of the pipe from clipping
    rotate([90, 0, 0])
      translate([bendRadius, 0, 0])
      cylinder(d=innerPipeDiameter, h=fudgeFactor*2);
    }}
  }
}

module TaperedBentPipe(
    bendRadius,
    end1InnerPipeDiameter,
    end2InnerPipeDiameter,
    end1WallThickness,
    end2WallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1
)
{
    assert(is_num(pipeAngle) &&  pipeAngle > 0, "pipeAngle must be greater than 0");
    //echo("TaperedBentPipe", bendRadius=bendRadius, end1InnerPipeDiameter=end1InnerPipeDiameter, end2InnerPipeDiameter=end2InnerPipeDiameter, end1WallThickness=end1WallThickness, end2WallThickness=end2WallThickness);

    outerPipeDiameter  = end1InnerPipeDiameter + end1WallThickness * 2;

    sizeStart = end1InnerPipeDiameter / 2 + end1WallThickness ;
    sizeEnd = end2InnerPipeDiameter / 2 + end2WallThickness ;

    //baseSupportThickness should be between the start and end, but wieghted to the thicker end.
    supportBaseValue = (max(sizeStart,sizeEnd)*2 + min(sizeStart,sizeEnd))/3;
    baseSupportThickness = supportBaseValue + baseThickness;
    baseSupportWidth =  baseWidth == 0 ? supportBaseValue *1.5 : baseWidth;
    baseSupportLength =  baseLength == 0 ? supportBaseValue * 2: baseLength;
    baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

    shapeOuter = shape_circle(sizeStart);
    shapeInner = shape_circle(sizeStart-end1WallThickness);

    //echo("TaperedBentPipe", baseSupportThickness=baseSupportThickness,  baseSupportAngle=baseSupportAngle,  baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);

    translate([0, 0, zPosition])
    difference(){
        difference(){

          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            translate([-bendRadius, 0, 0])
            rotate([90, 0, 0])
            union(){
              // printing base
              if (end2Count <= 1 && baseType != "none"){
                rotate([0,0,baseSupportAngle])
                translate([bendRadius,0,0])
                rotate([0,90,0])
                if (baseType == "rectangle")
                   translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
                else if (baseType == "oval")
                    resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
                }
                ring_extrude(shapeOuter, radius = bendRadius, angle = pipeAngle, scale = (sizeEnd/sizeStart           ));
              }
          }


          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            union(){
              translate([-bendRadius, 0, 0])
              rotate([90, 0, 0])
              ring_extrude(
                shapeInner,
                radius = bendRadius,
                angle = pipeAngle,
                scale = ((sizeEnd-end2WallThickness)/(sizeStart-end1WallThickness)));

              //Clear start from clipping
              translate([0, 0, -fudgeFactor])
              cylinder(
                  d=end1InnerPipeDiameter,
                  h=2*fudgeFactor);

              //Clear end of the pipe from clipping
              translate([-bendRadius+fudgeFactor, 0, 0])
              rotate([0, -pipeAngle, 0])
                  translate([bendRadius, 0, 0])
                  cylinder(
                      d=end2InnerPipeDiameter,
                      h=2*fudgeFactor);

          }
        }
      }
    }
  }

  /*
translate([0,0,25])
Stopper(
    diameter = 100,
    outer = true,
    totalLength = 20,
    taper1 = [10,10],
    taper2 = [5,5],
    wallThickness = 10,
    stopThickness = 20,
    marker = false);


Stopper(
    diameter = 100,
    outer = true,
    totalLength = 20,
    taper1 = 0.33,
    taper2 = 0.33,
    wallThickness = 10,
    stopThickness = 20,
    marker = false);
*/
//TODO This seems slow, esp when used for barbs
module Stopper(
    diameter,
    outer = true,
    totalLength,
    taper1,
    taper2,
    wallThickness,
    stopThickness,
    zPosition = 0,
    marker = false,
    help
)
{
  if(is_num(taper1)){ assert(taper1 >= 0 || taper1 <= 1, "taper1 should be between 0 to 1");}
  if(is_num(taper2)){ assert(taper2 >= 0 || taper2 <= 1, "taper1 should be between 0 to 1");}


  _diameter = outer ? diameter : diameter + wallThickness*2;
  markPos = (outer ? diameter+wallThickness : diameter-stopThickness*2)/2;

  taperLength1 = (is_list(taper1) ? taper1.y : totalLength * taper1);
  zoffset1 = wallThickness*taperLength1/stopThickness;
  length1= (zoffset1 + totalLength);
  taperWidth1 = is_list(taper1) ? taper1.x : length1 * stopThickness / taperLength1;

  taperLength2 = (is_list(taper2) ? taper2.y : totalLength * taper2);
  zoffset2 = wallThickness * taperLength2 / stopThickness;
  length2 = (zoffset2 + totalLength);
  taperWidth2 = is_list(taper2) ? taper2.x : length2 * stopThickness / taperLength2;

  translate([0,0,zPosition])
  union(){
    if(marker)
      translate([markPos,0,+stopThickness])
      sphere(d=stopThickness);
    intersection()
    {
      flat = totalLength - taperLength1 - taperLength2;
      StraightPipe (
        diameter = outer ? diameter : diameter-stopThickness*2,
        length = totalLength,
        wallThickness = wallThickness + stopThickness);

        //Bottom taper
        if(taperLength1 > 0)
        {
          //taperLength1 = totalLength * taper1;
          //zoffset1 = wallThickness*taperLength1/stopThickness;
          //length1= (zoffset1 + totalLength);
          //width1 = length1 * stopThickness / taperLength1;
          diameterstart1 = _diameter;
          diameterend1 = outer ? _diameter :_diameter - taperWidth1*2;
          Pipe (
            diameter1 = diameterstart1,
            diameter2 = diameterend1,
            length = length1,
            wallThickness1 = 0,
            wallThickness2 = taperWidth1,
            zPosition = -zoffset1);
        }

        //Top taper
        if(taperLength2 > 0)
        {
          //taperLength2 = totalLength * taper2;
          //zoffset2 = wallThickness * taperLength2 / stopThickness;
          //length2 = (zoffset2 + totalLength);
          //width2 = length2 * stopThickness / taperLength2;
          diameterstart2 = outer ? _diameter :_diameter - taperWidth2*2;
          diameterend2 = _diameter;
          Pipe (
            diameter1 = diameterstart2,
            diameter2 = diameterend2,
            length = length2,
            wallThickness1 = taperWidth2,
            wallThickness2 = 0);

        }
      }
   }

 HelpTxt("Stopper",[
    "diameter", diameter,
    "totalLength", totalLength,
    "taper1", taper1,
    "taper2", taper2,
    "wallThickness", wallThickness,
    "stopThickness", stopThickness,
    "zPosition", zPosition]
    ,help);
}
//CombinedEnd from path modules_pipe.scad
//Combined from path shape_circle.scad



/**
* shape_circle.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_circle.html
*
**/


function shape_circle(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        to = (is_undef(n) || n > _frags) ? _frags - 1: n - 1
    )
    [
        for(a = [each [0:to]] * step_a) 
        [radius * cos(a), radius * sin(a)]
    ];
//CombinedEnd from path shape_circle.scad
//Combined from path __frags.scad


function __frags(radius) = 
    $fn == 0 ?  
        max(min(360 / $fa, radius * 6.283185307179586 / $fs), 5) :
        max($fn, 3);
//CombinedEnd from path __frags.scad
//Combined from path ring_extrude.scad







/**
* ring_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ring_extrude.html
*
**/


module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "SOLID") {
    if(twist == 0 && scale == 1.0) {
        rotate_extrude(angle = angle) 
        translate([radius, 0, 0]) 
            polygon(shape_pts);
    } else {
        a_step = 360 / __frags(radius);

        angles = is_num(angle) ? [0, angle] : angle;

        m = floor(angles[0] / a_step) + 1;
        n = floor(angles[1] / a_step);

        leng = radius * cos(a_step / 2);

        begin_r = leng / cos((m - 0.5) * a_step - angles[0]);
        end_r =  leng / cos((n + 0.5) * a_step - angles[1]);

        angs = [
            [90, 0, angles[0]], 
            each [for(i = m; i <= n; i = i + 1) [90, 0, a_step * i]]
        ];

        pts = [
            __ra_to_xy(begin_r, angles[0]), 
            each [for(i = m; i <= n; i = i + 1) __ra_to_xy(radius, a_step * i)]
        ];

        is_angle_frag_end = angs[len(angs) - 1][2] == angles[1];
        
        all_angles = is_angle_frag_end ? 
            angs : [each angs, [90, 0, angles[1]]];
            
        all_points = is_angle_frag_end ? 
            pts : [each pts, __ra_to_xy(end_r, angles[1])];

        sections = cross_sections(shape_pts, all_points, all_angles, twist, scale);

        sweep(
            sections,
            triangles = triangles
        );

        // hook for testing
        test_ring_extrude(sections, angle);
    }
}

// Override it to test
module test_ring_extrude(sections, angle) {

}
//CombinedEnd from path ring_extrude.scad
//Combined from path __ra_to_xy.scad


function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];
//CombinedEnd from path __ra_to_xy.scad
//Combined from path cross_sections.scad





/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-cross_sections.html
*
**/


function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? [for(p = shape_pts) [each p, 1]] : [for(p = shape_pts) [each p, 0, 1]],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) [each p, 0]]
    )
    twist == 0 && scale == 1.0 ?
    [
        for(i = [0:len_path_pts_minus_one])
        let(transform_m = m_translation(pth_pts[i]) * m_rotation(angles[i]))
        [
            for(p = sh_pts) 
            let(transformed = transform_m * p)
            [transformed.x, transformed.y, transformed.z]
        ]
    ] :
    let(
        twist_step = twist / len_path_pts_minus_one,
        scale_step_vt = (is_num(scale) ? let(s = scale - 1) [s, s, 0] : ([each scale, 0] - [1, 1, 0])) / len_path_pts_minus_one,
        one_s = [1, 1, 1]
    )
    [
        for(i = [0:len_path_pts_minus_one])
        let(
            transform_m = m_translation(pth_pts[i]) * 
                          m_rotation(angles[i]) * 
                          m_rotation(twist_step * i) * 
                          m_scaling(scale_step_vt * i + one_s)
        )
        [
            for(p = sh_pts) 
            let(transformed = transform_m * p)
            [transformed.x, transformed.y, transformed.z]
        ]
    ];
//CombinedEnd from path cross_sections.scad
//Combined from path m_scaling.scad



/**
* m_scaling.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_scaling.html
*
**/


function m_scaling(s) = _m_scaling_impl(s);
//CombinedEnd from path m_scaling.scad
//Combined from path _m_scaling_impl.scad


function __m_scaling_to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : 
     leng == 2 ? [each s, 1] : [s.x, 1, 1];

function __m_scaling_to_scaling_vect(s) = is_num(s) ? [s, s, s] : __m_scaling_to_3_elems_scaling_vect(s);

SCALING_FINAL_ROW = [0, 0, 0, 1];
function _m_scaling_impl(s) = 
    let(v = __m_scaling_to_scaling_vect(s))
    [
        [v.x, 0, 0, 0],
        [0, v.y, 0, 0],
        [0, 0, v.z, 0],
        SCALING_FINAL_ROW
    ];
//CombinedEnd from path _m_scaling_impl.scad
//Combined from path m_translation.scad



/**
* m_translation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_translation.html
*
**/


function m_translation(v) = _m_translation_impl(v);
//CombinedEnd from path m_translation.scad
//Combined from path _m_translation_impl.scad


function _to_3_elems_translation_vect(v) =
     let(leng = len(v))
     leng == 3 ? v : 
     leng == 2 ? [each v, 0] : [v.x, 0, 0];

function _to_translation_vect(v) = is_num(v) ? [v, 0, 0] : _to_3_elems_translation_vect(v);

FINAL_ROW = [0, 0, 0, 1];
function _m_translation_impl(v) = 
    let(vt = _to_translation_vect(v))
    [ 
        [1, 0, 0, vt.x],
        [0, 1, 0, vt.y],
        [0, 0, 1, vt.z],
        FINAL_ROW
    ];
//CombinedEnd from path _m_translation_impl.scad
//Combined from path m_rotation.scad



/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_rotation.html
*
**/


function m_rotation(a, v) = _m_rotation_impl(a, v);
//CombinedEnd from path m_rotation.scad
//Combined from path _m_rotation_impl.scad




ROTATION_FINAL_ROW = [0, 0, 0, 1];
function __m_rotation_q_rotation(a, v) = 
    let(
        uv = v / norm(v),
        s = sin(a / 2) * uv,
        w = sin(a) * uv,

        xx = 2 * s.x ^ 2,
        yy = 2 * s.y ^ 2,
        zz = 2 * s.z ^ 2,

        xy = 2 * s.x * s.y,
        xz = 2 * s.x * s.z,
        yz = 2 * s.y * s.z
    )
    [
        [1 - yy - zz, xy - w.z, xz + w.y, 0],
        [xy + w.z, 1 - xx - zz, yz - w.x, 0],
        [xz - w.y, yz + w.x, 1 - xx - yy, 0],
        ROTATION_FINAL_ROW
    ];

function __m_rotation_xRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [1, 0, 0, 0],
        [0, c, -s, 0],
        [0, s, c, 0],
        ROTATION_FINAL_ROW
    ];

function __m_rotation_yRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, 0, s, 0],
        [0, 1, 0, 0],
        [-s, 0, c, 0],
        ROTATION_FINAL_ROW
    ];    

function __m_rotation_zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        ROTATION_FINAL_ROW
    ];    

function __m_rotation_xyz_rotation(a) =
    let(ang = __to_ang_vect(a))
    __m_rotation_zRotation(ang[2]) * __m_rotation_yRotation(ang[1]) * __m_rotation_xRotation(ang[0]);

function _m_rotation_impl(a, v) = 
    (a == 0 || a == [0, 0, 0] || a == [0] || a == [0, 0]) ? [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        ROTATION_FINAL_ROW
    ] : (is_undef(v) ? __m_rotation_xyz_rotation(a) : __m_rotation_q_rotation(a, v));
//CombinedEnd from path _m_rotation_impl.scad
//Combined from path __to_ang_vect.scad


function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : 
     leng == 2 ? [each a, 0] : [a.x, 0, 0];

function __to_ang_vect(a) = is_num(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);
//CombinedEnd from path __to_ang_vect.scad
//Combined from path sweep.scad



/**
* sweep.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html
*
**/


module sweep(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0]),
            range_j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect],
            range_i = [0:leng_pts_sect - 1]
        ) 
        concat(
            [
                for(j = range_j, i = range_i)
                let(i2 = j + (i + 1) % leng_pts_sect)
                [
                    j + i, 
                    i2, 
                    i2 + leng_pts_sect
                ]
            ],
            [
                for(j = range_j, i = range_i)
                let(ji = j + i)
                [
                    ji, 
                    j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                    ji + leng_pts_sect
                ]
            ]      
        );

    
    function the_same_after_twisting(f_sect, l_sect) =
        let(found = search([l_sect[0]], f_sect)[0], leng = len(l_sect))
        found != [] && 
        len([for(i = 0; l_sect[i] == f_sect[(found + i) % leng]; i = i + 1) undef]) == leng;

    function to_v_pts(sects) = [for(sect = sects) each sect];                   

    module solid_sections(sects) {
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = to_v_pts(sects);

        begin_end_the_same =
            first_sect == last_sect || the_same_after_twisting(first_sect, last_sect);

        if(begin_end_the_same) {
            f_idxes = side_indexes(sects);

            polyhedron(v_pts, f_idxes); 

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);
        } else {
            from = leng_pts_sect * (leng_sects - 1);
            f_idxes = [
                [each [leng_pts_sect - 1:-1:0]], 
                each side_indexes(sects), 
                [each [from:from + leng_pts_sect - 1]]
            ];
            
            polyhedron(v_pts, f_idxes);   

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            let(range = [begin_idx:end_idx])
            [for(sect = sects) [for(j = range) sect[j]]]; 

        range = [0:half_leng_sect - 1];
        function first_idxes() = 
            [
                for(i = range) 
                let(i3 = (i + 1) % half_leng_sect)
                [
                    i,
                    i + half_leng_v_pts,
                    i3 + half_leng_v_pts, 
                    i3
                ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i = range) 
                let(bi = begin_idx + i, i2 = begin_idx + (i + 1) % half_leng_sect)
                [
                    bi,
                    i2,
                    i2 + half_leng_v_pts,
                    bi + half_leng_v_pts
                ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [for(idxes = side_indexes(inner_sects, half_leng_v_pts)) reverse(idxes)];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        begin_end_the_same = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect)
           ); 

        v_pts = concat(to_v_pts(outer_sects), to_v_pts(inner_sects));

        if(begin_end_the_same) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);                     
        } else {
            f_idxes = concat(
                first_idxes(), 
                outer_idxes, 
                inner_idxes, 
                last_idxes(half_leng_v_pts - half_leng_sect)
            );
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);              
        }
    }
    
    module triangles_defined_sections() {
        faces = [
            [0, 1, 2], [3, 5, 4], 
            [1, 3, 4], [2, 1, 4], [2, 3, 0], 
            [0, 3, 1], [2, 4, 5], [2, 5, 3]
        ];
        module two_sections(section1, section2) {
            for(idx = triangles) {
                polyhedron(
                    concat(
                        [for(i = idx) section1[i]], 
                        [for(i = idx) section2[i]]
                    ),
                    faces
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_sweep_solid(points, faces, triangles) {

}
//CombinedEnd from path sweep.scad
//Combined from path reverse.scad


/**
* reverse.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-reverse.html
*
**/ 

function reverse(lt) = [for(i = len(lt) - 1; i > -1; i = i - 1) lt[i]];
//CombinedEnd from path reverse.scad
//Combined from path connectors.scad

















//CombinedEnd from path connectors.scad
//Combined from path connector_object.scad



iConnector=0;
iStyle=iConnector+1;
iWallThickness=iStyle+1;
iMeasurement=iWallThickness+1;
iDiameter=iMeasurement+1;
iLength=iDiameter+1;
iRotation=iLength+1;
iTaper=iRotation+1;
iEndCapDiameter=iTaper+1;
iEndCapThickness=iEndCapDiameter+1;
iEndCapGridSize=iEndCapThickness+1;
iEndCapGridWallThickness=iEndCapGridSize+1;
iStopThickness=iEndCapGridWallThickness+1;
iStopLength=iStopThickness+1;
iStopSymmetrical=iStopLength+1;
iBarbsCount=iStopSymmetrical+1;
iBarbsThickness=iBarbsCount+1;
iBarbsSymmetrical=iBarbsThickness+1;
iMagnetCount=iBarbsSymmetrical+1;
iMagnetDiameter=iMagnetCount+1;
iMagnetThickness=iMagnetDiameter+1;
iMagnetBorder=iMagnetThickness+1;
iMagnetZOffset=iMagnetBorder+1;
iMagnetFlangeThickness=iMagnetZOffset+1;
iMagnetTwistLockSize=iMagnetFlangeThickness+1;
iFlangeWidth=iMagnetTwistLockSize+1;
iFlangeThickness=iFlangeWidth+1;
iFlangeScrewPosition=iFlangeThickness+1;
iFlangeScrewBorder=iFlangeScrewPosition+1;
iFlangeScrewCount=iFlangeScrewBorder+1;
iFlangeScrewDiameter=iFlangeScrewCount+1;
iNozzleShape=iFlangeScrewDiameter+1;
iNozzleSize=iNozzleShape+1;
iNozzleTipWallThickness=iNozzleSize+1;
iNozzleRadius=iNozzleTipWallThickness+1;
iNozzleOffset=iNozzleRadius+1;
iNozzleChamferPercentage=iNozzleOffset+1;
iNozzleChamferAngle=iNozzleChamferPercentage+1;
iExtensionLength=iNozzleChamferAngle+1;
iExtensionGridSize=iExtensionLength+1;
iExtensionGridWallThickness=iExtensionGridSize+1;
iExtensionText=iExtensionGridWallThickness+1;
iExtensionTextSize=iExtensionText+1;
iAlignmentRing=iExtensionTextSize+1;

//end of user connector settings
iAlignmentDepth=iAlignmentRing+1;
iAlignmentUpperWidth=iAlignmentDepth+1;
iAlignmentLowerWidth=iAlignmentUpperWidth+1;
iAlignmentSideClearance=iAlignmentLowerWidth+1;
iAlignmentDepthClearance=iAlignmentSideClearance+1;
iAdapterColor=iAlignmentDepthClearance+1;
iInnerDiameter=iAdapterColor+1;
iInnerStartDiameter=iInnerDiameter+1;
iOuterStartDiameter=iInnerStartDiameter+1;
iInnerEndDiameter=iOuterStartDiameter+1;
iOuterEndDiameter=iInnerEndDiameter+1;

module echoConnector(name, end, help){
  assert(is_list(end), "end must be a list");
  HelpTxt(name,[
    "style", end[iStyle],
    "iWallThickness", end[iWallThickness],
    "iMeasurement", end[iMeasurement],
    "iDiameter", end[iDiameter],
    "iLength", end[iLength],
    "iRotation", end[iRotation],
    "iTaper", end[iTaper],
    "iEndCapDiameter", end[iEndCapDiameter],
    "iEndCapThickness", end[iEndCapThickness],
    "iEndCapGridSize", end[iEndCapGridSize],
    "iEndCapGridWallThickness", end[iEndCapGridWallThickness],
    "iStopThickness", end[iStopThickness],
    "iStopLength", end[iStopLength],
    "iStopSymmetrical", end[iStopSymmetrical],
    "iBarbsCount", end[iBarbsCount],
    "iBarbsThickness", end[iBarbsThickness],
    "iBarbsSymmetrical", end[iBarbsSymmetrical],
    "iMagnetCount", end[iMagnetCount],
    "iMagnetDiameter", end[iMagnetDiameter],
    "iMagnetThickness", end[iMagnetThickness],
    "iMagnetBorder", end[iMagnetBorder],
    "iMagnetZOffset", end[iMagnetZOffset],
    "iMagnetFlangeThickness", end[iMagnetFlangeThickness],
    "iMagnetTwistLockSize", end[iMagnetTwistLockSize],
    "iAlignmentRing", end[iAlignmentRing],
    "iAlignmentDepth", end[iAlignmentDepth],
    "iAlignmentUpperWidth", end[iAlignmentUpperWidth],
    "iAlignmentLowerWidth", end[iAlignmentLowerWidth],
    "iAlignmentSideClearance", end[iAlignmentSideClearance],
    "iAlignmentDepthClearance", end[iAlignmentDepthClearance],
    "iFlangeWidth", end[iFlangeWidth],
    "iFlangeThickness", end[iFlangeThickness],
    "iFlangeScrewPosition", end[iFlangeScrewPosition],
    "iFlangeScrewBorder", end[iFlangeScrewBorder],
    "iFlangeScrewCount", end[iFlangeScrewCount],
    "iFlangeScrewDiameter", end[iFlangeScrewDiameter],
    "iNozzleShape", end[iNozzleShape],
    "iNozzleSize", end[iNozzleSize],
    "iNozzleTipWallThickness", end[iNozzleTipWallThickness],
    "iNozzleRadius", end[iNozzleRadius],
    "iNozzleOffset", end[iNozzleOffset],
    "iNozzleChamferPercentage", end[iNozzleChamferPercentage],
    "iNozzleChamferAngle", end[iNozzleChamferAngle],
    "iExtensionLength", end[iExtensionLength],
    "iExtensionGridSize", end[iExtensionGridSize],
    "iExtensionGridWallThickness", end[iExtensionGridWallThickness],
    "iExtensionText", end[iExtensionText],
    "iExtensionTextSize", end[iExtensionTextSize],
    "iadapterColor", end[iAdapterColor],
    "iInnerDiameter", end[iInnerDiameter],
    "iInnerStartDiameter", end[iInnerStartDiameter],
    "iOuterStartDiameter", end[iOuterStartDiameter],
    "iInnerEndDiameter", end[iInnerEndDiameter],
    "iOuterEndDiameter", end[iOuterEndDiameter]
    ] ,help);
  }

function getConnector3Setting(transitionHullCenter, con1, con2, con3) =
  transitionHullCenter == "end1" ? con1
  : transitionHullCenter == "end2" ? con2
  : con3;

 i_measurement_inch = 1;
 i_measurement_mm = 0;

//input can be number of mm or [mm, inch], mm is deafault inch overrides mm.
function measurement_to_mm(input) =
  assert(is_num(input) || (is_list(input) && len(input) == 2), "input must be number or list of length 2 ")
  is_num(input)
    ? input
    : is_num(input[i_measurement_inch]) && input[i_measurement_inch] > 0 ? input[i_measurement_inch] * 25.4 : input[i_measurement_mm];


function UserConnectorSettings(
  connector,
  style="hose",
  wallThickness=2,
  measurement = "outer",
  diameter = [100,0],
  length = [40,0],
  rotation= 0,
  taper = 1,
  endCapDiameter = 0,
  endCapThickness = 0,
  endCapGridSize = 0,
  endCapGridWallThickness = 0,
  stopThickness = 0,
  stopLength = 0,
  stopSymmetrical = false,
  barbsCount = 0,
  barbsThickness = 0,
  barbsSymmetrical = false,
  magnetCount = 0,
  magnetDiameter = 0,
  magnetThickness = 0,
  magnetBorder = 2,
  magnetZOffset = 0,
  magnetFlangeThickness = 6,
  magnetTwistLockSize = "0",
  alignmentRing = "no",
  flangeWidth = 20,
  flangeThickness = 5,
  flangeScrewPosition = 0,
  flangeScrewBorder = 0,
  flangeScrewCount = 4,
  flangeScrewDiameter = 5,
  nozzleShape = "square",
  nozzleSize = [10,5,10],
  nozzleTipWallThickness = 0,
  nozzleRadius = 0,
  nozzleOffset = [0,0],
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0,
  extensionLength = 0,
  extensionGridSize = 0,
  extensionGridWallThickness = 0,
  extensionText = "",
  extensionTextSize = 0
  ) =
  let(result = [
    connector,
    style,
    wallThickness,
    measurement,
    diameter,
    length,
    rotation,
    taper,
    endCapDiameter,
    endCapThickness,
    endCapGridSize,
    endCapGridWallThickness,
    stopThickness,
    stopLength,
    stopSymmetrical,
    barbsCount,
    barbsThickness,
    barbsSymmetrical,
    magnetCount,
    magnetDiameter,
    magnetThickness,
    magnetBorder,
    magnetZOffset,
    magnetFlangeThickness,
    magnetTwistLockSize,
    flangeWidth,
    flangeThickness,
    flangeScrewPosition,
    flangeScrewBorder,
    flangeScrewCount,
    flangeScrewDiameter,
    nozzleShape,
    nozzleSize,
    nozzleTipWallThickness,
    nozzleRadius,
    nozzleOffset,
    nozzleChamferPercentage,
    nozzleChamferAngle,
    extensionLength,
    extensionGridSize,
    extensionGridWallThickness,
    extensionText,
    extensionTextSize,
    alignmentRing])
    ValidateUserConnectorSettings(result);

function ValidateUserConnectorSettings(userSettings) =
  // Parameter validation asserts
  assert(is_num(userSettings[iConnector]) && userSettings[iConnector] >= 0, str("connector must be a non-negative number:", userSettings[iConnector]))
  assert(is_string(userSettings[iStyle]), str("style must be a string:", userSettings[iStyle]))
  //assert(userSettings[iStyle] == "hose" || userSettings[iStyle] == "mag" || userSettings[iStyle] == "flange" || userSettings[iStyle] == "nozzle", "style must be 'hose', 'mag', 'flange', or 'nozzle'")
  assert(is_num(userSettings[iWallThickness]) && userSettings[iWallThickness] >= 0, str("wallThickness must be a non-negative number:", userSettings[iWallThickness]))
  assert(is_string(userSettings[iMeasurement]), str("measurement must be a string:", userSettings[iMeasurement]))
  assert(userSettings[iMeasurement] == "inner" || userSettings[iMeasurement] == "outer", str("measurement must be 'inner' or 'outer':", userSettings[iMeasurement]))
  assert(is_num(userSettings[iDiameter]) || (is_list(userSettings[iDiameter]) && len(userSettings[iDiameter]) == 2), str("diameter must be a number or list of length 2:", userSettings[iDiameter]))
  assert(is_num(userSettings[iLength]) || (is_list(userSettings[iLength]) && len(userSettings[iLength]) == 2), str("length must be a number or list of length 2:", userSettings[iLength]))
  assert(is_num(userSettings[iRotation]), str("rotation must be a number:", userSettings[iRotation]))
  assert(is_num(userSettings[iTaper]), str("taper must be a number:", userSettings[iTaper]))
  assert(is_num(userSettings[iEndCapDiameter]) && userSettings[iEndCapDiameter] >= 0, str("endCapDiameter must be a non-negative number:", userSettings[iEndCapDiameter]))
  assert(is_num(userSettings[iEndCapThickness]) && userSettings[iEndCapThickness] >= 0, str("endCapThickness must be a non-negative number:", userSettings[iEndCapThickness]))
  assert(is_num(userSettings[iEndCapGridSize]) && userSettings[iEndCapGridSize] >= 0, str("endCapGridSize must be a non-negative number:", userSettings[iEndCapGridSize]))
  assert(is_num(userSettings[iEndCapGridWallThickness]) && userSettings[iEndCapGridWallThickness] >= 0, str("endCapGridWallThickness must be a non-negative number:", userSettings[iEndCapGridWallThickness]))
  assert(is_num(userSettings[iStopThickness]) && userSettings[iStopThickness] >= 0, str("stopThickness must be a non-negative number:", userSettings[iStopThickness]))
  assert(is_num(userSettings[iStopLength]) && userSettings[iStopLength] >= 0, str("stopLength must be a non-negative number:", userSettings[iStopLength]))
  assert(is_bool(userSettings[iStopSymmetrical]), str("stopSymmetrical must be a boolean:", userSettings[iStopSymmetrical]))
  assert(is_num(userSettings[iBarbsCount]) && userSettings[iBarbsCount] >= 0, str("barbsCount must be a non-negative number:", userSettings[iBarbsCount]))
  assert(is_num(userSettings[iBarbsThickness]) && userSettings[iBarbsThickness] >= 0, str("barbsThickness must be a non-negative number:", userSettings[iBarbsThickness]))
  assert(is_bool(userSettings[iBarbsSymmetrical]), str("barbsSymmetrical must be a boolean:", userSettings[iBarbsSymmetrical]))
  assert(is_num(userSettings[iMagnetCount]) && userSettings[iMagnetCount] >= 0, str("magnetCount must be a non-negative number:", userSettings[iMagnetCount]))
  assert(is_num(userSettings[iMagnetDiameter]) && userSettings[iMagnetDiameter] >= 0, str("magnetDiameter must be a non-negative number:", userSettings[iMagnetDiameter]))
  assert(is_num(userSettings[iMagnetThickness]) && userSettings[iMagnetThickness] >= 0, str("magnetThickness must be a non-negative number:", userSettings[iMagnetThickness]))
  assert(is_num(userSettings[iMagnetBorder]) && userSettings[iMagnetBorder] >= 0, str("magnetBorder must be a non-negative number:", userSettings[iMagnetBorder]))
  assert(is_num(userSettings[iMagnetZOffset]), str("magnetZOffset must be a number:", userSettings[iMagnetZOffset]))
  assert(is_num(userSettings[iMagnetFlangeThickness]) && userSettings[iMagnetFlangeThickness] >= 0, str("magnetFlangeThickness must be a non-negative number:", userSettings[iMagnetFlangeThickness]))
  assert(is_string(userSettings[iMagnetTwistLockSize]), str("magnetTwistLockSize must be a string:", userSettings[iMagnetTwistLockSize]))
  assert(is_string(userSettings[iAlignmentRing]), str("alignmentRing must be a string:", userSettings[iAlignmentRing]))
  assert(userSettings[iAlignmentRing] == "no" || userSettings[iAlignmentRing] == "inner" || userSettings[iAlignmentRing] == "outer", str("alignmentRing must be 'no', 'inner', or 'outer':", userSettings[iAlignmentRing]))
  assert(is_num(userSettings[iFlangeWidth]) && userSettings[iFlangeWidth] >= 0, str("flangeWidth must be a non-negative number:", userSettings[iFlangeWidth]))
  assert(is_num(userSettings[iFlangeThickness]) && userSettings[iFlangeThickness] >= 0, str("flangeThickness must be a non-negative number:", userSettings[iFlangeThickness]))
  assert(is_num(userSettings[iFlangeScrewPosition]) && userSettings[iFlangeScrewPosition] >= 0, str("flangeScrewPosition must be a non-negative number:", userSettings[iFlangeScrewPosition]))
  assert(is_num(userSettings[iFlangeScrewBorder]) && userSettings[iFlangeScrewBorder] >= 0, str("flangeScrewBorder must be a non-negative number:", userSettings[iFlangeScrewBorder]))
  assert(is_num(userSettings[iFlangeScrewCount]) && userSettings[iFlangeScrewCount] >= 0, str("flangeScrewCount must be a non-negative number:", userSettings[iFlangeScrewCount]))
  assert(is_num(userSettings[iFlangeScrewDiameter]) && userSettings[iFlangeScrewDiameter] >= 0, str("flangeScrewDiameter must be a non-negative number:", userSettings[iFlangeScrewDiameter]))
  assert(is_string(userSettings[iNozzleShape]), str("nozzleShape must be a string:", userSettings[iNozzleShape]))
  assert(userSettings[iNozzleShape] == "square" || userSettings[iNozzleShape] == "circle", str("nozzleShape must be 'square', or 'oval':", userSettings[iNozzleShape]))
  assert(is_list(userSettings[iNozzleSize]) && len(userSettings[iNozzleSize]) == 3, str("nozzleSize must be a list of length 3:", userSettings[iNozzleSize]))
  assert(is_num(userSettings[iNozzleTipWallThickness]) && userSettings[iNozzleTipWallThickness] >= 0, str("nozzleTipWallThickness must be a non-negative number:", userSettings[iNozzleTipWallThickness]))
  assert(is_num(userSettings[iNozzleRadius]) && userSettings[iNozzleRadius] >= 0, str("nozzleRadius must be a non-negative number:", userSettings[iNozzleRadius]))
  assert(is_list(userSettings[iNozzleOffset]) && len(userSettings[iNozzleOffset]) == 2, str("nozzleOffset must be a list of length 2:", userSettings[iNozzleOffset]))
  assert(is_num(userSettings[iNozzleChamferPercentage]) && userSettings[iNozzleChamferPercentage] >= 0 && userSettings[iNozzleChamferPercentage] <= 100, str("nozzleChamferPercentage must be between 0 and 100:", userSettings[iNozzleChamferPercentage]))
  assert(is_num(userSettings[iNozzleChamferAngle]) && userSettings[iNozzleChamferAngle] >= 0 && userSettings[iNozzleChamferAngle] <= 90, str("nozzleChamferAngle must be between 0 and 90 degrees:", userSettings[iNozzleChamferAngle]))
  assert(is_num(userSettings[iExtensionLength]) && userSettings[iExtensionLength] >= 0, str("extensionLength must be a non-negative number:", userSettings[iExtensionLength]))
  assert(is_num(userSettings[iExtensionGridSize]) && userSettings[iExtensionGridSize] >= 0, str("extensionGridSize must be a non-negative number:", userSettings[iExtensionGridSize]))
  assert(is_num(userSettings[iExtensionGridWallThickness]) && userSettings[iExtensionGridWallThickness] >= 0, str("extensionGridWallThickness must be a non-negative number:", userSettings[iExtensionGridWallThickness]))
  assert(is_string(userSettings[iExtensionText]), str("extensionText must be a string:", userSettings[iExtensionText]))
  assert(is_num(userSettings[iExtensionTextSize]) && userSettings[iExtensionTextSize] >= 0, str("extensionTextSize must be a non-negative number:", userSettings[iExtensionTextSize]))
  userSettings;

function ValidateConnectorSettings(userSettings) =
  assert(is_num(userSettings[iAlignmentDepth]) && userSettings[iAlignmentDepth] >= 0, str("alignmentDepth must be a non-negative number:", userSettings[iAlignmentDepth]))
  assert(is_num(userSettings[iAlignmentUpperWidth]) && userSettings[iAlignmentUpperWidth] >= 0, str("alignmentUpperWidth must be a non-negative number:", userSettings[iAlignmentUpperWidth]))
  assert(is_num(userSettings[iAlignmentLowerWidth]) && userSettings[iAlignmentLowerWidth] >= 0, str("alignmentLowerWidth must be a non-negative number:", userSettings[iAlignmentLowerWidth]))
  assert(is_num(userSettings[iAlignmentSideClearance]) && userSettings[iAlignmentSideClearance] >= 0, str("alignmentSideClearance must be a non-negative number:", userSettings[iAlignmentSideClearance]))
  assert(is_list(userSettings[iAdapterColor]), str("adapterColor must be a list:", userSettings[iAdapterColor]))
  assert(is_num(userSettings[iInnerDiameter]) && userSettings[iInnerDiameter] >= 0, str("innerDiameter must be a non-negative number:", userSettings[iInnerDiameter]))
  assert(is_num(userSettings[iInnerStartDiameter]) && userSettings[iInnerStartDiameter] >= 0, str("innerStartDiameter must be a non-negative number:", userSettings[iInnerStartDiameter]))
  assert(is_num(userSettings[iInnerEndDiameter]) && userSettings[iInnerEndDiameter] >= 0, str("innerEndDiameter must be a non-negative number:", userSettings[iInnerEndDiameter]))
  assert(is_num(userSettings[iOuterStartDiameter]) && userSettings[iOuterStartDiameter] >= 0, str("outerStartDiameter must be a non-negative number:", userSettings[iOuterStartDiameter]))
  assert(is_num(userSettings[iOuterEndDiameter]) && userSettings[iOuterEndDiameter] >= 0, str("outerEndDiameter must be a non-negative number:", userSettings[iOuterEndDiameter]))
  ValidateUserConnectorSettings(userSettings);

function getConnectorSettings(
  userSettings = [],
  alignmentDepth,
  alignmentUpperWidth,
  alignmentLowerWidth,
  alignmentSideClearance,
  alignmentDepthClearance,
  adapterColor,
  con1OuterEndDiameter,
  con1Measurement,
  con1WallThickness) =
  let(
    style = userSettings[iStyle],
    measurement = userSettings[iMeasurement],
    diameter = userSettings[iDiameter],
    length = userSettings[iLength],
    taper = userSettings[iTaper],
    wallThickness = userSettings[iWallThickness],
    stopThickness = userSettings[iStopThickness],
    stopLength = userSettings[iStopLength],

    _diameter = measurement_to_mm(diameter),
    _length = measurement_to_mm(length),
    //For nozzle, if the diameter is 0, then set it to the D1, this will look nice.
    conMeasurement = let(
      m = retriveConnectorSetting(style, iSettingsMeasurement, measurement),
      d = retriveConnectorSetting(style, iSettingsDiameter, _diameter))
        (style == "nozzle" && d == 0) ? "outer" : m,
    conDiameter = let(d = retriveConnectorSetting(style, iSettingsDiameter, _diameter))
      (style == "nozzle" && d == 0) ? con1OuterEndDiameter : d,
    conWallThickness = let(w = retriveConnectorSetting(style, iSettingsWallThickness, wallThickness))
      (style == "nozzle" && w == 0) ? con1WallThickness : w,
    conLength = retriveConnectorSetting(style, iSettingsLength, _length),
    conTaper = let(t = (style == "nozzle") ? 0 : retriveConnectorSetting(style, iSettingsTaper, taper)) conMeasurement == "inner" ? t*-1 : t,
    conInnerDiameter = conMeasurement == "inner" ? conDiameter : conDiameter - conWallThickness * 2,
    conInnerStartDiameter = conInnerDiameter - conTaper / 2,
    conOuterStartDiameter = conInnerStartDiameter + conWallThickness*2,
    conInnerEndDiameter = conInnerDiameter + conTaper / 2,
    conOuterEndDiameter = conInnerEndDiameter + conWallThickness*2,
    //If the connector hose is not showm the stop has no thickenss
    conStopThickness = (conLength <= 0 || style == "mag" || style == "flange") ? 0 : stopThickness,
    //If the stop has no thickness, it needs no length
    conStopLength = (conStopThickness > 0 && style == "hose") ? stopLength : 0
    ) let (
      result = [
        userSettings[iConnector],
        style,
        userSettings[iWallThickness],
        measurement,
        diameter,
        conLength,
        userSettings[iRotation],
        conTaper,
        userSettings[iEndCapDiameter],
        userSettings[iEndCapThickness],
        userSettings[iEndCapGridSize],
        userSettings[iEndCapGridWallThickness],
        userSettings[iStopThickness],
        userSettings[iStopLength],
        userSettings[iStopSymmetrical],
        userSettings[iBarbsCount],
        userSettings[iBarbsThickness],
        userSettings[iBarbsSymmetrical],
        userSettings[iMagnetCount],
        userSettings[iMagnetDiameter],
        userSettings[iMagnetThickness],
        userSettings[iMagnetBorder],
        userSettings[iMagnetZOffset],
        userSettings[iMagnetFlangeThickness],
        userSettings[iMagnetTwistLockSize],
        userSettings[iFlangeWidth],
        userSettings[iFlangeThickness],
        userSettings[iFlangeScrewPosition],
        userSettings[iFlangeScrewBorder],
        userSettings[iFlangeScrewCount],
        userSettings[iFlangeScrewDiameter],
        userSettings[iNozzleShape],
        userSettings[iNozzleSize],
        userSettings[iNozzleTipWallThickness],
        userSettings[iNozzleRadius],
        userSettings[iNozzleOffset],
        userSettings[iNozzleChamferPercentage],
        userSettings[iNozzleChamferAngle],
        userSettings[iExtensionLength],
        userSettings[iExtensionGridSize],
        userSettings[iExtensionGridWallThickness],
        userSettings[iExtensionText],
        userSettings[iExtensionTextSize],
        userSettings[iAlignmentRing],

        //End of user settings
        alignmentDepth,
        alignmentUpperWidth,
        alignmentLowerWidth,
        alignmentSideClearance,
        alignmentDepthClearance,
        adapterColor,
        conInnerDiameter,
        conInnerStartDiameter,
        conOuterStartDiameter,
        conInnerEndDiameter,
        conOuterEndDiameter,
        conStopThickness,
        conStopLength
        ])
        ValidateConnectorSettings(result);
//CombinedEnd from path connector_object.scad
//Combined from path connector_common.scad


function lookupKey(dictionary, key, default=undef) = let(results = [
  for (record = dictionary)
  if (record[0] == key)
  record
]) is_undef(results) || !is_list(results)
  ? default
  : results[0][1];

function retriveConnectorConfig(connector, default = undef) = lookupKey(connectorSettings,connector,default);
function retriveConnectorSetting(connector, iSetting, default = -1) = let(
  config = retriveConnectorConfig(connector),
  settingValue = config == undef ? default
    : lookupKey(config, iSetting, default=default)
  )
   settingValue == undef
    ? default
    : settingValue;
//CombinedEnd from path connector_common.scad
//Combined from path connector_hose.scad











module HoseConnector(
    innerStartDiameter,
    innerEndDiameter,
    connectorMeasurement,
    length,
    wallThickness,
    stopLength = 0,
    stopWidth = 0,
    stopSymmetrical = false,
    barbsCount = 0,
    barbsThickness = 0,
    barbsSymmetrical = false,
    endCapDiameter = 0,
    endCapThickness = 0,
    endCapGridSize = 0,
    endCapGridWallThickness = 0,
    chamferLength = 0,
    chamferWidth = 0,
    help
)
{
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, "innerEndDiameter must be a number greater than 0");
  assert(is_num(innerStartDiameter) && innerStartDiameter > 0, "innerStartDiameter must be a number greater than 0");
  _barbsThickness = barbsThickness == 0 ? wallThickness/2 : barbsThickness;
  barbLength = length/(barbsCount*2+1);
  union() {
    difference ()
    {
      //outer cylinder
      translate([0,0,0])
      hull()
      {
        cylinder(fudgeFactor, d=innerStartDiameter+2*wallThickness);
        translate([0,0,length-fudgeFactor])
          cylinder(fudgeFactor, d=innerEndDiameter+2*wallThickness);
      }

      //Inner cylinder to remove
      translate([0,0,0-fudgeFactor])
      hull()
      {
        cylinder(fudgeFactor, d=innerStartDiameter);
        translate([0,0,length+2*fudgeFactor])
          cylinder(fudgeFactor, d=innerEndDiameter);
      }
      if(chamferLength >0)
      {
        Pipe (
          diameter1 = connectorMeasurement == "outer" ?
            innerStartDiameter + wallThickness*2 - chamferWidth*2 :
            innerStartDiameter - chamferWidth*2,
          diameter2 = connectorMeasurement == "outer" ?
            innerStartDiameter + wallThickness*2 + chamferWidth*2 :
            innerStartDiameter - chamferWidth*2,
          length = chamferLength*2,
          wallThickness1 = chamferWidth*2,
          wallThickness2 = 0,
          zPosition = -fudgeFactor);
      }
    }

    //barbs
    if(barbsCount > 0)
    {
      for (i = [0: barbsCount-1]) {
          translate([0,0,length/(barbsCount*2+1)*(i*2+1)])
          Stopper(
            diameter = connectorMeasurement == "outer" ? innerStartDiameter+wallThickness : innerStartDiameter,
            outer = connectorMeasurement == "outer",
            totalLength = barbLength,
            taper1 = barbsSymmetrical ? 0.4 : 1,
            taper2 = barbsSymmetrical ? 0.4 : 0,
            wallThickness = wallThickness/2,
            stopThickness = _barbsThickness);
      }
    }

    // Create the end cap
    if(endCapThickness > 0)
    {
      difference ()
      {
        //Main endcap
        cylinder(endCapThickness, d=innerStartDiameter + wallThickness/2);

        //endcap grid
        if(endCapGridSize>0)
        intersection(){
          hexwalls = endCapGridWallThickness == 0 ? wallThickness :    endCapGridWallThickness;
          gridspacing = (endCapGridSize*(sqrt(3)/2))*2 +hexwalls;
          gridsize = ceil(innerEndDiameter*1.4/gridspacing);
          innergridDiameter = endCapDiameter > 0 ? endCapDiameter+wallThickness*2 : 0;

          StraightPipe(
            diameter=innergridDiameter,
            length=endCapThickness+fudgeFactor*2,
            wallThickness = (innerEndDiameter-(innergridDiameter))/2,
            zPosition = -fudgeFactor);

          translate([0,0,-fudgeFactor])
            HexGrid([gridsize,gridsize],gridspacing)
            cylinder(r=endCapGridSize, h=endCapThickness+fudgeFactor*4, $fn=6);
        }
        if(endCapDiameter > 0)
          //Endcap center hole
          translate([0,0,-fudgeFactor])
            cylinder(endCapThickness + fudgeFactor * 2, d=endCapDiameter);
      }
    }

    // Create the hose stop
    if(stopWidth > 0 && stopLength > 0)
    {
      translate([0,0,-fudgeFactor])
      Stopper(
        diameter = innerEndDiameter,
        outer = innerStartDiameter <= innerEndDiameter,
        totalLength = stopLength+fudgeFactor*2,
        taper1 = stopSymmetrical ? 0.4 : 0.5,
        taper2 = stopSymmetrical ? 0.4 : 0,
        wallThickness = wallThickness,
        stopThickness = stopWidth,
        zPosition = length,
        marker = false,
        help = help);
    }
  }

   HelpTxt("HoseConnector",[
    "connectorMeasurement", connectorMeasurement,
    "innerStartDiameter", innerStartDiameter,
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "stopLength", stopLength,
    "stopWidth", stopWidth,
    "stopSymmetrical", stopSymmetrical,
    "barbsCount", barbsCount,
    "barbsThickness", barbsThickness,
    "barbsSymmetrical", barbsSymmetrical,
    "endCapDiameter", endCapDiameter,
    "endCapThickness", endCapThickness,
    "endCapGridSize", endCapGridSize,
    "endCapGridWallThickness", endCapGridWallThickness,
    "chamferLength", chamferLength,
    "chamferWidth", chamferWidth
    ],help);
}
//CombinedEnd from path connector_hose.scad
//Combined from path connector_flange.scad





module FlangeConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    flangeThickness,
    flangeWidth,
    screwPosition,
    screwBorder,
    screwCount,
    screwDiameter,
    help
)
{
  assert(is_num(flangeThickness), "flangeThickness should be a number");
  assert(is_num(screwBorder), "screwBorder should be a number");
  assert(is_num(screwCount), "screwCount should be a number");
  assert(is_num(screwDiameter), "screwDiameter should be a number");

  //The fillet around the edge
  fillet = flangeThickness;
  border = screwBorder == 0 ? flangeWidth/4 : screwBorder;
  flangeOuterDiameter = innerStartDiameter + flangeWidth;
  screwPositionRadius = screwPosition != 0
    ? innerStartDiameter/2 + screwDiameter/2 + screwPosition/2
    : (innerStartDiameter/2 + fillet + (flangeWidth/2-fillet)/2);

  echo("FlangeConnector", screwCount=screwCount, screwDiameter=screwDiameter, screwPosition=screwPosition, border=border);
  echo("FlangeConnector", screwPositionRadius=screwPositionRadius, fillet=fillet, flangeOuterDiameter=flangeOuterDiameter, innerStartDiameter=innerStartDiameter, flangeWidth=flangeWidth);

  difference ()
  {
    //flange
    union() {
      Pipe (
        diameter1 = innerStartDiameter,
        diameter2 = innerEndDiameter,
        length = length,
        wallThickness1 = wallThickness,
        wallThickness2 = wallThickness);

      // flange aound the screws
      hull () {
        cylinder (d = flangeOuterDiameter, flangeThickness);

        for (i = [0: screwCount-1]) {
            // The rotation should try to avoid the screw being under the bent hose.
            rotate ([fudgeFactor, 0, 180/screwCount * (i * 2 - 1 + screwCount)])
            translate ([screwPositionRadius, 0, 0])
            cylinder (d = screwDiameter + border*2, h = flangeThickness);
        }
      }

      // taper
      intersection()
      {
        HalfConePipe (
            diameter = innerEndDiameter,
            length = fillet,
            wallThickness1 = fillet - fudgeFactor,
            wallThickness2 = 0,
            zPosition= flangeThickness - fudgeFactor);

        translate([0, 0, 0])
        {
            // limit fillet to length
            cylinder(
                d=innerEndDiameter*2,
                h=length);
        }
      }
    }

    //Screw cut out
    for (i = [0: screwCount-1]) {
        // The rotation should try to avoid the screw being under the bent hose.
        rotate ([fudgeFactor, 0, 180/screwCount * (i * 2 - 1 + screwCount)])
        translate ([screwPositionRadius, 0, - fudgeFactor*2])
        cylinder (d = screwDiameter, h = flangeThickness + length + fudgeFactor*4);
    }

    //Flange inner
    translate([0, 0, -fudgeFactor])
        cylinder (
            d1 = innerStartDiameter,
            d2 = innerEndDiameter,
            h = length + 2 * fudgeFactor*2);
  }

  HelpTxt("FlangeConnector",[
    "innerStartDiameter", innerStartDiameter,
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "flangeThickness", flangeThickness,
    "flangeWidth", flangeWidth,
    "screwPosition", screwPosition,
    "screwBorder", screwBorder,
    "screwCount", screwCount,
    "screwDiameter", screwDiameter,
    "border", border,
    "flangeOuterDiameter", flangeOuterDiameter,
    "screwPositionRadius", screwPositionRadius
    ],help);
}
//CombinedEnd from path connector_flange.scad
//Combined from path connector_magnetic.scad








module MagneticConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    magnetDiameter,
    magnetThickness,
    magnetBorder,
    magnetZOffset,
    flangeThickness,
    magnetCount,
    alignmentRing,
    alignmentDepth,
    alignmentUpperWidth,
    alignmentLowerWidth,
    alignmentSideClearance,
    alignmentDepthClearance,
    twistLockSize,
)
{
  //These sizes need to be tested.
  //head, outer thread for slot, thread hole size
  lockingSize =
    twistLockSize == "3" ? [5.5+0.3,3,2.5] //m3
    : twistLockSize == "3cnc" ? [5.5+0.3,3,4] //m3
    : twistLockSize == "4" ? [7+0.3,4,3.3] //m4
    : twistLockSize == "4cnc" ? [7+0.3,4,5.6] //m4
    : twistLockSize == "5" ? [8.5+0.3,5,4.2] //m5
    : twistLockSize == "5cnc" ? [8.5+0.3,5,6.5] //m5
    : [0,0,0];

  locking = lockingSize != [0,0,0];

  alignmentBorder = alignmentRing != "no" ? magnetBorder/2 : 0;
  magnetPosition = (innerStartDiameter + magnetDiameter) / 2 + magnetBorder +
      (alignmentRing != "no" ? alignmentBorder + alignmentUpperWidth : 0);

  //lockingOffset = magnetCount % 2 == 0 ? lockingOffset : false;
  //lockingDivisions = lockingOffset ? magnetCount/2 : magnetCount;

  magnetDivisionAngle = 360 / magnetCount;
  magnetCir = 2*PI*magnetPosition;
  magnetDivisionCir = magnetCir / magnetCount;
  lockingSystemSize =  magnetDiameter+lockingSize[0]+lockingSize[1]*2+magnetBorder*3;
  twistLockBorder = magnetBorder * 1.5; //Mostly because the magent would be bigger than the bolt any way
  lockingOffset = magnetCount % 2 == 0 ? (magnetDivisionCir < lockingSystemSize) : false;
  lockingDivisions = lockingOffset ? magnetCount/2 : magnetCount;

  endAngleoffset = magnetDivisionAngle * ((magnetDiameter+lockingSize[1])/2+magnetBorder)/magnetDivisionCir; //This needs to be calcualted based on magnet size and bot size.

  startAngleoffset = lockingOffset ? magnetDivisionAngle * ((magnetDiameter+lockingSize[0])/2+magnetBorder)/magnetDivisionCir : endAngleoffset;


  echo("MagneticConnector_locking", magnetDivisionAngle=magnetDivisionAngle, magnetCir=magnetCir, magnetDivisionCir=magnetDivisionCir, minLockSpace = lockingSystemSize, endAngleoffset=endAngleoffset, endAngleoffset=endAngleoffset);
  fillet = flangeThickness;
    difference ()
    {
        //flange
        union() {
            Pipe (
                diameter1 = innerStartDiameter,
                diameter2 = innerEndDiameter,
                length = length,
                wallThickness1 = wallThickness,
                wallThickness2 = wallThickness);

            // flange aound the magnets
            hull () {
                roundover = lockingSize !=[0,0,0] ? 0
                  : max(flangeThickness-magnetThickness-magnetZOffset,0);
                  echo(roundover=roundover);
                for (i = [0: magnetCount-1]) {
                    rotate ([0, 0, i * magnetDivisionAngle])
                    translate ([magnetPosition, 0, 0])
                    if(roundover > 0){
                      roundedCylinder(
                        h = flangeThickness,
                        r = (magnetDiameter + magnetBorder)/2,
                        roundedr2=roundover);
                    }else {
                      cylinder (d = magnetDiameter + magnetBorder * 2, flangeThickness);
                    }
                }

              //flage around locks
              if(locking)
              for (i = [0: magnetCount-1])
              rotate ([0, 0, i* magnetDivisionAngle])
              union(){
                  rotate ([0, 0, 0.5*magnetDivisionAngle])
                  translate ([magnetPosition, 0, 0])
                  cylinder (d = lockingSize[0]+twistLockBorder*2, h = flangeThickness + fudgeFactor*2);

                  rotate ([0, 0, magnetDivisionAngle-endAngleoffset])
                  translate ([magnetPosition, 0, 0])
                  cylinder (d = lockingSize[0]+twistLockBorder*2, h = flangeThickness + fudgeFactor*2);

                  rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*magnetDivisionAngle])
                  rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
                  translate ([magnetPosition, flangeThickness/2, 0])
                  square([lockingSize[0]+twistLockBorder*2,flangeThickness],center=true);
                }

            }


            // protuding magent rung
            if(alignmentRing == "protruding")
            {
                AlignmentRing(
                    centerDiameter = innerStartDiameter + alignmentBorder*2 + alignmentUpperWidth,
                    alignmentDepth = alignmentDepth,
                    alignmentUpperWidth = alignmentUpperWidth,
                    alignmentLowerWidth = alignmentLowerWidth,
                    alignmentSideClearance = alignmentSideClearance,
                    alignmentDepthClearance = alignmentDepthClearance,
                    magnetBorder = magnetBorder
                );
            }

            // taper
            intersection()
            {
                HalfConePipe (
                    diameter = innerEndDiameter,
                    length = fillet,
                    wallThickness1 = fillet - fudgeFactor,
                    wallThickness2 = 0,
                    zPosition= flangeThickness - fudgeFactor);

                translate([0, 0, 0])
                {
                    // incase the connector is less
                    cylinder(
                        d=innerEndDiameter*2,
                        h=length);
                }
            }
        }

        //Magnet cut out
        for (i = [0: magnetCount-1]) {
            rotate ([0, 0, i* 360 / magnetCount])
            translate ([magnetPosition, 0, magnetZOffset - fudgeFactor])
            cylinder (d = magnetDiameter, h = magnetThickness + fudgeFactor);
        }

        //Lock cut out
        if(locking){
          for (i = [0: lockingDivisions-1]) {

            rotate ([0, 0, i*360/lockingDivisions])
            union(){
              rotate ([0, 0, endAngleoffset-(lockingOffset ? 360/magnetCount : 0)])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[2], h = length + fudgeFactor*2);

              rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[0], h = length + fudgeFactor*2);

              rotate ([0, 0, 360/magnetCount-endAngleoffset])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[1], h = length + fudgeFactor*2);

              rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
              rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
              translate ([magnetPosition, length/2, 0])
              square([lockingSize[1],length+fudgeFactor*2],center=true);

              translate ([0, 0, flangeThickness/2])
              union(){
                rotate ([0, 0, 360/magnetCount-endAngleoffset])
                translate ([magnetPosition, 0, - fudgeFactor])
                cylinder (d = lockingSize[0], h = length + fudgeFactor*2);

                rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
                rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
                translate ([magnetPosition, length/2, 0])
                square([lockingSize[0],length+fudgeFactor*2],center=true);
              }
            }
          }
        }
        //Flange inner
        translate([0, 0, -fudgeFactor])
            cylinder (
                d1 = innerStartDiameter,
                d2 = innerEndDiameter,
                h = length + 2 * fudgeFactor);

        if(alignmentRing == "recessed")
        {
            // Create recessed alignment ring
            AlignmentRing(
                    centerDiameter = innerStartDiameter + alignmentBorder*2 + alignmentUpperWidth,
                    alignmentDepth = alignmentDepth,
                    alignmentUpperWidth = alignmentUpperWidth,
                    alignmentLowerWidth = alignmentLowerWidth,
                    alignmentSideClearance = 0,
                    alignmentDepthClearance = 0,
                    magnetBorder = magnetBorder);
        }
    }
}

module AlignmentRing(
    centerDiameter,
    alignmentDepth,
    alignmentUpperWidth,
    alignmentLowerWidth,
    alignmentSideClearance,
    alignmentDepthClearance,
    magnetBorder
)
{

//rotate_extrude()
//translate([45, 0, 0])
//circle(r = 4);


    ringHeight = 2*(alignmentDepth-alignmentDepthClearance);
    ringMaxWidth = (alignmentUpperWidth - alignmentSideClearance);
    ringMinWidth = (alignmentLowerWidth - alignmentSideClearance);
    intersection()
    {
        union()
        {

            ConeRing (
                centerDiameter = centerDiameter,
                length = alignmentDepth,
                wallThickness1 = ringMaxWidth,
                wallThickness2 = ringMinWidth,
                zPosition = 0);
            //Add a StraightPipe between the two to block clipping without impacting the angle of the cones.
            StraightPipe (
                diameter = centerDiameter - ringMaxWidth + fudgeFactor,
                length = fudgeFactor,
                wallThickness = ringMaxWidth- fudgeFactor,
                zPosition = -fudgeFactor/2);
            ConeRing (
                centerDiameter = centerDiameter,
                length = alignmentDepth,
                wallThickness1 = ringMinWidth,
                wallThickness2= ringMaxWidth,
                zPosition = -alignmentDepth);
       }

        translate([0, 0, -ringHeight/2])
        {
            cylinder(
                d=centerDiameter + alignmentUpperWidth,
                h=ringHeight);
        }
    }
}
//CombinedEnd from path connector_magnetic.scad
//Combined from path connector_nozzle.scad





nozzleVersion = "1.0";

nozzleSettings = ["nozzle", [
  [iSettingsTaper, 0],
  [iSettingsVersion, nozzleVersion]
  ]];

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleSize = [0,0,0],
  nozzleTipWallThickness,
  nozzleRadius,
  nozzleOffset = [0,0],
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0,
  help
)
{
  assert(is_list(nozzleSize) && len(nozzleSize) == 3, "nozzleSize must be a list of length 2");

  assert(nozzleShape == "square" || nozzleShape == "circle", str("nozzleShape only supports square and circle. Provided:'", nozzleShape ,"'"));
  innerRadius = innerStartDiameter/2;
  _nozzleRadius = nozzleShape == "circle" && nozzleRadius == 0 ? nozzleSize.x/2
    : nozzleShape == "square" ? min(nozzleSize.x/2, nozzleSize.y/2, nozzleRadius)
    : nozzleRadius;
  circlepositionx = nozzleShape == "square" ? nozzleSize.x/2 - _nozzleRadius : 0;
  circlepositiony = nozzleShape == "square" ? nozzleSize.y/2 - _nozzleRadius : 0;
  circlepositions = nozzleShape == "square" ?
    [[ circlepositionx, circlepositiony ],
    [ -circlepositionx, circlepositiony ],
    [ circlepositionx, -circlepositiony ],
    [ -circlepositionx, -circlepositiony ]] : [[ circlepositionx, circlepositiony ]] ;

  nozzleWidth = (nozzleShape == "square" ? nozzleSize.x : _nozzleRadius * 2) + wallThickness*2;
  nozzleDepth = (nozzleShape == "square" ? nozzleSize.y : _nozzleRadius * 2) + wallThickness*2;
  nozzleWidthChamfer = nozzleWidth * nozzleChamferPercentage /100;
  nozzleLengthChamfer = nozzleWidthChamfer * tan(nozzleChamferAngle);

  tipWallThickness = nozzleTipWallThickness == 0 ? wallThickness : nozzleTipWallThickness;

  widthChamfer = min(nozzleWidthChamfer, nozzleWidth);
  lengthChamfer = min(nozzleLengthChamfer, nozzleSize.z);

  //todo, add correction to ensure that the thickness of the walls never reduce to less than wallthickenss1 and wallThickness2
  //using wallThickness/2 is a sloppy approximation, really need to use trig to would out the correct value
  leadin = max(fudgeFactor, wallThickness/2);
  startOuterLeadin = innerStartDiameter > max(nozzleSize.x,nozzleSize.y) ? leadin : fudgeFactor;
  startInnerLeadin = innerStartDiameter > max(nozzleSize.x,nozzleSize.y) ? fudgeFactor : leadin;
  endOuterLeadin = max(nozzleSize.x,nozzleSize.y) > innerStartDiameter ? leadin : fudgeFactor;
  endInnerLeadin = max(nozzleSize.x,nozzleSize.y) > innerStartDiameter ? fudgeFactor : leadin;

  difference()
  {
    //Outer Shape
    union()
    {
      // Nozzle base
      hull()
      {
        cylinder(startOuterLeadin, r=innerRadius+wallThickness);
        translate([nozzleOffset.y,nozzleOffset.x,length - endOuterLeadin+ fudgeFactor])
        hull() for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(endOuterLeadin, r=_nozzleRadius+wallThickness+fudgeFactor);
      }

      // Nozzle
      translate([nozzleOffset.y,nozzleOffset.x,length + fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
      {
        translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=_nozzleRadius+wallThickness+fudgeFactor);
        translate([circlepositions[i][0], circlepositions[i][1], nozzleSize.z])
          cylinder(fudgeFactor, r=_nozzleRadius+tipWallThickness+fudgeFactor);
      }
    }

    //Inner shape
    union()
    {
      // Nozzle base
      union(){
        translate([0,0,-fudgeFactor])
          cylinder(startInnerLeadin+fudgeFactor*2, r=innerRadius);

        translate([0,0,startInnerLeadin])
        hull()
        {
          cylinder(fudgeFactor, r=innerRadius);
          translate([nozzleOffset.y,nozzleOffset.x,length-startInnerLeadin-endInnerLeadin])
            hull() for (i= [ 0 : len(circlepositions) - 1 ])
              translate([circlepositions[i][0], circlepositions[i][1], 0])
              cylinder(fudgeFactor, r=_nozzleRadius+fudgeFactor);
        }
        translate([nozzleOffset.y,nozzleOffset.x,length-endInnerLeadin-fudgeFactor])
          hull() for (i= [ 0 : len(circlepositions) - 1 ])
            translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(endInnerLeadin+fudgeFactor*3, r=_nozzleRadius+fudgeFactor);

       }

      // Nozzle
      translate([nozzleOffset.y,nozzleOffset.x,length+fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
        translate([circlepositions[i][0], circlepositions[i][1], 0])
        cylinder(nozzleSize.z+fudgeFactor*2, r=_nozzleRadius+fudgeFactor);
    }

    // Chamfer
    if(widthChamfer > 0 && lengthChamfer > 0)
    {
      translate([nozzleOffset.y,nozzleOffset.x,nozzleSize.z+length+fudgeFactor*3] )
      rotate([90,0,180])
        linear_extrude(nozzleDepth+1, center=true)
          polygon( points = [[nozzleWidth/2-widthChamfer,0],
                              [nozzleWidth/2+fudgeFactor*2,0],
                              [nozzleWidth/2+fudgeFactor*2,-lengthChamfer]] );
    }
  }

  HelpTxt("Nozzle",[
    "innerStartDiameter", innerStartDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "nozzleShape", nozzleShape,
    "nozzleSize", nozzleSize,
    "nozzleTipWallThickness", nozzleTipWallThickness,
    "nozzleRadius", nozzleRadius,
    "nozzleOffset", nozzleOffset,
    "nozzleChamferPercentage", nozzleChamferPercentage,
    "nozzleChamferAngle", nozzleChamferAngle,
    "_nozzleWidth", nozzleWidth,
    "_nozzleDepth", nozzleDepth,
    "_nozzleWidthChamfer", nozzleWidthChamfer,
    "_nozzleLengthChamfer", nozzleLengthChamfer,
    "_nozzleRadius", _nozzleRadius,
    "_circlepositions", circlepositions,
    ],help);
}
//CombinedEnd from path connector_nozzle.scad
//Combined from path connector_camlock.scad





camlockVersion = "1.0";
camlockMinLength = 35+3;
camlockMeasurement = "outer";
camlockOuterDiameter = 24.25*2;

camlockSettings = ["camlock", [
  [iSettingsLength, camlockMinLength],
  [iSettingsMeasurement, camlockMeasurement],
  [iSettingsDiameter, camlockOuterDiameter],
  [iSettingsTaper ,0],
  [iSettingsVersion, camlockVersion]
  ]];

 /*
 CamlockConnector(
  innerEndDiameter = camlockOuterDiameter,
  length = camlockMinLength,
  wallThickness = 2);
 */

module CamlockConnector(
  innerEndDiameter,
  length,
  wallThickness){

  innerDiameter =  20*2;
  //camlockOuterDiameter = 48.5;
  outerDiameter = camlockOuterDiameter;
  camlockHeight = 35;
  camlockStopLength = camlockMinLength - camlockHeight;
  camlockStopWidth = camlockStopLength/2.1;
  camlockWallThickness = (outerDiameter - innerDiameter)/2;
  camlockRingClipRadius = 5.1;//4.8;
  camlockRingClipHeight = 15;
  camlockRingClipPosition = 27.25;
  camlockChamfer = 1.6;
  camlockChamferLength = 1.6;

 echo("CamlockConnector", innerDiameter = innerDiameter, outerDiameter=outerDiameter, camlockHeight=camlockHeight, length = length, camlockWallThickness = camlockWallThickness);

  difference(){
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter,
      innerEndDiameter = innerDiameter,
      length = camlockHeight,
      wallThickness = camlockWallThickness,
      stopLength = camlockStopLength,
      stopWidth = camlockStopWidth,
      stopSymmetrical = 0,
      chamferLength = camlockChamferLength,
      chamferWidth= camlockChamfer
    );

    //hollow out top to reduce width and plastic, and match desired width
    translate([0,0,camlockRingClipHeight+wallThickness/2])
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter-wallThickness*2,
      innerEndDiameter = innerDiameter-wallThickness*2,
      length = camlockHeight+camlockStopLength+fudgeFactor*2-(camlockRingClipHeight+wallThickness/2),
      wallThickness = camlockWallThickness,
      stopLength = 0,
      stopWidth = 0,
      stopSymmetrical = 0,
      chamferLength = camlockWallThickness,
      chamferWidth= camlockWallThickness
    );

    //subtract the ring lock
    translate([0,0,camlockRingClipHeight])
      rotate_extrude(angle = 360, convexity = 2)
      translate([camlockRingClipPosition,0,0])
      circle(camlockRingClipRadius);
  }

  /*Pipe (
    diameter1 = innerDiameter,
    diameter2 = innerEndDiameter,
    length = length - camlockHeight,
    wallThickness1 = (outerDiameter - innerDiameter)/2,
    wallThickness2 = wallThickness,
    zPosition = camlockHeight);*/
}
//CombinedEnd from path connector_camlock.scad
//Combined from path connector_centec.scad









cenTecFemaleVersion = "0.1";
cenTecFemaleBodyLength =  25;
cenTecFemaleWallThickness = 3;
cenTecFemaleMinLength = cenTecFemaleBodyLength+2;
cenTecFemaleMeasurement = "inner";
cenTecFemaleInnerDiameter = 22.625*2;
cenTecFemaleOuterDiameter = cenTecFemaleInnerDiameter + cenTecFemaleWallThickness*2;

centecFemaleSettings = ["centec_female", [
  [iSettingsLength, cenTecFemaleMinLength],
  [iSettingsMeasurement, cenTecFemaleMeasurement],
  [iSettingsDiameter, cenTecFemaleInnerDiameter],
  [iSettingsWallThickness, (cenTecFemaleOuterDiameter - cenTecFemaleInnerDiameter)/2],
  [iSettingsTaper ,0],
  [iSettingsVersion, cenTecFemaleVersion]
  ]];

cenTecMaleVersion = "0.2";
cenTecMaleBodyLength =  25.797;
cenTecMaleMinLength = 32;
cenTecMaleMeasurement = "outer";
cenTecMaleInnerDiameter = 32.544;
cenTecMaleOuterDiameter = 44.75; //v0.1 45.244;
cenTecMaleWallThickness = (cenTecMaleOuterDiameter - cenTecMaleInnerDiameter)/2;

centecMaleSettings = ["centec_male", [
  [iSettingsLength, cenTecMaleMinLength],
  [iSettingsMeasurement, cenTecMaleMeasurement],
  [iSettingsDiameter, cenTecMaleOuterDiameter],
  [iSettingsWallThickness, (cenTecMaleOuterDiameter - cenTecMaleInnerDiameter)/2],
  [iSettingsTaper ,0],
  [iSettingsVersion, cenTecMaleVersion]
  ]];

//Test female
//CenTecFemaleConnector();
//Test male
//CenTecMaleConnector();

module CenTecMaleConnector($fn = 64){
  connectorLength = cenTecMaleMinLength;
  connectorInnerRadius= cenTecMaleInnerDiameter/2;
  connectorOuterRadius= cenTecMaleOuterDiameter/2;
  StopInnerRadius = 18.2;
  wallThickness = cenTecMaleWallThickness;
  StopInnerLength = cenTecFemaleWallThickness;

  clickLength = 6.5;//V0.1 5.556;
  clickDiameter = 36.513;
  clickZpos = 8.5;//V0.1 9.128;
  clickWallThicknessDepth = (cenTecMaleOuterDiameter-clickDiameter);

  startLipLength = 1.191;
  startLipDiameter = 35.719;
  startLipWidthDepth = (cenTecMaleOuterDiameter - startLipDiameter);

  stopLength = 6;
  stopWidth = 3.175;
  stopZpos = connectorLength - stopLength;// 25.797;

  union(){
  difference(){
    Pipe(
      diameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness=wallThickness);
    /*HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = connectorInnerRadius*2,
      innerEndDiameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness = wallThickness);*/
    Pipe(
      diameter = startLipDiameter,
      length = startLipLength,
      wallThickness=startLipWidthDepth,
      zPosition = -fudgeFactor);
    Pipe(
      diameter = clickDiameter,
      length = clickLength,
      wallThickness=clickWallThicknessDepth,
      zPosition = clickZpos);
  }

  Stopper(
    diameter = connectorOuterRadius*2-fudgeFactor,
    outer = true,
    totalLength = stopLength,
    taper1 = 0,
    taper2 = 0.5,
    wallThickness = 0,
    stopThickness = stopWidth,
    zPosition = stopZpos);
  }
}

module CenTecFemaleConnector($fn = 64){

  pinHoleWidth = 9.5;
  pinHoleHeight = 6;
  pinHoleRadius = 3;
  pinHoleOffset = 11;

  pinSlideIndent = 1.5;
  connectorLength = cenTecFemaleBodyLength;
  connectorInnerEndRadius= cenTecFemaleInnerDiameter/2;
  connectorInnerStartRadius= cenTecFemaleInnerDiameter/2+0.275;
  StopInnerRadius = 18.2;
  wallThickness = cenTecFemaleWallThickness;
  StopInnerLength = cenTecFemaleWallThickness;

  slideTaper=1;

  _pinHoleRadius = min(pinHoleRadius, pinHoleHeight/2);


  echo("CenTecConnector", _pinHoleRadius=_pinHoleRadius, pinHoleHeight=pinHoleHeight);
    //Main body


  difference(){
    HoseConnector(
      connectorMeasurement = "inner",
      innerStartDiameter = connectorInnerStartRadius*2,
      innerEndDiameter = connectorInnerEndRadius*2,
      length = connectorLength,
      wallThickness = wallThickness,
      stopLength = 2,
      stopWidth = 2,
      chamferLength = 1,
      chamferWidth= 1
    );


    //Thumb relief for the press pin
    for(i=[0:1])
      rotate([0,0,i*180])
      //translate([connectorInnerEndRadius,0,pinHoleHeight])
      translate([0,connectorInnerEndRadius+wallThickness/2,pinHoleHeight/2+pinHoleOffset])
        union(){
        rotate([90,0,0])
        centecRoundedCube(
          x=pinHoleWidth,
          y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
          h=wallThickness*2,
          r=_pinHoleRadius,
          center = true);

        translate([0,wallThickness/2,0])
        rotate([90,0,180])
        centecRoundedCube(
          x=pinHoleWidth,
          y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
          h=wallThickness,
          r1=_pinHoleRadius,
          r2=(_pinHoleRadius+wallThickness)*2, //these values are made up, not sure what a could value should be
          center = true);
    }

    //Slide for the clip
    intersection(){

      slideLength=pinHoleOffset+pinHoleHeight/2;

      for(i=[0:1])
      rotate([0,0,i*180])
      //translate([connectorInnerEndRadius,0,pinHoleHeight])
      translate([0,connectorInnerEndRadius+wallThickness/2,slideLength/2-pinHoleHeight/2])
      rotate([90,0,0])
      cube([pinHoleWidth,slideLength+pinHoleHeight, wallThickness*2], center = true);
      /*roundedCube(
        x=pinHoleWidth,
        y=slideLength+pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
        h=wallThickness*2,
        r1=0.1,
        r2=1,
        center = true);*/

      translate([0,0,slideLength+slideTaper])
      mirror([0,0,1])
      HoseConnector(
        connectorMeasurement = "outer",
        innerStartDiameter = connectorInnerStartRadius*2-pinSlideIndent*2-pinSlideIndent/2,
        innerEndDiameter = connectorInnerStartRadius*2-pinSlideIndent,
        length = slideLength,
        wallThickness = pinSlideIndent,
        stopLength = slideTaper*2,
        stopWidth = slideTaper
      );
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//fn = overrides the #fn function for the corners
module centecRoundedCube(
  x,
  y,
  h,
  r,
  r1,
  r2,
  taper=0,
  center=false,
  fn = 64)
{
  r1 = is_num(r1) ? r1 : r;
  r2 = is_num(r2) ? r2 : r;

  positions=[
     [r1            ,r1            ,0]
    ,[max(x-r1, r1) ,r1            ,0]
    ,[max(x-r1, r1) ,max(y-r1, r1) ,0]
    ,[r1            ,max(y-r1, r1) ,0]
    ];

  translate(center ? [-x/2,-y/2,-h/2]:[0:0:0])
  hull(){
    for (x =[0:1:len(positions)-1])
    {
      //translate(positions[x])
      //  circle(cornerRadius, $fn=fn);
      translate(positions[x])
        cylinder(r1=r1, r2=r2, h=h,$fn=fn);
    }
  }
}
//CombinedEnd from path connector_centec.scad
//Combined from path connector_dyson.scad









/* Hidden */
dysonVersion = "1.2";
dysonMinLength = 46;
dysonMeasurement = "outer";
dysonOuterDiameter = 34.1;
dysonInnerDiameter = 28.5;
dysonWallThickenss = (dysonOuterDiameter - dysonInnerDiameter)/2;

dysonSettings = ["dyson", [
  [iSettingsLength, dysonMinLength],
  [iSettingsMeasurement, dysonMeasurement],
  [iSettingsDiameter, dysonOuterDiameter],
  [iSettingsWallThickness, dysonWallThickenss],
  [iSettingsTaper ,0],
  [iSettingsVersion, dysonVersion]
  ]];

//DysonConnector();

module DysonConnector(
  innerEndDiameter = dysonInnerDiameter,
  length = dysonMinLength,
  wallThickness = dysonWallThickenss,
  IncludeOrientationClip = true,
  $fn = 64
){
  heightStartShaft = 10;
  heightCutout= 4.45;
  heightCutoutTapper = 2.75;
  //heightMainShaft = 28;

  orientationClipHeight = 37-.5;

  orentationClipwallThickness = 2.5;
  orientationClipCenter = 5.5;
  orientationClipTaper = 2;
  orientationClipWidth = 3;
  orientationClipLength = orientationClipCenter + orientationClipTaper*2;
  heightMainShaft = orientationClipHeight - (heightStartShaft+heightCutout+heightCutoutTapper) + orientationClipLength;
  height = heightStartShaft+heightCutout+heightCutoutTapper+heightMainShaft;
  innerDiameter = 28.5;
  outerDiameter = dysonOuterDiameter;

  cutoutRadius = 30.7;// dysonInnerDiameter/2;
  innerRadius = innerDiameter/2;
  outerRadius = outerDiameter/2;

  union() {
    difference() {
      union() {
        difference() {
        //Main pipe
        Pipe (
          diameter1 = innerEndDiameter,
          diameter2 = innerEndDiameter,
          length = length,
          wallThickness1 = wallThickness,
          wallThickness2 = wallThickness);

        //retaining ring
        Stopper(
            diameter = outerDiameter+fudgeFactor,
            outer = false,
            totalLength = heightCutout+heightCutoutTapper,
            taper1 = 0,
            taper2 = 0.38,
            wallThickness = 0,
            stopThickness = 1.5,
            zPosition = heightStartShaft);
        }

        // orientation clip
        if(IncludeOrientationClip == true){
          translate([0,0,orientationClipHeight])
          difference() {
            Stopper(
              diameter = outerDiameter,
              outer = true,
              totalLength = orientationClipLength,
              taper1 = 0.2,
              taper2 = 0.2,
              wallThickness = 0,
              stopThickness = orentationClipwallThickness);

            clipCount = 4;
            for(i=[0:1:clipCount-1])
            {
              rotate([0,0,i*360/clipCount])
              difference() {
                //Circle cutout for clip
                translate([0,-outerRadius+4,-23/2+6.5]) rotate([90,0,0])
                  union(){
                    baseclipheight = orentationClipwallThickness*1.7;
                  cylinder(r=23/2, h=baseclipheight);
                  translate([0,0,baseclipheight-fudgeFactor])
                  cylinder(r1=23/2, r2=25/2, h=orentationClipwallThickness);
                  }
                //Verticle clip lock
               translate([0,-outerRadius,orientationClipWidth/2]) rotate([90,0,0])
                 hull() {
                    cylinder(d1=orientationClipWidth, d2=orientationClipWidth-0.5, h=orentationClipwallThickness);
                  translate([0,orientationClipLength-orientationClipWidth,0])
                    cylinder(d1=orientationClipWidth, d2=orientationClipWidth-0.5, h=orentationClipwallThickness);
                }
              }
            }
          }
        }
      }

      //remove center
      translate([0,0,-fudgeFactor])
        cylinder(r=innerRadius, h=height+fudgeFactor*2);
    }
  }
}
//CombinedEnd from path connector_dyson.scad
//Combined from path connector_dw735.scad






dw735Version = "1.2";
dw735MinLength = 17;
dw735Measurement = "inner";
dw735InnerDiameter = 71;

dw735Settings = ["dw735", [
  [iSettingsLength, dw735MinLength],
  [iSettingsMeasurement, dw735Measurement],
  [iSettingsDiameter, dw735InnerDiameter],
  [iSettingsTaper ,0],
  [iSettingsVersion, dw735Version]
  ]];

module Dw735Connector(
  innerEndDiameter ,
  length,
  wallThickness,
  connectorCount = 1
){
  // Spring pin hole center distance
  springHoleOffset = 7.875;
  // Spring pin hole
  springHoleDiameter = 6.75;
  // Slot hole width (diameter)
  slotDiameter = 6.5;
  // Mounting slot length
  slotLength = 16;
  slotOffset1 = 7.5;
  slotOffset2 = 9;
  fixedPinLength = 4.1;
  maxSupportThickness = fixedPinLength - 1.5;
  clearanceHeight = 4;
  clearanceDiameter = innerEndDiameter+9.2;

  _connectorCount = max(1,connectorCount);

  slotAngle = (slotLength-slotDiameter)/(2*PI*(innerEndDiameter/2+wallThickness))*360;

  echo("Dw735Connector", innerEndDiameter=innerEndDiameter, length = length, wallThickness = wallThickness);
  rotate([0,0,-90])
  difference(){
    union(){
      //Main body
      StraightPipe (
        diameter = innerEndDiameter,
        length = length,
        wallThickness = wallThickness);

      // Slot support
      intersection(){
        StraightPipe (
          diameter = innerEndDiameter+wallThickness*2,
          length = length,
          wallThickness = fixedPinLength - 1.5);

        for (rotation = [0:_connectorCount-1])
        {
          flippedRotation = rotation % 2 == 0 ? rotation : -rotation;
          rotate([0, 0, -rotation*(180/_connectorCount)])
          union(){
            hull(){
              rotate([0,0,90])
                translate([innerEndDiameter/2,0,slotOffset2])
                sphere(d=slotDiameter+wallThickness*2+fixedPinLength);
              rotate([0,0,90-slotAngle])
                translate([innerEndDiameter/2,0,slotOffset1])
                sphere(d=slotDiameter+wallThickness*2+fixedPinLength);
            }
            hull(){
              rotate([0,0,90-slotAngle])
                translate([innerEndDiameter/2,0,slotOffset1])
                sphere(d=slotDiameter+wallThickness*2+fixedPinLength);
              rotate([0,0,90-slotAngle])
                translate([innerEndDiameter/2,0,0])
                sphere(d=slotDiameter+wallThickness*2+fixedPinLength);
            }
          }
        }
      }
    }

    Pipe (
      diameter1 = clearanceDiameter,
      diameter2 = clearanceDiameter+wallThickness*2,
      length = wallThickness,
      wallThickness1 = wallThickness,
      wallThickness2 = 0,
      zPosition = clearanceHeight-fudgeFactor);

     StraightPipe (
        diameter = clearanceDiameter,
        length = clearanceHeight+fudgeFactor,
        wallThickness = wallThickness,
        zPosition = -fudgeFactor);


    for (rotation = [0:_connectorCount-1])
    {
      rotate([0, 0, -rotation*(180/_connectorCount)])
      // Spring pin hole
      translate([0,0,springHoleOffset]){
        rotate([90,0,0])
          cylinder(d=springHoleDiameter,h=innerEndDiameter);
      }
    }

    // slot cutout
    intersection(){
      StraightPipe (
        diameter = innerEndDiameter-fudgeFactor,
        length = length+fudgeFactor*2,
        wallThickness = fixedPinLength,
        zPosition = -fudgeFactor);

      for (rotation = [0:_connectorCount-1])
      {
        rotate([0, 0, -rotation*(180/_connectorCount)])
        union(){
          hull(){
            translate([0,0,slotOffset2])
              rotate([90,0,180])
              translate([0,0,(innerEndDiameter-wallThickness)/2])
              cylinder(d=slotDiameter,h=fixedPinLength+wallThickness);
            translate([0,0,slotOffset1])
              rotate([90,0,180-slotAngle])
              translate([0,0,(innerEndDiameter-wallThickness)/2])
              cylinder(d=slotDiameter,h=fixedPinLength+wallThickness);
          }
          hull(){
            translate([0,0,slotOffset1])
              rotate([90,0,180-slotAngle])
              translate([0,0,(innerEndDiameter-wallThickness)/2])
              cylinder(d=slotDiameter,h=fixedPinLength+wallThickness);
            rotate([90,0,180-slotAngle])
              translate([0,0,(innerEndDiameter-wallThickness)/2])
              cylinder(d=slotDiameter,h=fixedPinLength+wallThickness);
          }
        }
      }
    }
  }
}
//CombinedEnd from path connector_dw735.scad
//Combined from path connector_osvac.scad










//osVAC
//Female documentation https://www.thingiverse.com/thing:4562762
//Male documentation https://www.thingiverse.com/thing:4562789

/* Hidden */
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
  finalShaftLength = 5;

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
  cutoutArcLength = 35/180*PI*(osvacfInnerWallDiameter/2+cutoutDepthx);
  cutoutArcAngle = (cutoutArcLength*180)/(PI*(innerWallDiameter/2+cutoutDepthx));
  echo();
  difference(){
    //Main outer body
    cylinder(length, d=outerDiameter);

    //Main inner body removal
    union(){
      hull(){
        translate([0,0,-fudgeFactor])
          cylinder(innerShaftLength, d=innerWallDiameter);
        translate([0,0,innerShaftLength])
          cylinder(innerTaperSize,
            d1=innerWallDiameter,
            d2=innerDiameter);
      }

      //Opening relief
      translate([0,0,-fudgeFactor])
        cylinder(
          cutoutDepthx/2,
          d1=innerWallDiameter+cutoutDepthx,
          d2=innerWallDiameter
         );


      finalShaftLength = length - innerShaftLength;
      translate([0,0,length-finalShaftLength+fudgeFactor])
        cylinder(finalShaftLength, d=innerDiameter);

     translate([0,0,-fudgeFactor])
     intersection(){
        cylinder(cutoutDepthz+fudgeFactor, r=cutoutRadius);
        for(i = [0:360/clipCount:360]){
          rotate([0,0,i])
          union(){
          translate([0,-cutoutWidth/2,-fudgeFactor])
            roundedCube(
              size=[cutoutRadius,cutoutWidth,cutoutDepthz],
              topRadius = 0,
              bottomRadius = 0,
              sideRadius = 2);

           rotate([0,0,cutoutArcAngle])
           translate([0,-cutoutWidth/2,cutoutDepthz-cutoutHeight-fudgeFactor])
            roundedCube(
              size=[cutoutRadius,cutoutWidth,cutoutHeight],
              topRadius = 0,
              bottomRadius = 0,
              sideRadius = 2);

            //it creates the bump to produce the lock
            rotate([0,0,cutoutArcAngle/4])
            translate([0,0,cutoutDepthz-cutoutHeight-fudgeFactor])
              intersection(){
                translate([0,0,-cutoutHeight])
                rotate_extrude(angle=cutoutArcAngle/2)
                  translate([cutoutRadius-(cutoutDepthx*2),0,0])
                  square([cutoutDepthx+cutoutBumpDepthx,cutoutHeight*2], center=false);

              translate([cutoutRadius,0,cutoutHeight-2])
              rotate([45,0,0])
                cube([10,cutoutHeight*2,cutoutHeight*2], center=true);
            }
          }
        }
      }
    }
  }

  HelpTxt("osVacFemaleConnector",[
    "innerDiameter", innerDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "innerTaperSize", innerTaperSize,
    "innerWallDiameter", innerWallDiameter,
    "outerDiameter", outerDiameter,
    "finalShaftLength", finalShaftLength,
    "innerShaftLength", innerShaftLength,
    "cutoutHeight", cutoutHeight,
    "cutoutz", cutoutz,
    "cutoutDepthz", cutoutDepthz,
    "cutoutDepthx", cutoutDepthx,
    "cutoutArcLength",cutoutArcLength,
    "cutoutArcAngle",cutoutArcAngle,
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
  help,
  $fn = 64
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

  union() {
    difference ()
    {
      //outer cylinder
      union(){
        cylinder(length, d=outerDiameter);

        translate([0,0,clipz])
        difference(){
          intersection(){
            roundedCylinder(
              clipHeight,
              r=outerDiameter/2+clipThickness,
              roundedr1=clipr,
              roundedr2=0);
            for(i = [0:360/clipCount:360]){
              rotate([0,0,i])
              translate([outerDiameter/2-clipThickness,-clipWidth/2,-fudgeFactor])
                hull(){
                  roundedCube(
                    size=[clipThickness,clipWidth,clipHeight],
                    topRadius = 0,
                    bottomRadius = 1,
                    sideRadius = 1);
                  roundedCube(
                    size=[clipThickness,clipWidth,clipHeight],
                    topRadius = 0,
                    bottomRadius = 1,
                    sideRadius = 2);
              }
            }
          }

          Pipe(
            diameter1 = outerDiameter+clipThickness*2+fudgeFactor,
            diameter2 = outerDiameter-fudgeFactor*2,
            length = clipTopTaperHeight,
            wallThickness1 = 0,
            wallThickness2 = clipThickness+fudgeFactor,
            zPosition = clipTopTaperz);
        }
      }

      //Inner cylinder to remove
      translate([0,0,0-fudgeFactor])
      cylinder(length+fudgeFactor*2, d=innerDiameter);

      Pipe(
        diameter1 = innerDiameter-fudgeFactor,
        diameter2 = innerDiameter-fudgeFactor,
        length = hoseEndTaper+fudgeFactor,
        wallThickness1 = hoseEndTaper,
        wallThickness2 = 0,
        zPosition = -fudgeFactor);
      Pipe(
        diameter1 = outerDiameter-hoseEndTaper*2,
        diameter2 = outerDiameter+hoseEndTaper*2,
        length = hoseEndTaper+hoseEndTaper,
        wallThickness1 = hoseEndTaper,
        wallThickness2 = 0,
        zPosition = -fudgeFactor);
    }
  }

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



//CombinedEnd from path connector_osvac.scad
//Combined from path connector_makita.scad






//from here https://cad.onshape.com/documents/b952efdb75aae7a041c428d2/w/8d2594b7d94e0bbfda74354e/e/ce4460e84e97931fc7b7869b

makitaVersion = "0.1";
makitaMinLength = 53.3;
makitaMeasurement = "outer";
makitaOuterDiameter = 38.5;
makitaInnerDiameter = 31;
makitaWallThickness = (makitaOuterDiameter-makitaInnerDiameter)/2;

makitaMaleSettings = ["makita_male", [
  [iSettingsLength, makitaMinLength],
  [iSettingsMeasurement, makitaMeasurement],
  [iSettingsDiameter, makitaOuterDiameter],
  [iSettingsTaper ,0],
  [iSettingsWallThickness, makitaWallThickness],
  [iSettingsVersion, makitaVersion]
  ]];

 /*
 makitaConnector(
  innerEndDiameter = makitaOuterDiameter,
  length = makitaMinLength,
  wallThickness = 2);
 */

//MakitaMaleConnector();

module MakitaMaleConnector(
  help,
  $fn = 64){
  outerDiameter = makitaOuterDiameter;
  innerDiameter =  outerDiameter - makitaWallThickness*2;

  makitaRingClipRadius = outerDiameter - 1.85*2;
  makitaRingClipHeight = 10.5;
  makitaRingClipPosition = 29.5;

  lowerInnerLipDiameter = 33;
  lowerInnerLipLength = 3;
  makitaChamfer = 1;
  makitaChamferLength = 4.5;
  endStopDiameter = 51;
  endStopLength = 4;

 echo("makitaConnector", innerDiameter = innerDiameter, outerDiameter=outerDiameter, makitaMinLength=makitaMinLength, makitaWallThickness = makitaWallThickness);

  difference(){
    union(){
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter,
      innerEndDiameter = innerDiameter,
      length = makitaMinLength,
      wallThickness = makitaWallThickness,
      stopSymmetrical = 0,
      chamferLength = makitaChamferLength,
      chamferWidth= makitaChamfer
    );

      Stopper(
        diameter = makitaOuterDiameter-fudgeFactor,
        outer = true,
        totalLength = endStopLength,
        taper1 = 0,
        taper2 = 0.5,
        wallThickness = 0,
        stopThickness = (endStopDiameter-makitaOuterDiameter)/2,
        zPosition = makitaMinLength-endStopLength);
    }

    translate([0,0,-fudgeFactor])
    cylinder(d=lowerInnerLipDiameter, h=lowerInnerLipLength);

    //subtract the ring lock
    Pipe (
      diameter = makitaRingClipRadius,
      length = makitaRingClipHeight,
      wallThickness = makitaWallThickness,
      zPosition = makitaRingClipPosition);
  }
}
//CombinedEnd from path connector_makita.scad
//Combined from path connector_common_post.scad


connectorSettings =[
  nozzleSettings,
  camlockSettings,
  centecFemaleSettings,
  centecMaleSettings,
  dysonSettings,
  dw735Settings,
  osvacmSettings,
  osvacm32Settings,
  osvacfSettings,
  osvacf32Settings,
  makitaMaleSettings];
//CombinedEnd from path connector_common_post.scad

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

//execution point
HoseAdapter(
  connector1 = UserConnectorSettings(
    connector=1,
    style="hose",
    wallThickness=End1_Wall_Thickness,
    measurement=End1_Measurement,
    diameter=End1_Diameter,
    length=End1_Length,
    taper=End1_Taper,
    stopThickness=End1_StopThickness,
    stopLength=End1_StopLength,
    stopSymmetrical=End1_Stop_Symmetrical,
    barbsCount=End1_Barbs_Count,
    barbsThickness=End1_Barbs_Thickness,
    barbsSymmetrical=End1_Barbs_Symmetrical),

  connector2 = UserConnectorSettings(
    connector=2,
    style="hose",
    wallThickness=End2_Wall_Thickness,
    measurement=End2_Measurement,
    diameter=End2_Diameter,
    length=End2_Length,
    taper=End2_Taper,
    stopThickness=End2_StopThickness,
    stopLength=End2_StopLength,
    stopSymmetrical=End2_Stop_Symmetrical,
    barbsCount=End2_Barbs_Count,
    barbsThickness=End2_Barbs_Thickness,
    barbsSymmetrical=End2_Barbs_Symmetrical),

  transitionStyle = Transition_Style,
  transitionLength = Transition_Length,
  transitionBendRadius = Transition_Bend_Radius,
  transitionAngle = Transition_Angle,

  sliceDebug = Enable_Debug_Slice,
  showCaliper = Enable_Calipers_Slice,
  end1Color = End1_Color,
  end2Color = End2_Color,
  transitionColor = Transition_Color,
  extensionColor = Extension_Color,
  help = Enable_Help
);
