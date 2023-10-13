// Hose connector modules
// version 2023-07-24
use <dotSCAD/ring_extrude.scad>
use <dotSCAD/shape_circle.scad>
use <modules/ub.scad>
// https://justinsdk.github.io/dotSCAD/


//TODO Ideas
//All pre and post trasition length. so a flat section before and after the taper.abs
//Allow rotation of each end, handy for the dw735 for example. 

/* [Hidden] */
fudgeFactor = 0.015;

dysonMinLength = 46;
dysonMeasurement = "outer";
dysonOuterDiameter = 34;
dysonInnerDiameter = 28.5;

camlockMinLength = 35+3;
camlockMeasurement = "outer";
camlockOuterDiameter = 24.25*2;

dw735MinLength = 17;
dw735Measurement = "inner";
dw735InnerDiameter = 71;

/* [Connector 1] */
//Wall thickness
End1_Wall_Thickness = 2; //0.01
//The style of the end
End1_Style="flange"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, dyson: Dyson connector, camlock: CAMLOCK connetor, dw735: Dewalt DW735x]
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]
// End 1 diameter of the adapter (mm)
End1_Diameter = 50;  //0.1
//Length of the start connector (including the flange).
End1_Length= 15;  //0.1
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
End1_Stop_Symmetrical = 0;
//Number of barbs
End1_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End1_Barbs_Thickness = 0; //0.1
//Should the barbes be tapered both sides. Might be easier to print.
End1_Barbs_Symmetrical = 0; //[0,1]
//End Cap Inner Diameter.
End1_Hose_EndCap_Diameter = 0;  //0.1
//Thickness of endcap.
End1_Hose_EndCap_Thickness = 0;  //0.1

/* [Connector 1 - Flange] */
//Width of Flange added to the connector diamater
End1_Flange_Width = 20;
//Thickness of the flange
End1_Flange_Thickness = 5;
//Position of the screws added to the connector diamater, 0 = middle of flange
End1_Flange_Screw_Position= 0;
//Minium amount of the material around the magnets (mm), 0 = End1_Flange_Width / 4
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
// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 6;  //0.1
// Include a flange alignment ring
End1_Ring = "no"; //[no: No alignment ring, protruding: protruding ring, recessed: Recessed ring]

/* [Transition] */
// tapered for hose connections, flat for attaching to a device
Transition_Style = "bend+taper"; //[flat, taper+bend: Taper then bend, bend+taper: Bend then taper, organicbend: Tapered bend, hull: Hull for multiple end count, none: no transition]
//Length of the transition between the two ends
Transition_Length = 10;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 0;  //1
//Angle of bend through the transition section.
Transition_Angle = 0;  //1
// X offset for the connector, not supported on taperedbend.
Transition_xOffset = 0; // 0.1
// Y offset for the connector, not supported on taperedbend.
Transition_yOffset = 0; // 0.1
/* [Transition Multiple connector settings] */
// Dupliacte the second connector. Adjust angle and bend radius to make it work.
Transition_End2_Count = 1;  //[1, 2, 3, 4, 5, 6]
// MulitConnector, connector in hull length.
Transition_HullLength = 0; // 0.1
// MulitConnector, connector in hull offset.
Transition_HullyOffset = 0; // 0.1
// MulitConnector, add center connector.
Transition_HullCenter = false;
// MulitConnector, center connector height. default is 2*lengthInHull
Transition_HullCenterHeight = 0;
  

/* [Transition Support For Angled Pipes] */
// Include a flate section on the transition to assist with printing
Transition_Base_Type="none"; // [none, oval, rectangle]
//Support Base Additional Thickness;
Transition_Base_Thickness=0;
//Support Base Width, Default is half diameter;
Transition_Base_Width=0;
// Support Base Length Default is 2/3 diameter;;
Transition_Base_Length=0;
// Support Base Angle position, default half of Bend Radius;
Transition_Base_Angle=0;

/* [Connector 2] */
//Wall thickness
End2_Wall_Thickness = 2; //0.01
End2_Style="nozzle"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, nozzle: Nozzle attachement, none: None]
// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm)
End2_Diameter = 40;  //0.1
//Length of the pipe coming out of the flange.
End2_Length= 40;  //1
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
End2_Stop_Symmetrical = 0;
//Number of barbs
End2_Barbs_Count = 0;
//Thickness of the barbs, default is half wall thickness
End2_Barbs_Thickness = 0; //0.1
//Should the barbes be tapered both sides. Might be easier to print.
End2_Barbs_Symmetrical = 0; //[0,1]
//End Cap Inner Diameter.
End2_Hose_EndCap_Diameter = 0;  //0.1
//Thickness of endcap.
End2_Hose_EndCap_Thickness = 0;  //0.1

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
// Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;  //0.1
// Include a flange alignment ring
End2_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]

/* [Connector 2 - Nozzle] */
// Is the measurement the adapter's outside or inside diameter?
End2_Nozzle_Shape = "square"; //[square, circle]
End2_Nozzle_Square_Width = 10; //0.1
End2_Nozzle_Square_Depth = 5; //0.1
End2_Nozzle_Tip_Wall_Thickness = 0; //0.1
End2_Nozzle_Radius = 0; //0.1
End2_Nozzle_Length = 10;
End2_Nozzle_xOffset = 0; //0.1
End2_Nozzle_yOffset = 0; //0.1
End2_Nozzle_Chamfer_Percentage = 0; //0.1
End2_Nozzle_Chamfer_Angle = 0; //0.1

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

/* [Hidden] */
//Detail
$fn=120;

