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
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "outer"; //[inner, outer]
// End 1 diameter of the adapter (mm, inch)
End1_Diameter = [100,0];  //0.01
//Length of the start connector, including the flange (mm, inch).
End1_Length = [40,0];  //0.1
//Taper of the start connector, use negative to taper other direction.
End1_Taper = 1;  //0.1

/* [Connector 1 - Extension] */
End1_Extension_SlipRing= "disabled"; //[disabled, notaper: non tapered, inner, outer]
End1_Extension_SlipRing_Width = 5;
//Add breakaway supports to the slip ring gap.
End1_Extension_SlipRing_Support = "disabled"; //[disabled, enabled, internal, external]
//Diameter of the breakaway supports.
End1_Extension_SlipRing_Support_Size = 0.2; //0.1
//Approximate spacing between supports around the selected opening.
End1_Extension_SlipRing_Support_Spacing = 5; //0.1
//Thickness of hose stop
End1_Extension_StopThickness = 0;  //1
//Length of hose stop
End1_Extension_StopLength = 0;  //1
//Should the stop be tapered both sides. Might easier to print.
End1_Extension_Stop_Symmetrical = false;

/* [Connector 1 - Hose connector] */
//Number of barbs
End1_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End1_Barbs_Thickness = 0; //0.1
//Should the barbs be tapered both sides. Might be easier to print.
End1_Barbs_Symmetrical = false;

/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "bend+taper"; //[flat, bend+taper: Bend and taper, organicbend: Tapered bend]
//Length of the transition between the two ends
Transition_Length = 0;  //1
//Angle of bend through the transition section.
Transition_Angle = 0;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1
// Select the bend pipe's inside diameter from the two ends, or enter a custom value
Transition_Bend_Pipe_Diameter = "larger"; //[larger, smaller, custom]
// Inside diameter of the bend pipe when custom is selected
Transition_Custom_Bend_Pipe_Diameter = 40; //0.1

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

/* [Connector 2 - Extension] */
End2_Extension_SlipRing= "disabled"; //[disabled, notaper: non tapered, inner, outer]
End2_Extension_SlipRing_Width = 5;
//Add breakaway supports to the slip ring gap.
End2_Extension_SlipRing_Support = "disabled"; //[disabled, enabled, internal, external]
//Diameter of the breakaway supports.
End2_Extension_SlipRing_Support_Size = 0.2; //0.1
//Approximate spacing between supports around the selected opening.
End2_Extension_SlipRing_Support_Spacing = 5; //0.1
//Thickness of hose stop
End2_Extension_StopThickness = 0;  //1
//Length of hose stop
End2_Extension_StopLength = 0;  //1
//Should the stop be tapered both sides. Might easier to print.
End2_Extension_Stop_Symmetrical = false;

/*[Connector 2 - Hose connector] */
//Number of barbs
End2_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End2_Barbs_Thickness = 0; //0.1
//Should the barbs be tapered both sides. Might be easier to print.
End2_Barbs_Symmetrical = false;

/* [other] */
//Slice model in half to be able to easy see inside
Enable_Debug_Slice = "disable"; //[disable, enable, preview only]
//Will only show if debug is also enabled
Enable_Calipers_Slice = "disable"; //[disable, enable, preview only]
Enable_Help = false;
End1_Color = ["",1];  //0.1
End2_Color = ["",1];  //0.1
Transition_Color = ["",1]; //The color, then the alpha value
Extension_Color = ["",0.7]; //The color, then the alpha value

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
    style="hose",
    wallThickness=End1_Wall_Thickness,
    measurement=End1_Measurement,
    diameter=End1_Diameter,
    length=End1_Length,
    taper=End1_Taper,
    barbsCount=End1_Barbs_Count,
    barbsThickness=End1_Barbs_Thickness,
    barbsSymmetrical=End1_Barbs_Symmetrical,
    extensionSlipRing=End1_Extension_SlipRing,
    extensionSlipRingWidth=End1_Extension_SlipRing_Width,
    extensionSlipRingSupport=End1_Extension_SlipRing_Support,
    extensionSlipRingSupportSize=End1_Extension_SlipRing_Support_Size,
    extensionSlipRingSupportSpacing=End1_Extension_SlipRing_Support_Spacing,
    extensionStopThickness=End1_Extension_StopThickness,
    extensionStopLength=End1_Extension_StopLength,
    extensionStopSymmetrical=End1_Extension_Stop_Symmetrical),

  connector2 = UserConnectorSettings(
    connector=2,
    style="hose",
    wallThickness=End2_Wall_Thickness,
    measurement=End2_Measurement,
    diameter=End2_Diameter,
    length=End2_Length,
    taper=End2_Taper,
    barbsCount=End2_Barbs_Count,
    barbsThickness=End2_Barbs_Thickness,
    barbsSymmetrical=End2_Barbs_Symmetrical,
    extensionSlipRing=End2_Extension_SlipRing,
    extensionSlipRingWidth=End2_Extension_SlipRing_Width,
    extensionSlipRingSupport=End2_Extension_SlipRing_Support,
    extensionSlipRingSupportSize=End2_Extension_SlipRing_Support_Size,
    extensionSlipRingSupportSpacing=End2_Extension_SlipRing_Support_Spacing,
    extensionStopThickness=End2_Extension_StopThickness,
    extensionStopLength=End2_Extension_StopLength,
    extensionStopSymmetrical=End2_Extension_Stop_Symmetrical),

  transitionStyle = Transition_Style,
  transitionLength = Transition_Length,
  transitionBendRadius = Transition_Bend_Radius,
  transitionBendPipeDiameter = Transition_Bend_Pipe_Diameter,
  transitionCustomBendPipeDiameter = Transition_Custom_Bend_Pipe_Diameter,
  transitionAngle = Transition_Angle,

  sliceDebug = renderModeEnabled(Enable_Debug_Slice),
  showCaliper = renderModeEnabled(Enable_Calipers_Slice),
  end1Color = End1_Color,
  end2Color = End2_Color,
  transitionColor = Transition_Color,
  extensionColor = Extension_Color,
  help = Enable_Help
);
