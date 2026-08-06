include <../constants.scad>
include <connector_hose.scad>

nxtVersion = "1.0";
nxtMinLength = 25.0;
nxtMeasurement = "outer";
nxtOuterDiameter = 63.70;
nxtInnerDiameter = 58.20;
nxtWallThickness = (nxtOuterDiameter - nxtInnerDiameter) / 2; // 2.75mm
nxtRidgeHeight = 2.60;
nxtRidgeCount = 6;
nxtRidgeSpan = 19.25;
nxtRidgeArc = 55;
nxtRidgeOffset = 2.0;

rigidNxtSettings = ["rigid_nxt", [
  [iSettingsLength, nxtMinLength],
  [iSettingsMeasurement, nxtMeasurement],
  [iSettingsDiameter, nxtOuterDiameter],
  [iSettingsTaper, 0],
  [iSettingsWallThickness, nxtWallThickness],
  [iSettingsVersion, nxtVersion]
]];

rigidNxtConnector_demo = false;
if (rigidNxtConnector_demo) {
  $fn = 128;
  RigidNXTConnector(help = true);
}

module RigidNXTConnector(
  outerStartDiameter = nxtOuterDiameter,
  outerEndDiameter = nxtOuterDiameter,
  length = nxtMinLength,
  wallThickness = nxtWallThickness,
  ridgeCount = nxtRidgeCount,
  ridgeHeight = nxtRidgeHeight,
  ridgeSpan = nxtRidgeSpan,
  ridgeArc = nxtRidgeArc,
  ridgeOffset = nxtRidgeOffset,
  help = false,
  $fn = 64
) {
  assert(is_num(outerStartDiameter) && outerStartDiameter > 0, "outerStartDiameter must be a number > 0");
  assert(is_num(length) && length > 0, "length must be a number > 0");
  assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be a number > 0");

  innerStartDiameter = outerStartDiameter - wallThickness * 2;
  innerEndDiameter = outerEndDiameter - wallThickness * 2;
  ridgePitch = ridgeCount > 1 ? ridgeSpan / (ridgeCount - 1) : 0;
  r_base = outerStartDiameter / 2;
  r_max = r_base + ridgeHeight;
  ramp_len = ridgePitch * 0.82;

  union() {
    HoseConnector(
      connectorMeasurement = "outer",
      innerStartDiameter = innerStartDiameter,
      innerEndDiameter = innerEndDiameter,
      length = length,
      wallThickness = wallThickness,
      help = help,
      $fn = $fn
    );

    if (ridgeCount > 0 && ridgeHeight > 0) {
      rotate([0, 0, 90 - ridgeArc / 2]) {
        rotate_extrude(angle = ridgeArc, $fn = $fn) {
          for (i = [0 : ridgeCount - 1]) {
            z0 = ridgeOffset + i * ridgePitch;
            z1 = z0 + ramp_len;
            z2 = z0 + ridgePitch;

            if (z2 <= length + 0.1) {
              polygon(points = [
                [r_base - 0.1, z0],
                [r_max, z1],
                [r_base - 0.1, z2]
              ]);
            }
          }
        }
      }
    }
  }
}
