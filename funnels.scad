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

/* [Funnel advanced] */
//Angle of the spout
SpoutAngle = 0;
//Where should the angle be applied
TransitionStyle = "taper+bend"; //[taper+bend: Taper then bend, bend+taper: Bend then taper]
//Offset the spout in the x direction
SpoutXOffset = 0;
//Offset the spout in the y direction
SpoutYOffset = 0;

/* [Spout] */
//Internal Diameter of the spout tip
SpoutTipDiameter = 5;
//Length of the spout tip. Default is related to funnel length.
SpoutTipLength = 0;
//Wall thickness of the spout tip
SpoutTipWallThickness = 0.6;

/* [Spout advanced] */
// Pre tip length of the spout.
SpoutLength = 1;
// Pre tip internal diameter of the spout.
SpoutDiameter= 0;

/* [Hidden] */
FlangeThickness = 1.5; // 0
ScrewBorder = 3;

//Detail
$fn=120;

module end_of_customizer_opts() {}

//Apply defaults
transitionLength = FunnelLength < 1 ? (OpeningDiameter-SpoutDiameter)/2 : FunnelLength;
spoutTipLength = SpoutTipLength < 1 ? transitionLength*1.5 : SpoutTipLength;
spoutLength = SpoutLength < 1 ? 1 : SpoutLength;
spoutDiameter = SpoutDiameter < 1 ? SpoutTipDiameter : SpoutDiameter;

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
      transitionXOffset = SpoutXOffset,
      transitionYOffset = SpoutYOffset,
      transitionAngle = SpoutAngle,
      //transitionBendRadius = transitionLength,
      connector2Style = "nozzle",
      connector2Measurement = "inner",
      connector2Diameter = spoutDiameter,
      connector2Length = spoutLength,
      connector2WallThickness = WallThickness,
      connector2NozzleShape = "circle",
      connector2NozzleTipWallThickness = SpoutTipWallThickness,
      connector2NozzleRadius = SpoutTipDiameter/2,
      connector2NozzleLength = spoutTipLength,
      connector2NozzleChamferPercentage = 100,
      connector2NozzleChamferAngle = 30);
