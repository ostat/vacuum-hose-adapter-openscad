// Hose connector modules
// version 2022-09-27

use <dotSCAD/ring_extrude.scad>
use <dotSCAD/shape_circle.scad>
// https://justinsdk.github.io/dotSCAD/


/* [General ] */

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
//Wall thickness
End1_Wall_Thickness = 2; //0.01
//The style of the end
End1_Style="flange"; // [mag: Magnetic Flange, flange: Flange, hose: Hose connector, dyson: Dyson connector]
// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]
// End 1 diameter of the adapter (mm)
End1_Diameter = 50;  //0.1
//Length of the start connector (including the flange).
End1_Length= 15;  //0.1
//Taper of the start connector, use negative to taper other direction.
End1_Taper = 0;  //0.1


/* [Connector 1 - Hose connector] */
//Thickness of hose stop
End1_StopThickness = 6;  //1
//Length of hose stop
End1_StopLength = 5;  //1


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
Transition_Style = "tapered"; //[tapered, flat, sweep]
//Length of the transition between the two ends
Transition_Length = 10;  //1
// Radius of transition bend (mm)
Transition_Bend_Radius = 10;  //1
//Angle of bend through the transition section.
Transition_Angle = 45;  //1

Transition_xOffset = 0; // 0.1
Transition_yOffset = 0; // 0.1

/* [Transition Support For Angled Pipes] */
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
End2_Style="nozzle"; // [mag: Magnetic Flange, hose: Hose connector, nozzle: Nozzle attachement]


// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]
// End 2 diameter of the adapter (mm)
End2_Diameter = 40;  //0.1
//Length of the pipe coming out of the flange.
End2_Length= 40;  //1
//Taper of the start connector, use negative to taper other direction.
End2_Taper = 0;  //0.1


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

/* [Hidden] */
fudgeFactor = 0.015;

dysonMinLength = 46;
dysonInnerDiameter = 28.5;
dysonOuterDiameter = 34;
  
//Detail
$fn=120;

