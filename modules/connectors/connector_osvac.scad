//osVAC
//Female documentation https://www.thingiverse.com/thing:4562762
//Male documentation https://www.thingiverse.com/thing:4562789
use <../thirdparty/ub.scad>
include <../constants.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>

/* [Hidden] */
clipCount = 3;

osvacmVersion = "0.1";
osvacmMinLength = 30;
osvacmMeasurement = "inner";
osvacmOuterDiameter = 37.8;
osvacmInnerDiameter = 32;
osvacmWallThickness = (osvacmOuterDiameter - osvacmInnerDiameter)/2;

osvacm32Settings = ["osvacm32", [
  [iSettingsLength, osvacmMinLength],
  [iSettingsMeasurement, osvacmMeasurement],
  [iSettingsDiameter, osvacmInnerDiameter],
  [iSettingsWallThickness, osvacmWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacmVersion]
  ]];
osvacmSettings = ["osvacm", [
  [iSettingsLength, osvacmMinLength],
  [iSettingsMeasurement, osvacmMeasurement],
  [iSettingsWallThickness, osvacmWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacmVersion]
  ]];

osvacfVersion = "0.1";
osvacfMinLength = 34.10;
osvacfMeasurement = "inner";
osvacfOuterDiameter = 47.265;
osvacfInnerDiameter = 32;
osvacfInnerWallDiameter = 38.2;
osvacfWallThickness = (osvacfOuterDiameter - osvacfInnerDiameter)/2;
osvacf32Settings = ["osvacf32", [
  [iSettingsLength, osvacfMinLength],
  [iSettingsMeasurement, osvacfMeasurement],
  [iSettingsDiameter, osvacfInnerDiameter],
  [iSettingsWallThickness, osvacfWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacfVersion]
  ]];
osvacfSettings = ["osvacf", [
  [iSettingsLength, osvacfMinLength],
  [iSettingsMeasurement, osvacfMeasurement],
  [iSettingsWallThickness, osvacfWallThickness],
  [iSettingsTaper ,0],
  [iSettingsVersion, osvacfVersion]
  ]];

//Test male connector
//osVacMaleConnector(innerDiameter = 50, help=true);

//Test female connector
//osVacFemaleConnector(innerDiameter = 50, help=true);

module osVacFemaleConnector(
  innerDiameter = osvacfInnerDiameter,
  length = osvacfMinLength,
  wallThickness = osvacfWallThickness,
  help,
  $fn = 64){
  innerTaperSize = (osvacfInnerWallDiameter-osvacfInnerDiameter)/2;
  innerWallDiameter = innerDiameter + innerTaperSize*2;
  outerDiameter = innerDiameter + wallThickness*2;
  finalShaftLength = 5;

  innerShaftLength = 30.5;
  cutoutz = 3.7;
  cutoutHeight = 6.35;
  cutoutDepthz = innerShaftLength - cutoutz;
  cutoutDepthx = 2;
  cutoutBumpDepthx = 1.6;
  cutoutRadius = innerWallDiameter/2+cutoutDepthx;
  cutoutWidth = 10.2;
  //The distence is base on a f32,
  //The spec defines it as the ARC Length for 35deg on an F32
  cutoutArcLength = 35/180*PI*(osvacfInnerWallDiameter/2+cutoutDepthx);
  cutoutArcAngle = (cutoutArcLength*180)/(PI*(innerWallDiameter/2+cutoutDepthx));
  echo();
  difference(){
    //Main outer body
    cylinder(length, d=outerDiameter);

    //Main inner body removal
    union(){
      hull(){
        translate([0,0,-fudgeFactor])
          cylinder(innerShaftLength, d=innerWallDiameter);
        translate([0,0,innerShaftLength])
          cylinder(innerTaperSize,
            d1=innerWallDiameter,
            d2=innerDiameter);
      }

      //Opening relief
      translate([0,0,-fudgeFactor])
        cylinder(
          cutoutDepthx/2,
          d1=innerWallDiameter+cutoutDepthx,
          d2=innerWallDiameter
         );


      finalShaftLength = length - innerShaftLength;
      translate([0,0,length-finalShaftLength+fudgeFactor])
        cylinder(finalShaftLength, d=innerDiameter);

     translate([0,0,-fudgeFactor])
     intersection(){
        cylinder(cutoutDepthz+fudgeFactor, r=cutoutRadius);
        for(i = [0:360/clipCount:360]){
          rotate([0,0,i])
          union(){
          translate([0,-cutoutWidth/2,-fudgeFactor])
            roundedCube(
              size=[cutoutRadius,cutoutWidth,cutoutDepthz],
              topRadius = 0,
              bottomRadius = 0,
              sideRadius = 2);

           rotate([0,0,cutoutArcAngle])
           translate([0,-cutoutWidth/2,cutoutDepthz-cutoutHeight-fudgeFactor])
            roundedCube(
              size=[cutoutRadius,cutoutWidth,cutoutHeight],
              topRadius = 0,
              bottomRadius = 0,
              sideRadius = 2);

            //it creates the bump to produce the lock
            rotate([0,0,cutoutArcAngle/4])
            translate([0,0,cutoutDepthz-cutoutHeight-fudgeFactor])
              intersection(){
                translate([0,0,-cutoutHeight])
                rotate_extrude(angle=cutoutArcAngle/2)
                  translate([cutoutRadius-(cutoutDepthx*2),0,0])
                  square([cutoutDepthx+cutoutBumpDepthx,cutoutHeight*2], center=false);

              translate([cutoutRadius,0,cutoutHeight-2])
              rotate([45,0,0])
                cube([10,cutoutHeight*2,cutoutHeight*2], center=true);
            }
          }
        }
      }
    }
  }

  HelpTxt("osVacFemaleConnector",[
    "innerDiameter", innerDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "innerTaperSize", innerTaperSize,
    "innerWallDiameter", innerWallDiameter,
    "outerDiameter", outerDiameter,
    "finalShaftLength", finalShaftLength,
    "innerShaftLength", innerShaftLength,
    "cutoutHeight", cutoutHeight,
    "cutoutz", cutoutz,
    "cutoutDepthz", cutoutDepthz,
    "cutoutDepthx", cutoutDepthx,
    "cutoutArcLength",cutoutArcLength,
    "cutoutArcAngle",cutoutArcAngle,
    "cutoutBumpDepthx", cutoutBumpDepthx,
    "cutoutRadius", cutoutRadius,
    "cutoutWidth", cutoutWidth,
    "osvacfWallThickness", osvacfWallThickness,
    "osvacfMinLength", osvacfMinLength,
    "osvacfInnerDiameter", osvacfInnerDiameter
    ],help);
}

