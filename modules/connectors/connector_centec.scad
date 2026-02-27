include <../constants.scad>
include <../modules_utility.scad>
include <connector_hose.scad>

cenTecFemaleVersion = "0.1";
cenTecFemaleBodyLength =  25;
cenTecFemaleWallThickness = 3;
cenTecFemaleMinLength = cenTecFemaleBodyLength+2;
cenTecFemaleMeasurement = "inner";
cenTecFemaleInnerDiameter = 22.625*2;
cenTecFemaleOuterDiameter = cenTecFemaleInnerDiameter + cenTecFemaleWallThickness*2;

centecFemaleSettings = ["centec_female", [
  [iSettingsLength, cenTecFemaleMinLength],
  [iSettingsMeasurement, cenTecFemaleMeasurement],
  [iSettingsDiameter, cenTecFemaleInnerDiameter],
  [iSettingsWallThickness, (cenTecFemaleOuterDiameter - cenTecFemaleInnerDiameter)/2],
  [iSettingsTaper ,0],
  [iSettingsVersion, cenTecFemaleVersion]
  ]];

cenTecMaleVersion = "0.2";
cenTecMaleBodyLength =  25.797;
cenTecMaleMinLength = 32;
cenTecMaleMeasurement = "outer";
cenTecMaleInnerDiameter = 32.544;
cenTecMaleOuterDiameter = 44.75; //v0.1 45.244;
cenTecMaleWallThickness = (cenTecMaleOuterDiameter - cenTecMaleInnerDiameter)/2;

centecMaleSettings = ["centec_male", [
  [iSettingsLength, cenTecMaleMinLength],
  [iSettingsMeasurement, cenTecMaleMeasurement],
  [iSettingsDiameter, cenTecMaleOuterDiameter],
  [iSettingsWallThickness, (cenTecMaleOuterDiameter - cenTecMaleInnerDiameter)/2],
  [iSettingsTaper ,0],
  [iSettingsVersion, cenTecMaleVersion]
  ]];

//Test female
//CenTecFemaleConnector();
//Test male
//CenTecMaleConnector();

module CenTecMaleConnector($fn = 64){
  connectorLength = cenTecMaleMinLength;
  connectorInnerRadius= cenTecMaleInnerDiameter/2;
  connectorOuterRadius= cenTecMaleOuterDiameter/2;
  StopInnerRadius = 18.2;
  wallThickness = cenTecMaleWallThickness;
  StopInnerLength = cenTecFemaleWallThickness;

  clickLength = 6.5;//V0.1 5.556;
  clickDiameter = 36.513;
  clickZpos = 8.5;//V0.1 9.128;
  clickWallThicknessDepth = (cenTecMaleOuterDiameter-clickDiameter);

  startLipLength = 1.191;
  startLipDiameter = 35.719;
  startLipWidthDepth = (cenTecMaleOuterDiameter - startLipDiameter);

  stopLength = 6;
  stopWidth = 3.175;
  stopZpos = connectorLength - stopLength;// 25.797;

  union(){
  difference(){
    Pipe(
      diameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness=wallThickness);
    /*HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = connectorInnerRadius*2,
      innerEndDiameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness = wallThickness);*/
    Pipe(
      diameter = startLipDiameter,
      length = startLipLength,
      wallThickness=startLipWidthDepth,
      zPosition = -fudgeFactor);
    Pipe(
      diameter = clickDiameter,
      length = clickLength,
      wallThickness=clickWallThicknessDepth,
      zPosition = clickZpos);
  }

  Stopper(
    diameter = connectorOuterRadius*2-fudgeFactor,
    outer = true,
    totalLength = stopLength,
    taper1 = 0,
    taper2 = 0.5,
    wallThickness = 0,
    stopThickness = stopWidth,
    zPosition = stopZpos);
  }
}

module CenTecFemaleConnector($fn = 64){

  pinHoleWidth = 9.5;
  pinHoleHeight = 6;
  pinHoleRadius = 3;
  pinHoleOffset = 11;

  pinSlideIndent = 1.5;
  connectorLength = cenTecFemaleBodyLength;
  connectorInnerEndRadius= cenTecFemaleInnerDiameter/2;
  connectorInnerStartRadius= cenTecFemaleInnerDiameter/2+0.275;
  StopInnerRadius = 18.2;
  wallThickness = cenTecFemaleWallThickness;
  StopInnerLength = cenTecFemaleWallThickness;

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