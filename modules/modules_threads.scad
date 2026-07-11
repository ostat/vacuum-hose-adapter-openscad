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

  // Same bore sizing as ScrewHole.
  cut_diam = 1.01*diameter + 1.25*tolerance;
  _pitch = (pitch==0) ? ThreadPitch(cut_diam) : pitch;
  _tooth_height = (tooth_height==0) ? _pitch : min(tooth_height, _pitch);

  // ScrewHole's cut profile is flat at the root radius, which truncates the
  // material teeth flat when tooth_height < pitch. Cutting with a full-height
  // (pointy) thread enlarged by 'shift', clipped back to the intended major
  // radius, keeps the teeth pointy at the requested height and flank angle.
  shift = (_pitch - _tooth_height) / (2*tan(tooth_angle));
  extra_height = 0.001 * height;

  mirror(reverse_thread ? [0,0,0] :[1,0,0])
  difference() {
    cylinder(h=height, r=diameter/2+wallThickness);
    translate(position)
      rotate(rotation)
      translate([0, 0, -extra_height/2])
      intersection() {
        ScrewThread(cut_diam + 2*shift, height + extra_height,
          pitch=_pitch, tooth_angle=tooth_angle, tolerance=tolerance);
        // ScrewThread's crest radius for cut_diam, shrinkage correction included.
        cylinder(h=height + extra_height, r=(cut_diam + 0.25*tolerance)/2);
      }
  }
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
        tooth_height=tooth_height,
        tip_min_fract=tip_min_fract,
        referenceThreadOuter= false);

    translate([0,0,-fudgeFactor])
      cylinder(h=height+fudgeFactor*2, d=diameter);
    }
}
