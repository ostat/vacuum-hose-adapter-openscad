
include <constants.scad>
include <dotSCAD/shape_circle.scad>
include <dotSCAD/ring_extrude.scad>

/*
difference(){
radius = 25;
height = 10;
thickness = 10;

union(){
  cylinder(height*2, d=radius*2-thickness*2);
  cylinder(height, d=radius*2);
  translate([0,0,-height])
  cylinder(height, d=radius*2);
}
Pipe(
    diameter1 = radius*2,
    diameter2 = radius*2-thickness*2,
    length = height+fudgeFactor*2,
    wallThickness1 = fudgeFactor,
    wallThickness2 = thickness+fudgeFactor);
}*/
            
//diameter1: Inner start diameter.
//diameter2: Inner end diameter.
//length: pipe length
//wallThickness1 Thickness of the walls at the start
//wallThickness2 Thickness of the walls at the end
//zPosition: Start Z position.
module Pipe(
    diameter1,
    diameter2,
    length,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    Offset = [0,0])
{
  difference ()
  {
    //outer cylinder
    translate([0,0,zPosition])
    hull()
    {
      if(Offset.x>0 || Offset.y>0){
        cylinder(fudgeFactor, d=diameter1+wallThickness1*2);
        translate([Offset.x,Offset.y,length-fudgeFactor])
          cylinder(fudgeFactor, d=diameter2+wallThickness2*2);
      }
      else{
        cylinder(length, 
          d1=diameter1+wallThickness1*2,
          d2=diameter2+wallThickness2*2);
      }
    }

    //Inner cylinder to remove
    translate([0,0,zPosition])
      if(Offset.x > 0 || Offset.y>0){
        hull() {
          cylinder(fudgeFactor, d=diameter1);
          translate([Offset.x,Offset.y,length+fudgeFactor*2])
            cylinder(fudgeFactor, d=diameter2);
        }
      } else {
      union()
      {
        // main removal
        cylinder(length, d1=diameter1, d2=diameter2);
        
        // bottomtop glitch correction
        translate([0,0,-fudgeFactor])
          cylinder(fudgeFactor*2, d=diameter1);

        // top glitch correction
        translate([0,0,length-fudgeFactor])
          cylinder(fudgeFactor*2, d=diameter2);
       }
    }
  }
}

module StraightPipe(
  diameter,
  length,
  wallThickness,
  zPosition = 0)
{
    Pipe (
        diameter1 = diameter,
        diameter2 = diameter,
        length = length,
        wallThickness1 = wallThickness,
        wallThickness2 = wallThickness,
        zPosition = zPosition);
}

module HalfConePipe(diameter, length, wallThickness1, wallThickness2, zPosition)
{
    Pipe (
        diameter1 = diameter,
        diameter2 = diameter,
        length = length,
        wallThickness1 = wallThickness1,
        wallThickness2 = wallThickness2,
        zPosition = zPosition);
}

module ConeRing(centerDiameter, length, wallThickness1, wallThickness2, zPosition)
{
    difference ()
    {
        //outer cylinder
        translate([0, 0, zPosition])
        cylinder(
            d1=centerDiameter+wallThickness1,
            d2=centerDiameter+wallThickness2,
            h=length);

        //Inner cylinder to remove
        translate([0, 0, zPosition-fudgeFactor])
        cylinder(
            d1=centerDiameter-wallThickness1,
            d2=centerDiameter-wallThickness2,
            h=length + 2*fudgeFactor);
    }
}

