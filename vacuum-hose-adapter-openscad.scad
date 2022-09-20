// Hose connector 
// version 2022-09-17

/* [General ] */
Wall_Thickness = 2;

/* [Alignment Ring] */
//draw just the alignment ring
Draw_Alignment_Ring = "no"; //[end1: Draw end 1, end2: Draw end 2, no: Don't draw]

//Alignment depth in to flange (mm)
Alignment_Depth = 2;

//Alignment upper width at widest part (mm)
Alignment_Upper_Width = 3;

//Alignment lower width at narrowest part (mm)
Alignment_Lower_Width = 0.5;

//Alignment side clearance, to give nice fit (mm).
Alignment_Side_Clearance = 0.25;

//Alignment Depth Clearance, to prevent hitting bottom (mm).
Alignment_Depth_Clearance = .75;

/* [Connector 1] */
//The style of the end
End1_Style="mag"; // [mag: Magnetic Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]

// End 1 diameter of the adapter (mm)
End1_Diameter = 50;

//Length of the start connector (including the flange).
End1_Length= 15;

//Taper of the start connector, use negative to taper other direction.
End1_Taper = 0;

/* [Connector 1 - Hose connector] */
//Thickness of hose stop
End1_StopThickness = 6;

//Length of hose stop
End1_StopLength = 5;
    
/* [Connector 1 - Magnetic Flange] */
//Number of magnets in the flange
End1_Magnets_Count = 8;

//The diameter of the magnets (mm)
End1_Magnet_Diameter = 10.5;

//The thickness of the magnets (mm)
End1_Magnet_Thickness = 2.5;

//Size of the material around the magnets (mm)
End1_Magnet_Border = 2;

// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 6;

// Include a flange alignment ring
End1_Ring = "no"; //[no: No alignment ring, protruding: protruding ring, recessed: Recessed ring]

/* [Transition] */
//Length of the transition between the two ends
Transition_Length = 10;

/* [Connector 2] */
End2_Style="hose"; // [mag: Magnetic Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "outer"; //[inner, outer]

// End 2 diameter of the adapter (mm)
End2_Diameter = 40;

//Length of the pipe coming out of the flange.
End2_Length= 40;

//Taper of the start connector, use negative to taper other direction.
End2_Taper = 2;

/* [Connector 2 - Hose connector] */
//Thickness of hose stop
End2_StopThickness = 6;

//Length of hose stop
End2_StopLength = 5;
    
/* [Connector 2 - Magnetic Flange] */

//Number of magnets in the flange
End2_Magnets_Count = 6;

//The diameter of the magnets
End2_Magnet_Diameter = 12;

//The thickness of the magnets
End2_Magnet_Thickness = 3;

//Size of the material around the magnets
End2_Magnet_Border = 2;

// Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;

// Include a flange alignment ring
End2_Ring = "no"; //[no: No alignment ring, protruding: Protruding ring, recessed: Recessed ring]


/* [Hidden] */
//Stops visual clipping when one object is subtracted from another
adjustment = 0.015;

//Detail
$fn=120;

end1InnerDiameter = End1_Measurement == "inner" ? End1_Diameter : End1_Diameter - Wall_Thickness * 2;
end2InnerDiameter = End2_Measurement == "inner" ? End2_Diameter : End2_Diameter - Wall_Thickness * 2;

//Apply taper, from small to big
end1InnerStartDiameter = end1InnerDiameter - End1_Taper / 2;
end1InnerEndDiameter = end1InnerDiameter + End1_Taper / 2;

//Apply taper, from big to small
end2InnerStartDiameter = end2InnerDiameter + End2_Taper / 2;
end2InnerEndDiameter = end2InnerDiameter - End2_Taper / 2;
      
//diameter1: Inner start diameter.
//diameter2: Inner end diameter.
//length: pipe length
//wallThickness1 Thickness of the walls at the start
//wallThickness2 Thickness of the walls at the end
//zPosition: Start Z position.
module Pipe(diameter1, diameter2, length, wallThickness1, wallThickness2, zPosition)
{
    difference () 
    {
        //outer cylinder
        translate([0, 0, zPosition])
        {
            cylinder(
                d1=diameter1+2*wallThickness1, 
                d2=diameter2+2*wallThickness2, 
                h=length);
        }
        
        //Inner cylinder to remove
        translate([0, 0, zPosition-adjustment])
        {
             cylinder(
                d1=diameter1, 
                d2=diameter2,
                h=length + 2*adjustment);
        }
    }
}

module TaperedPipe(diameter1, diameter2, length, wallThickness, zPosition)
{
    Pipe (
        diameter1,
        diameter2,
        length,
        wallThickness,
        wallThickness,
        zPosition);
}

module StraightPipe(diameter, length, wallThickness, zPosition)
{
    Pipe (
        diameter,
        diameter,
        length,
        wallThickness,
        wallThickness,
        zPosition);
}