HoseAdapter(
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
  connector1MagnetFlangeThickness = End1_Magnet_Flange_Thickness,
  connector1Ring = End1_Ring,

  connector1FlangeWidth = End1_Flange_Width,
  connector1FlangeThickness = End1_Flange_Thickness,
  connector1FlangeScrewPosition = End1_Flange_Screw_Position,
  connector1FlangeScrewBorder = End1_Flange_Screw_Border,
  connector1FlangeScrewCount = End1_Flange_Screw_Count,
  connector1FlangeScrewDiameter = End1_Flange_Screw_Diameter,


  transitionStyle = Transition_Style,
  transitionLength = Transition_Length,
  transitionBendRadius = Transition_Bend_Radius,
  transitionAngle = Transition_Angle,
  transitionXOffset = Transition_xOffset,
  transitionYOffset = Transition_yOffset,
  transitionBaseType = Transition_Base_Type,
  transitionBaseThickness = Transition_Base_Thickness,
  transitionBaseWidth = Transition_Base_Width,
  transitionBaseLength = Transition_Base_Length,
  transitionBaseAngle = Transition_Base_Angle,
  transitionEnd2Count = Transition_End2_Count,
  transitionHullLength = Transition_HullLength,
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
  connector2MagnetFlangeThickness = End2_Magnet_Flange_Thickness,
  connector2Ring = End2_Ring,

  connector2FlangeWidth = End2_Flange_Width,
  connector2FlangeThickness = End2_Flange_Thickness,
  connector2FlangeScrewPosition = End2_Flange_Screw_Position,
  connector2FlangeScrewBorder = End2_Flange_Screw_Border,
  connector2FlangeScrewCount = End2_Flange_Screw_Count,
  connector2FlangeScrewDiameter = End2_Flange_Screw_Diameter,
  
  connector2NozzleShape = End2_Nozzle_Shape,
  connector2NozzleSquareWidth = End2_Nozzle_Square_Width,
  connector2NozzleSquareDepth = End2_Nozzle_Square_Depth,
  connector2NozzleTipWallThickness = End2_Nozzle_Tip_Wall_Thickness,
  connector2NozzleRadius = End2_Nozzle_Radius,
  connector2NozzleLength = End2_Nozzle_Length,
  connector2NozzlexOffset = End2_Nozzle_xOffset,
  connector2NozzleyOffset = End2_Nozzle_yOffset,
  connector2NozzleChamferPercentage = End2_Nozzle_Chamfer_Percentage,
  connector2NozzleChamferAngle = End2_Nozzle_Chamfer_Angle,
  sliceDebug = Enable_Debug_Slice
);




//diameter1: Inner start diameter.
//diameter2: Inner end diameter.
//length: pipe length
//wallThickness1 Thickness of the walls at the start
//wallThickness2 Thickness of the walls at the end
//zPosition: Start Z position.
module Pipe(
    diameter1,
    diameter2,
    length,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    xOffset = 0,
    yOffset = 0)
{
  difference ()
  {
    //outer cylinder
    translate([0,0,zPosition])
    hull()
    {
      cylinder(fudgeFactor, d=diameter1+2*wallThickness1);
      translate([xOffset,yOffset,length-fudgeFactor])
        cylinder(fudgeFactor, d=diameter2+2*wallThickness2);
    }

    //Inner cylinder to remove
    translate([0,0,zPosition-fudgeFactor])
    hull()
    {
      cylinder(fudgeFactor, d=diameter1);
      translate([xOffset,yOffset,length+2*fudgeFactor])
        cylinder(fudgeFactor, d=diameter2);
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
    end1WallThickness,
    end2WallThickness,
    pipeAngle = 0,
    zPosition=0,
    end2Count=1,
    lengthInHull=0,
    lengthOutHull=0,
    edgeOffset = 0,
    addCenter = false,
    centerHeight= 0
)
{
  outer1PipeRadius = inner1PipeRadius+ end1WallThickness;
  outer2PipeRadius = inner2PipeRadius + end2WallThickness;
  //_edgeOffset = outer1PipeRadius - outer2PipeRadius - edgeOffset;
  _edgeOffset = edgeOffset;

  end1BaseHeight = end1WallThickness;
  end2BaseHeight = end2WallThickness;
  
  echo(_edgeOffset = _edgeOffset, lengthInHull = lengthInHull, centerHeight=centerHeight, lengthOutHull=lengthOutHull, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, a= (cos(pipeAngle) * outer2PipeRadius*2) );
  
  difference(){
    //Outer shape
    union(){
      hull(){
        for (rotation = [0:end2Count-1])
        {
          rotate([0,0,rotation*(360/end2Count)])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, lengthInHull])
          cylinder(r=outer2PipeRadius, h=end2WallThickness);
        }
        cylinder(r=outer1PipeRadius, h=end1BaseHeight+fudgeFactor);
      }

      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        echo("Outer shape", pipeAngle=pipeAngle, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, _edgeOffset=_edgeOffset, lengthInHull=lengthInHull, end2WallThickness=end2WallThickness );

        rotate([0,0,rotation*(360/end2Count)])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, lengthInHull])
        cylinder(r=outer2PipeRadius, h=lengthOutHull+fudgeFactor);
      }
      
      if(addCenter)
      {
          translate([0, 0, centerHeight])
          cylinder(r=outer2PipeRadius, h=lengthOutHull);
          cylinder(r1 =outer1PipeRadius, r2=outer2PipeRadius, h=centerHeight);
      }
    }

    //inner/negative shape
    union(){
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*(360/end2Count)])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
          cylinder(r=inner2PipeRadius, h=end2WallThickness+fudgeFactor*2);
        }

        //End 1
        cylinder(r=inner1PipeRadius, h=end1BaseHeight+fudgeFactor*2);
      }

      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        rotate([0,0,rotation*(360/end2Count)])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
        cylinder(r=inner2PipeRadius, h=lengthOutHull+end2WallThickness*2+fudgeFactor*2);
      }
      
      if(addCenter)
      {
          translate([0, 0, centerHeight-fudgeFactor])
          cylinder(r=inner2PipeRadius, h=lengthOutHull+fudgeFactor*2);
          cylinder(r1=inner1PipeRadius, r2=inner2PipeRadius, h=centerHeight);
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

// rotate as per a, v, but around point pt
module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();
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
    end2Count=1
)
{
  outerPipeDiameter  = innerPipeDiameter + wallThickness * 2;

  baseSupportThickness = outerPipeDiameter/2 + baseThickness;
  baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
  baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
  baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

  echo("BentPipe", bendRadius=bendRadius, innerPipeDiameter=innerPipeDiameter,wallThickness=wallThickness, pipeAngle=pipeAngle, zPosition=zPosition);
  echo("BentPipe", baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);


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
            translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
          else if (baseType == "oval")
            resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
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

    echo("TaperedBentPipe", bendRadius=bendRadius, end1InnerPipeDiameter=end1InnerPipeDiameter, end2InnerPipeDiameter=end2InnerPipeDiameter, end1WallThickness=end1WallThickness, end2WallThickness=end2WallThickness);

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

    echo("TaperedBentPipe", baseSupportThickness=baseSupportThickness,  baseSupportAngle=baseSupportAngle,  baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);

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
    screwDiameter
)
{
  //The fillet around the edge
  fillet = flangeThickness;
  border = screwBorder == 0 ? flangeWidth/4 : screwBorder;
  flangeOuterDiameter = innerStartDiameter + flangeWidth;
  screwPositionRadius = screwPosition != 0
    ? innerStartDiameter/2 + screwPosition/2
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
            cylinder (d = screwDiameter + border, h = flangeThickness);
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
}


module MagneticConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    magnetDiameter,
    magnetThickness,
    magnetBorder,
    flangeThickness,
    magnetCount,
    alignmentRing,
    alignmentDepth,
    alignmentUpperWidth,
    alignmentLowerWidth,
    alignmentSideClearance,
    alignmentDepthClearance
)
{

    alignmentBorder = alignmentRing != "no" ? magnetBorder/2 : 0;
    magnetPosition = (innerStartDiameter + magnetDiameter) / 2 + magnetBorder +
        (alignmentRing != "no" ? alignmentBorder + alignmentUpperWidth : 0);

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
                for (i = [0: magnetCount-1]) {
                    rotate ([0, 0, i * (360 / magnetCount)])
                    translate ([magnetPosition, 0, 0])
                    cylinder (d = magnetDiameter + magnetBorder * 2, flangeThickness);
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
            translate ([magnetPosition, 0, - fudgeFactor])
            cylinder (d = magnetDiameter, h = magnetThickness + fudgeFactor);
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


module DysonConnector(
  innerEndDiameter,
  length,
  wallThickness,
  IncludeOrientationClip = true
){
  heightStartShaft = 10;
  heightCutout= 4.45;
  heightCutoutTapper = 2.75;
  //heightMainShaft = 28;

  orientationClipHeight = 37-.5;

  orientationClipCenter = 5.5;
  orientationClipTaper = 2;
  orientationClipLength = orientationClipCenter + orientationClipTaper*2;
  heightMainShaft = orientationClipHeight - (heightStartShaft+heightCutout+heightCutoutTapper) + orientationClipLength;
  height = heightStartShaft+heightCutout+heightCutoutTapper+heightMainShaft;
  innerDiameter = 28.5;
  outerDiameter = 34;

  cutoutRadius = 30.7;// dysonInnerDiameter/2;
  innerRadius = innerDiameter/2;
  outerRadius = outerDiameter/2;
  orentationRadius = 34.5/2;

  union() {

    difference() {
      union() {
        // Dyson connector
        translate([0,0,0])
          cylinder(r=outerRadius, h=heightStartShaft);
        translate([0,0,heightStartShaft])
          cylinder(r=outerRadius-1.5, h=heightCutout);
        translate([0,0,heightStartShaft+heightCutout])
          cylinder(r1=outerRadius-1.5, r2=outerRadius, h=heightCutoutTapper);
        translate([0,0,heightStartShaft+heightCutout+heightCutoutTapper])
          cylinder(r=outerRadius, h=heightMainShaft);

        // orientation clip
        if(IncludeOrientationClip == true){
          translate([0,0,orientationClipHeight]) difference() {
            union() {
              cylinder(r1=outerRadius, r2=outerRadius+1.5, h=orientationClipTaper);
              translate([0,0,orientationClipTaper])
                cylinder(r=outerRadius+1.5, h=orientationClipCenter);
              translate([0,0,orientationClipCenter + orientationClipTaper])
              cylinder(r1=outerRadius+1.5, r2=outerRadius, h=orientationClipTaper);
            }

            
            for(i=[0,90,180,270])
            {
              rotate([0,0,i])
              difference() {
                //Circle cutout for clip
                translate([0,-34.5/2+4,-23/2+6.5]) rotate([90,0,0])
                  cylinder(r1=23/2, r2=23.5/2, h=7);
                //Verticle clip lock
                hull() {
                  translate([0,-33.5/2,1.5]) rotate([90,0,0])
                    cylinder(r1=1.5, r2=1.25, h=2);
                  translate([0,-33.5/2,8-1.5]) rotate([90,0,0])
                    cylinder(r1=1.5, r2=1.25, h=2);
                }
              }
            }
          }
        }
      }

      //remove center
      translate([0,0,-fudgeFactor])
        cylinder(r=innerRadius, h=height+2);
    }
    /*
    echo("DysonConnector", innerRadius, innerDiameter, length, height);
    Pipe (
        diameter1 = innerDiameter,
        diameter2 = innerEndDiameter,
        length = length - height,
        wallThickness1 = (outerDiameter - innerDiameter)/2,
        wallThickness2 = wallThickness,
        zPosition = height);*/

  }
}

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
  fixedPinLength = 4.5;
  
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
          wallThickness = fixedPinLength);
        
        for (rotation = [0:_connectorCount-1])
        {
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
      length = camlockHeight,
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

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleSquareWidth,
  nozzleSquareDepth,
  nozzleTipWallThickness,
  nozzleRadius,
  nozzleLength,
  nozzlexOffset = 0,
  nozzleyOffset = 0,
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0
)
{
  innerRadius = innerStartDiameter/2;

  circlepositionx = nozzleShape == "square" ? nozzleSquareDepth/2 - nozzleRadius : 0;
  circlepositiony = nozzleShape == "square" ? nozzleSquareWidth/2 - nozzleRadius : 0;
  circlepositions = nozzleShape == "square" ?
    [[ circlepositionx, circlepositiony ],
    [ -circlepositionx, circlepositiony ],
    [ circlepositionx, -circlepositiony ],
    [ -circlepositionx, -circlepositiony ]] : [[ circlepositionx, circlepositiony ]] ;

  nozzleWidth = (nozzleShape == "square" ? nozzleSquareDepth : nozzleRadius * 2) + wallThickness*2;
  nozzleDepth = (nozzleShape == "square" ? nozzleSquareWidth : nozzleRadius * 2) + wallThickness*2;
  nozzleWidthChamfer = nozzleWidth * nozzleChamferPercentage /100;
  nozzleLengthChamfer = nozzleWidthChamfer * tan(nozzleChamferAngle);

  tipWallThickness = nozzleTipWallThickness == 0 ? wallThickness : nozzleTipWallThickness;

  widthChamfer = min(nozzleWidthChamfer, nozzleWidth);
  lengthChamfer = min(nozzleLengthChamfer, nozzleLength);

  echo("nozzle", innerRadius=innerRadius, circlepositionx=circlepositionx, circlepositiony=circlepositiony, nozzleWidth=nozzleWidth, nozzleDepth=nozzleDepth, nozzleWidthChamfer=nozzleWidthChamfer, nozzleLengthChamfer=nozzleLengthChamfer, widthChamfer=widthChamfer, lengthChamfer=lengthChamfer);

  difference()
  {
    //Outer Shape
    union()
    {
      // Nozzle base
      hull()
      {
        cylinder(fudgeFactor*2, r=innerRadius+wallThickness);
        translate([nozzleyOffset,nozzlexOffset,length + fudgeFactor])
        hull() for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=nozzleRadius+wallThickness+fudgeFactor);
      }

      // Nozzle
      translate([nozzleyOffset,nozzlexOffset,length + fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
      {
        translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=nozzleRadius+wallThickness+fudgeFactor);
        translate([circlepositions[i][0], circlepositions[i][1], nozzleLength])
          cylinder(fudgeFactor, r=nozzleRadius+tipWallThickness+fudgeFactor);
      }
    }

    //Inner shape
    union()
    {
      // Nozzle base
      hull()
      {
        translate([00,0,-fudgeFactor])
          cylinder(fudgeFactor*2, r=innerRadius);
        translate([nozzleyOffset,nozzlexOffset,length+fudgeFactor])
          hull() for (i= [ 0 : len(circlepositions) - 1 ])
            translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(fudgeFactor*2, r=nozzleRadius+fudgeFactor);
      }

      // Nozzle
      translate([nozzleyOffset,nozzlexOffset,length+fudgeFactor*2])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
        translate([circlepositions[i][0], circlepositions[i][1], 0])
        cylinder(nozzleLength+fudgeFactor*2, r=nozzleRadius+fudgeFactor);
    }

    // Chamfer
    if(widthChamfer > 0 && lengthChamfer > 0)
    {
      translate([0,0,nozzleLength+length+fudgeFactor*3] )
        rotate([90,0,180])
        linear_extrude(nozzleDepth+1, center=true)
          polygon( points = [[nozzleWidth/2-widthChamfer,0],
                              [nozzleWidth/2+fudgeFactor*2,0],
                              [nozzleWidth/2+fudgeFactor*2,-lengthChamfer]] );
    }
  }
}

module HoseConnector(
    innerStartDiameter,
    innerEndDiameter,
    connectorMeasurement,
    length,
    wallThickness,
    stopLength,
    stopWidth,
    stopSymmetrical = 0,
    barbsCount = 0,
    barbsThickness = 0,
    barbsSymmetrical = 0,
    endCapDiameter = 0,
    endCapThickness = 0,
    chamferLength = 0,
    chamferWidth = 0
)
{
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
            diameter = innerStartDiameter+wallThickness,
            outer = connectorMeasurement == "outer",
            totalLength = barbLength,
            taper1 = barbsSymmetrical == 0 ? 1 : 0.4,
            taper2 = barbsSymmetrical == 0 ? 0 : 0.4,
            wallThickness = wallThickness/2,
            stopThickness = _barbsThickness);
      }
    }
    
    // Create the end cap
    if(endCapThickness > 0)
    {
      difference () 
      {
        cylinder(endCapThickness, d=innerEndDiameter + wallThickness/2);
        translate([0,0,-fudgeFactor])
          cylinder(endCapThickness + fudgeFactor * 2, d=endCapDiameter);
      }
    }

    // Create the hose stop
    if(stopWidth > 0)
    {
      Stopper(
        diameter = innerEndDiameter,
        outer = connectorMeasurement == "outer",
        totalLength = stopLength,
        taper1 = stopSymmetrical == 0 ? 0.5 : 0.4,
        taper2 = stopSymmetrical == 0? 0 : 0.4,
        wallThickness = wallThickness,
        stopThickness = stopWidth,
        zPosition = length);
    }
  }
}