module BentPipeHull(
    inner1PipeRadius,
    inner2PipeRadius,
    end1WallThickness,
    end2WallThickness,
    pipeAngle = 0,
    zPosition=0,
    end2Count=1,
    lengthInHull=0,
    lengthOutHull=0,
    lengthOutHullCenter=0,
    edgeOffset = 0,
    addCenter = false,
    centerHeight= 0
)
{
  assert(is_num(inner1PipeRadius), "inner1PipeRadius must be a number");
  assert(is_num(inner2PipeRadius), "inner2PipeRadius must be a number");
  assert(is_num(end1WallThickness), "end1WallThickness must be a number");
  assert(is_num(end2WallThickness), "end2WallThickness must be a number");
  assert(is_num(pipeAngle), "pipeAngle must be a number");
  assert(is_num(zPosition), "zPosition must be a number");
  assert(is_num(end2Count), "end2Count must be a number");
  assert(is_num(lengthInHull), "lengthInHull must be a number");
  assert(is_num(lengthOutHull), "lengthOutHull must be a number");
  assert(is_num(edgeOffset), "edgeOffset must be a number");
  assert(is_bool(addCenter), "addCenter must be a boolean");
  assert(is_num(centerHeight), "centerHeight must be a number");
  
  outer1PipeRadius = inner1PipeRadius + end1WallThickness;
  outer2PipeRadius = inner2PipeRadius + end2WallThickness;
  //_edgeOffset = outer1PipeRadius - outer2PipeRadius - edgeOffset;
  _edgeOffset = edgeOffset;
  
  end1BaseHeight = end1WallThickness;
  end2BaseHeight = end2WallThickness;
  
  //echo("BentPipeHull", _edgeOffset = _edgeOffset, lengthInHull = lengthInHull, centerHeight=centerHeight, lengthOutHull=lengthOutHull, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, a= (cos(pipeAngle) * outer2PipeRadius*2));
  
  difference(){
    //Outer shape
    union(){
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*(360/end2Count)])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, lengthInHull])
          cylinder(r=outer2PipeRadius, h=end2WallThickness);
        }
           
        if(addCenter)
        {
          //end 2 center
          translate([0, 0, centerHeight-end2WallThickness])
          cylinder(r=outer2PipeRadius, h=end2WallThickness);
        }
        
        //end1
        cylinder(r=outer1PipeRadius, h=end1BaseHeight+fudgeFactor);
      }

      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        //echo("Outer shape", pipeAngle=pipeAngle, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, _edgeOffset=_edgeOffset, lengthInHull=lengthInHull, end2WallThickness=end2WallThickness );

        rotate([0,0,rotation*(360/end2Count)])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, lengthInHull])
        cylinder(r=outer2PipeRadius, h=lengthOutHull+end2WallThickness+fudgeFactor);
      }
      
      if(addCenter)
      {
          translate([0, 0, centerHeight])
          cylinder(r=outer2PipeRadius, h=lengthOutHullCenter);
      }
    }

    //inner/negative shape
    union(){
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*(360/end2Count)])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
          cylinder(r=inner2PipeRadius, h=end2WallThickness+fudgeFactor*2);
        }

        if(addCenter)
        {
        //End 2 center
          translate([0, 0, centerHeight-end2WallThickness-fudgeFactor])
          cylinder(r=inner2PipeRadius, h=end2WallThickness+fudgeFactor*2);
        }
        
        //End 1
        cylinder(r=inner1PipeRadius, h=end1BaseHeight+fudgeFactor*2);
      }

      for (rotation = [0:end2Count-1])
      {
        //End 2 extentions
        rotate([0,0,rotation*(360/end2Count)])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
        cylinder(r=inner2PipeRadius, h=lengthOutHull+end2WallThickness*2+fudgeFactor*2);
      }
      
      if(addCenter)
      {
          translate([0, 0, centerHeight-fudgeFactor])
          cylinder(r=inner2PipeRadius, h=lengthOutHullCenter+fudgeFactor*2);
        }
    }

    //Clear start from clipping
    rotate([0, 0, pipeAngle])
    translate([0, 0, -fudgeFactor])
      cylinder(
          r=inner1PipeRadius,
          h=fudgeFactor*2);

  }
}

