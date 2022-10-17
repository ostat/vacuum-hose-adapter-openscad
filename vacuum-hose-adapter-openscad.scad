// Hose connector
// version 2022-09-27

include <vacuum-hose-adapter-modules.scad>

/* [General ] */
Wall_Thickness = 2; //0.1

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

/* [Connector 1] */
//The style of the end
End1_Style="flange"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]

// End 1 diameter of the adapter (mm)
End1_Diameter = 50;  //1

//Length of the start connector (including the flange).
End1_Length= 15;  //1

//Taper of the start connector, use negative to taper other direction.
End1_Taper = 0;  //0.1

/* [Connector 1 - Hose connector] */
//Thickness of hose stop
End1_StopThickness = 6;  //1

//Length of hose stop
End1_StopLength = 5;  //1

/* [Connector 1 - Flange] */
//Outer diameter of the flange
End1_Flange_Outer_Diameter = 80;

//Thickness of the flange
End1_Flange_Thickness = 5;

//Number of Screw holes flange
End1_Screw_Count = 4;

//The diameter of the screws (mm)
End1_Screw_Diameter = 5;  //0.1

/* [Connector 1 - Magnetic Connector] */
//Number of magnets in the connector
End1_Magnets_Count = 8;

//The diameter of the magnets (mm)
End1_Magnet_Diameter = 10.5;  //0.1

//The thickness of the magnets (mm)
End1_Magnet_Thickness = 2.5;  //0.1

//Size of the material around the magnets (mm)
End1_Magnet_Border = 2;  //0.1

// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 6;  //0.1

// Include a flange alignment ring
End1_Ring = "no"; //[no: No alignment ring, protruding: protruding ring, recessed: Recessed ring]

/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "tapered"; //[tapered, flat, sweep]

//Length of the transition between the two ends
Transition_Length = 10;  //1

// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1

//Angle of bend through the transition section.
Transition_Angle = 0;  //1

/* [Connector 2] */
End2_Style="hose"; // [mag: Magnetic Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]

// End 2 diameter of the adapter (mm)
End2_Diameter = 40;  //1

//Length of the pipe coming out of the flange.
End2_Length= 40;  //1

//Taper of the start connector, use negative to taper other direction.
End2_Taper = 2;  //0.1

/* [Connector 2 - Hose connector] */
//Thickness of hose stop 
End2_StopThickness = 0;  //1

//Length of hose stop
End2_StopLength = 0;  //1
    
/* [Connector 2 - Magnetic Flange] */

//Number of magnets in the flange
End2_Magnets_Count = 6;  //1

//The diameter of the magnets
End2_Magnet_Diameter = 12;  //0.1

//The thickness of the magnets
End2_Magnet_Thickness = 3;  //0.1

//Size of the material around the magnets
End2_Magnet_Border = 2;  //0.1

// Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;  //0.1

// Include a flange alignment ring
End2_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]

/* [Hidden] */
fudgeFactor = 0.015;

//Detail
$fn=120;

HoseAdapter(
    wallThickness = Wall_Thickness,
    drawAlignmentRing = Draw_Alignment_Ring,
    alignmentDepth = Alignment_Depth,
    alignmentUpperWidth = Alignment_Upper_Width,
    alignmentLowerWidth = Alignment_Lower_Width,
    alignmentSideClearance = Alignment_Side_Clearance,
    alignmentDepthClearance = Alignment_Depth_Clearance,
    connector1Style = End1_Style,
    connector1Measurement = End1_Measurement,
    connector1Diameter = End1_Diameter,
    connector1Length = End1_Length,
    connector1Taper = End1_Taper,
    connector1StopThickness = End1_StopThickness,
    connector1StopLength = End1_StopLength,
    connector1MagnetCount = End1_Magnets_Count,
    connector1MagnetDiameter = End1_Magnet_Diameter,
    connector1MagnetThickness = End1_Magnet_Thickness,
    connector1MagnetBorder = End1_Magnet_Border,
    connector1MagnetFlangeThickness = End1_Magnet_Flange_Thickness,
    connector1Ring = End1_Ring,
    connector1FlangeOuterDiameter = End1_Flange_Outer_Diameter,
    connector1FlangeThickness = End1_Flange_Thickness,
    connector1FlangeScrewCount = End1_Screw_Count,
    connector1FlangeScrewDiameter = End1_Screw_Diameter,
    transitionStyle = Transition_Style,
    transitionLength = Transition_Length,
    transitionBendRadius = Transition_Bend_Radius,
    transitionAngle = Transition_Angle,
    connector2Style = End2_Style,
    connector2Measurement = End2_Measurement,
    connector2Diameter = End2_Diameter,
    connector2Length = End2_Length,
    connector2Taper = End2_Taper,
    connector2StopThickness = End2_StopThickness,
    connector2StopLength = End2_StopLength,
    connector2MagnetCount = End2_Magnets_Count,
    connector2MagnetDiameter = End2_Magnet_Diameter,
    connector2MagnetThickness = End2_Magnet_Thickness,
    connector2MagnetBorder = End2_Magnet_Border,
    connector2MagnetFlangeThickness = End2_Magnet_Flange_Thickness,
    connector2Ring = End2_Ring
);