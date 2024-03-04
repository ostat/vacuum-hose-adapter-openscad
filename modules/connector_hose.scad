fudgeFactor = 0.015;

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
    endCapGridSize = 0,
    endCapGridWallThickness = 0,
    chamferLength = 0,
    chamferWidth = 0,
    help
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
    if(stopWidth > 0)
    {
      translate([0,0,-fudgeFactor])
      Stopper(
        diameter = innerEndDiameter,
        outer = connectorMeasurement == "outer",
        totalLength = stopLength+fudgeFactor*2,
        taper1 = stopSymmetrical == 0 ? 0.5 : 0.4,
        taper2 = stopSymmetrical == 0? 0 : 0.4,
        wallThickness = wallThickness,
        stopThickness = stopWidth,
        zPosition = length);
    }
  }
  
   HelpTxt("HoseConnector",[
    "innerStartDiameter", innerStartDiameter,
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
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

//TODO This seems slow, esp when used for barbs
module Stopper(
    diameter,
    outer,
    totalLength,
    taper1,
    taper2,
    wallThickness,
    stopThickness,
    zPosition = 0,
    help
)
{
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