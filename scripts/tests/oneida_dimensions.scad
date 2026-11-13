include <../../modules/connectors/connector_oneida.scad>

epsilon = 0.0001;

function approx(a, b, tolerance = epsilon) = abs(a - b) <= tolerance;

supportedNominalInch = [3,4,5,6,7,8,9,10,11,12,14,16,18];
supportedNominalMm = [76.2,101.6,127,152.4,177.8,203.2,228.6,254,279.4,304.8,355.6,406.4,457.2];

assert(oneidaQuickClampSupportedNominalsInch() == supportedNominalInch);
supportedNominalMmActual = oneidaQuickClampSupportedNominalDiameters();
assert(len(supportedNominalMmActual) == len(supportedNominalMm));
for (i = [0 : len(supportedNominalMm) - 1]) {
  assert(approx(supportedNominalMmActual[i], supportedNominalMm[i]));
  dimensions = oneidaQuickClampDimensions(supportedNominalMm[i], 2.4, 0);
  assert(approx(dimensions[iOneidaDimensionBeadOuterDiameter], supportedNominalMm[i] + 9));
  assert(approx(dimensions[iOneidaDimensionNeckOuterDiameter], supportedNominalMm[i] - 4));
  assert(approx((dimensions[iOneidaDimensionBeadOuterDiameter] - dimensions[iOneidaDimensionBeadInnerDiameter]) / 2, 5.58));
}

dimsFiveInch = oneidaQuickClampDimensions(nominalDiameter = 5 * 25.4, wallThickness = 2.4, fitAdjustment = 0);
dimsFiveMetric = oneidaQuickClampDimensions(nominalDiameter = 127, wallThickness = 2.4, fitAdjustment = 0);
dimsSixInch = oneidaQuickClampDimensions(nominalDiameter = 6 * 25.4, wallThickness = 2.4, fitAdjustment = 0);

assert(dimsFiveInch == dimsFiveMetric);
assert(approx(dimsFiveMetric[iOneidaDimensionNominal], 127));
assert(approx(dimsFiveMetric[iOneidaDimensionBeadOuterDiameter], 136));
assert(approx(dimsFiveMetric[iOneidaDimensionBeadInnerDiameter], 124.84));
assert(approx(dimsFiveMetric[iOneidaDimensionNeckOuterDiameter], 123));
assert(approx(dimsFiveMetric[iOneidaDimensionNeckInnerDiameter], 118.2));

assert(approx(dimsSixInch[iOneidaDimensionNominal], 152.4));
assert(approx(dimsSixInch[iOneidaDimensionBeadOuterDiameter], 161.4));
assert(approx(dimsSixInch[iOneidaDimensionNeckOuterDiameter], 148.4));
assert(approx(dimsSixInch[iOneidaDimensionBeadOuterDiameter] - dimsSixInch[iOneidaDimensionNominal], 9));
assert(approx(dimsSixInch[iOneidaDimensionNeckOuterDiameter] - dimsSixInch[iOneidaDimensionNominal], -4));

dimsFiveFitPlus = oneidaQuickClampDimensions(nominalDiameter = 127, wallThickness = 2.4, fitAdjustment = 0.5);
dimsFiveFitMinus = oneidaQuickClampDimensions(nominalDiameter = 127, wallThickness = 2.4, fitAdjustment = -0.5);

assert(approx(dimsFiveFitPlus[iOneidaDimensionNominal], dimsFiveMetric[iOneidaDimensionNominal]));
assert(approx(dimsFiveFitPlus[iOneidaDimensionBeadOuterDiameter] - dimsFiveMetric[iOneidaDimensionBeadOuterDiameter], 0.5));
assert(approx(dimsFiveFitPlus[iOneidaDimensionBeadInnerDiameter] - dimsFiveMetric[iOneidaDimensionBeadInnerDiameter], 0.5));
assert(approx(dimsFiveFitPlus[iOneidaDimensionNeckOuterDiameter] - dimsFiveMetric[iOneidaDimensionNeckOuterDiameter], 0.5));
assert(approx(dimsFiveFitPlus[iOneidaDimensionNeckInnerDiameter] - dimsFiveMetric[iOneidaDimensionNeckInnerDiameter], 0.5));

assert(approx(dimsFiveFitMinus[iOneidaDimensionNominal], dimsFiveMetric[iOneidaDimensionNominal]));
assert(approx(dimsFiveMetric[iOneidaDimensionBeadOuterDiameter] - dimsFiveFitMinus[iOneidaDimensionBeadOuterDiameter], 0.5));
assert(approx(dimsFiveMetric[iOneidaDimensionBeadInnerDiameter] - dimsFiveFitMinus[iOneidaDimensionBeadInnerDiameter], 0.5));
assert(approx(dimsFiveMetric[iOneidaDimensionNeckOuterDiameter] - dimsFiveFitMinus[iOneidaDimensionNeckOuterDiameter], 0.5));
assert(approx(dimsFiveMetric[iOneidaDimensionNeckInnerDiameter] - dimsFiveFitMinus[iOneidaDimensionNeckInnerDiameter], 0.5));

minimumLengthWall24 = oneidaQuickClampMinimumLength(wallThickness = 2.4);
minimumLengthWall4 = oneidaQuickClampMinimumLength(wallThickness = 4);
assert(approx(minimumLengthWall24, 7.98));
assert(approx(minimumLengthWall4, 9.58));
assert(approx(minimumLengthWall24 - 2.4, 5.58));
assert(approx(minimumLengthWall4 - 4, 5.58));

cube([1,1,1]);
