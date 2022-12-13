// Hose connector examples
// version 2022-09-26

use <vacuum-hose-adapter-modules.scad>

fudgeFactor = 0.015;
//$fn=120;

$fs = 1;
$fa = 6;

part = "50to30"; //[50to30: 50mm hose to 30mm hose, 50to30bend45deg: 50mm hose to 30mm hose bent by 45deg, 50to30bend45degsweep: 50mm hose to 30mm hose bent by 45deg sweep ,50to100: 50mm hose to 100mm hose, 50to100bend90deg: 50mm hose to 100mm hose bent by 90deg, 50to100bend90degsweep: 50mm hose to 100mm hose bent by 90deg sweep, 50toflat: flat plate to 50mm hose, mag50to40: 50mm magnet to 40mm, mag50to100: 50mm magnet to 100mm, mag50toflat: 50mm magnet to flat plate with connector, mag50toflat120: 50mm magnet to flat plate, screwflange50: flange 50mm hose, 50ring: 50m magnet flange alignment ring, mag100to100: 100m magnet flange to 100mm hose, mag100to50: 100m magnet flange to 50mm hose, 100ring: 100m magnet flange alignment ring, mag50tomag100: 50mm magnet to 100mm magnet, funnel: funnel 80mm to 5 mm , funnelOffset: funnel offset 80mm to 5 mm]

module end_of_customizer_opts() {}

