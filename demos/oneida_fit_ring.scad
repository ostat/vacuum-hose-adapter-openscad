include <../modules/vacuum-hose-adapter.scad>

/* [Oneida Fit Ring] */
Oneida_Nominal_Diameter_Inch = 5; // [3,4,5,6,7,8,9,10,11,12,14,16,18]
Fit_Adjustment_mm = 0;
Wall_Thickness_mm = 2.4;
Ring_Length = 10;

$fn = 160;

translate([0, 0, Ring_Length])
mirror([0, 0, 1])
OneidaQuickClampConnector(
  nominalDiameter = Oneida_Nominal_Diameter_Inch * 25.4,
  length = Ring_Length,
  wallThickness = Wall_Thickness_mm,
  fitAdjustment = Fit_Adjustment_mm,
  $fn = $fn
);
