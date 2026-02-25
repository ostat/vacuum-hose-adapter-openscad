include <constants.scad>
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

 /*
 makitaConnector(
  innerEndDiameter = makitaOuterDiameter,
  length = makitaMinLength,
  wallThickness = 2);
 */

//MakitaMaleConnector();

module MakitaMaleConnector(
  help,
  $fn = 64){
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
    Pipe (
      diameter = makitaRingClipRadius,
      length = makitaRingClipHeight,
      wallThickness = makitaWallThickness,
      zPosition = makitaRingClipPosition);
  }
}