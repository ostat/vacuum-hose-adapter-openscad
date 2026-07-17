include <../constants.scad>
include <connector_hose.scad>
//from here https://cad.onshape.com/documents/b952efdb75aae7a041c428d2/w/8d2594b7d94e0bbfda74354e/e/ce4460e84e97931fc7b7869b

makitaVersion = "0.1";
makitaMinLength = 53.3;
makitaMeasurement = "outer";
makitaOuterDiameter = 38.5;
makitaInnerDiameter = 31;
makitaWallThickness = (makitaOuterDiameter-makitaInnerDiameter)/2;

makitaMaleSettings = ["makita_male", [
  [iSettingsLength, makitaMinLength],
  [iSettingsMeasurement, makitaMeasurement],
  [iSettingsDiameter, makitaOuterDiameter],
  [iSettingsTaper ,0],
  [iSettingsWallThickness, makitaWallThickness],
  [iSettingsVersion, makitaVersion]
  ]];

connector_makita_demo = false;

if(connector_makita_demo){
  MakitaMaleConnector(
    help=true, $fn=128);
}

module MakitaMaleConnector(
  help = false,
  $fn = 64){

  assert(is_bool(help), "help must be a boolean");

  outerDiameter = makitaOuterDiameter;
  innerDiameter =  outerDiameter - makitaWallThickness*2;

  makitaRingClipRadius = outerDiameter - 1.85*2;
  makitaRingClipHeight = 10.5;
  makitaRingClipPosition = 29.5;

  lowerInnerLipDiameter = 33;
  lowerInnerLipLength = 3;
  makitaChamfer = 1;
  makitaChamferLength = 4.5;
  endStopDiameter = 51;
  endStopLength = 4;

  assert(is_num(makitaMinLength) && makitaMinLength > 0, "makitaMinLength must be a number greater than 0");
  assert(is_num(makitaWallThickness) && makitaWallThickness > 0, "makitaWallThickness must be a number greater than 0");
  assert(is_num(outerDiameter) && outerDiameter > 0, "outerDiameter must be a number greater than 0");
  assert(is_num(innerDiameter) && innerDiameter > 0, "innerDiameter must be a number greater than 0");
  assert(makitaWallThickness * 2 < outerDiameter, "makitaWallThickness is too large for outerDiameter");

  assert(is_num(makitaRingClipRadius) && makitaRingClipRadius > 0, "makitaRingClipRadius must be a number greater than 0");
  assert(is_num(makitaRingClipHeight) && makitaRingClipHeight > 0, "makitaRingClipHeight must be a number greater than 0");
  assert(is_num(makitaRingClipPosition) && makitaRingClipPosition >= 0, "makitaRingClipPosition must be a number greater than or equal to 0");
  assert(makitaRingClipPosition + makitaRingClipHeight <= makitaMinLength + fudgeFactor, "ring clip must fit within connector length");

  assert(is_num(lowerInnerLipDiameter) && lowerInnerLipDiameter > 0, "lowerInnerLipDiameter must be a number greater than 0");
  assert(is_num(lowerInnerLipLength) && lowerInnerLipLength > 0, "lowerInnerLipLength must be a number greater than 0");
  assert(is_num(makitaChamfer) && makitaChamfer >= 0, "makitaChamfer must be a number greater than or equal to 0");
  assert(is_num(makitaChamferLength) && makitaChamferLength >= 0, "makitaChamferLength must be a number greater than or equal to 0");
  assert(is_num(endStopDiameter) && endStopDiameter >= outerDiameter, "endStopDiameter must be a number greater than or equal to outerDiameter");
  assert(is_num(endStopLength) && endStopLength > 0 && endStopLength <= makitaMinLength, "endStopLength must be > 0 and <= makitaMinLength");

 echo("makitaConnector", innerDiameter = innerDiameter, outerDiameter=outerDiameter, makitaMinLength=makitaMinLength, makitaWallThickness = makitaWallThickness);

  difference(){
    union(){
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerDiameter,
      innerEndDiameter = innerDiameter,
      length = makitaMinLength,
      wallThickness = makitaWallThickness,
      stopSymmetrical = 0,
      chamferLength = makitaChamferLength,
      chamferWidth= makitaChamfer
    );

      Stopper(
        diameter = makitaOuterDiameter-fudgeFactor,
        outer = true,
        totalLength = endStopLength,
        taper1 = 0,
        taper2 = 0.5,
        wallThickness = 0,
        stopThickness = (endStopDiameter-makitaOuterDiameter)/2,
        zPosition = makitaMinLength-endStopLength);
    }

    translate([0,0,-fudgeFactor])
    cylinder(d=lowerInnerLipDiameter, h=lowerInnerLipLength);

    //subtract the ring lock
    pipe(
      diameter = makitaRingClipRadius,
      length = makitaRingClipHeight,
      wallThickness = makitaWallThickness,
      zPosition = makitaRingClipPosition);
  }
}