//TODO This seems slow, esp when used for barbs
  
module Stopper(
    diameter,
    outer,
    totalLength,
    taper1,
    taper2,
    wallThickness,
    stopThickness,
    zPosition = 0
)
{
  echo("Stopper", diameter= diameter, outer=outer, totalLength=totalLength,taper1 =taper1, taper2=taper2,wallThickness=wallThickness, stopThickness=stopThickness, zPosition=zPosition );
    
  intersection()
  {
    flat = totalLength * (1 - taper1 - taper2);
    StraightPipe (
      diameter = outer ? diameter : diameter-stopThickness*2,
      length = totalLength,
      wallThickness = wallThickness + stopThickness,
      zPosition = zPosition);

      _diameter = outer ? diameter : diameter + wallThickness*2;
  
      //Bottom taper
      if(taper1 > 0)
      {
        taperLength1 = totalLength * taper1;
        zoffset1 = wallThickness*taperLength1/stopThickness;
        length1= (zoffset1 + totalLength);
        width1 = length1 * stopThickness / taperLength1;
        diameterstart1 = _diameter;
        diameterend1 = outer ? _diameter :_diameter - width1*2;
        Pipe (
          diameter1 = diameterstart1,
          diameter2 = diameterend1,
          length = length1,
          wallThickness1 = 0,
          wallThickness2 = width1,
          zPosition = zPosition-zoffset1);
      }

      //Top taper
      if(taper2 > 0)
      {
        taperLength2 = totalLength * taper2;
        zoffset2 = wallThickness * taperLength2 / stopThickness;
        length2 = (zoffset2 + totalLength);
        width2 = length2 * stopThickness / taperLength2;
        diameterstart2 = outer ? _diameter :_diameter - width2*2;
        diameterend2 = _diameter;
        Pipe (
          diameter1 = diameterstart2,
          diameter2 = diameterend2,
          length = length2,
          wallThickness1 = width2,
          wallThickness2 = 0,
          zPosition = zPosition);
        
      }
   }
}

