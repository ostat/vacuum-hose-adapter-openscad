/* [Hidden] */
fudgeFactor = 0.015;

dw735MinLength = 17;
dw735Measurement = "inner";
dw735InnerDiameter = 71;

dw735Settings = ["dw735", [
  [iSettingsLength, dw735MinLength],
  [iSettingsMeasurement, dw735Measurement],
  [iSettingsDiameter, dw735InnerDiameter],
  [iSettingsTaper ,0]
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