module BentPipe(
    bendRadius,
    innerPipeDiameter,
    wallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1
)
{
  outerPipeDiameter  = innerPipeDiameter + wallThickness * 2;

  baseSupportThickness = outerPipeDiameter/2 + baseThickness;
  baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
  baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
  baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

  //echo("BentPipe", bendRadius=bendRadius, innerPipeDiameter=innerPipeDiameter,wallThickness=wallThickness, pipeAngle=pipeAngle, zPosition=zPosition);
  //echo("BentPipe", baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);


  difference() {
    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){
        // printing base
        if (end2Count <= 1 && baseType != "none"){
          rotate([0,0,baseSupportAngle])
          translate([bendRadius,0,0])
          rotate([0,90,0])
          if (baseType == "rectangle")
            translate([0,0,baseSupportThickness*3/4]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness/2],center=true);
          else if (baseType == "oval")
            translate([0,0,baseSupportThickness/2])
            resize([baseSupportWidth,0,0]) 
            cylinder(h=baseSupportThickness/2,d=baseSupportLength);
        }

        rotate_extrude(angle=pipeAngle, convexity=10)
          translate([bendRadius, 0, 0])
          circle(d=outerPipeDiameter);
      }
    }

    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){

     rotate([0, 0, -1])
     rotate_extrude(angle=pipeAngle+2,convexity=10)
            translate([bendRadius, 0, 0])
            circle(d=innerPipeDiameter);

      //Clear start from clipping
      rotate([90, 0, pipeAngle])
      translate([bendRadius, 0, -baseSupportThickness])
      cylinder(
          d=innerPipeDiameter,
          h=baseSupportThickness);

    //Clear end of the pipe from clipping
    rotate([90, 0, 0])
      translate([bendRadius, 0, 0])
      cylinder(d=innerPipeDiameter, h=fudgeFactor*2);
    }}
  }
}

