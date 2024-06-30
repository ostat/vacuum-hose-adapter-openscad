include <modules_pipe.scad>

difference(){
  radius = 25;
  height = 10;
  thickness = 10;

  union(){

    
    Pipe(
        diameter1 = 100,
        diameter2 = 40,
        length = 20,
        wallThickness = 2);
    translate([0,0,30])
    Pipe(
        diameter1 = 40,
        diameter2 = 100,
        length = 20,
        wallThickness = 2);
    translate([0,0,60])
    Pipe(
        diameter1 = 20,
        diameter2 = 100,
        length = 10,
        wallThickness = 2);     
    translate([100,0,0])
    Pipe(
        diameter1 = radius*2,
        diameter2 = radius*2-thickness*2,
        length = height+fudgeFactor*2,
        wallThickness1 = fudgeFactor,
        wallThickness2 = thickness+fudgeFactor);

    translate([100,0,25])
    Pipe(
        diameter1 = 28.5,
        diameter2 = 30.1,
        length =0.8,
        wallThickness1 = 2.8,
        wallThickness2 = 2);
  }

translate([-200,0,-10])    
cube([400,100,100]);
}