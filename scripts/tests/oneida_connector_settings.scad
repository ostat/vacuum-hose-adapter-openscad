include <../../modules/connectors/connectors.scad>

epsilon = 0.0001;

function approx(a, b, tolerance = epsilon) = abs(a - b) <= tolerance;

function oneidaConnector(connectorNumber = 1, wall = 2.4, fit = 0, lengthValue = [20,0], nominal = [0,5]) =
  getConnectorSettings(
    userSettings = OneidaConnectorSettings(
      connector = connectorNumber,
      diameter = nominal,
      wallThickness = wall,
      length = lengthValue,
      fitAdjustment = fit
    ),
    slipRingSettings = [[0,0], wall, wall, 0],
    alignmentDepth = 0,
    alignmentUpperWidth = 0,
    alignmentLowerWidth = 0,
    alignmentSideClearance = 0,
    alignmentDepthClearance = 0,
    adapterColor = ["CornflowerBlue", 1],
    con1OuterEndDiameter = 127,
    con1Measurement = "outer",
    con1WallThickness = wall
  );

function hoseConnector(oneidaFit = 0) =
  getConnectorSettings(
    userSettings = OneidaConnectorSettings(settings = UserConnectorSettings(
      connector = 1,
      style = "hose",
      diameter = [100,0],
      wallThickness = 2.4,
      length = [20,0]
    ), fitAdjustment = oneidaFit),
    slipRingSettings = [[0,0], 2.4, 2.4, 0],
    alignmentDepth = 0,
    alignmentUpperWidth = 0,
    alignmentLowerWidth = 0,
    alignmentSideClearance = 0,
    alignmentDepthClearance = 0,
    adapterColor = ["Tomato", 1],
    con1OuterEndDiameter = 100,
    con1Measurement = "outer",
    con1WallThickness = 2.4
  );

defaultOneidaSettings = OneidaConnectorSettings(
  connector = 1,
  diameter = [0,5],
  wallThickness = 2.4,
  length = [20,0]
);
assert(len(defaultOneidaSettings) == userSettingsLength);
assert(approx(measurement_to_mm(defaultOneidaSettings[iDiameter]), 118.2));

hoseDefaultSettings = UserConnectorSettings(
  connector = 1,
  style = "hose",
  diameter = [100,0],
  wallThickness = 2.4,
  length = [20,0]
);
hoseExplicitSettings = OneidaConnectorSettings(settings = hoseDefaultSettings, fitAdjustment = 0);
assert(hoseDefaultSettings == hoseExplicitSettings);
assert(OneidaConnectorSettings(settings = hoseDefaultSettings, fitAdjustment = "unused") == hoseDefaultSettings,
  "Non-Oneida settings must pass through without evaluating Oneida controls");
hoseNoFit = hoseConnector(0);
hoseWithFitValue = hoseConnector(1.25);
assert(approx(hoseNoFit[iInnerDiameter], hoseWithFitValue[iInnerDiameter]));
assert(approx(hoseNoFit[iOuterStartDiameter], hoseWithFitValue[iOuterStartDiameter]));
assert(approx(hoseNoFit[iLength], hoseWithFitValue[iLength]));

oneidaCon1 = oneidaConnector(connectorNumber = 1, wall = 2.4, fit = 0);
oneidaCon2 = oneidaConnector(connectorNumber = 2, wall = 2.4, fit = 0);
oneidaCon3 = oneidaConnector(connectorNumber = 3, wall = 2.4, fit = 0);
assert(approx(oneidaCon1[iInnerDiameter], oneidaCon2[iInnerDiameter]));
assert(approx(oneidaCon1[iInnerDiameter], oneidaCon3[iInnerDiameter]));
assert(approx(oneidaCon1[iOuterStartDiameter], oneidaCon2[iOuterStartDiameter]));
assert(approx(oneidaCon1[iOuterStartDiameter], oneidaCon3[iOuterStartDiameter]));
assert(approx(oneidaCon1[iLength], oneidaCon2[iLength]));
assert(approx(oneidaCon1[iLength], oneidaCon3[iLength]));