module HoseAdapter(
    drawAlignmentRing = "no",
    alignmentDepth = 2,
    alignmentUpperWidth = 3,
    alignmentLowerWidth = 0.5,
    alignmentSideClearance = 0.25,
    alignmentDepthClearance = .75,

    connector1WallThickness = 2,
    connector1Style= "hose",
    connector1Measurement= "inner",
    connector1Diameter = 0,
    connector1Length = 0,
    connector1Rotation = 0,
    connector1Taper = 0,
    connector1EndCapDiameter = 0,
    connector1EndCapThickness = 0,
    connector1StopThickness = 0,
    connector1StopLength = 0,
    connector1StopSymmetrical = 0,
    connector1BarbsCount = 0,
    connector1BarbsThickness = 0,
    connector1BarbsSymmetrical = 0,
    connector1MagnetCount = 0,
    connector1MagnetDiameter = 0,
    connector1MagnetThickness = 0,
    connector1MagnetBorder = 0,
    connector1MagnetFlangeThickness = 0,
    connector1Ring= "no",
    connector1FlangeWidth = 0,
    connector1FlangeThickness = 0,
    connector1FlangeScrewPosition = 0,
    connector1FlangeScrewBorder = 0,
    connector1FlangeScrewCount = 0,
    connector1FlangeScrewDiameter = 0,

    transitionStyle = "tapered",
    transitionLength = 0,
    transitionBendRadius = 0,
    transitionAngle = 0,
    transitionXOffset = 0,
    transitionYOffset = 0,
    transitionBaseType = "none",
    transitionBaseThickness =0 ,
    transitionBaseWidth =0 ,
    transitionBaseLength = 0,
    transitionBaseAngle = 0,
    transitionEnd2Count = 1,
    transitionHullLength = 0,
    transitionHullyOffset = 0,
    transitionHullCenter = false,
    transitionHullCenterHeight= 0,
  
    connector2WallThickness = 2,
    connector2Style = "hose",
    connector2Measurement = "inner",
    connector2Diameter = 0,
    connector2Length = 0,
    connector2Rotation = 0,
    connector2Taper = 0,
    connector2EndCapDiameter = 0,
    connector2EndCapThickness = 0,
    connector2StopThickness = 0,
    connector2StopLength = 0,
    connector2StopSymmetrical = 0,
    connector2BarbsCount = 0,
    connector2BarbsThickness = 0,
    connector2BarbsSymmetrical = 0,

    connector2MagnetCount = 0,
    connector2MagnetDiameter = 0,
    connector2MagnetThickness = 0,
    connector2MagnetBorder = 0,
    connector2MagnetFlangeThickness = 0,
    connector2Ring = "no",
    
    connector2FlangeWidth = 0,
    connector2FlangeThickness = 0,
    connector2FlangeScrewPosition = 0,
    connector2FlangeScrewBorder = 0,
    connector2FlangeScrewCount = 0,
    connector2FlangeScrewDiameter = 0,
    
    connector2NozzleShape = "square",
    connector2NozzleSquareWidth = 20,
    connector2NozzleSquareDepth = 10,
    connector2NozzleTipWallThickness = 0,
    connector2NozzleRadius = 5,
    connector2NozzleLength = 50,
    connector2NozzlexOffset = 0,
    connector2NozzleyOffset = 0,
    connector2NozzleChamferPercentage = 0,
    connector2NozzleChamferAngle = 0,
    sliceDebug = false
){
  //Apply defauls and overrides 
  connector1Measurement =
    (connector1Style == "camlock") ? camlockMeasurement :
    (connector1Style == "dyson") ? dysonMeasurement :
    (connector1Style == "dw735") ? dw735Measurement :
    connector1Measurement;
  
  connector1Diameter = 
    (connector1Style == "camlock") ? camlockOuterDiameter :
    (connector1Style == "dyson") ? dysonOuterDiameter :
    (connector1Style == "dw735") ? dw735InnerDiameter :
   connector1Diameter;
 
   connector1WallThickness = 
    (connector1Style == "dyson") ? (dysonOuterDiameter - dysonInnerDiameter)/2 :
    connector1WallThickness;
  
  end1InnerDiameter = 
    (connector1Measurement == "inner") ? connector1Diameter : 
    connector1Diameter - connector1WallThickness * 2;
  
  end2InnerDiameter = connector2Measurement == "inner" ? connector2Diameter : connector2Diameter - connector2WallThickness * 2;

  connector1Length = 
    (connector1Style == "dyson" && connector1Length < dysonMinLength) ? dysonMinLength :
    (connector1Style == "camlock") ? camlockMinLength :
    (connector1Style == "dw735" && connector1Length < dw735MinLength) ? dw735MinLength :
    connector1Length;
  
  echo(connector1Length = connector1Length, connector1Style = connector1Style, dw735MinLength = dw735MinLength);
  
  connector1Taper = 
    (connector1Style == "dyson") ? 0 : //dyson lock has no taper
    (connector1Style == "camlock") ? 0 : //cam lock has no taper
    (connector1Style == "dw735") ? 0 : //cam lock has no taper
    connector1Taper;

  //Apply taper, from small to big
  end1InnerStartDiameter = end1InnerDiameter - connector1Taper / 2;
  end1OuterStartDiameter = end1InnerStartDiameter + connector1WallThickness*2;
  end1InnerEndDiameter = end1InnerDiameter + connector1Taper / 2;
  end1OuterEndDiameter = end1InnerEndDiameter + connector1WallThickness*2;

  //Apply taper, from big to small
  end2InnerStartDiameter = end2InnerDiameter + connector2Taper / 2;
  end2OuterStartDiameter = end2InnerStartDiameter + connector2WallThickness*2;
  end2InnerEndDiameter = end2InnerDiameter - connector2Taper / 2;
  end2OuterEndDiameter = end2InnerEndDiameter + connector2WallThickness*2;

  //If the connector hose is not showm the stop has no thickenss
  connector1StopThickness = (connector1Length <= 0 || connector1Style == "mag" || connector1Style == "flange") ? 0 : connector1StopThickness;
  connector2StopThickness = (connector2Length <= 0 || connector2Style == "mag" || connector2Style == "flange") ? 0 : connector2StopThickness;

  //If the stop has no thickness, it needs no length
  connector1StopLength = (connector1StopThickness > 0 && connector1Style == "hose") ? connector1StopLength : 0;
  connector2StopLength = (connector2StopThickness > 0 && connector1Style == "hose") ? connector2StopLength : 0;


  //Transition settings 
  //Total length of connector 1
      endConnector1 = connector1Length + connector1StopLength;

      // transitionLength is not wanted for sweep
      _transitionAngle = (transitionStyle == "flat") ? 0 : transitionAngle;
      _transitionStyle = _transitionAngle == 0 && transitionStyle == "organicbend" ? "bend+taper" : transitionStyle;
      _transitionLength = _transitionStyle == "organicbend" || _transitionStyle == "hull"
        ? 0
        : transitionLength == 0
          ? abs(end1OuterEndDiameter - end2OuterStartDiameter)/2
          : transitionLength;

      //Calculate the bend radius
      //organicbend, the '0' value must be max of connector 1 or 2 diameter, plus the wall thickness * 2 otherwise it will clip, then add provided radius.
      //transition the '0' value must be end 1 diameter/2 + wall thickenss *2 to prevent clipping, then addd provided radius.

      //((end2InnerStartDiameter + connector1WallThickness)/ sin(_transitionAngle / 2)/2)/ sin(_transitionAngle) + transitionBendRadius
      taperedAverageDiameter = (max(end1OuterEndDiameter,end2OuterStartDiameter)*2 + min(end1OuterEndDiameter,end2OuterStartDiameter))/3;

      hoseSpacer = connector2WallThickness;
      shapeOverlap = ((end1OuterEndDiameter/2-hoseSpacer)-(cos(_transitionAngle)*end2OuterStartDiameter))/sin(_transitionAngle);
      lengthInHull = _transitionStyle == "hull"
        ? (shapeOverlap > 0 ? 0 : shapeOverlap * -1) + _transitionLength
        : 0;
      transitionCenterHeight = transitionHullCenterHeight == 0 ? lengthInHull * 2 : transitionHullCenterHeight;
  
      edgeOffset = _transitionStyle == "hull"
        ? (shapeOverlap > 0
          ? (end1OuterEndDiameter - end2OuterStartDiameter)/2-shapeOverlap/2 + transitionHullyOffset
          : (end1OuterEndDiameter - end2OuterStartDiameter)/2 + transitionHullyOffset) * cos(_transitionAngle)
        : 0;
      //end hull settings
      echo("hull settings", shapeOverlap=shapeOverlap, lengthInHull=lengthInHull, _transitionLength=_transitionLength,edgeOffset=edgeOffset );
      bendRadius = transitionStyle == "organicbend"
        ? transitionEnd2Count > 1
          ? -(taperedAverageDiameter/2)/(cos(_transitionAngle)-1)-taperedAverageDiameter/2 + transitionBendRadius
          : taperedAverageDiameter + transitionBendRadius
        : transitionStyle == "bend+taper"
          ? transitionEnd2Count > 1
            ? -(end1OuterEndDiameter/2)/(cos(_transitionAngle)-1)-end1OuterEndDiameter/2 + transitionBendRadius
            : end1OuterEndDiameter/2 + transitionBendRadius
          : transitionStyle == "taper+bend"
            ? transitionEnd2Count > 1
              ? -(end2OuterStartDiameter/2)/(cos(_transitionAngle)-1)-end2OuterStartDiameter/2 + transitionBendRadius
              : end2OuterStartDiameter/2 + transitionBendRadius
            : transitionStyle == "hull"
              ? 0
              : 0;
    
      
  if(drawAlignmentRing == "end1")
  {
      !AlignmentRing(
          centerDiameter = end1InnerStartDiameter + connector1MagnetBorder + alignmentUpperWidth,
          alignmentDepth = alignmentDepth,
          alignmentUpperWidth = alignmentUpperWidth,
          alignmentLowerWidth = alignmentLowerWidth,
          alignmentSideClearance = alignmentSideClearance,
          alignmentDepthClearance = alignmentDepthClearance,
          magnetBorder = connector1MagnetBorder);
  }

  if(drawAlignmentRing == "end2")
  {
      !AlignmentRing(
          centerDiameter = end2InnerStartDiameter + connector2MagnetBorder + alignmentUpperWidth,
          alignmentDepth = alignmentDepth,
          alignmentUpperWidth = alignmentUpperWidth,
          alignmentLowerWidth = alignmentLowerWidth,
          alignmentSideClearance = alignmentSideClearance,
          alignmentDepthClearance = alignmentDepthClearance,
          magnetBorder = connector2MagnetBorder);
  }

  
  difference()
  {
    union() 
    {
      color("LightPink")
      rotate([0,0,connector1Rotation])
      union(){
        //Create the start connector
        if(connector1Length > 0)
        {
          if(connector1Style == "mag")
          {
            connector1StopLength = 0;
            connector1StopThickness = 0;

            //Create the flange on end 1
            MagneticConnector(
                innerStartDiameter = end1InnerStartDiameter,
                innerEndDiameter = end1InnerEndDiameter,
                length = connector1Length,
                wallThickness = connector1WallThickness,
                magnetDiameter = connector1MagnetDiameter,
                magnetThickness = connector1MagnetThickness,
                magnetBorder = connector1MagnetBorder,
                flangeThickness = connector1MagnetFlangeThickness,
                magnetCount = connector1MagnetCount,
                alignmentRing = connector1Ring,
                alignmentDepth = alignmentDepth,
                alignmentUpperWidth = alignmentUpperWidth,
                alignmentLowerWidth = alignmentLowerWidth,
                alignmentSideClearance = alignmentSideClearance,
                alignmentDepthClearance = alignmentDepthClearance);
          }

          if(connector1Style == "flange")
          {
            connector1StopLength = 0;
            connector1StopThickness = 0;

            //Create the flange on end 1
            FlangeConnector(
              innerStartDiameter = end1InnerStartDiameter,
              innerEndDiameter = end1InnerEndDiameter,
              length = connector1Length,
              wallThickness = connector1WallThickness,
              flangeThickness = connector1FlangeThickness,
              flangeWidth = connector1FlangeWidth,
              screwPosition = connector1FlangeScrewPosition,
              screwBorder = connector1FlangeScrewBorder,
              screwCount = connector1FlangeScrewCount,
              screwDiameter = connector1FlangeScrewDiameter);
          }

          if(connector1Style == "hose")
          {
            HoseConnector(
              innerStartDiameter = end1InnerStartDiameter,
              innerEndDiameter = end1InnerEndDiameter,
              connectorMeasurement = connector1Measurement,
              length = connector1Length,
              wallThickness = connector1WallThickness,
              stopLength = connector1StopLength,
              stopWidth = connector1StopThickness,
              stopSymmetrical = connector1StopSymmetrical,
              barbsCount  = connector1BarbsCount,
              barbsThickness = connector1BarbsThickness,
              barbsSymmetrical = connector1BarbsSymmetrical,
              endCapDiameter = connector1EndCapDiameter,
              endCapThickness = connector1EndCapThickness
            );
          }

          if(connector1Style == "dyson")
          {
            DysonConnector(
              innerEndDiameter = end1InnerEndDiameter,
              length = connector1Length,
              wallThickness = connector1WallThickness,
              IncludeOrientationClip = true);
          }
          else if(connector1Style == "camlock")
          {
            CamlockConnector(
              innerEndDiameter = end1InnerEndDiameter,
              length = connector1Length,
              wallThickness = connector1WallThickness);
          }
          else if(connector1Style == "dw735")
          {
            Dw735Connector(
              innerEndDiameter = end1InnerEndDiameter,
              length = connector1Length,
              wallThickness = connector1WallThickness,
              connectorCount = _transitionAngle > 0 ? 4 : 1);
          }
          else {
            //echo("connect 1 style not supported connector1Style:" + connector1Style);
          }
          
          if(sliceDebug){
            translate([0,0,connector1Length/2])
            rotate([90,0,0])
            Caliper(l=end1InnerDiameter, end=3, help=0, in=1, messpunkt = false,txt = str("End 1 Inner Diameter - ", end1InnerDiameter,"mm"));
            if(end1InnerDiameter != end1InnerStartDiameter){
              translate([0,0,0])
              rotate([90,0,0])
              Caliper(l=end1InnerStartDiameter, end=3, help=0, in=1, messpunkt = false);
            }
            if(end1InnerDiameter != end1InnerEndDiameter){
              translate([0,0,connector1Length])
              rotate([90,0,0])
              Caliper(l=end1InnerEndDiameter, end=3, help=0, in=1, messpunkt = false);
            }
          }
        }
      }

  
echo("transition", taperedAverageDiameter=taperedAverageDiameter, transitionStyle=transitionStyle, bendRadius=bendRadius, _transitionAngle=_transitionAngle);
      echo("transition", end1InnerEndDiameter=end1InnerEndDiameter, end2InnerStartDiameter=end2InnerStartDiameter);
      translate([0, 0, endConnector1])
      union()
      {
        if(transitionStyle == "flat")
        {
          transDiameter = min(end1InnerEndDiameter,  end2InnerStartDiameter);
          transThickness = abs(end1InnerEndDiameter - end2InnerStartDiameter)/2 + max(connector1WallThickness,connector2WallThickness);
          color("LightGreen")
          StraightPipe(
              diameter = transDiameter,
              length = _transitionLength,
              wallThickness = transThickness);
        }
        if(_transitionStyle == "organicbend")
        {
            //Bent pipe that tapers through the bend.
            color("LightGreen")
            TaperedBentPipe(
                bendRadius = bendRadius,
                end1InnerPipeDiameter = end1InnerEndDiameter,
                end2InnerPipeDiameter = end2InnerStartDiameter,
                end1WallThickness = connector1WallThickness,
                end2WallThickness = connector2WallThickness,
                pipeAngle = _transitionAngle,
                baseType = transitionBaseType,
                baseThickness = transitionBaseThickness,
                baseWidth = transitionBaseWidth,
                baseLength = transitionBaseLength,
                baseAngle = transitionBaseAngle,
                end2Count = transitionEnd2Count);
        }
        else if(_transitionStyle == "hull")
        {
          color("LightGreen")
          BentPipeHull(
              inner1PipeRadius = end1InnerEndDiameter/2,
              inner2PipeRadius = end2InnerStartDiameter/2,
              end1WallThickness = connector1WallThickness,
              end2WallThickness = connector2WallThickness,
              pipeAngle = _transitionAngle,
              end2Count = transitionEnd2Count,
              lengthInHull = lengthInHull,
              lengthOutHull = transitionHullLength,
              edgeOffset = edgeOffset,
              addCenter = transitionHullCenter,
              centerHeight= transitionCenterHeight
          );
        }
        else if(_transitionStyle == "bend+taper")
        {
          //Tapered transition
          //the bent pipe section, diameter matches connector 1.
          if(_transitionAngle > 0)
          {
            color("LightGreen")
            BentPipe(
              bendRadius = bendRadius,
              innerPipeDiameter = end1InnerEndDiameter,
              wallThickness = connector1WallThickness,
              pipeAngle = _transitionAngle,
              baseType = transitionBaseType,
              baseThickness = transitionBaseThickness,
              baseWidth = transitionBaseWidth,
              baseLength = transitionBaseLength,
              baseAngle = transitionBaseAngle,
              end2Count = transitionEnd2Count);
          }

          //Tapered section position to the end of the bent pipe
          for (rotation = [0:transitionEnd2Count-1])
          {
            color("SpringGreen")
            rotate([0, 0, rotation*(360/transitionEnd2Count)])
            translate([-bendRadius, 0, 0])
              rotate([0, -_transitionAngle, 0])
              translate([bendRadius, 0, 0])
                Pipe(
                  diameter1 = end1InnerEndDiameter,
                  diameter2 = end2InnerStartDiameter,
                  length = _transitionLength,
                  wallThickness1 = connector1WallThickness,
                  wallThickness2 = connector2WallThickness,
                  xOffset = transitionXOffset,
                  yOffset = transitionYOffset);
          }
        }
        else if(_transitionStyle == "taper+bend")
        {
          //Tapered section position to the end of the bent pipe
          color("SpringGreen")
          Pipe(
            diameter1 = end1InnerEndDiameter,
            diameter2 = end2InnerStartDiameter,
            length = _transitionLength,
            wallThickness1 = connector1WallThickness,
            wallThickness2 = connector2WallThickness,
            xOffset = transitionXOffset,
            yOffset = transitionYOffset);

          if(_transitionAngle > 0)
          {
            //the bent pipe section, diameter matches connector 2.
            translate([transitionXOffset, transitionYOffset, 0])
            color("LightGreen")
            BentPipe(
              bendRadius = bendRadius,
              innerPipeDiameter = end2InnerStartDiameter,
              wallThickness = connector2WallThickness,
              pipeAngle = _transitionAngle,
              zPosition = _transitionLength,
              baseType = transitionBaseType,
              baseThickness = transitionBaseThickness,
              baseWidth = transitionBaseWidth,
              baseLength = transitionBaseLength,
              baseAngle = transitionBaseAngle,
              end2Count = transitionEnd2Count);
          }
        }
      }

      // Create the end connector
      if(connector2Length > 0)
      {
        echo("Connector2", transitionStyle=_transitionStyle, bendRadius=bendRadius, transitionAngle=_transitionAngle, endConnector1=endConnector1);
        echo("Connector2", transitionXOffset=transitionXOffset, transitionYOffset=transitionYOffset, _transitionLength=_transitionLength, endConnector1=endConnector1);
        echo("Connector2", edgeOffset=edgeOffset, lengthInHull=lengthInHull, transitionHullLength=transitionHullLength);

        preRotation = [
          ((_transitionStyle == "taper+bend") ? transitionXOffset
            : _transitionStyle == "hull" ? -end1OuterEndDiameter/2
            : 0) - bendRadius,
          ((_transitionStyle == "taper+bend") ? transitionYOffset : 0),
          ((_transitionStyle == "taper+bend" || _transitionStyle == "flat" || _transitionStyle == "none") ? _transitionLength
            : _transitionStyle == "hull" ? 0
            : 0) + endConnector1];

        postRotation = [
          ((_transitionStyle == "bend+taper") ? transitionXOffset
            : _transitionStyle == "hull" ? end1OuterEndDiameter/2-edgeOffset
            : 0) + bendRadius,
          ((_transitionStyle == "bend+taper") ? transitionYOffset : 0),
          ((_transitionStyle == "bend+taper") ? _transitionLength
            : _transitionStyle == "hull" ? max(transitionHullLength,transitionHullLength)+lengthInHull+connector2WallThickness
            : 0)];
        //The max above is a bug.

        color("SkyBlue")
        for (rotation = [0:transitionEnd2Count-1])
        {
          rotate([0, 0, rotation*(360/transitionEnd2Count)])
          translate(preRotation)
          rotate([0, -_transitionAngle, 0])
          translate(postRotation)
          rotate([0,0,connector2Rotation])
          union()
          {
            if(connector2Style == "mag")
            {
              translate([0, 0, connector2Length+connector2StopLength])
              mirror ([0,0,1])
              MagneticConnector(
                //Start and End are reversed as the flange is mirrored.
                innerStartDiameter = end2InnerEndDiameter,
                innerEndDiameter = end2InnerStartDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                magnetDiameter = connector2MagnetDiameter,
                magnetThickness = connector2MagnetThickness,
                magnetBorder = connector2MagnetBorder,
                flangeThickness = connector2MagnetFlangeThickness,
                magnetCount = connector2MagnetCount,
                alignmentRing = connector2Ring,
                alignmentDepth = alignmentDepth,
                alignmentUpperWidth = alignmentUpperWidth,
                alignmentLowerWidth = alignmentLowerWidth,
                alignmentDepthClearance = alignmentDepthClearance);
            }
            else if(connector2Style == "hose")
            {
                translate([0, 0, connector2Length+connector2StopLength])
                mirror ([0,0,1])
                HoseConnector(
                  innerStartDiameter = end2InnerEndDiameter,
                  innerEndDiameter = end2InnerStartDiameter,
                  connectorMeasurement = connector2Measurement,
                  length = connector2Length,
                  wallThickness = connector2WallThickness,
                  stopLength = connector2StopLength,
                  stopWidth = connector2StopThickness,
                  stopSymmetrical = connector2StopSymmetrical,
                  barbsCount  = connector2BarbsCount,
                  barbsThickness = connector2BarbsThickness,
                  barbsSymmetrical = connector2BarbsSymmetrical,
                  endCapDiameter = connector2EndCapDiameter,
                  endCapThickness = connector2EndCapThickness);
            }
            else if(connector2Style == "flange")
            {
              connector2StopLength = 0;
              connector2StopThickness = 0;

              //Create the flange on end 1
              translate([0, 0, connector2Length+connector2StopLength])
              mirror ([0,0,1])
              FlangeConnector(
                innerStartDiameter = end2InnerStartDiameter,
                innerEndDiameter = end2InnerEndDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                flangeThickness = connector2FlangeThickness,
                flangeWidth = connector2FlangeWidth,
                screwPosition = connector2FlangeScrewPosition,
                screwBorder = connector2FlangeScrewBorder,
                screwCount = connector2FlangeScrewCount,
                screwDiameter = connector2FlangeScrewDiameter);
            }
            else if(connector2Style == "nozzle")
            {
              Nozzle(
                innerStartDiameter = end2InnerStartDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                nozzleShape = connector2NozzleShape,
                nozzleSquareWidth = connector2NozzleSquareWidth,
                nozzleSquareDepth = connector2NozzleSquareDepth,
                nozzleTipWallThickness = connector2NozzleTipWallThickness,
                nozzleRadius = connector2NozzleRadius,
                nozzleLength = connector2NozzleLength,
                nozzlexOffset = connector2NozzlexOffset,
                nozzleyOffset = connector2NozzleyOffset,
                nozzleChamferPercentage = connector2NozzleChamferPercentage,
                nozzleChamferAngle = connector2NozzleChamferAngle);
            }
            else{
              echo(str("connect 2 style not supported connector2Style: ", connector2Style));
            }
            
            if(sliceDebug){
              translate([0, 0, endConnector1+connector2Length+connector2StopLength+transitionCenterHeight+transitionHullLength])
              //translate([0,0,connector2Length/2])
              rotate([90,0,0])
              Caliper(l=end2InnerEndDiameter, end=3, help=0, in=1, messpunkt = false);
            }
          }
        }
      
        color("SkyBlue")
        if(transitionHullCenter)
        {
          rotate([0,0,connector2Rotation])
          union()
          {
            if(connector2Style == "mag")
            {
              translate([0, 0, endConnector1+connector2Length+connector2StopLength+transitionCenterHeight+transitionHullLength])
              mirror ([0,0,1])
              MagneticConnector(
                //Start and End are reversed as the flange is mirrored.
                innerStartDiameter = end2InnerEndDiameter,
                innerEndDiameter = end2InnerStartDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                magnetDiameter = connector2MagnetDiameter,
                magnetThickness = connector2MagnetThickness,
                magnetBorder = connector2MagnetBorder,
                flangeThickness = connector2MagnetFlangeThickness,
                magnetCount = connector2MagnetCount,
                alignmentRing = connector2Ring,
                alignmentDepth = alignmentDepth,
                alignmentUpperWidth = alignmentUpperWidth,
                alignmentLowerWidth = alignmentLowerWidth,
                alignmentDepthClearance = alignmentDepthClearance);
            }
            else if(connector2Style == "hose")
            {
                translate([0, 0, endConnector1+connector2Length+connector2StopLength+transitionCenterHeight+transitionHullLength])
                mirror ([0,0,1])
                HoseConnector(
                  innerStartDiameter = end2InnerEndDiameter,
                  innerEndDiameter = end2InnerStartDiameter,
                  connectorMeasurement = connector2Measurement,
                  length = connector2Length,
                  wallThickness = connector2WallThickness,
                  stopLength = connector2StopLength,
                  stopWidth = connector2StopThickness,
                  stopSymmetrical = connector2StopSymmetrical,
                  barbsCount  = connector2BarbsCount,
                  barbsThickness = connector2BarbsThickness,
                  barbsSymmetrical = connector2BarbsSymmetrical,
                  endCapDiameter = connector2EndCapDiameter,
                  endCapThickness = connector2EndCapThickness
              );
            }
            else if(connector2Style == "flange")
            {
              connector1StopLength = 0;
              connector1StopThickness = 0;
              translate([0, 0, endConnector1+connector2Length+connector2StopLength+connector2WallThickness+transitionCenterHeight+transitionHullLength])
              mirror ([0,0,1])
              FlangeConnector(
                innerStartDiameter = end2InnerStartDiameter,
                innerEndDiameter = end2InnerEndDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                flangeThickness = connector2FlangeThickness,
                flangeWidth = connector2FlangeWidth,
                screwPosition = connector2FlangeScrewPosition,
                screwBorder = connector2FlangeScrewBorder,
                screwCount = connector2FlangeScrewCount,
                screwDiameter = connector2FlangeScrewDiameter);
            }
            else if(connector2Style == "nozzle")
            {
              translate([0, 0, endConnector1+connector2StopLength+transitionCenterHeight+transitionHullLength])
              Nozzle(
                innerStartDiameter = end2InnerStartDiameter,
                length = connector2Length,
                wallThickness = connector2WallThickness,
                nozzleShape = connector2NozzleShape,
                nozzleSquareWidth = connector2NozzleSquareWidth,
                nozzleSquareDepth = connector2NozzleSquareDepth,
                nozzleTipWallThickness = connector2NozzleTipWallThickness,
                nozzleRadius = connector2NozzleRadius,
                nozzleLength = connector2NozzleLength,
                nozzlexOffset = connector2NozzlexOffset,
                nozzleyOffset = connector2NozzleyOffset,
                nozzleChamferPercentage = connector2NozzleChamferPercentage,
                nozzleChamferAngle = connector2NozzleChamferAngle);
            }
            else{
              echo("connect 2 style not supported connector2Style:" + connector2Style);
            }
          }
          if(sliceDebug){
            translate([0, 0, endConnector1+connector2Length+connector2StopLength+transitionCenterHeight+transitionHullLength])
            translate([0,0,connector1Length/2])
            rotate([90,0,0])
            Caliper(l=end1InnerEndDiameter, end=3, help=0, in=1, messpunkt = false);
          }
        }
      }
    }
    
    if(sliceDebug){
      echo("enabling debug slice");
      cubeSziex = max(end1InnerDiameter,end2InnerDiameter)*3;
      cubeSziey = max(end1InnerDiameter,end2InnerDiameter)*1.5;
      cubeSziez = (connector1Length + connector2Length)*3;
      translate([-cubeSziex/2, -cubeSziey, -fudgeFactor])
      cube([cubeSziex,cubeSziey,cubeSziez]);
    }
  }
}
