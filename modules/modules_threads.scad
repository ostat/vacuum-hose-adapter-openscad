include <constants.scad>
include <threads-scad/threads.scad>

// Create a standard sized metric hex nut.
module InternalHoseThread(
  diameter, 
  wallThickness=2, 
  height=0, 
  tolerance=0.4, 
  position=[0,0,0], 
  rotation=[0,0,0], 
  pitch=0, 
  tooth_angle=30, 
  tooth_height=0) {
  ScrewHole(
    outer_diam=diameter, 
    height=height, 
    tolerance=tolerance,
    position=position, 
    rotation=rotation, 
    pitch=pitch, 
    tooth_angle=tooth_angle, 
    tooth_height=tooth_height)
    cylinder(h=height, r=diameter/2+wallThickness, $fn=32);
}

module ExternalHoseThread(
  diameter, 
  wallThickness=2, 
  height=0, 
  tolerance=0.4, 
  pitch=0, 
  tooth_angle=30, 
  tolerance=0.4, 
  tip_height=0, 
  tooth_height=0, 
  tip_min_fract=0.75) {
  
  fudegeFactor = 0.01;
    
  translate([0,0,height])
  rotate([0,180,0])
    difference(){
      ScrewThread(
        outer_diam=diameter+wallThickness*2, 
        height=height, 
        tolerance=tolerance,
        tip_height=tip_height == 0 ? ThreadPitch(diameter) : tip_height, 
        pitch=pitch, 
        tooth_angle=tooth_angle, 
        tooth_height=tooth_height, 
        tip_min_fract=tip_min_fract,
        referenceThreadOuter= false);
        
    translate([0,0,-fudegeFactor])
      cylinder(h=height+fudegeFactor*2, d=diameter, $fn=32);
    }
}
