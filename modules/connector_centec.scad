fudgeFactor = 0.015;

cenTecMinLength = 25+2;
cenTecMeasurement = "inner";
cenTecInnerDiameter = 22.625*2;
cenTecOuterDiameter = cenTecInnerDiameter + 6;

module CenTecConnector(){

  pinHoleWidth = 11;
  pinHoleHeight = 6;
  pinHoleRadius = 1;
  pinHoleOffset = 11;

  pinSlideIndent = 1.5;
  connectorLength = 25;
  connectorInnerEndRadius= 22.625;
  connectorInnerStartRadius= 22.9;
  StopInnerRadius = 18.2;
  ConnectorOuterRadius = 51.250;
  wallThickness = 3;
  StopInnerLength = wallThickness;
  
  echo("CenTecConnector");
    //Main body


difference(){
    HoseConnector(
      connectorMeasurement = "inner",
      innerStartDiameter = connectorInnerStartRadius*2,
      innerEndDiameter = connectorInnerEndRadius*2,
      length = connectorLength,
      wallThickness = wallThickness,
      stopLength = 2,
      stopWidth = 2,
      chamferLength = 1,
      chamferWidth= 1
    );


    for(i=[0:1])
    rotate([0,0,i*180])
    //translate([connectorInnerEndRadius,0,pinHoleHeight])
    translate([0,connectorInnerEndRadius+wallThickness/2,pinHoleHeight/2+pinHoleOffset])
    union(){
    rotate([90,0,0])
    roundedCube(
      x=pinHoleWidth,
      y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
      h=wallThickness*2,
      r=pinHoleRadius,
      center = true);
    
    translate([0,wallThickness/2,0])
    rotate([90,0,180])
    roundedCube(
      x=pinHoleWidth,
      y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
      h=wallThickness,
      r1=pinHoleRadius,
      r2=(pinHoleRadius+wallThickness)*2, //these values are made up, not sure what a could value should be
      center = true);
  }
    
    intersection(){
      slideTaper=1;
      slideLength=pinHoleOffset+pinHoleHeight/2;

      for(i=[0:1])
      rotate([0,0,i*180])
      //translate([connectorInnerEndRadius,0,pinHoleHeight])
      translate([0,connectorInnerEndRadius+wallThickness/2,slideLength/2-pinHoleHeight/2])
      rotate([90,0,0])
      roundedCube(
        x=pinHoleWidth,
        y=slideLength+pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
        h=wallThickness*2,
        r1=pinHoleRadius,
        center = true);

        
      translate([0,0,slideLength+slideTaper])
      mirror([0,0,1])
      HoseConnector(
        connectorMeasurement = "outer",
        innerStartDiameter = connectorInnerStartRadius*2-pinSlideIndent*2,
        innerEndDiameter = connectorInnerStartRadius*2-pinSlideIndent,
        length = slideLength,
        wallThickness = pinSlideIndent,
        stopLength = slideTaper*2,
        stopWidth = slideTaper
      );
    }
  }      
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//fn = overrides the #fn function for the corners
module roundedCube(
  x,
  y,
  h,
  r,
  r1,
  r2,
  taper=0,
  center=false,
  fn = 64)
{
  r1 = is_num(r1) ? r1 : r;
  r2 = is_num(r2) ? r2 : r;
  
  positions=[
     [r1            ,r1            ,0]
    ,[max(x-r1, r1) ,r1            ,0]
    ,[max(x-r1, r1) ,max(y-r1, r1) ,0]
    ,[r1            ,max(y-r1, r1) ,0]
    ];

  translate(center ? [-x/2,-y/2,-h/2]:[0:0:0])
  hull(){
    for (x =[0:1:len(positions)-1])
    {
      //translate(positions[x]) 
      //  circle(cornerRadius, $fn=fn);
      translate(positions[x]) 
        cylinder(r1=r1, r2=r2, h=h,$fn=fn);
    }
  }
}