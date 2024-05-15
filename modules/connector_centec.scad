include <constants.scad>

include <modules_utility.scad>
include <connector_hose.scad>

cenTecBodyLength =  25;
cenTecWallThickness = 3;
cenTecMinLength = cenTecBodyLength+2;
cenTecMeasurement = "inner";
cenTecInnerDiameter = 22.625*2;
cenTecOuterDiameter = cenTecInnerDiameter + cenTecWallThickness*2;

centecSettings = ["centec", [
  [iSettingsLength, cenTecMinLength],
  [iSettingsMeasurement, cenTecMeasurement],
  [iSettingsDiameter, cenTecInnerDiameter],
  [iSettingsWallThickness, (cenTecOuterDiameter - cenTecInnerDiameter)/2],
  [iSettingsTaper ,0]
  ]];
  
//CenTecConnector();

module CenTecConnector(){

  pinHoleWidth = 9.5;
  pinHoleHeight = 6;
  pinHoleRadius = 3;
  pinHoleOffset = 11;

  pinSlideIndent = 1.5;
  connectorLength = cenTecBodyLength;
  connectorInnerEndRadius= cenTecInnerDiameter/2;
  connectorInnerStartRadius= cenTecInnerDiameter/2+0.275;
  StopInnerRadius = 18.2;
  wallThickness = cenTecWallThickness;
  StopInnerLength = cenTecWallThickness;
  
  slideTaper=1;
  
  _pinHoleRadius = min(pinHoleRadius, pinHoleHeight/2);
  
  
  echo("CenTecConnector", _pinHoleRadius=_pinHoleRadius, pinHoleHeight=pinHoleHeight);
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


    //Thumb relief for the press pin
    for(i=[0:1])
      rotate([0,0,i*180])
      //translate([connectorInnerEndRadius,0,pinHoleHeight])
      translate([0,connectorInnerEndRadius+wallThickness/2,pinHoleHeight/2+pinHoleOffset])
        union(){
        rotate([90,0,0])
        centecRoundedCube(
          x=pinHoleWidth,
          y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
          h=wallThickness*2,
          r=_pinHoleRadius,
          center = true);
        
        translate([0,wallThickness/2,0])
        rotate([90,0,180])
        centecRoundedCube(
          x=pinHoleWidth,
          y=pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
          h=wallThickness,
          r1=_pinHoleRadius,
          r2=(_pinHoleRadius+wallThickness)*2, //these values are made up, not sure what a could value should be
          center = true);
    }
      
    //Slide for the clip
    intersection(){

      slideLength=pinHoleOffset+pinHoleHeight/2;

      for(i=[0:1])
      rotate([0,0,i*180])
      //translate([connectorInnerEndRadius,0,pinHoleHeight])
      translate([0,connectorInnerEndRadius+wallThickness/2,slideLength/2-pinHoleHeight/2])
      rotate([90,0,0])
      cube([pinHoleWidth,slideLength+pinHoleHeight, wallThickness*2], center = true);
      /*roundedCube(
        x=pinHoleWidth,
        y=slideLength+pinHoleHeight,//max(pinHoleWidth,pinHoleHeight),
        h=wallThickness*2,
        r1=0.1,
        r2=1,
        center = true);*/
        
      translate([0,0,slideLength+slideTaper])
      mirror([0,0,1])
      HoseConnector(
        connectorMeasurement = "outer",
        innerStartDiameter = connectorInnerStartRadius*2-pinSlideIndent*2-pinSlideIndent/2,
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
module centecRoundedCube(
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