// funnel
// version 2026-02-27

use <modules/vacuum-hose-adapter.scad>

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
SpoutOffset = [0,0];

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
      connector1 = UserConnectorSettings(
        connector=1,
        style="flange",
        wallThickness=WallThickness,
        measurement="inner",
        diameter=OpeningDiameter,
        length=3,
        flangeWidth=7,
        flangeThickness=FlangeThickness,
        flangeScrewPosition=WallThickness * 2 + HangingHoleDiameter + ScrewBorder,
        flangeScrewBorder=ScrewBorder,
        flangeScrewCount=1,
        flangeScrewDiameter=HangingHoleDiameter),

      transitionStyle = TransitionStyle,
      transitionLength = transitionLength,
      transitionOffset = SpoutOffset,
      transitionAngle = SpoutAngle,

      connector2 = UserConnectorSettings(
        connector=2,
        style="nozzle",
        wallThickness=WallThickness,
        measurement="inner",
        diameter=spoutDiameter,
        length=spoutLength,
        nozzleShape = "circle",
        nozzleTipWallThickness = SpoutTipWallThickness,
        nozzleRadius = SpoutTipDiameter/2,
        nozzleSize= [0,0,spoutTipLength],
        nozzleChamferPercentage = 100,
        nozzleChamferAngle = 30)
  );
