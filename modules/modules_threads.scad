include <constants.scad>
include <thirdparty/threads-scad/threads.scad>

threads_demo = false;

if(threads_demo){
$fn = 64;
diameter = 50;
spacer = diameter*1.5;
reversed_options = [true, false];

render()
  for(iReverse = [0:len(reversed_options)-1])
  union(){
    translate([0, spacer*iReverse, 0])
    InternalHoseThread(
      diameter = diameter,
      height = 20,
      reverse_thread = reversed_options[iReverse]
    );

    translate([spacer, spacer*iReverse, 0])
    ExternalHoseThread(
      diameter = diameter,
      height = 20,
      reverse_thread = reversed_options[iReverse]
    );
  }
}

// create a internal thread inside a hose (like a nut)
module InternalHoseThread(
  diameter,
  wallThickness=2,
  height=0,
  tolerance=0.4,
  position=[0,0,0],
  rotation=[0,0,0],
  pitch=0,
  tooth_angle=30,
  tooth_height=0,
  reverse_thread = false) {
  mirror(reverse_thread ? [0,0,0] :[1,0,0])
  ScrewHole(
    outer_diam=diameter,
    height=height,
    tolerance=tolerance,
    position=position,
    rotation=rotation,
    pitch=pitch,
    tooth_angle=tooth_angle,
    tooth_height=tooth_height)
    cylinder(h=height, r=diameter/2+wallThickness);
}

// create an external thread outside a hose (like a bolt)
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
  tip_min_fract=0.75,
  reverse_thread = false) {

  fudgeFactor = 0.01;

  mirror(reverse_thread ? [0,0,0] :[1,0,0])
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
        tooth_height=min(tooth_height, pitch==0 ? ThreadPitch(diameter+wallThickness*2) : pitch),
        tip_min_fract=tip_min_fract,
        referenceThreadOuter= false);

    translate([0,0,-fudgeFactor])
      cylinder(h=height+fudgeFactor*2, d=diameter);
    }
}