module TaperedBentPipe(
    bendRadius,
    end1InnerPipeDiameter,
    end2InnerPipeDiameter,
    end1WallThickness,
    end2WallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1
)
{
    assert(is_num(pipeAngle) &&  pipeAngle > 0, "pipeAngle must be greater than 0");
    //echo("TaperedBentPipe", bendRadius=bendRadius, end1InnerPipeDiameter=end1InnerPipeDiameter, end2InnerPipeDiameter=end2InnerPipeDiameter, end1WallThickness=end1WallThickness, end2WallThickness=end2WallThickness);

    outerPipeDiameter  = end1InnerPipeDiameter + end1WallThickness * 2;

    sizeStart = end1InnerPipeDiameter / 2 + end1WallThickness ;
    sizeEnd = end2InnerPipeDiameter / 2 + end2WallThickness ;

    //baseSupportThickness should be between the start and end, but wieghted to the thicker end.
    supportBaseValue = (max(sizeStart,sizeEnd)*2 + min(sizeStart,sizeEnd))/3;
    baseSupportThickness = supportBaseValue + baseThickness;
    baseSupportWidth =  baseWidth == 0 ? supportBaseValue *1.5 : baseWidth;
    baseSupportLength =  baseLength == 0 ? supportBaseValue * 2: baseLength;
    baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

    shapeOuter = shape_circle(sizeStart);
    shapeInner = shape_circle(sizeStart-end1WallThickness);

    //echo("TaperedBentPipe", baseSupportThickness=baseSupportThickness,  baseSupportAngle=baseSupportAngle,  baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);

    translate([0, 0, zPosition])
    difference(){
        difference(){

          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            translate([-bendRadius, 0, 0])
            rotate([90, 0, 0])
            union(){
              // printing base
              if (end2Count <= 1 && baseType != "none"){
                rotate([0,0,baseSupportAngle])
                translate([bendRadius,0,0])
                rotate([0,90,0])
                if (baseType == "rectangle")
                   translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
                else if (baseType == "oval")
                    resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
                }
                ring_extrude(shapeOuter, radius = bendRadius, angle = pipeAngle, scale = (sizeEnd/sizeStart           ));
              }
          }


          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            union(){
              translate([-bendRadius, 0, 0])
              rotate([90, 0, 0])
              ring_extrude(
                shapeInner,
                radius = bendRadius,
                angle = pipeAngle,
                scale = ((sizeEnd-end2WallThickness)/(sizeStart-end1WallThickness)));

              //Clear start from clipping
              translate([0, 0, -fudgeFactor])
              cylinder(
                  d=end1InnerPipeDiameter,
                  h=2*fudgeFactor);

              //Clear end of the pipe from clipping
              translate([-bendRadius+fudgeFactor, 0, 0])
              rotate([0, -pipeAngle, 0])
                  translate([bendRadius, 0, 0])
                  cylinder(
                      d=end2InnerPipeDiameter,
                      h=2*fudgeFactor);

          }
        }
      }
    }
  }

  /*
translate([0,0,25])
Stopper(
    diameter = 100,
    outer = true,
    totalLength = 20,
    taper1 = [10,10],
    taper2 = [5,5],
    wallThickness = 10,
    stopThickness = 20,
    marker = false);


Stopper(
    diameter = 100,
    outer = true,
    totalLength = 20,
    taper1 = 0.33,
    taper2 = 0.33,
    wallThickness = 10,
    stopThickness = 20,
    marker = false);
*/
//TODO This seems slow, esp when used for barbs
module Stopper(
    diameter,
    outer = true,
    totalLength,
    taper1,
    taper2,
    wallThickness,
    stopThickness,
    zPosition = 0,
    marker = false,
    help
)
{
  if(is_num(taper1)){ assert(taper1 >= 0 || taper1 <= 1, "taper1 should be between 0 to 1");}
  if(is_num(taper2)){ assert(taper2 >= 0 || taper2 <= 1, "taper1 should be between 0 to 1");}
  
  
  _diameter = outer ? diameter : diameter + wallThickness*2;
  markPos = (outer ? diameter+wallThickness : diameter-stopThickness*2)/2;
  
  taperLength1 = (is_list(taper1) ? taper1.y : totalLength * taper1);
  zoffset1 = wallThickness*taperLength1/stopThickness;
  length1= (zoffset1 + totalLength);
  taperWidth1 = is_list(taper1) ? taper1.x : length1 * stopThickness / taperLength1;
   
  taperLength2 = (is_list(taper2) ? taper2.y : totalLength * taper2);
  zoffset2 = wallThickness * taperLength2 / stopThickness;
  length2 = (zoffset2 + totalLength);
  taperWidth2 = is_list(taper2) ? taper2.x : length2 * stopThickness / taperLength2;
  
  echo("taper-1",taper1=taper1,taperLength1=taperLength1,zoffset1=zoffset1,length1=length1,taperWidth1=taperWidth1);
  echo("taper-2",taper2=taper2,taperLength2=taperLength2,zoffset2=zoffset2,length2=length2,taperWidth2=taperWidth2);
  
  translate([0,0,zPosition])
  union(){
    if(marker)
      translate([markPos,0,+stopThickness])
      sphere(d=stopThickness);
    intersection()
    {
      flat = totalLength - taperLength1 - taperLength2;
      StraightPipe (
        diameter = outer ? diameter : diameter-stopThickness*2,
        length = totalLength,
        wallThickness = wallThickness + stopThickness);
    
        //Bottom taper
        if(taperLength1 > 0)
        {
          //taperLength1 = totalLength * taper1;
          //zoffset1 = wallThickness*taperLength1/stopThickness;
          //length1= (zoffset1 + totalLength);
          //width1 = length1 * stopThickness / taperLength1;
          diameterstart1 = _diameter;
          diameterend1 = outer ? _diameter :_diameter - taperWidth1*2;
          Pipe (
            diameter1 = diameterstart1,
            diameter2 = diameterend1,
            length = length1,
            wallThickness1 = 0,
            wallThickness2 = taperWidth1,
            zPosition = -zoffset1);
        }

        //Top taper
        if(taperLength2 > 0)
        {
          //taperLength2 = totalLength * taper2;
          //zoffset2 = wallThickness * taperLength2 / stopThickness;
          //length2 = (zoffset2 + totalLength);
          //width2 = length2 * stopThickness / taperLength2;
          diameterstart2 = outer ? _diameter :_diameter - taperWidth2*2;
          diameterend2 = _diameter;
          Pipe (
            diameter1 = diameterstart2,
            diameter2 = diameterend2,
            length = length2,
            wallThickness1 = taperWidth2,
            wallThickness2 = 0);
          
        }
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