module osVacMaleConnector(
  innerDiameter = osvacmInnerDiameter,
  length = osvacmMinLength,
  wallThickness = osvacmWallThickness,
  help,
  $fn = 64
){
  outerDiameter = innerDiameter+wallThickness*2;

  hoseEndTaper=0.7;
  clipHeight = 6.95;
  clipz = 3.2;
  clipr = 1;//not right
  clipThickness = 2;
  clipWidth = 9.8;
  clipTopTaperz = 5.8;
  clipTopTaperHeight = clipHeight - clipTopTaperz;

  union() {
    difference ()
    {
      //outer cylinder
      union(){
        cylinder(length, d=outerDiameter);

        translate([0,0,clipz])
        difference(){
          intersection(){
            roundedCylinder(
              clipHeight,
              r=outerDiameter/2+clipThickness,
              roundedr1=clipr,
              roundedr2=0);
            for(i = [0:360/clipCount:360]){
              rotate([0,0,i])
              translate([outerDiameter/2-clipThickness,-clipWidth/2,-fudgeFactor])
                hull(){
                  roundedCube(
                    size=[clipThickness,clipWidth,clipHeight],
                    topRadius = 0,
                    bottomRadius = 1,
                    sideRadius = 1);
                  roundedCube(
                    size=[clipThickness,clipWidth,clipHeight],
                    topRadius = 0,
                    bottomRadius = 1,
                    sideRadius = 2);
              }
            }
          }

          Pipe(
            diameter1 = outerDiameter+clipThickness*2+fudgeFactor,
            diameter2 = outerDiameter-fudgeFactor*2,
            length = clipTopTaperHeight,
            wallThickness1 = 0,
            wallThickness2 = clipThickness+fudgeFactor,
            zPosition = clipTopTaperz);
        }
      }

      //Inner cylinder to remove
      translate([0,0,0-fudgeFactor])
      cylinder(length+fudgeFactor*2, d=innerDiameter);

      Pipe(
        diameter1 = innerDiameter-fudgeFactor,
        diameter2 = innerDiameter-fudgeFactor,
        length = hoseEndTaper+fudgeFactor,
        wallThickness1 = hoseEndTaper,
        wallThickness2 = 0,
        zPosition = -fudgeFactor);
      Pipe(
        diameter1 = outerDiameter-hoseEndTaper*2,
        diameter2 = outerDiameter+hoseEndTaper*2,
        length = hoseEndTaper+hoseEndTaper,
        wallThickness1 = hoseEndTaper,
        wallThickness2 = 0,
        zPosition = -fudgeFactor);
    }
  }

  HelpTxt("osVacMaleConnector",[
    "innerDiameter", innerDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "outerDiameter", outerDiameter,
    "hoseEndTaper", hoseEndTaper,
    "clipz", clipz,
    "clipr", clipr,
    "clipThickness", clipThickness,
    "clipWidth", clipWidth,
    "clipTopTaperHeight", clipTopTaperHeight,
    "osvacmWallThickness", osvacmWallThickness,
    "osvacmMinLength", osvacmMinLength,
    "osvacmInnerDiameter", osvacmInnerDiameter
    ],help);
}



