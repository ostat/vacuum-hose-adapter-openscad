include <../constants.scad>
include <../modules_utility.scad>
include <connector_hose.scad>

connector_centec_demo = false;

if(connector_centec_demo && $preview){
  $fn = 64;

  //Test female
  CenTecFemaleConnector();
  //Test male
  translate([60,0,0])
  CenTecMaleConnector();
}

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


module CenTecMaleConnector($fn = 64){
  assert(is_num(cenTecMaleMinLength) && cenTecMaleMinLength > 0, str("cenTecMaleMinLength must be a number greater than 0. Provided:", cenTecMaleMinLength));
  assert(is_num(cenTecMaleBodyLength) && cenTecMaleBodyLength > 0, str("cenTecMaleBodyLength must be a number greater than 0. Provided:", cenTecMaleBodyLength));
  assert(is_num(cenTecMaleInnerDiameter) && cenTecMaleInnerDiameter > 0, str("cenTecMaleInnerDiameter must be a number greater than 0. Provided:", cenTecMaleInnerDiameter));
  assert(is_num(cenTecMaleOuterDiameter) && cenTecMaleOuterDiameter > cenTecMaleInnerDiameter, str("cenTecMaleOuterDiameter must be greater than cenTecMaleInnerDiameter. outer=", cenTecMaleOuterDiameter, " inner=", cenTecMaleInnerDiameter));
  assert(is_num(cenTecMaleWallThickness) && cenTecMaleWallThickness > 0, str("cenTecMaleWallThickness must be a number greater than 0. Provided:", cenTecMaleWallThickness));
  assert(cenTecMaleWallThickness * 2 < cenTecMaleOuterDiameter, str("cenTecMaleWallThickness is too large for cenTecMaleOuterDiameter. wallThickness=", cenTecMaleWallThickness, " outerDiameter=", cenTecMaleOuterDiameter));

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
    pipe(
      diameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness=wallThickness);
    /*HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = connectorInnerRadius*2,
      innerEndDiameter = connectorInnerRadius*2,
      length = connectorLength,
      wallThickness = wallThickness);*/
    pipe(
      diameter = startLipDiameter,
      length = startLipLength,
      wallThickness=startLipWidthDepth,
      zPosition = -fudgeFactor);
    pipe(
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
  assert(is_num(cenTecFemaleBodyLength) && cenTecFemaleBodyLength > 0, str("cenTecFemaleBodyLength must be a number greater than 0. Provided:", cenTecFemaleBodyLength));
  assert(is_num(cenTecFemaleMinLength) && cenTecFemaleMinLength > cenTecFemaleBodyLength, str("cenTecFemaleMinLength must be greater than cenTecFemaleBodyLength. minLength=", cenTecFemaleMinLength, " bodyLength=", cenTecFemaleBodyLength));
  assert(is_num(cenTecFemaleWallThickness) && cenTecFemaleWallThickness > 0, str("cenTecFemaleWallThickness must be a number greater than 0. Provided:", cenTecFemaleWallThickness));
  assert(is_num(cenTecFemaleInnerDiameter) && cenTecFemaleInnerDiameter > 0, str("cenTecFemaleInnerDiameter must be a number greater than 0. Provided:", cenTecFemaleInnerDiameter));
  assert(is_num(cenTecFemaleOuterDiameter) && cenTecFemaleOuterDiameter > cenTecFemaleInnerDiameter, str("cenTecFemaleOuterDiameter must be greater than cenTecFemaleInnerDiameter. outer=", cenTecFemaleOuterDiameter, " inner=", cenTecFemaleInnerDiameter));

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

  assert(is_num(pinHoleWidth) && pinHoleWidth > 0, str("pinHoleWidth must be a number greater than 0. Provided:", pinHoleWidth));
  assert(is_num(pinHoleHeight) && pinHoleHeight > 0, str("pinHoleHeight must be a number greater than 0. Provided:", pinHoleHeight));
  assert(is_num(pinHoleRadius) && pinHoleRadius > 0, str("pinHoleRadius must be a number greater than 0. Provided:", pinHoleRadius));
  assert(is_num(pinHoleOffset) && pinHoleOffset >= 0, str("pinHoleOffset must be a number greater than or equal to 0. Provided:", pinHoleOffset));
  assert(is_num(pinSlideIndent) && pinSlideIndent > 0, str("pinSlideIndent must be a number greater than 0. Provided:", pinSlideIndent));
  assert(is_num(slideTaper) && slideTaper >= 0, str("slideTaper must be a number greater than or equal to 0. Provided:", slideTaper));
  assert(is_num(_pinHoleRadius) && _pinHoleRadius > 0, str("_pinHoleRadius must be a number greater than 0. Provided:", _pinHoleRadius));
  assert(_pinHoleRadius <= pinHoleHeight/2, str("_pinHoleRadius must be less than or equal to half pinHoleHeight. pinHoleRadius=", _pinHoleRadius, " pinHoleHeight=", pinHoleHeight));


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
  $fn = 64)
{
  assert(is_num(x) && x > 0, str("x must be a number greater than 0. Provided:", x));
  assert(is_num(y) && y > 0, str("y must be a number greater than 0. Provided:", y));
  assert(is_num(h) && h > 0, str("h must be a number greater than 0. Provided:", h));
  assert(is_bool(center), str("center must be a boolean. Provided:", center));
  assert(is_undef(r) || (is_num(r) && r >= 0), str("r must be undefined or a number greater than or equal to 0. Provided:", r));
  assert(is_undef(r1) || (is_num(r1) && r1 >= 0), str("r1 must be undefined or a number greater than or equal to 0. Provided:", r1));
  assert(is_undef(r2) || (is_num(r2) && r2 >= 0), str("r2 must be undefined or a number greater than or equal to 0. Provided:", r2));

  r1 = is_num(r1) ? r1 : r;
  r2 = is_num(r2) ? r2 : r;
  //assert(r1 <= min(x, y)/2, str("r1 must be less than or equal to half of the smaller dimension. r1=", r1, " limit=", min(x, y)/2));
  //assert(r2 <= min(x, y)/2, str("r2 must be less than or equal to half of the smaller dimension. r2=", r2, " limit=", min(x, y)/2));

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
        cylinder(r1=r1, r2=r2, h=h);
    }
  }
}