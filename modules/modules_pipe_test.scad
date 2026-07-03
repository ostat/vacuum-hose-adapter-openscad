include <modules_pipe.scad>
include <modules_utility.scad>

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