if (part == "mag50to40") {
    HoseAdapter(
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 15,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "tapered",
        transitionLength = 10,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 40,
        connector2Length = 40,
        connector2Taper = 2);
}
if (part == "mag50to100") {
    HoseAdapter(
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 15,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "tapered",
        transitionLength = 25,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 100,
        connector2Length = 50);
}
if (part == "mag50toflat120") {
    HoseAdapter(
        drawAlignmentRing = "no",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1wallThickness = 2, 
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 7,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "flat",
        transitionLength = 5,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 120);
}
if (part == "mag50toflat") {
    HoseAdapter(
        drawAlignmentRing = "no",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 7,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "flat",
        transitionLength = 5,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 30,
        connector2Length = 5);
}
if (part == "screwflange50") {
    HoseAdapter(
        connector1Style = "flange",
        connector1Measurement = "outer",
        connector1Diameter = 51,
        connector1Length = 10,
        connector1FlangeOuterDiameter = 80,
        connector1FlangeThickness = 5,
        connector1FlangeScrewCount = 4,
        connector1FlangeScrewDiameter = 5,
        connector1FlangeWidth = 30,
    
        transitionStyle = "tapered",
        transitionLength = 5,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 50,
        connector2Length = 20,
        connector2Taper = 1);
}
if (part == "50ring") {
    HoseAdapter(
        drawAlignmentRing = "end1",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetBorder = 3,
        connector1Ring = "recessed");
}
if (part == "50to30") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1StopThickness = 4,
        connector1StopLength = 8,
        transitionStyle = "tapered",
        transitionLength = 10,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 40,
        connector2Length = 40,
        connector2Taper = 2);
}
if (part == "50to30bend45deg") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1StopThickness = 4,
        connector1StopLength = 8,
        transitionStyle = "tapered",
        transitionLength = 10,
        transitionBendRadius = 10,
        transitionAngle = 45,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 40,
        connector2Length = 40,
        connector2Taper = 2);
}
if (part == "50to30bend45degsweep") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1StopThickness = 4,
        connector1StopLength = 8,
        transitionStyle = "sweep",
        transitionLength = 10,
        transitionBendRadius = 10,
        transitionAngle = 45,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 40,
        connector2Length = 40,
        connector2Taper = 2);
}
if (part == "50to100") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1Taper = 2,
        transitionStyle = "tapered",
        transitionLength = 50,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 100,
        connector2Length = 50,
        connector2Taper = 2,
        connector2StopThickness = 4,
        connector2StopLength = 8);
}
if (part == "50to100bend90deg") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1Taper = 2,
        transitionStyle = "tapered",
        transitionLength = 50,
        transitionBendRadius = 15,
        transitionAngle = 90,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 100,
        connector2Length = 50,
        connector2Taper = 2,
        connector2StopThickness = 4,
        connector2StopLength = 8);
}
if (part == "50to100bend90degsweep") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "outer",
        connector1Diameter = 50,
        connector1Length = 40,
        connector1Taper = 2,
        transitionStyle = "sweep",
        transitionLength = 50,
        transitionBendRadius = 15,
        transitionAngle = 90,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 100,
        connector2Length = 50,
        connector2Taper = 2,
        connector2StopThickness = 4,
        connector2StopLength = 8);
}
if (part == "50toflat") {
    HoseAdapter(
        connector1Style = "hose",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 45,
        connector1Ring = "recessed",
        transitionStyle = "flat",
        transitionLength = 6,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 100);
}
if (part == "mag100to100") {
    HoseAdapter(
        drawAlignmentRing = "no",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 100,
        connector1Length = 15,
        connector1MagnetCount = 12,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "tapered",
        transitionLength = 10,
        connector2Style = "hose",
        connector2Measurement = "inner",
        connector2Diameter = 100,
        connector2Length = 50,
        connector2Taper = 2,
        connector2Ring = "no");
}
if (part == "mag100to50") {
    HoseAdapter(
        drawAlignmentRing = "no",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 100,
        connector1Length = 15,
        connector1MagnetCount = 12,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "tapered",
        transitionLength = 50,
        connector2Style = "hose",
        connector2Measurement = "outer",
        connector2Diameter = 50,
        connector2Length = 50,
        connector2Taper = 2,
        connector2Ring = "no");
}
if (part == "100ring") {
    HoseAdapter(
        drawAlignmentRing = "end1",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 100,
        connector1MagnetCount = 12,
        connector1MagnetDiameter = 10.5,
        connector1MagnetBorder = 3,
        connector1Ring = "recessed");
}
if (part == "mag50tomag100") {
    HoseAdapter(
        drawAlignmentRing = "no",
        alignmentDepth = 2,
        alignmentUpperWidth = 3,
        alignmentLowerWidth = 0.5,
        alignmentSideClearance = 0.25,
        alignmentDepthClearance = 0.75,
        connector1Style = "mag",
        connector1Measurement = "inner",
        connector1Diameter = 50,
        connector1Length = 15,
        connector1MagnetCount = 8,
        connector1MagnetDiameter = 10.5,
        connector1MagnetThickness = 2.5,
        connector1MagnetBorder = 3,
        connector1MagnetFlangeThickness = 7,
        connector1Ring = "recessed",
        transitionStyle = "tapered",
        transitionLength = 10,
        connector2Style = "mag",
        connector2Measurement = "inner",
        connector2Diameter = 100,
        connector2Length = 15,
        connector2MagnetCount = 12,
        connector2MagnetDiameter = 10.5,
        connector2MagnetThickness = 2.5,
        connector2MagnetBorder = 3,
        connector2MagnetFlangeThickness = 7,
        connector2Ring = "recessed");
}
if (part == "funnel") {
    HoseAdapter(
        connector1Style = "flange",
        connector1Measurement = "inner",
        connector1Diameter = 80,
        connector1WallThickness = 1.5,
        connector1FlangeWidth = 7,
        connector1FlangeThickness = 1.5,
        connector1FlangeScrewPosition = 10,
        connector1FlangeScrewBorder = 5,
        connector1FlangeScrewCount = 1,
        connector1FlangeScrewDiameter = 5,
        connector1Length = 3,
        transitionStyle = "tapered",
        transitionLength = 40,
        connector2Style = "nozzle",
        connector2Measurement = "inner",
        connector2Diameter = 10,
        connector2Length = 15,
        connector2WallThickness = 1.5,
        connector2NozzleShape = "circle",
        connector2NozzleTipWallThickness = 0.6,
        connector2NozzleRadius = 5,
        connector2NozzleLength = 50,
        connector2NozzleChamferPercentage = 100,
        connector2NozzleChamferAngle = 30);
}
if (part == "funnelOffset") {
    HoseAdapter(
        connector1Style = "flange",
        connector1Measurement = "inner",
        connector1Diameter = 25,
        connector1WallThickness = 1.5,
        connector1FlangeWidth = 7,
        connector1FlangeThickness = 1.5,
        connector1FlangeScrewPosition = 10,
        connector1FlangeScrewBorder = 5,
        connector1FlangeScrewCount = 1,
        connector1FlangeScrewDiameter = 5,
        connector1Length = 3,
        transitionStyle = "tapered",
        transitionLength = 20,
        transitionXOffset = -10,
        transitionYOffset = 0,
  
        connector2Style = "nozzle",
        connector2Measurement = "inner",
        connector2Diameter = 5,
        connector2Length = 0.5,
        connector2WallThickness = 1.5,
        connector2NozzleShape = "circle",
        connector2NozzleTipWallThickness = 0.6,
        connector2NozzleRadius = 2.5,
        connector2NozzleLength = 15,
        connector2NozzleChamferPercentage = 100,
        connector2NozzleChamferAngle = 30);
}

if (part == "funnelOffset2") {
    HoseAdapter(
        connector1Style = "flange",
        connector1Measurement = "inner",
        connector1Diameter = 80,
        connector1WallThickness = 1.5,
        connector1FlangeWidth = 7,
        connector1FlangeThickness = 1.5,
        connector1FlangeScrewPosition = 10,
        connector1FlangeScrewBorder = 5,
        connector1FlangeScrewCount = 1,
        connector1FlangeScrewDiameter = 5,
        connector1Length = 3,
        transitionStyle = "tapered",
        transitionLength = 40,
        transitionXOffset = -30,
        transitionYOffset = 0,
  
        connector2Style = "nozzle",
        connector2Measurement = "inner",
        connector2Diameter = 10,
        connector2Length = 2,
        connector2WallThickness = 1.5,
        connector2NozzleShape = "circle",
        connector2NozzleTipWallThickness = 0.6,
        connector2NozzleRadius = 5,
        connector2NozzleLength = 50,
        connector2NozzleChamferPercentage = 100,
        connector2NozzleChamferAngle = 30);
}