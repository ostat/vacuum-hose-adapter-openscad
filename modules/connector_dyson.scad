include <constants.scad>
use <modules_utility.scad>
use <modules_pipe.scad>

/* [Hidden] */
dysonVersion = "1.2";
dysonMinLength = 46;
dysonMeasurement = "outer";
dysonOuterDiameter = 34.1;
dysonInnerDiameter = 28.5;
dysonWallThickenss = (dysonOuterDiameter - dysonInnerDiameter)/2;

dysonSettings = ["dyson", [
  [iSettingsLength, dysonMinLength],
  [iSettingsMeasurement, dysonMeasurement],
  [iSettingsDiameter, dysonOuterDiameter],
  [iSettingsWallThickness, dysonWallThickenss],
  [iSettingsTaper ,0],
  [iSettingsVersion, dysonVersion]
  ]];
  
//DysonConnector();

module DysonConnector(
  innerEndDiameter = dysonInnerDiameter,
  length = dysonMinLength,
  wallThickness = dysonWallThickenss,
  IncludeOrientationClip = true,
  $fn = 64
){
  heightStartShaft = 10;
  heightCutout= 4.45;
  heightCutoutTapper = 2.75;
  //heightMainShaft = 28;

  orientationClipHeight = 37-.5;

  orentationClipwallThickness = 2.5;
  orientationClipCenter = 5.5;
  orientationClipTaper = 2;
  orientationClipWidth = 3;
  orientationClipLength = orientationClipCenter + orientationClipTaper*2;
  heightMainShaft = orientationClipHeight - (heightStartShaft+heightCutout+heightCutoutTapper) + orientationClipLength;
  height = heightStartShaft+heightCutout+heightCutoutTapper+heightMainShaft;
  innerDiameter = 28.5;
  outerDiameter = dysonOuterDiameter;

  cutoutRadius = 30.7;// dysonInnerDiameter/2;
  innerRadius = innerDiameter/2;
  outerRadius = outerDiameter/2;
  
  union() {
    difference() {
      union() {
        difference() {
        //Main pipe
        Pipe (
          diameter1 = innerEndDiameter,
          diameter2 = innerEndDiameter,
          length = length,
          wallThickness1 = wallThickness,
          wallThickness2 = wallThickness); 
        
        //retaining ring
        Stopper(
            diameter = outerDiameter+fudgeFactor,
            outer = false,
            totalLength = heightCutout+heightCutoutTapper,
            taper1 = 0,
            taper2 = 0.38,
            wallThickness = 0,
            stopThickness = 1.5,
            zPosition = heightStartShaft);
        }
        
        // orientation clip
        if(IncludeOrientationClip == true){
          translate([0,0,orientationClipHeight]) 
          difference() {
            Stopper(
              diameter = outerDiameter,
              outer = true,
              totalLength = orientationClipLength,
              taper1 = 0.2,
              taper2 = 0.2,
              wallThickness = 0,
              stopThickness = orentationClipwallThickness);
            
            clipCount = 4;
            for(i=[0:1:clipCount-1])
            {
              rotate([0,0,i*360/clipCount])
              difference() {
                //Circle cutout for clip
                translate([0,-outerRadius+4,-23/2+6.5]) rotate([90,0,0])
                  union(){
                    baseclipheight = orentationClipwallThickness*1.7;
                  cylinder(r=23/2, h=baseclipheight);
                  translate([0,0,baseclipheight-fudgeFactor])
                  cylinder(r1=23/2, r2=25/2, h=orentationClipwallThickness);
                  }
                //Verticle clip lock
               translate([0,-outerRadius,orientationClipWidth/2]) rotate([90,0,0])
                 hull() {
                    cylinder(d1=orientationClipWidth, d2=orientationClipWidth-0.5, h=orentationClipwallThickness);
                  translate([0,orientationClipLength-orientationClipWidth,0])
                    cylinder(d1=orientationClipWidth, d2=orientationClipWidth-0.5, h=orentationClipwallThickness);
                }
              }
            }
          }
        }
      }

      //remove center
      translate([0,0,-fudgeFactor])
        cylinder(r=innerRadius, h=height+fudgeFactor*2);
    }
  }
}