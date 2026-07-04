include <../constants.scad>
use <connector_hose.scad>

camlockVersion = "1.0";
camlockMinLength = 35+3;
camlockMeasurement = "outer";
camlockOuterDiameter = 24.25*2;

connector_camlock_demo = false;

camlockSettings = ["camlock", [
  [iSettingsLength, camlockMinLength],
  [iSettingsMeasurement, camlockMeasurement],
  [iSettingsDiameter, camlockOuterDiameter],
  [iSettingsTaper ,0],
  [iSettingsVersion, camlockVersion]
  ]];

if(connector_camlock_demo && $preview){
  $fn = 64;
  spacer = camlockOuterDiameter * 1.4;

  render_options = [
    [2],
    [4]
  ];

  for(iRender = [0:len(render_options)-1])
    translate([spacer * iRender, 0, 0])
      CamlockConnector(
        innerEndDiameter = camlockOuterDiameter,
        length = camlockMinLength,
        wallThickness = render_options[iRender][0],
        $fn = 128);
}


module CamlockConnector(
  innerEndDiameter,
  length,
  wallThickness){

  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, "innerEndDiameter must be a number greater than 0");
  assert(is_num(length) && length > 0, "length must be a number greater than 0");
  assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be a number greater than 0");
  assert(length >= camlockMinLength, "length must be at least camlockMinLength");

  innerDiameter =  20*2;
  //camlockOuterDiameter = 48.5;
  outerDiameter = camlockOuterDiameter;
  camlockHeight = 35;
  camlockStopLength = camlockMinLength - camlockHeight;
  camlockStopWidth = camlockStopLength/2.1;
  camlockWallThickness = (outerDiameter - innerDiameter)/2;
  camlockRingClipRadius = 5.1;//4.8;
  camlockRingClipHeight = 15;
  camlockRingClipPosition = 27.25;
  camlockChamfer = 1.6;
  camlockChamferLength = 1.6;

  assert(is_num(innerDiameter) && innerDiameter > 0, "innerDiameter must be a number greater than 0");
  assert(is_num(outerDiameter) && outerDiameter > innerDiameter, "outerDiameter must be greater than innerDiameter");
  assert(is_num(camlockHeight) && camlockHeight > 0 && camlockHeight <= camlockMinLength, "camlockHeight must be positive and no greater than camlockMinLength");
  assert(is_num(camlockStopLength) && camlockStopLength >= 0, "camlockStopLength must be a number greater than or equal to 0");
  assert(is_num(camlockStopWidth) && camlockStopWidth > 0, "camlockStopWidth must be a number greater than 0");
  assert(is_num(camlockWallThickness) && camlockWallThickness > 0, "camlockWallThickness must be a number greater than 0");
  assert(is_num(camlockRingClipRadius) && camlockRingClipRadius > 0, "camlockRingClipRadius must be a number greater than 0");
  assert(is_num(camlockRingClipHeight) && camlockRingClipHeight > 0, "camlockRingClipHeight must be a number greater than 0");
  assert(is_num(camlockRingClipPosition) && camlockRingClipPosition > outerDiameter / 2, "camlockRingClipPosition must be outside the outer radius");
  assert(is_num(camlockChamfer) && camlockChamfer > 0, "camlockChamfer must be a number greater than 0");
  assert(is_num(camlockChamferLength) && camlockChamferLength > 0, "camlockChamferLength must be a number greater than 0");
  assert(camlockRingClipHeight + wallThickness / 2 <= camlockMinLength + fudgeFactor, "ring clip cutout must fit within the camlock length");
  assert(camlockChamferLength <= camlockHeight, "camlockChamferLength must be less than or equal to camlockHeight");

 echo("CamlockConnector", innerDiameter = innerDiameter, outerDiameter=outerDiameter, camlockHeight=camlockHeight, length = length, camlockWallThickness = camlockWallThickness);

  difference(){
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter,
      innerEndDiameter = innerDiameter,
      length = camlockHeight,
      wallThickness = camlockWallThickness,
      stopLength = camlockStopLength,
      stopWidth = camlockStopWidth,
      stopSymmetrical = false,
      chamferLength = camlockChamferLength,
      chamferWidth= camlockChamfer
    );

    //hollow out top to reduce width and plastic, and match desired width
    translate([0,0,camlockRingClipHeight+wallThickness/2])
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter-wallThickness*2,
      innerEndDiameter = innerDiameter-wallThickness*2,
      length = camlockHeight+camlockStopLength+fudgeFactor*2-(camlockRingClipHeight+wallThickness/2),
      wallThickness = camlockWallThickness,
      stopLength = 0,
      stopWidth = 0,
      stopSymmetrical = false,
      chamferLength = camlockWallThickness,
      chamferWidth= camlockWallThickness
    );

    //subtract the ring lock
    translate([0,0,camlockRingClipHeight])
      rotate_extrude(angle = 360, convexity = 2)
      translate([camlockRingClipPosition,0,0])
      circle(camlockRingClipRadius);
  }

  /*pipe(
    diameter1 = innerDiameter,
    diameter2 = innerEndDiameter,
    length = length - camlockHeight,
    wallThickness1 = (outerDiameter - innerDiameter)/2,
    wallThickness2 = wallThickness,
    zPosition = camlockHeight);*/
}