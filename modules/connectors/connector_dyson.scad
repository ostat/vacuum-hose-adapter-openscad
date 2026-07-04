include <../constants.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>

connector_dyson_demo = false;

if(connector_dyson_demo && $preview){
  $fn = 64;
  spacer = dysonOuterDiameter * 1.5;

  render_options = [
    [dysonInnerDiameter, dysonMinLength, dysonWallThickenss, true],
    [dysonInnerDiameter, dysonMinLength + 8, dysonWallThickenss, false],
    [dysonInnerDiameter + 2, dysonMinLength, dysonWallThickenss + 0.5, true],
    [dysonInnerDiameter - 1, dysonMinLength + 12, dysonWallThickenss, false]
  ];

  for(iRender = [0:len(render_options)-1])
    translate([spacer * (iRender % 2), spacer * floor(iRender / 2), 0])
      DysonConnector(
        innerEndDiameter = render_options[iRender][0],
        length = render_options[iRender][1],
        wallThickness = render_options[iRender][2],
        IncludeOrientationClip = render_options[iRender][3]);
}

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
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, str("innerEndDiameter must be a number greater than 0. Provided:", innerEndDiameter));
  assert(is_num(length) && length > 0, str("length must be a number greater than 0. Provided:", length));
  assert(is_num(wallThickness) && wallThickness > 0, str("wallThickness must be a number greater than 0. Provided:", wallThickness));
  assert(is_bool(IncludeOrientationClip), str("IncludeOrientationClip must be a boolean. Provided:", IncludeOrientationClip));
  assert(is_num($fn) && $fn >= 3 && floor($fn) == $fn, str("$fn must be an integer greater than or equal to 3. Provided:", $fn));

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

  assert(is_num(dysonMinLength) && dysonMinLength > 0, str("dysonMinLength must be a number greater than 0. Provided:", dysonMinLength));
  assert(is_num(dysonInnerDiameter) && dysonInnerDiameter > 0, str("dysonInnerDiameter must be a number greater than 0. Provided:", dysonInnerDiameter));
  assert(is_num(dysonOuterDiameter) && dysonOuterDiameter > dysonInnerDiameter, str("dysonOuterDiameter must be greater than dysonInnerDiameter. outer=", dysonOuterDiameter, " inner=", dysonInnerDiameter));
  assert(is_num(dysonWallThickenss) && dysonWallThickenss > 0, str("dysonWallThickenss must be a number greater than 0. Provided:", dysonWallThickenss));
  assert(innerEndDiameter <= dysonOuterDiameter, str("innerEndDiameter must be less than or equal to dysonOuterDiameter. innerEndDiameter=", innerEndDiameter, " outerDiameter=", dysonOuterDiameter));
  assert(length >= dysonMinLength, str("length must be at least dysonMinLength. length=", length, " minLength=", dysonMinLength));
  assert(wallThickness <= innerEndDiameter/2, str("wallThickness must be less than or equal to half innerEndDiameter. wallThickness=", wallThickness, " innerEndDiameter=", innerEndDiameter));
  assert(heightStartShaft > 0 && heightCutout > 0 && heightCutoutTapper > 0 && orientationClipHeight > 0, "Dyson core dimensions must be positive");
  assert(heightMainShaft > 0 && height > 0, str("derived heights must be positive. heightMainShaft=", heightMainShaft, " height=", height));
  assert(orientationClipLength > orientationClipCenter, str("orientationClipLength must be greater than orientationClipCenter. length=", orientationClipLength, " center=", orientationClipCenter));
  assert(orentationClipwallThickness > 0, str("orentationClipwallThickness must be greater than 0. Provided:", orentationClipwallThickness));
  assert(orientationClipWidth > 0 && orientationClipLength > 0, str("orientation clip dimensions must be positive. width=", orientationClipWidth, " length=", orientationClipLength));

    union() {
      difference() {
        //Main pipe
        pipe(
          diameter1 = innerEndDiameter,
          diameter2 = innerEndDiameter,
          length = length,
          wallThickness1 = wallThickness,
          wallThickness2 = wallThickness,
          chamfer1 = [0.3,0.3]);

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
}