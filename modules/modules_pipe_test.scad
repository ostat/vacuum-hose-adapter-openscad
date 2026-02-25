include <modules_pipe.scad>
include <modules_utility.scad>

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


translate([-250,0,0])    
difference(){  
  BentPipeHull(
    inner1PipeRadius=50,
    inner2PipeRadius=50,
    inner3PipeRadius=50,
    end1WallThickness=2,
    end2WallThickness=2,
    end3WallThickness=3,
    pipeAngle=45,
    zPosition=0,
    end2Count=1,
    lengthInHull=100,
    lengthOutHull=0,
    lengthOutHullCenter=90,
    edgeOffset = 10,
    addCenter = true,
    centerHeight= 50);
 
  translate([-200,0,-50])    
  cube([400,100,200]);   
}