assert(approx(oneidaCon1[iOuterStartDiameter], 123));
assert(approx(oneidaCon1[iInnerDiameter], 118.2));
assert(approx(oneidaCon1[iLength], 20));

oneidaWall4 = oneidaConnector(connectorNumber = 1, wall = 4, fit = 0);
assert(approx(oneidaWall4[iOuterStartDiameter], 123));
assert(approx(oneidaWall4[iInnerDiameter], 115));

oneidaFitPlus = oneidaConnector(connectorNumber = 1, wall = 2.4, fit = 0.5);
oneidaFitMinus = oneidaConnector(connectorNumber = 1, wall = 2.4, fit = -0.5);
assert(approx(oneidaFitPlus[iOuterStartDiameter] - oneidaCon1[iOuterStartDiameter], 0.5));
assert(approx(oneidaFitPlus[iInnerDiameter] - oneidaCon1[iInnerDiameter], 0.5));
assert(approx(oneidaCon1[iOuterStartDiameter] - oneidaFitMinus[iOuterStartDiameter], 0.5));
assert(approx(oneidaCon1[iInnerDiameter] - oneidaFitMinus[iInnerDiameter], 0.5));

minimumLength = oneidaQuickClampMinimumLength(wallThickness = 2.4);
oneidaAtMinimumLength = oneidaConnector(connectorNumber = 1, wall = 2.4, fit = 0, lengthValue = [minimumLength,0]);
assert(approx(oneidaAtMinimumLength[iLength], minimumLength));

for (connector = [1:3])
  for (wall = [2.4, 4])
    for (fit = [-0.5, 0, 0.5]) {
      settings = oneidaConnector(connectorNumber = connector, wall = wall, fit = fit);
      assert(settings[iWallThickness] == wall);
      assert(settings[iInterfaceWallThickness] == wall);
      assert(approx(settings[iDiameter], 123 + fit - 2 * wall));
      assert(approx(settings[iInterfaceInnerDiameter], 123 + fit - 2 * wall));
      assert(approx(settings[iInterfaceOuterDiameter], 123 + fit));
      assert(settings[iMeasurement] == "inner" && settings[iTaper] == 0);
    }

hiddenOneida = oneidaConnector(lengthValue = [0,0]);
assert(hiddenOneida[iLength] == 0 && hiddenOneida[iInterfaceLength] == 0);

for (nominalSize = oneidaQuickClampSupportedNominalsInch()) {
  inchSettings = oneidaConnector(nominal = [0,nominalSize]);
  metricSettings = oneidaConnector(nominal = [nominalSize * 25.4,0]);
  assert(inchSettings == metricSettings);
  assert(approx(inchSettings[iInterfaceInnerDiameter], nominalSize * 25.4 - 8.8));
  assert(approx(inchSettings[iInterfaceOuterDiameter], nominalSize * 25.4 - 4));
}

original = UserConnectorSettings(
  connector = 3, style = "oneida", diameter = [0,5], wallThickness = 4,
  length = [20,0], rotation = 37, taper = 3, measurement = "outer",
  extensionLength = 12, extensionExitDiameter = 110,
  extensionText = "Oneida", extensionTextSize = 5,
  extensionSlipRing = "outer", extensionSlipRingWidth = 6,
  extensionSlipRingSupport = "external", extensionSlipRingSupportSize = 0.3,
  extensionSlipRingSupportSpacing = 7,
  extensionStopThickness = 2, extensionStopLength = 3, extensionStopSymmetrical = true);
localSettings = OneidaConnectorSettings(settings = original, fitAdjustment = 0.5);
assert(len(localSettings) == len(original));
for (i = [0:len(original)-1])
  if (i != iMeasurement && i != iDiameter && i != iTaper && i != iLength)
    assert(localSettings[i] == original[i], str("Oneida must preserve generic field ", i));
assert(localSettings[iMeasurement] == "inner" && localSettings[iTaper] == 0);
assert(approx(measurement_to_mm(localSettings[iDiameter]), 115.5));
assert(approx(measurement_to_mm(localSettings[iLength]), 20));

cube([1,1,1]);
