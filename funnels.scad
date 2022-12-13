// Hose connector examples
// version 2022-09-26

use <vacuum-hose-adapter-modules.scad>
/* [Funnel] */
//funnel opening diameter
OpeningDiameter = 20; //0.01

//Size of the hole for hanging
HangingHoleDiameter = 5;
//Length of the main funnel section. Default is the difference of opening and tip, to five 45deg walls.
FunnelLength = 0;
//Thickness of the funnel walls
WallThickness = 1.5; // 0.1

/* [Funnel adavanced] */
//Angle of the nozel
NozelAngle = 0;
//Where should the angle be applied
TransitionStyle = "taper+bend"; //[taper+bend: Taper then bend, bend+taper: Bend then taper]
//Offset the nozel in the x direction
TransitionXOffset = 0;
//Offset the nozel in the y direction
TransitionYOffset = 0;

/* [Nozel] */
//Internal Diameter of the nozel tip
NozelTipDiameter = 5;
//Length of the nozel tip. Default is related to funnel length.
NozelTipLength = 0;
//Wall thickness of the nozel tip
NozzleTipWallThickness = 0.6;

/* [Nozel adavanced] */
// Pre tip length of the nozel.
NozelLength = 1;
// Pre tip internal diameter of the nozel. 
NozelDiameter= 0;

/* [Hidden] */
FlangeThickness = 1.5; // 0
ScrewBorder = 3;

module end_of_customizer_opts() {}

//Apply defaults
transitionLength = FunnelLength < 1 ? (OpeningDiameter-NozelDiameter)/2 : FunnelLength;
nozelTipLength = NozelTipLength < 1 ? transitionLength*1.5 : NozelTipLength;
nozelLength = NozelLength < 1 ? 1 : NozelLength;
nozelDiameter = NozelDiameter < 1 ? NozelTipDiameter : NozelDiameter;

  HoseAdapter(
      connector1Style = "flange",
      connector1Measurement = "inner",
      connector1Diameter = OpeningDiameter,
      connector1WallThickness = WallThickness,
      connector1FlangeWidth = 7,
      connector1FlangeThickness = FlangeThickness,
      connector1FlangeScrewPosition = WallThickness * 2 + HangingHoleDiameter + ScrewBorder,
      connector1FlangeScrewBorder = ScrewBorder,
      connector1FlangeScrewCount = 1,
      connector1FlangeScrewDiameter = HangingHoleDiameter,
      connector1Length = 3,
      transitionStyle = TransitionStyle,
      transitionLength = transitionLength,
      transitionXOffset = TransitionXOffset,
      transitionYOffset = TransitionYOffset,
      transitionAngle = NozelAngle,
      //transitionBendRadius = transitionLength,
      connector2Style = "nozzle",
      connector2Measurement = "inner",
      connector2Diameter = nozelDiameter,
      connector2Length = nozelLength,
      connector2WallThickness = WallThickness,
      connector2NozzleShape = "circle",
      connector2NozzleTipWallThickness = NozzleTipWallThickness,
      connector2NozzleRadius = NozelTipDiameter/2,
      connector2NozzleLength = nozelTipLength,
      connector2NozzleChamferPercentage = 100,
      connector2NozzleChamferAngle = 30);