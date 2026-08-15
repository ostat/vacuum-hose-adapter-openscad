include <../constants.scad>
include <connector_hose.scad>

kobaltVersion = "1.0";
kobaltMinLength = 16.7;
kobaltMeasurement = "inner";
kobaltBaseOD = 38.20;
kobaltRingOD = 39.85;
kobaltFitClearance = -0.30;
kobaltInnerDiameter = kobaltBaseOD + kobaltFitClearance; // 37.90mm
kobaltWallThickness = 2.50;

kobaltSettings = ["kobalt", [
  [iSettingsLength, kobaltMinLength],
  [iSettingsMeasurement, kobaltMeasurement],
  [iSettingsDiameter, kobaltInnerDiameter],
  [iSettingsTaper, 0],
  [iSettingsWallThickness, kobaltWallThickness],
  [iSettingsVersion, kobaltVersion]
]];

kobaltConnector_demo = false;
if (kobaltConnector_demo) {
  $fn = 128;
  KobaltConnector(help = true);
}

module KobaltConnector(
  innerEndDiameter = kobaltInnerDiameter,
  length = kobaltMinLength,
  wallThickness = kobaltWallThickness,
  fitClearance = kobaltFitClearance,
  ringOD = kobaltRingOD,
  entryChamfer = 1.50,
  enableRecesses = true,
  help = false,
  $fn = 64
) {
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, "innerEndDiameter must be a number > 0");
  assert(is_num(length) && length > 0, "length must be a number > 0");
  assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be a number > 0");

  recess_id = ringOD + fitClearance;
  recess_r_outer = recess_id / 2;
  recess_r_inner = innerEndDiameter / 2 - 0.1;
  depth = recess_r_outer - recess_r_inner;

  upper_h = (8.35 - 5.50) / 2;
  upper_points = [
    [recess_r_inner, upper_h],
    for (a = [90 : -10 : -90])
      [recess_r_inner + depth * cos(a), upper_h * sin(a)],
    [recess_r_inner, -upper_h]
  ];

  lower_h = (16.70 - 14.00) / 2;
  lower_points = [
    [recess_r_inner, lower_h],
    for (a = [90 : -10 : -90])
      [recess_r_inner + depth * cos(a), lower_h * sin(a)],
    [recess_r_inner, -lower_h]
  ];

  difference() {
    pipe(
        diameter = innerEndDiameter,
        length = length,
        wallThickness = wallThickness,
        chamfer1 = [0,0],
        chamfer2 = [entryChamfer,0],
        centerSmallerWall = false,
        enableWallThicknessCompensation = true);

    if (enableRecesses && depth > 0) {
      // Upper ring recess (depth 5.50mm to 8.35mm from lip, peak at 6.925mm)
      translate([0, 0, length - 6.925])
        rotate_extrude($fn = $fn)
          polygon(points = upper_points);

      // Lower ring recess (depth 14.00mm to 16.70mm from lip, peak at 15.35mm)
      translate([0, 0, length - 15.35])
        rotate_extrude($fn = $fn)
          polygon(points = lower_points);
    }
  }
}
