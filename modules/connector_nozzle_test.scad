include <connector_nozzle.scad>

difference(){
  union(){
    Nozzle(
      innerStartDiameter = 100,
      length = 10,
      wallThickness = 2,
      nozzleShape = "square",
      nozzleSize = [10,10,2],
      nozzleTipWallThickness = 1,
      nozzleRadius = 2);
      
    translate([0,0,20])    
    Nozzle(
      innerStartDiameter = 10,
      length = 10,
      wallThickness = 2,
      nozzleShape = "square",
      nozzleSize = [100,10,2],
      nozzleTipWallThickness = 1,
      nozzleRadius = 2);
  }

  translate([-100,0,-10])    
  cube([200,100,100]);
}