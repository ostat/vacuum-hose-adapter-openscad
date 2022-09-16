// Hose connector

/* [Parameters] */
Wall_Thickness = 2;

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
End1_Magnet_Diameter = 12;

//The thickness of the magnets (mm)
End1_Magnet_Thickness = 3;

//Size of the material around the magnets (mm)
End1_Magnet_Border = 4;

// Thickness of the magnet flange (mm)
End1_Magnet_Flange_Thickness = 7;

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
End2_Magnet_Border = 4;

// Inner diameter of the Magnet flange
End2_Magnet_Flange_Thickness = 10;

/* [Hidden] */
//Stops clipping when one object is subtracted from another
adjustment = 0.02;

//Detail
$fn=100 *1;

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
//wallThicknessL Thickness of the walls
//zPosition: Start Z position.
module Pipe(diameter1, diameter2, length, wallThickness, zPosition)
{
    difference () 
    {
        //outer cylinder
        translate([0, 0, zPosition])
        {
            cylinder(
                d1=diameter1+2*wallThickness, 
                d2=diameter2+2*wallThickness, 
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

module ConePipe(diameter1, diameter2, length, wallThickness1, wallThickness2, zPosition)
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



module StartFlange()
{
    magnetPosition = (end1InnerDiameter + End1_Magnet_Diameter) / 2 + End1_Magnet_Border;
    
    difference () 
    {
        //flange
        hull () {
            for (i = [0: End1_Magnets_Count-1]) {
                rotate ([0, 0, i * (360 / End1_Magnets_Count)]) 
                translate ([magnetPosition, 0, 0]) 
                cylinder (d = End1_Magnet_Diameter + End1_Magnet_Border * 2, End1_Magnet_Flange_Thickness);
            }
        }
        
        //Magnet cut out
        for (i = [0: End1_Magnets_Count-1]) {
            rotate ([0, 0, i* 360 / End1_Magnets_Count]) 
            translate ([magnetPosition, 0, - adjustment]) 
            cylinder (d = End1_Magnet_Diameter, h = End1_Magnet_Thickness + adjustment);
        }

        //Flange inner  
        translate([0, 0, -adjustment])
            cylinder (
                d1 = end1InnerStartDiameter, 
                d2 = end1InnerEndDiameter,
                h = End1_Length + 2 * adjustment);   
    }
}

module EndFlange()
{
    magnetPosition = (end2InnerDiameter + End2_Magnet_Diameter) / 2 + End2_Magnet_Border;
    
    flangeZPosition = end2StartZ + End2_Length - End2_Magnet_Flange_Thickness;
    magnetZPosition = flangeZPosition + End2_Magnet_Flange_Thickness - End2_Magnet_Thickness;
    
    
    difference () 
    {
        //Flange
        hull () {
            for (i = [0: End2_Magnets_Count-1]) {
                rotate ([0, 0, i * (360 / End2_Magnets_Count)]) 
                translate ([magnetPosition, 0, flangeZPosition]) 
                cylinder (d = End2_Magnet_Diameter + End2_Magnet_Border * 2, End2_Magnet_Flange_Thickness);
            }
        }
        
        //Magnet cut out
        for (i = [0: End2_Magnets_Count-1]) {
            rotate ([0, 0, i* 360 / End2_Magnets_Count]) 
            translate ([magnetPosition, 0, magnetZPosition + adjustment]) 
            cylinder (d = End2_Magnet_Diameter, h = End2_Magnet_Thickness + adjustment);
        }

        //Flange inner  
        translate([0, 0, end2StartZ-adjustment])
            cylinder (
                d1 = end2InnerStartDiameter, 
                d2 = end2InnerEndDiameter,
                h = End2_Length + 2 * adjustment);   
    }
}

//Create the start connector
if(End1_Style == "mag")
{
    //Create the flange on end 1
    StartFlange(); 
}

if(End1_Style == "hose")
{
    // Create the hose stop
    Pipe (
    end1InnerEndDiameter + Wall_Thickness /2,
    end1InnerEndDiameter+ Wall_Thickness /2,
    End1_StopLength,
    End1_StopThickness + adjustment,
    End1_Length - End1_StopLength);
    
    ConePipe (
    end1InnerEndDiameter + Wall_Thickness /2,
    end1InnerEndDiameter + Wall_Thickness /2,
    End1_StopLength,
    0,
    End1_StopThickness + adjustment,
    End1_Length - End1_StopLength*2);
}
//End1 hose connector
Pipe (
    end1InnerStartDiameter,
    end1InnerEndDiameter,
    End1_Length,
    Wall_Thickness,
    0); 

//Transition between connections
Pipe (
    end1InnerEndDiameter,
    end2InnerStartDiameter,
    Transition_Length,
    Wall_Thickness,
    End1_Length);

// Create the end connector
end2StartZ = End1_Length + Transition_Length;
  
if(End2_Style == "mag")
{
    EndFlange(); 
}
if(End2_Style == "hose")
{
    // Create the hose stop
    Pipe (
    end2InnerStartDiameter + Wall_Thickness /2,
    end2InnerStartDiameter+ Wall_Thickness /2,
    End2_StopLength,
    End2_StopThickness + adjustment,
    end2StartZ);
    
    ConePipe (
    end2InnerStartDiameter + Wall_Thickness /2,
    end2InnerStartDiameter + Wall_Thickness /2,
    End2_StopLength,
    End2_StopThickness + adjustment,
    0,
    end2StartZ + End2_StopLength);
}

Pipe (
    end2InnerStartDiameter,
    end2InnerEndDiameter,
    End2_Length,
    Wall_Thickness,
    end2StartZ); 