HoseAdapter(
    drawAlignmentRing = Draw_Alignment_Ring,
    alignmentDepth = Alignment_Depth,
    alignmentUpperWidth = Alignment_Upper_Width,
    alignmentLowerWidth = Alignment_Lower_Width,
    alignmentSideClearance = Alignment_Side_Clearance,
    alignmentDepthClearance = Alignment_Depth_Clearance,

    connector1WallThickness  = End1_Wall_Thickness,
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
    
    connector2WallThickness  = End2_Wall_Thickness,
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
    connector2Ring = End2_Ring,
    connector2NozzleShape = End2_Nozzle_Shape,
    connector2NozzleSquareWidth = End2_Nozzle_Square_Width,
    connector2NozzleSquareDepth = End2_Nozzle_Square_Depth,
    connector2NozzleTipWallThickness = End2_Nozzle_Tip_Wall_Thickness,
    connector2NozzleRadius = End2_Nozzle_Radius,
    connector2NozzleLength = End2_Nozzle_Length,
    connector2NozzlexOffset = End2_Nozzle_xOffset,
    connector2NozzleyOffset = End2_Nozzle_yOffset,
    connector2NozzleChamferPercentage = End2_Nozzle_Chamfer_Percentage,
    connector2NozzleChamferAngle = End2_Nozzle_Chamfer_Angle
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
  echo ("Pipe", diameter1, diameter2, length, wallThickness1, wallThickness2, xOffset, yOffset, zPosition);
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

module TaperedPipe(
  diameter1, 
  diameter2, 
  length, 
  wallThickness1, 
  wallThickness2, 
  zPosition = 0,
  xOffset = 0,
  yOffset = 0)
{
    Pipe (
        diameter1 = diameter1,
        diameter2 = diameter2,
        length = length,
        wallThickness1 = wallThickness1,
        wallThickness2 = wallThickness2,
        zPosition = zPosition,
        xOffset = xOffset,
        yOffset = yOffset);
}

module StraightPipe(diameter, length, wallThickness, zPosition)
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

module BentPipe(
    bendRadius,
    innerPipeDiameter,
    wallThickness,
    pipeAngle,
    zPosition,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
)
{
  outerPipeDiameter  = innerPipeDiameter + wallThickness * 2;
  outerCircleRadius = bendRadius + outerPipeDiameter;

  baseSupportThickness = outerPipeDiameter/2 + baseThickness;
  baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
  baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
  baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;
  
  echo("BentPipe", baseSupportWidth, baseSupportLength);
  
  translate([-(outerCircleRadius - outerPipeDiameter), 0, zPosition])
    rotate([90, 0, 0])
    difference() {
      union(){
      // printing base
        if (baseType != "none"){
          rotate([0,0,baseSupportAngle])
          translate([bendRadius,0,0])
          rotate([0,90,0])
          if (baseType == "rectangle")
            translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
          else if (baseType == "oval") 
            resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
        }
          
        rotate_extrude(angle=pipeAngle, convexity=10)
          translate([outerCircleRadius - outerPipeDiameter, 0, 0])
          circle(d=outerPipeDiameter);
      }
      
     rotate([0, 0, -1])
     rotate_extrude(angle=pipeAngle+2,convexity=10)
            translate([outerCircleRadius - outerPipeDiameter, 0, 0])
            circle(d=innerPipeDiameter);
          
      //Clear start from clipping
      rotate([90, 0, pipeAngle])
      translate([outerCircleRadius - outerPipeDiameter, 0, -baseSupportThickness])
      cylinder(
          d=innerPipeDiameter, 
          h=baseSupportThickness);
    
    //Clear end of the pipe from clipping
    rotate([90, 0, 0])
      translate([outerCircleRadius - outerPipeDiameter, 0, 0])
      cylinder(d=innerPipeDiameter, h=baseSupportThickness);
    }
}

module TaperedBentPipe(
    bendRadius,
    end1InnerPipeDiameter,
    end2InnerPipeDiameter,
    end1WallThickness,
    end2WallThickness,
    pipeAngle,
    zPosition,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
)
{
    outerPipeDiameter  = end1InnerPipeDiameter + end1WallThickness * 2;
    outerCircleRadius = bendRadius + outerPipeDiameter;
  
    sizeStart = end1InnerPipeDiameter / 2 + end1WallThickness ;
    sizeEnd = end2InnerPipeDiameter / 2 + end2WallThickness ;

    baseSupportThickness = (sizeStart+sizeEnd)/2 + baseThickness;
    baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
    baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
    baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;
  
    shapeOuter = shape_circle(sizeStart);
    shapeInner = shape_circle(sizeStart-end1WallThickness);
    
    translate([0, 0, zPosition])
    difference(){
        translate([-(outerCircleRadius - outerPipeDiameter), 0, 0])
        rotate([90, 0, 0])
        difference(){
          union(){
            // printing base
            if (baseType != "none"){
              rotate([0,0,baseSupportAngle])
              translate([bendRadius,0,0])
              rotate([0,90,0])
              if (baseType == "rectangle")
                 translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
              else if (baseType == "oval") 
                  resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
              }
              ring_extrude(shapeOuter, radius = bendRadius, angle = pipeAngle, scale = (sizeEnd/sizeStart));
            }
            ring_extrude(shapeInner, radius = bendRadius, angle = pipeAngle, scale = ((sizeEnd-end2WallThickness)/(sizeStart-end1WallThickness)));
        }
        
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
  
  echo("FlangeConnector", screwCount, screwDiameter, screwPosition, border);
  echo("FlangeConnector", screwPositionRadius, fillet, flangeOuterDiameter, innerStartDiameter, flangeWidth);

  difference () 
  {
    //flange
    union() {
      TaperedPipe (
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
            TaperedPipe (
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
                translate([0,-34.5/2+4,-23/2+6.5]) rotate([90,0,0])
                  cylinder(r1=23/2, r2=23.5/2, h=7);
                hull() { 
                  translate([0,-34.5/2,1.5]) rotate([90,0,0])
                    cylinder(r1=1.5, r2=1.25, h=2);
                  translate([0,-34.5/2,8-1.5]) rotate([90,0,0])
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
    echo("DysonConnector", innerRadius, innerDiameter, length, height);
    Pipe (
        diameter1 = innerDiameter,
        diameter2 = innerEndDiameter,
        length = length - height,
        wallThickness1 = (outerDiameter - innerDiameter)/2,
        wallThickness2 = wallThickness,
        zPosition = height);
    
  }
}

module Nozzle(
innerStartDiameter,
length,
wallThickness,
nozzleShape,
nozzleSquareWidth,
nozzleSquareDepth,//Change to width and depth, also swap
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

  echo("nozzle", innerRadius, circlepositionx, circlepositiony, nozzleWidth, nozzleDepth, nozzleWidthChamfer, nozzleLengthChamfer, widthChamfer,lengthChamfer);
  
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
    length,
    wallThickness,
    stopLength,
    stopWidth)
{
    union() {
    
        //hose connector
        TaperedPipe (
            diameter1 = innerStartDiameter,
            diameter2 = innerEndDiameter,
            length = length,
            wallThickness1 = wallThickness,
            wallThickness2 = wallThickness);
        
        // Create the hose stop
        if(stopWidth > 0)
        {
            intersection()
            {
                StraightPipe (
                    diameter = innerEndDiameter,
                    length = stopLength,
                    wallThickness = stopWidth + wallThickness,
                    zPosition = length);
                
                // because pythagoras
                x = stopLength*wallThickness/(2*stopWidth);

                //A triagnle, when intersected with the pipe above, creates the stop
                HalfConePipe (
                    diameter = innerEndDiameter,
                    length = x + stopLength,
                    wallThickness1 = 0,
                    wallThickness2 = 2*stopWidth + wallThickness,
                    zPosition = length - x);
            }
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
    connector1Taper = 0,
    connector1StopThickness = 0,
    connector1StopLength = 0,
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

    connector2WallThickness = 2,
    connector2Style = "hose",
    connector2Measurement = "inner",
    connector2Diameter = 0,
    connector2Length = 0,
    connector2Taper = 0,
    connector2StopThickness = 0,
    connector2StopLength = 0,
    connector2MagnetCount = 0,
    connector2MagnetDiameter = 0,
    connector2MagnetThickness = 0,
    connector2MagnetBorder = 0,
    connector2MagnetFlangeThickness = 0,
    connector2Ring = "no",
    connector2NozzleShape = "square",
    connector2NozzleSquareWidth = 20,
    connector2NozzleSquareDepth = 10,
    connector2NozzleTipWallThickness = 0,
    connector2NozzleRadius = 5,
    connector2NozzleLength = 50,
    connector2NozzlexOffset = 0,
    connector2NozzleyOffset = 0,
    connector2NozzleChamferPercentage = 0,
    connector2NozzleChamferAngle = 0                   
){
    end1InnerDiameter = connector1Measurement == "inner" ? connector1Diameter : connector1Diameter - connector1WallThickness * 2;
    end2InnerDiameter = connector2Measurement == "inner" ? connector2Diameter : connector2Diameter - connector2WallThickness * 2;

    //Dyson is a fixed size connector.
    connector1Length = (connector1Style == "dyson" && connector1Length < dysonMinLength) ? dysonMinLength  : connector1Length;
   
    //Apply taper, from small to big
    end1InnerStartDiameter = end1InnerDiameter - connector1Taper / 2;
    end1InnerEndDiameter = end1InnerDiameter + connector1Taper / 2;

    //Apply taper, from big to small
    end2InnerStartDiameter = end2InnerDiameter + connector2Taper / 2;
    end2InnerEndDiameter = end2InnerDiameter - connector2Taper / 2;

    //If the connector hose is not showm the stop has no thickenss
    connector1StopThickness = (connector1Length <= 0 || connector1Style == "mag" || connector1Style == "flange") ? 0 : connector1StopThickness;
    connector2StopThickness = (connector2Length <= 0 || connector2Style == "mag" || connector2Style == "flange") ? 0 : connector2StopThickness;
    
    //If the stop has no thickness, it needs no length
    connector1StopLength = (connector1StopThickness > 0 && connector1Style == "hose") ? connector1StopLength : 0;
    connector2StopLength = (connector2StopThickness > 0 && connector1Style == "hose") ? connector2StopLength : 0;
    
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

    color("LightPink") 
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
                  length = connector1Length,
                  wallThickness = connector1WallThickness,
                  stopLength = connector1StopLength,
                  stopWidth = connector1StopThickness);
          }
          
          if(connector1Style == "dyson")
          {
              DysonConnector(
                innerEndDiameter = end1InnerEndDiameter,
                length = connector1Length,
                wallThickness = connector1WallThickness,
                IncludeOrientationClip = true);
          }
      }
    }
    //Total length of connector 1
    endConnector1 = connector1Length + connector1StopLength;

    //Calculate the bend radius
    //Sweep, the '0' value must be max of connector 1 or 2 diameter, plus the wall thickness * 2 otherwise it will clip, then add provided radius.
    //transition the '0' value must be end 1 diameter/2 + wall thickenss *2 to prevent clipping, then addd provided radius.
    bendRadius = transitionStyle == "sweep" 
        ? max(end1InnerEndDiameter, end2InnerEndDiameter) + max(connector1WallThickness, connector2WallThickness) * 2 + transitionBendRadius
        : end1InnerEndDiameter/2 + max(connector1WallThickness, connector2WallThickness) * 2 + transitionBendRadius;
    
    // transitionLength is not wanted for sweep
    transitionLength = transitionStyle == "sweep" ? 0 : transitionLength;
    
    color("LightGreen") 
    union(){
      if(transitionAngle > 0){
          if(transitionStyle == "sweep")
          {
              //Bent pipe that tapers through the bend.
              TaperedBentPipe(
                  bendRadius = bendRadius,
                  end1InnerPipeDiameter = end1InnerEndDiameter,
                  end2InnerPipeDiameter = end2InnerStartDiameter,
                  end1WallThickness = connector1WallThickness,
                  end2WallThickness = connector2WallThickness,
                  pipeAngle = transitionAngle,
                  zPosition = endConnector1,
                  baseType = transitionBaseType,
                  baseThickness = transitionBaseThickness,
                  baseWidth = transitionBaseWidth,
                  baseLength = transitionBaseLength,
                  baseAngle = transitionBaseAngle);
          }
          else
          {
              //Tapered transition
              
              //the bent pipe section, diameter matches connector 1.
              BentPipe(
                  bendRadius = bendRadius,
                  innerPipeDiameter = end1InnerEndDiameter,
                  wallThickness = connector1WallThickness,
                  pipeAngle = transitionAngle,
                  zPosition = endConnector1,
                  baseType = transitionBaseType,
                  baseThickness = transitionBaseThickness,
                  baseWidth = transitionBaseWidth,
                  baseLength = transitionBaseLength,
                  baseAngle = transitionBaseAngle);
            
            //Tapered section position to the end of the bent pipe
            translate([-bendRadius, 0, endConnector1])
              rotate([0, -transitionAngle, 0])
              translate([bendRadius, 0, 0])
                  TaperedPipe(
                    diameter1 = end1InnerEndDiameter, 
                    diameter2 = end2InnerStartDiameter, 
                    length = transitionLength, 
                    wallThickness1 = connector1WallThickness, 
                    wallThickness2 = connector2WallThickness, 
                    xOffset = transitionXOffset,
                    yOffset = transitionYOffset);     
          }
      }
    }

    translate([-bendRadius, 0, endConnector1])
    rotate([0, -transitionAngle, 0])
    translate([bendRadius, 0, 0])
    union()
    {
        color("LightGreen") 
        union(){
          //Transition between connections
          if(transitionLength > 0)
          {
              if(transitionStyle == "flat")
              {
                  transDiameter = min(end1InnerEndDiameter,  end2InnerStartDiameter);
                  transThickness = abs(end1InnerEndDiameter - end2InnerStartDiameter)/2 + max(connector1WallThickness,connector2WallThickness);
                  StraightPipe(
                      diameter = transDiameter, 
                      length = transitionLength, 
                      wallThickness = transThickness, 
                      zPosition = 0);
              }
              else
              {
                  TaperedPipe(
                      diameter1 = end1InnerEndDiameter, 
                      diameter2 = end2InnerStartDiameter, 
                      length = transitionLength, 
                      wallThickness1 = connector1WallThickness, 
                      wallThickness2 = connector2WallThickness,
                      zPosition = 0,
                      xOffset = transitionXOffset,
                      yOffset = transitionYOffset);       
              }
          }
        }
      
        color("SkyBlue") 
        translate([transitionXOffset, transitionYOffset, 0])
        union(){
        // Create the end connector
        if(connector2Length > 0)
        {
            end2StartZ = transitionLength;

            if(connector2Style == "mag")
            {
                translate([0, 0, end2StartZ+connector2Length+connector2StopLength])
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
                
            if(connector2Style == "hose")
            {
                translate([0, 0, end2StartZ+connector2Length+connector2StopLength])
                mirror ([0,0,1])    
                HoseConnector(
                    innerStartDiameter = end2InnerEndDiameter,
                    innerEndDiameter = end2InnerStartDiameter,
                    length = connector2Length,
                    wallThickness = connector2WallThickness,
                    stopLength = connector2StopLength,
                    stopWidth = connector2StopThickness);
            }
            
            if(connector2Style == "nozzle")
            {
                translate([0, 0, end2StartZ])
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
                    nozzleChamferAngle = connector2NozzleChamferAngle
              );
            }
          }
        }
    }
}
