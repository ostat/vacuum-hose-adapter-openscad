include <../modules/vacuum-hose-adapter.scad>

/* [Oneida to 4in Hose Adapter] */
Oneida_Nominal_Diameter_Inch = 5; // [3,4,5,6,7,8,9,10,11,12,14,16,18]
Fit_Adjustment_mm = 0;
Wall_Thickness_mm = 2.4;
Oneida_Length_mm = 20;
Hose_Length_mm = 35;
Transition_Length_mm = 25;

$fn = 160;

HoseAdapter(
  connector1 = OneidaConnectorSettings(
    connector = 1,
    diameter = [0, Oneida_Nominal_Diameter_Inch],
    length = [Oneida_Length_mm, 0],
    wallThickness = Wall_Thickness_mm,
    fitAdjustment = Fit_Adjustment_mm
  ),
  connector2 = UserConnectorSettings(
    connector = 2,
    style = "hose",
    measurement = "outer",
    diameter = [0, 4],
    length = [Hose_Length_mm, 0],
    wallThickness = Wall_Thickness_mm,
    taper = 0
  ),
  transitionLength = Transition_Length_mm
);
