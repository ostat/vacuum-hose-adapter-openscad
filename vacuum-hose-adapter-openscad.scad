// Hose connector
// version 2024-04-30
// repo https://github.com/ostat/vacuum-hose-adapter-openscad
//
// I give permision to use this script as you want, you are also free to sell models generated using this script. When sharing or selling models generated please provide attribution, with a link to the repo.
//
// I don't approve of you hosting or uploading this script it to any site or 3d modeling site.

use <modules/ub.scad>
include <modules/constants.scad>
include <modules/modules_utility.scad>
include <modules/modules_pipe.scad>

include <modules/connector_object.scad>
include <modules/connector_common.scad>
include <modules/connector_hose.scad>
include <modules/connector_flange.scad>
include <modules/connector_magnetic.scad>
include <modules/connector_nozzle.scad>

include <modules/connector_camlock.scad>
include <modules/connector_centec.scad>
include <modules/connector_dyson.scad>
include <modules/connector_dw735.scad>
include <modules/connector_osvac.scad>
include <modules/connector_makita.scad>

include <modules/connector_common_post.scad>

//TODO Ideas
//All pre and post trasition length. so a flat section before and after the taper.abs

/* [Hidden] */
DefaultEnd1Color = "LightPink";
DefaultEnd2Color = "SkyBlue";
DefaultEnd3Color = "MediumPurple";
DefaultTransitionColor = "LightGreen";
DefaultExtensionColor = "MediumSeaGreen";

