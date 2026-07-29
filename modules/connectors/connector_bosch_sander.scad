// Bosch random orbital sander (e.g. ROS20VS) dust extraction port.
// The sander's outlet rim has 8 bumps; this connector fits over it and
// twist-locks via 8 bayonet grooves cut into the inner wall.
//
// Adapted from "Bosch ROS20VS sander+vacuum adapter (OpenSCAD)" by tjsoco
// Source:  https://www.printables.com/model/794035-bosch-ros20vs-sandervacuum-adapter-openscad
// Original license: Creative Commons Attribution (CC-BY 4.0) - https://creativecommons.org/licenses/by/4.0/
// The bayonet locking-groove geometry is derived from that work.

include <../constants.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>
include <connector_hose.scad>

boschSanderVersion = "1.0";
boschSanderMeasurement = "inner";     // the diameter is the bore that slips over the sander outlet
boschSanderInnerDiameter = 28;        // inside dimension of the sander end (fixed by the tool)
boschSanderWallThickness = 3.5;       // wall thickness (locked to the tool via the settings below)
boschSanderDefaultLength = 28;
boschSanderMinLength = 20;            // must clear the bayonet groove (entrance + lock pocket + margin)
boschSanderGrooveCount = 8;           // the sander rim has 8 bumps

// Bayonet channel geometry, measured axially from the insertion opening (z = 0).
boschSanderGrooveWidth = 2.7;         // width/diameter of the machined channel
boschSanderEntranceDepth = 15;        // how far a bump travels straight in before the twist
boschSanderTwistAngle = 20;           // rotation from the entrance channel to the locking pocket
boschSanderLockDepth = 2;             // how far the locking pocket rises back toward the opening

// Clearance pocket at the mouth so the connector can seat past the machine's rubber ring
// (the ring nests in this pocket) far enough for the bumps to reach the bayonet.
boschSanderRingClearanceDiameter = 30.6;  // outer diameter of the machine's rubber ring
boschSanderRingClearanceDepth = 5;        // how deep the pocket is bored into the mouth
boschSanderRingClearanceChamfer = 1;      // 45 lead-in so it slides easily over the rubber

// Bore (measurement + diameter), wall thickness and taper are locked to the tool so the part
// fits and the transition blends flush -- registered values override the matching Customizer
// fields, the same as the other tool connectors (Dyson, Makita, ...). Wall defaults to
// boschSanderWallThickness (outer = boschSanderInnerDiameter + 2 * wall).
// Length is left unregistered, so End_Length passes through from the Customizer and can be
// grown from boschSanderMinLength upward (checked in the module below).
boschSanderSettings = ["bosch_sander", [
  [iSettingsMeasurement, boschSanderMeasurement],
  [iSettingsDiameter, boschSanderInnerDiameter],
  [iSettingsWallThickness, boschSanderWallThickness],
  [iSettingsTaper, 0],
  [iSettingsVersion, boschSanderVersion]
  ]];

connector_bosch_sander_demo = false;

if(connector_bosch_sander_demo){
  BoschSanderConnector(help = true, $fn = 128);
}

// A single bayonet groove pattern (subtracted from the tube wall).
// boreRadius places the channel on the inner wall; the opening is at z = 0.
module boschSanderLockingGroove(boreRadius){
  gw = boschSanderGrooveWidth;
  // Flared lead-in at the mouth so the bump finds the channel.
  translate([boreRadius,0,0])
    hull(){
      sphere(d=gw+0.5);
      translate([0,0,2]) sphere(d=gw+0.5);
    }
  // Straight entrance channel running in from the mouth to the twist.
  translate([boreRadius,0,0])
    hull(){
      sphere(d=gw);
      translate([0,0,boschSanderEntranceDepth]) sphere(d=gw);
    }
  // Lateral channel: the twist that carries the bump sideways.
  translate([0,0,boschSanderEntranceDepth])
    rotate_extrude(angle=boschSanderTwistAngle)
      translate([boreRadius,0,0]) circle(d=gw);
  // Locking pocket: rises back toward the mouth so the bump is retained.
  rotate([0,0,boschSanderTwistAngle])
    translate([boreRadius,0,boschSanderEntranceDepth-boschSanderLockDepth])
      hull(){
        sphere(d=gw);
        translate([0,0,boschSanderLockDepth]) sphere(d=gw);
      }
}

module BoschSanderConnector(
  innerEndDiameter = boschSanderInnerDiameter,
  length = boschSanderDefaultLength,
  wallThickness = boschSanderWallThickness,
  help = false,
  $fn = 64
){
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, str("innerEndDiameter must be a number greater than 0. Provided:", innerEndDiameter));
  assert(is_num(length) && length > 0, str("length must be a number greater than 0. Provided:", length));
  assert(is_num(wallThickness) && wallThickness > 0, str("wallThickness must be a number greater than 0. Provided:", wallThickness));
  assert(is_bool(help), str("help must be a boolean. Provided:", help));
  // Length may be grown from its minimum; below it the bayonet groove would not fit.
  assert(length >= boschSanderMinLength, str("length must be at least boschSanderMinLength (", boschSanderMinLength, ") to clear the bayonet groove. Provided:", length));

  boreRadius = innerEndDiameter/2;
  assert(boreRadius > boschSanderGrooveWidth, str("innerEndDiameter is too small for the locking groove. Provided:", innerEndDiameter));
  outerDiameter = innerEndDiameter + wallThickness*2;
  assert(boschSanderRingClearanceDiameter + boschSanderRingClearanceChamfer*2 <= outerDiameter, str("ring clearance (plus chamfer) must fit within the outer diameter (", outerDiameter, "). Provided:", boschSanderRingClearanceDiameter));
  assert(boschSanderRingClearanceDepth < length, str("ring clearance depth must be less than the connector length (", length, "). Provided:", boschSanderRingClearanceDepth));

  echo("BoschSanderConnector", innerEndDiameter=innerEndDiameter, length=length, wallThickness=wallThickness, grooveCount=boschSanderGrooveCount);

  difference(){
  
    union(){
      pipe(
        diameter = boschSanderRingClearanceDiameter,
        length = length,
        wallThickness = wallThickness-(boschSanderRingClearanceDiameter-innerEndDiameter)/2,
        chamfer1 = [boschSanderRingClearanceChamfer,0],
        chamfer2 = [0,0]);
      
      translate([0,0,boschSanderRingClearanceDepth + fudgeFactor])
      pipe(
        diameter = innerEndDiameter,
        length = length-boschSanderRingClearanceDepth + fudgeFactor,
        wallThickness = wallThickness,
        chamfer1 = [(boschSanderRingClearanceDiameter - innerEndDiameter)/2 + fudgeFactor,0],
        chamfer2 = [0,0]);
    }

    for(i = [0:boschSanderGrooveCount-1])
      rotate([0,0,i*360/boschSanderGrooveCount])
        boschSanderLockingGroove(boreRadius);
  }

  HelpTxt("BoschSanderConnector",[
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "grooveCount", boschSanderGrooveCount,
    "entranceDepth", boschSanderEntranceDepth,
    "twistAngle", boschSanderTwistAngle,
    "lockDepth", boschSanderLockDepth
    ],help);
}