module HalfConePipe(diameter, length, wallThickness1, wallThickness2, zPosition)
{
    Pipe (
        diameter,
        diameter,
        length,
        wallThickness1,
        wallThickness2,
        zPosition);
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
        translate([0, 0, zPosition-adjustment])
        cylinder(
            d1=centerDiameter-wallThickness1, 
            d2=centerDiameter-wallThickness2, 
            h=length + 2*adjustment);
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
                innerStartDiameter,
                innerEndDiameter,
                length,
                wallThickness,
                0);

            hull () {
                for (i = [0: magnetCount-1]) {
                    rotate ([0, 0, i * (360 / magnetCount)]) 
                    translate ([magnetPosition, 0, 0]) 
                    cylinder (d = magnetDiameter + magnetBorder * 2, flangeThickness);
                }
            }
            
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
            
            HalfConePipe (
                diameter = innerEndDiameter,
                length = fillet,
                wallThickness1 = fillet - adjustment,
                wallThickness2 = 0,
                zPosition= flangeThickness - adjustment);  
            
        }
        
        //Magnet cut out
        for (i = [0: magnetCount-1]) {
            rotate ([0, 0, i* 360 / magnetCount]) 
            translate ([magnetPosition, 0, - adjustment]) 
            cylinder (d = magnetDiameter, h = magnetThickness + adjustment);
        }

        //Flange inner  
        translate([0, 0, -adjustment])
            cylinder (
                d1 = innerStartDiameter, 
                d2 = innerEndDiameter,
                h = length + 2 * adjustment);
        
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
                diameter = centerDiameter - ringMaxWidth + adjustment, 
                length = adjustment, 
                wallThickness = ringMaxWidth- adjustment, 
                zPosition = -adjustment/2);
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

module HoseConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    stopLength,
    stopWidth
)
{
    union() {
        //hose connector
        TaperedPipe (
            innerStartDiameter,
            innerEndDiameter,
            length,
            wallThickness,
            0);
        
        // Create the hose stop
        StraightPipe (
            innerEndDiameter + wallThickness,
            stopLength,
            stopWidth + wallThickness/2 + adjustment,
            length - stopLength);
        
        HalfConePipe (
            innerEndDiameter + wallThickness,
            stopLength,
            0,
            stopWidth + wallThickness/2 + adjustment,
            length - stopLength*2);
    }
}


if(Draw_Alignment_Ring == "end1")
{
    !AlignmentRing(
        centerDiameter = end1InnerStartDiameter + End1_Magnet_Border + Alignment_Upper_Width,
        alignmentDepth = Alignment_Depth,
        alignmentUpperWidth = Alignment_Upper_Width,
        alignmentLowerWidth = Alignment_Lower_Width,
        alignmentSideClearance = Alignment_Side_Clearance,
        alignmentDepthClearance = Alignment_Depth_Clearance,
        magnetBorder = End1_Magnet_Border);
}

if(Draw_Alignment_Ring == "end2")
{
    !AlignmentRing(
        centerDiameter = end2InnerStartDiameter + End2_Magnet_Border + Alignment_Upper_Width,
        alignmentDepth = Alignment_Depth,
        alignmentUpperWidth = Alignment_Upper_Width,
        alignmentLowerWidth = Alignment_Lower_Width,
        alignmentSideClearance = Alignment_Side_Clearance,
        alignmentDepthClearance = Alignment_Depth_Clearance,
        magnetBorder = End2_Magnet_Border);
}

//Create the start connector
if(End1_Length > 0)
{
    if(End1_Style == "mag")
    {
        //Create the flange on end 1
        MagneticConnector(
            innerStartDiameter = end1InnerStartDiameter,
            innerEndDiameter = end1InnerEndDiameter,
            length = End1_Length,
            wallThickness = Wall_Thickness,
            magnetDiameter = End1_Magnet_Diameter,
            magnetThickness = End1_Magnet_Thickness,
            magnetBorder = End1_Magnet_Border,
            flangeThickness = End1_Magnet_Flange_Thickness,
            magnetCount = End1_Magnets_Count,
            alignmentRing = End1_Ring,
            alignmentDepth = Alignment_Depth,
            alignmentUpperWidth = Alignment_Upper_Width,
            alignmentLowerWidth = Alignment_Lower_Width,
            alignmentSideClearance = Alignment_Side_Clearance,
            alignmentDepthClearance = Alignment_Depth_Clearance);
    }

    if(End1_Style == "hose")
    {
        HoseConnector(
            innerStartDiameter = end1InnerStartDiameter,
            innerEndDiameter = end1InnerEndDiameter,
            length = End1_Length,
            wallThickness = Wall_Thickness,
            stopLength = End1_StopLength,
            stopWidth = End1_StopThickness);
    }
}

//Transition between connections
if(End2_Length > 0)
{
    TaperedPipe(
        diameter1 = end1InnerEndDiameter, 
        diameter2 = end2InnerStartDiameter, 
        length = Transition_Length, 
        wallThickness = Wall_Thickness, 
        zPosition = End1_Length);
}

// Create the end connector
if(End2_Length > 0)
{
    end2StartZ = End1_Length + Transition_Length;

    translate([0, 0, end2StartZ+End2_Length])
    mirror ([0,0,1])    
    union() {    
        if(End2_Style == "mag")
        {
            MagneticConnector(
                //Start and End are reversed as the flange is mirrored.
                innerStartDiameter = end2InnerEndDiameter, 
                innerEndDiameter = end2InnerStartDiameter,
                length = End2_Length,
                wallThickness = Wall_Thickness,
                magnetDiameter = End2_Magnet_Diameter,
                magnetThickness = End2_Magnet_Thickness,
                magnetBorder = End2_Magnet_Border,
                flangeThickness = End2_Magnet_Flange_Thickness,
                magnetCount = End2_Magnets_Count,
                alignmentRing = End2_Ring,
                alignmentDepth = Alignment_Depth,
                alignmentUpperWidth = Alignment_Upper_Width,
                alignmentLowerWidth = Alignment_Lower_Width,
                alignmentClearance = Alignment_Clearance);
        }
        
        if(End2_Style == "hose")
        {
            HoseConnector(
                innerStartDiameter = end2InnerEndDiameter,
                innerEndDiameter = end2InnerStartDiameter,
                length = End2_Length,
                wallThickness = Wall_Thickness,
                stopLength = End2_StopLength,
                stopWidth = End2_StopThickness);
        }
    }
}