/* [Connector 1] */
//Wall thickness
End1_Wall_Thickness = 2; //0.01
//The style of the end
End1_Style="flange"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector]
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]
// End 1 diameter of the adapter (mm, inch)
End1_Diameter = [50,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End1_Length = [15,0];  //0.1
//Rotation around the z axis. Userfull for non symeterical connectors.
End1_Rotation= 0;  
//Taper of the start connector, use negative to taper other direction.
End1_Taper = 0;  //0.1

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
//End Cap Inner Diameter.
End1_Hose_EndCap_Diameter = 0;  //0.1
//Thickness of endcap.
End1_Hose_EndCap_Thickness = 0;  //0.1
//End cap grid size for holes
End1_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End1_Hose_EndCap_GridWallThickness = 0;  //0.1

/* [Connector 1 - Flange] */
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

/* [Connector 1 - Magnetic Connector] */
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

/* [Connector 1 - Extension] */
//Length of the extnetion
End1_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End1_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
End1_Extension_GridWallThickness = 0;  //0.1
End1_Extension_Text = "";
End1_Extension_Text_Size = 0;


/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "bend+taper"; //[flat, taper+bend: Taper then bend, bend+taper: Bend then taper, organicbend: Tapered bend, hull: Hull for multiple end count, none: no transition]
//Length of the transition between the two ends
Transition_Length = 10;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1
//Angle of bend through the transition section.
Transition_Angle = 0;  //1
// offset for the connector, not supported on taperedbend.
Transition_Offset = [0,0]; // 0.1

/* [Transition Multiple connector settings] */
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

/* [Transition Support For Angled Pipes] */
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

/* [Connector 2] */
//Wall thickness
End2_Wall_Thickness = 2; //0.01
End2_Style="nozzle"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x, centec_female: Cen-Tec quick female connect, centec_male: Cen-Tec quick male connect, osvacm32:osVAC M32, osvacm:osVAC Male, osvacf32:osVAC F32,osvacf:osVAC Female, makita_male: Makita Quick connect Male connector, none: None]
// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm, inch)
End2_Diameter = [40,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End2_Length = [40 ,0];  //0.1
//Rotation around the z axis. Userfull for non symeterical connectors.
End2_Rotation= 0;  
//Taper of the start connector, use negative to taper other direction.
End2_Taper = 0;  //0.1

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
//Thickness of endcap, 0 means disabled
End2_Hose_EndCap_Thickness = 0;  //0.1
//End Cap Inner Diameter.
End2_Hose_EndCap_Diameter = 0;  //0.1
//End cap grid size for holes
End2_Hose_EndCap_GridSize = 0;  //0.1
//Thickness of the walls in the end cap
End2_Hose_EndCap_GridWallThickness = 0;  //0.1

/* [Connector 2 - Flange] */
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

/* [Connector 2 - Magnetic Flange] */
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
//Length of the extnetion
End2_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End2_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
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
//Rotation around the z axis. Userfull for non symeterical connectors.
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


/* [Connector 3 - Flange] */
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

/* [Connector 3 - Magnetic Flange] */
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
//Length of the extnetion
End3_Extension_Length = 0;
//Size of the grid in the extnetion. 0: diameter/6
End3_Extension_GridSize = 0;  //0.1
//Size of the grid walls in the extnetion. 0: no grid, -1: uses wall thickness
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

/* [Hidden] */
//Detail
$fn=120;

module end_of_customizer_opts() {}

function getColor(colorSetting, defaultColor) = 
  assert(is_list(colorSetting), str("colorSetting must be a list colorSetting=", colorSetting, " defaultColor", defaultColor))
  assert(len(colorSetting) == 2, "colorSetting be length 2")
  let(
    c = colorSetting[0] == "" ? defaultColor : colorSetting[0],
    a = is_num(colorSetting[1]) && colorSetting[1] >=0 && colorSetting[1] <=1 ? colorSetting[1] : 1) [c,a];

HoseAdapter();//execution point

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
  assert(is_num(con[iLength]), "length must be a number");
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
  assert(is_list(transitionColor), "adapterColor must be a list")
  assert(len(transitionColor) == 2, "adapterColor be length 2")
  
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
              end2Count = connector2Count);
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
            end2Count = connector2Count);
        }

        //Tapered section position to the end of the bent pipe
        for (rotation = [0:connector2Count-1])
        {
          //color("SpringGreen")
          color(transitionColor[0], transitionColor[1])
          rotate([0, 0, rotation*(360/connector2Count)])
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
            end2Count = connector2Count);
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
  drawAlignmentRing = Draw_Alignment_Ring,
  alignmentDepth = Alignment_Depth,
  alignmentUpperWidth = Alignment_Upper_Width,
  alignmentLowerWidth = Alignment_Lower_Width,
  alignmentSideClearance = Alignment_Side_Clearance,
  alignmentDepthClearance = Alignment_Depth_Clearance,

  connector1Style = End1_Style,
  connector1WallThickness  = End1_Wall_Thickness,
  connector1Measurement = End1_Measurement,
  connector1Diameter = End1_Diameter,
  connector1Length = End1_Length,
  connector1Rotation = End1_Rotation,
  connector1Taper = End1_Taper,
  connector1EndCapDiameter  = End1_Hose_EndCap_Diameter,
  connector1EndCapThickness = End1_Hose_EndCap_Thickness,
  connector1EndCapGridSize  = End1_Hose_EndCap_GridSize,
  connector1EndCapGridWallThickness = End1_Hose_EndCap_GridWallThickness,
  connector1StopThickness = End1_StopThickness,
  connector1StopLength = End1_StopLength,
  connector1StopSymmetrical = End1_Stop_Symmetrical,
  connector1BarbsCount = End1_Barbs_Count,
  connector1BarbsThickness = End1_Barbs_Thickness,
  connector1BarbsSymmetrical = End1_Barbs_Symmetrical,

  connector1MagnetCount = End1_Magnets_Count,
  connector1MagnetDiameter = End1_Magnet_Diameter,
  connector1MagnetThickness = End1_Magnet_Thickness,
  connector1MagnetBorder = End1_Magnet_Border,
  connector1MagnetZOffset = End1_Magnet_ZOffset,
  connector1MagnetFlangeThickness = End1_Magnet_Flange_Thickness,
  connector1MagnetTwistLockSize = End1_Magnet_Twist_Lock_Size,
  connector1Ring = End1_Ring,

  connector1FlangeWidth = End1_Flange_Width,
  connector1FlangeThickness = End1_Flange_Thickness,
  connector1FlangeScrewPosition = End1_Flange_Screw_Position,
  connector1FlangeScrewBorder = End1_Flange_Screw_Border,
  connector1FlangeScrewCount = End1_Flange_Screw_Count,
  connector1FlangeScrewDiameter = End1_Flange_Screw_Diameter,

  connector1ExtensionLength = End1_Extension_Length,
  connector1ExtensionGridSize = End1_Extension_GridSize,
  connector1ExtensionGridWallThickness = End1_Extension_GridWallThickness,
  connector1ExtensionText = End1_Extension_Text,
  connector1ExtensionTextSize=End1_Extension_Text_Size,

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
  transitionHullLength = Transition_HullLength,
  transitionHullCenterLength = Transition_HullCenterLength,
  transitionHullyOffset = Transition_HullyOffset,
  transitionHullCenter = Transition_HullCenter,
  transitionHullCenterHeight= Transition_HullCenterHeight,
  
  connector2Style = End2_Style,
  connector2WallThickness  = End2_Wall_Thickness,
  connector2Measurement = End2_Measurement,
  connector2Diameter = End2_Diameter,
  connector2Length = End2_Length,
  connector2Rotation = End2_Rotation,
  connector2Taper = End2_Taper,
  connector2EndCapDiameter  = End2_Hose_EndCap_Diameter,
  connector2EndCapThickness = End2_Hose_EndCap_Thickness,
  connector2EndCapGridSize  = End2_Hose_EndCap_GridSize,
  connector2EndCapGridWallThickness = End2_Hose_EndCap_GridWallThickness,
  connector2StopThickness = End2_StopThickness,
  connector2StopLength = End2_StopLength,
  connector2StopSymmetrical = End2_Stop_Symmetrical,
  connector2BarbsCount = End2_Barbs_Count,
  connector2BarbsThickness = End2_Barbs_Thickness,
  connector2BarbsSymmetrical = End2_Barbs_Symmetrical,

  connector2MagnetCount = End2_Magnets_Count,
  connector2MagnetDiameter = End2_Magnet_Diameter,
  connector2MagnetThickness = End2_Magnet_Thickness,
  connector2MagnetBorder = End2_Magnet_Border,
  connector2MagnetZOffset = End2_Magnet_ZOffset,
  connector2MagnetFlangeThickness = End2_Magnet_Flange_Thickness,
  connector2MagnetTwistLockSize = End2_Magnet_Twist_Lock_Size,
  connector2Ring = End2_Ring,

  connector2FlangeWidth = End2_Flange_Width,
  connector2FlangeThickness = End2_Flange_Thickness,
  connector2FlangeScrewPosition = End2_Flange_Screw_Position,
  connector2FlangeScrewBorder = End2_Flange_Screw_Border,
  connector2FlangeScrewCount = End2_Flange_Screw_Count,
  connector2FlangeScrewDiameter = End2_Flange_Screw_Diameter,
  
  connector2NozzleShape = End2_Nozzle_Shape,
  connector2NozzleSize = End2_Nozzle_Size,
  connector2NozzleTipWallThickness = End2_Nozzle_Tip_Wall_Thickness,
  connector2NozzleRadius = End2_Nozzle_Radius,
  connector2NozzleOffset = End2_Nozzle_Offset,
  connector2NozzleChamferPercentage = End2_Nozzle_Chamfer_Percentage,
  connector2NozzleChamferAngle = End2_Nozzle_Chamfer_Angle,
  
  connector2ExtensionLength = End2_Extension_Length,
  connector2ExtensionGridSize = End2_Extension_GridSize,
  connector2ExtensionGridWallThickness = End2_Extension_GridWallThickness,
  connector2ExtensionText = End2_Extension_Text,
  connector2ExtensionTextSize=End2_Extension_Text_Size,
  
  connector3Style = End3_Style,
  connector3WallThickness  = End3_Wall_Thickness,
  connector3Measurement = End3_Measurement,
  connector3Diameter = End3_Diameter,
  connector3Length = End3_Length,
  connector3Rotation = End3_Rotation,
  connector3Taper = End3_Taper,
  connector3EndCapDiameter  = End3_Hose_EndCap_Diameter,
  connector3EndCapThickness = End3_Hose_EndCap_Thickness,
  connector3EndCapGridSize  = End3_Hose_EndCap_GridSize,
  connector3EndCapGridWallThickness = End3_Hose_EndCap_GridWallThickness,
  connector3StopThickness = End3_StopThickness,
  connector3StopLength = End3_StopLength,
  connector3StopSymmetrical = End3_Stop_Symmetrical,
  connector3BarbsCount = End3_Barbs_Count,
  connector3BarbsThickness = End3_Barbs_Thickness,
  connector3BarbsSymmetrical = End3_Barbs_Symmetrical,

  connector3MagnetCount = End3_Magnets_Count,
  connector3MagnetDiameter = End3_Magnet_Diameter,
  connector3MagnetThickness = End3_Magnet_Thickness,
  connector3MagnetBorder = End3_Magnet_Border,
  connector3MagnetZOffset = End3_Magnet_ZOffset,
  connector3MagnetFlangeThickness = End3_Magnet_Flange_Thickness,
  connector3MagnetTwistLockSize = End3_Magnet_Twist_Lock_Size,
  connector3Ring = End3_Ring,

  connector3FlangeWidth = End3_Flange_Width,
  connector3FlangeThickness = End3_Flange_Thickness,
  connector3FlangeScrewPosition = End3_Flange_Screw_Position,
  connector3FlangeScrewBorder = End3_Flange_Screw_Border,
  connector3FlangeScrewCount = End3_Flange_Screw_Count,
  connector3FlangeScrewDiameter = End3_Flange_Screw_Diameter,
  
  connector3NozzleShape = End3_Nozzle_Shape,
  connector3NozzleSize = End3_Nozzle_Size,
  connector3NozzleTipWallThickness = End3_Nozzle_Tip_Wall_Thickness,
  connector3NozzleRadius = End3_Nozzle_Radius,
  connector3NozzleOffset = End3_Nozzle_Offset,
  connector3NozzleChamferPercentage = End3_Nozzle_Chamfer_Percentage,
  connector3NozzleChamferAngle = End3_Nozzle_Chamfer_Angle,
  
  connector3ExtensionLength = End3_Extension_Length,
  connector3ExtensionGridSize = End3_Extension_GridSize,
  connector3ExtensionGridWallThickness = End3_Extension_GridWallThickness,
  connector3ExtensionText = End3_Extension_Text,
  connector3ExtensionTextSize=End3_Extension_Text_Size,
  
  sliceDebug = Enable_Debug_Slice,
  showCaliper = Enable_Calipers_Slice,
  end1Color = End1_Color,
  end2Color = End2_Color,
  end3Color = End3_Color,
  transitionColor = Transition_Color,
  extensionColor = Extension_Color,
  help = Enable_Help
){
  assert(is_num(connector1Length), "connector1Length must be a number");
  
  $gha=[["connector1",[0,0,0]],["connector2",[0,0,0]],["trasnition",[0,0,0]]];

  end1 = getConnectorSettings(
    connector=1,
    style=connector1Style, 
    wallThickness=connector1WallThickness, 
    measurement=connector1Measurement, 
    diameter=connector1Diameter, 
    length=connector1Length, 
    rotation=connector1Rotation,
    taper=connector1Taper, 
    endCapDiameter=connector1EndCapDiameter,
    endCapThickness=connector1EndCapThickness,
    endCapGridSize=connector1EndCapGridSize,
    endCapGridWallThickness=connector1EndCapGridWallThickness,
    stopThickness=connector1StopThickness,
    stopLength=connector1StopLength,
    stopSymmetrical=connector1StopSymmetrical,
    barbsCount=connector1BarbsCount,
    barbsThickness=connector1BarbsThickness,
    barbsSymmetrical=connector1BarbsSymmetrical,
    magnetCount=connector1MagnetCount,
    magnetDiameter=connector1MagnetDiameter,
    magnetThickness=connector1MagnetThickness,
    magnetBorder=connector1MagnetBorder,
    magnetZOffset=connector1MagnetZOffset,
    magnetFlangeThickness=connector1MagnetFlangeThickness,
    magnetTwistLockSize=connector1MagnetTwistLockSize,
    alignmentRing=connector1Ring,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    flangeWidth=connector1FlangeWidth,
    flangeThickness=connector1FlangeThickness,
    flangeScrewPosition=connector1FlangeScrewPosition,
    flangeScrewBorder=connector1FlangeScrewBorder,
    flangeScrewCount=connector1FlangeScrewCount,
    flangeScrewDiameter=connector1FlangeScrewDiameter,
    //nozzleShape=connector1NozzleShape,
    //nozzleSize=connector1NozzleSize,
    //nozzleTipWallThickness=connector1NozzleTipWallThickness,
    //nozzleRadius=connector1NozzleRadius,
    //nozzleOffset=connector1NozzleOffset,
    //nozzleChamferPercentage=connector1NozzleChamferPercentage,
    //nozzleChamferAngle=connector1NozzleChamferAngle,
    extensionLength=connector1ExtensionLength,
    extensionGridSize=connector1ExtensionGridSize,
    extensionGridWallThickness=connector1ExtensionGridWallThickness,
    extensionText=connector1ExtensionText,
    extensionTextSize=connector1ExtensionTextSize,
    adapterColor = getColor(end1Color, DefaultEnd1Color),
    con1Measurement=connector1Measurement, 
    con1Diameter=connector1Diameter, 
    con1WallThickness=connector1WallThickness);
  
  end2 = getConnectorSettings(
    connector=2,
    style=connector2Style, 
    wallThickness=connector2WallThickness, 
    measurement=connector2Measurement, 
    diameter=connector2Diameter, 
    length=connector2Length, 
    rotation=connector2Rotation,
    taper=connector2Taper, 
    endCapDiameter=connector2EndCapDiameter,
    endCapThickness=connector2EndCapThickness,
    endCapGridSize=connector2EndCapGridSize,
    endCapGridWallThickness=connector2EndCapGridWallThickness,
    stopThickness=connector2StopThickness,
    stopLength=connector2StopLength,
    stopSymmetrical=connector2StopSymmetrical,
    barbsCount=connector2BarbsCount,
    barbsThickness=connector2BarbsThickness,
    barbsSymmetrical=connector2BarbsSymmetrical,
    magnetCount=connector2MagnetCount,
    magnetDiameter=connector2MagnetDiameter,
    magnetThickness=connector2MagnetThickness,
    magnetBorder=connector2MagnetBorder,
    magnetZOffset=connector2MagnetZOffset,
    magnetFlangeThickness=connector2MagnetFlangeThickness,
    magnetTwistLockSize=connector2MagnetTwistLockSize,
    alignmentRing=connector2Ring,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    flangeWidth=connector2FlangeWidth,
    flangeThickness=connector2FlangeThickness,
    flangeScrewPosition=connector2FlangeScrewPosition,
    flangeScrewBorder=connector2FlangeScrewBorder,
    flangeScrewCount=connector2FlangeScrewCount,
    flangeScrewDiameter=connector2FlangeScrewDiameter,
    nozzleShape=connector2NozzleShape,
    nozzleSize=connector2NozzleSize,
    nozzleTipWallThickness=connector2NozzleTipWallThickness,
    nozzleRadius=connector2NozzleRadius,
    nozzleOffset=connector2NozzleOffset,
    nozzleChamferPercentage=connector2NozzleChamferPercentage,
    nozzleChamferAngle=connector2NozzleChamferAngle,
    extensionLength=connector2ExtensionLength,
    extensionGridSize=connector2ExtensionGridSize,
    extensionGridWallThickness=connector2ExtensionGridWallThickness,
    extensionText=connector2ExtensionText,
    extensionTextSize=connector2ExtensionTextSize,
    adapterColor = getColor(end2Color, DefaultEnd2Color),
    con1Measurement=end1[iMeasurement], 
    con1Diameter=end1[iDiameter], 
    con1WallThickness=end1[iWallThickness]);

  end3 = getConnectorSettings(
    connector=3,
    style=connector3Style, 
    wallThickness=connector3WallThickness, 
    measurement=connector3Measurement, 
    diameter=connector3Diameter, 
    length=connector3Length, 
    rotation=connector3Rotation,
    taper=connector3Taper, 
    endCapDiameter=connector3EndCapDiameter,
    endCapThickness=connector3EndCapThickness,
    endCapGridSize=connector3EndCapGridSize,
    endCapGridWallThickness=connector3EndCapGridWallThickness,
    stopThickness=connector3StopThickness,
    stopLength=connector3StopLength,
    stopSymmetrical=connector3StopSymmetrical,
    barbsCount=connector3BarbsCount,
    barbsThickness=connector3BarbsThickness,
    barbsSymmetrical=connector3BarbsSymmetrical,
    magnetCount=connector3MagnetCount,
    magnetDiameter=connector3MagnetDiameter,
    magnetThickness=connector3MagnetThickness,
    magnetBorder=connector3MagnetBorder,
    magnetZOffset=connector3MagnetZOffset,
    magnetFlangeThickness=connector3MagnetFlangeThickness,
    magnetTwistLockSize=connector3MagnetTwistLockSize,
    alignmentRing=connector3Ring,
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    flangeWidth=connector3FlangeWidth,
    flangeThickness=connector3FlangeThickness,
    flangeScrewPosition=connector3FlangeScrewPosition,
    flangeScrewBorder=connector3FlangeScrewBorder,
    flangeScrewCount=connector3FlangeScrewCount,
    flangeScrewDiameter=connector3FlangeScrewDiameter,
    nozzleShape=connector3NozzleShape,
    nozzleSize=connector3NozzleSize,
    nozzleTipWallThickness=connector3NozzleTipWallThickness,
    nozzleRadius=connector3NozzleRadius,
    nozzleOffset=connector3NozzleOffset,
    nozzleChamferPercentage=connector3NozzleChamferPercentage,
    nozzleChamferAngle=connector3NozzleChamferAngle,
    extensionLength=connector3ExtensionLength,
    extensionGridSize=connector3ExtensionGridSize,
    extensionGridWallThickness=connector3ExtensionGridWallThickness,
    extensionText=connector3ExtensionText,
    extensionTextSize=connector3ExtensionTextSize,
    adapterColor = getColor(end3Color, DefaultEnd3Color),
    con1Measurement=end1[iMeasurement], 
    con1Diameter=end1[iDiameter], 
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
          ? max(abs(end1[iOuterEndDiameter] - end2[iOuterStartDiameter])/2, abs(end1[iInnerEndDiameter] - end2[iInnerStartDiameter])/2)
          : transitionLength;

      //Calculate the bend radius
      //organicbend, the '0' value must be max of connector 1 or 2 diameter, plus the wall thickness * 2 otherwise it will clip, then add provided radius.
      //transition the '0' value must be end 1 diameter/2 + wall thickenss *2 to prevent clipping, then addd provided radius.

      //((end2[iInnerStartDiameter] + connector1WallThickness)/ sin(_transitionAngle / 2)/2)/ sin(_transitionAngle) + transitionBendRadius
      //For organic bend only
      taperedAverageDiameter = (max(end1[iOuterEndDiameter],end2[iOuterStartDiameter])*2 + min(end1[iOuterEndDiameter],end2[iOuterStartDiameter]))/3;

      hoseSpacer = end2[iWallThickness];
      shapeOverlap = ((end1[iOuterEndDiameter]/2-hoseSpacer)-(cos(_transitionAngle)*end2[iOuterStartDiameter]))/sin(_transitionAngle);
      lengthInHull = _transitionStyle == "hull"
        ? (shapeOverlap > 0 ? 0 : shapeOverlap * -1) + _transitionLength
        : 0;
      transitionCenterHeight = transitionHullCenterHeight == 0 ? lengthInHull * 2 : transitionHullCenterHeight;
  
      //Push end horizontially out from verticle center line 
      edgeOffset = _transitionStyle == "hull"
        ? (shapeOverlap > 50
          ? (end1[iOuterEndDiameter] - end2[iOuterStartDiameter])/2-shapeOverlap/2 + transitionHullyOffset
          : (end1[iOuterEndDiameter] - end2[iOuterStartDiameter])/2 + transitionHullyOffset) * cos(_transitionAngle)
        : 0;
      //end hull settings
      bendRadius = _transitionStyle == "organicbend"
        ? transitionEnd2Count > 1
          ? -(taperedAverageDiameter/2)/(cos(_transitionAngle)-1)-taperedAverageDiameter/2 + transitionBendRadius
          : taperedAverageDiameter + transitionBendRadius
        : _transitionStyle == "bend+taper"
          ? transitionEnd2Count > 1
            ? -(end1[iOuterEndDiameter]/2)/(cos(_transitionAngle)-1)-end1[iOuterEndDiameter]/2 + transitionBendRadius
            : end1[iOuterEndDiameter]/2 + transitionBendRadius
          : _transitionStyle == "taper+bend"
            ? transitionEnd2Count > 1
              ? -(end2[iOuterStartDiameter]/2)/(cos(_transitionAngle)-1)-end2[iOuterStartDiameter]/2 + transitionBendRadius
              : end2[iOuterStartDiameter]/2 + transitionBendRadius
            : _transitionStyle == "hull"
              ? 0
              : 0;

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
    
          for (rotation = [0:transitionEnd2Count-1])
          {
            if(sliceDebug == false || rotation ==0)
            rotate([0, 0, rotation*(360/transitionEnd2Count)])
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
