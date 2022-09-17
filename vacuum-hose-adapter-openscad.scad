// Hose connector 
// version 2022-09-17

/* [General ] */
Wall_Thickness = 2;

/* [Allignmet Ring] */
//draw just the allignment ring
Draw_Allignmet_Ring = "no"; //[end1: Draw end 1, end2: Draw end 2, no: Dont draw]

//lip depth in to flange
Lip_Depth = 2;

//lip width at widest part
Lip_Width = 3;

//lip clearance to give nice fit.
Lip_Clearance = 0.25;

/* [Connector 1] */
//The style of the end
End1_Style="mag"; // [mag: Magnetic Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End1_Measurement = "inner"; //[inner, outer]

// End 1 diameter of the adapter (mm)
End1_Diameter = 100;

//Length of the start connector (including the flange).
End1_Length= 50;

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
End1_Magnet_Thickness = 3;

//Size of the material around the magnets (mm)
End1_Magnet_Border = 2;

// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 7;

// Include a flange alignment lip
End1_Lip = "no"; //[no: No alignment lip, protruding: protruding lip, recessed: Recessed lip]

/* [Transition] */
//Length of the transition between the two ends
Transition_Length = 50;

/* [Connector 2] */
End2_Style="hose"; // [mag: Magnetic Flange, hose: Hose connector]

// Is the measurement the adapter's outside or inside diameter?
End2_Measurement = "inner"; //[inner, outer]

// End 2 diameter of the adapter (mm)
End2_Diameter = 50;

//Length of the pipe coming out of the flange.
End2_Length= 50;

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

// Include a flange alignment lip
End2_Lip = "no"; //[no: No alignment lip, protruding: Protruding lip, recessed: Recessed lip]


/* [Hidden] */
//Stops visual clipping when one object is subtracted from another
adjustment = 0.02;



//Detail
$fn=25;

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
    alignmentLip,
    lipDepth,
    lipWidth,
    lipClearance,
)
{

    lipBorder = alignmentLip != "no" ? magnetBorder/2 : 0;
    magnetPosition = (innerStartDiameter + magnetDiameter) / 2 + magnetBorder +
        (alignmentLip != "no" ? lipBorder + lipWidth : 0);
  
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
            
            if(alignmentLip == "protruding")
            {
                // Create extruding lip
                ConeRing (
                    centerDiameter = innerStartDiameter + lipBorder*2 + lipWidth + lipClearance, 
                    length = lipDepth, 
                    wallThickness1 = lipWidth/2 - lipClearance/2 , 
                    wallThickness2= lipWidth - lipClearance/2 , 
                    zPosition = -lipDepth);
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
        
        if(alignmentLip == "recessed")
        {
            // Create recessed lip
            ConeRing (
                centerDiameter = innerStartDiameter + lipBorder*2 + lipWidth + lipClearance, 
                length = lipDepth, 
                wallThickness1 = lipWidth + lipClearance/2 , 
                wallThickness2 = lipWidth/2 + lipClearance/2 , 
                zPosition = 0 - adjustment);
        }
    }
}

module AllignmentRing(
    centerDiameter,
    lipDepth,
    lipWidth,
    lipClearance,
    magnetBorder
)
{
    !union() 
    {
        ConeRing (
            centerDiameter = end1InnerStartDiameter + End1_Magnet_Border/2 + lipWidth/2, 
            length = lipDepth, 
            wallThickness1 = lipWidth - lipClearance/2 , 
            wallThickness2 = lipWidth/2 - lipClearance/2 , 
            zPosition = 0 - adjustment);   
        ConeRing (
            centerDiameter = end1InnerStartDiameter + End1_Magnet_Border/2 + lipWidth/2, 
            length = lipDepth, 
            wallThickness2= lipWidth - lipClearance/2 , 
            wallThickness1 = lipWidth/2 - lipClearance/2 , 
            zPosition = -lipDepth);
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


if(Draw_Allignmet_Ring == "end1")
{
    !AllignmentRing(
        centerDiameter = end1InnerStartDiameter + End1_Magnet_Border/2 + Lip_Width/2,
        lipDepth = Lip_Depth,
        lipWidth = Lip_Width,
        lipClearance = Lip_Clearance,
        magnetBorder = End1_Magnet_Border);
}

if(Draw_Allignmet_Ring == "end2")
{
    !AllignmentRing(
        centerDiameter = end2InnerStartDiameter + End2_Magnet_Border/2 + Lip_Width/2,
        lipDepth = Lip_Depth,
        lipWidth = Lip_Width,
        lipClearance = Lip_Clearance,
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
            alignmentLip = End1_Lip,
            lipDepth = Lip_Depth,
            lipWidth = Lip_Width,
            lipClearance = Lip_Clearance);
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
                    alignmentLip = End2_Lip,
                    lipDepth = Lip_Depth,
                    lipWidth = Lip_Width,
                    lipClearance = Lip_Clearance);
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