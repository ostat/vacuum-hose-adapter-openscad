include <constants.scad>

nozzleVersion = "1.0";

nozzleSettings = ["nozzle", [
  [iSettingsTaper, 0],
  [iSettingsVersion, nozzleVersion]
  ]];

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleSize = [0,0,0],
  nozzleTipWallThickness,
  nozzleRadius,
  nozzleOffset = [0,0],
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0,
  help
)
{
  assert(is_list(nozzleSize) && len(nozzleSize) == 3, "nozzleSize must be a list of length 2");

  assert(nozzleShape == "square" || nozzleShape == "circle", str("nozzleShape only supports square and circle. Provided:'", nozzleShape ,"'"));
  innerRadius = innerStartDiameter/2;
  _nozzleRadius = nozzleShape == "circle" && nozzleRadius == 0 ? nozzleSize.x/2
    : nozzleShape == "square" ? min(nozzleSize.x/2, nozzleSize.y/2, nozzleRadius)
    : nozzleRadius;
  circlepositionx = nozzleShape == "square" ? nozzleSize.x/2 - _nozzleRadius : 0;
  circlepositiony = nozzleShape == "square" ? nozzleSize.y/2 - _nozzleRadius : 0;
  circlepositions = nozzleShape == "square" ?
    [[ circlepositionx, circlepositiony ],
    [ -circlepositionx, circlepositiony ],
    [ circlepositionx, -circlepositiony ],
    [ -circlepositionx, -circlepositiony ]] : [[ circlepositionx, circlepositiony ]] ;

  nozzleWidth = (nozzleShape == "square" ? nozzleSize.x : _nozzleRadius * 2) + wallThickness*2;
  nozzleDepth = (nozzleShape == "square" ? nozzleSize.y : _nozzleRadius * 2) + wallThickness*2;
  nozzleWidthChamfer = nozzleWidth * nozzleChamferPercentage /100;
  nozzleLengthChamfer = nozzleWidthChamfer * tan(nozzleChamferAngle);

  tipWallThickness = nozzleTipWallThickness == 0 ? wallThickness : nozzleTipWallThickness;

  widthChamfer = min(nozzleWidthChamfer, nozzleWidth);
  lengthChamfer = min(nozzleLengthChamfer, nozzleSize.z);

  //todo, add correction to ensure that the thickness of the walls never reduce to less than wallthickenss1 and wallThickness2
  //using wallThickness/2 is a sloppy approximation, really need to use trig to would out the correct value
  leadin = max(fudgeFactor, wallThickness/2);
  startOuterLeadin = innerStartDiameter > max(nozzleSize.x,nozzleSize.y) ? leadin : fudgeFactor;
  startInnerLeadin = innerStartDiameter > max(nozzleSize.x,nozzleSize.y) ? fudgeFactor : leadin;
  endOuterLeadin = max(nozzleSize.x,nozzleSize.y) > innerStartDiameter ? leadin : fudgeFactor;
  endInnerLeadin = max(nozzleSize.x,nozzleSize.y) > innerStartDiameter ? fudgeFactor : leadin;

  difference()
  {
    //Outer Shape
    union()
    {
      // Nozzle base
      hull()
      {
        cylinder(startOuterLeadin, r=innerRadius+wallThickness);
        translate([nozzleOffset.y,nozzleOffset.x,length - endOuterLeadin+ fudgeFactor])
        hull() for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(endOuterLeadin, r=_nozzleRadius+wallThickness+fudgeFactor);
      }

      // Nozzle
      translate([nozzleOffset.y,nozzleOffset.x,length + fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
      {
        translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=_nozzleRadius+wallThickness+fudgeFactor);
        translate([circlepositions[i][0], circlepositions[i][1], nozzleSize.z])
          cylinder(fudgeFactor, r=_nozzleRadius+tipWallThickness+fudgeFactor);
      }
    }

    //Inner shape
    union()
    {
      // Nozzle base
      union(){
        translate([0,0,-fudgeFactor])
          cylinder(startInnerLeadin+fudgeFactor*2, r=innerRadius);

        translate([0,0,startInnerLeadin])
        hull()
        {
          cylinder(fudgeFactor, r=innerRadius);
          translate([nozzleOffset.y,nozzleOffset.x,length-startInnerLeadin-endInnerLeadin])
            hull() for (i= [ 0 : len(circlepositions) - 1 ])
              translate([circlepositions[i][0], circlepositions[i][1], 0])
              cylinder(fudgeFactor, r=_nozzleRadius+fudgeFactor);
        }
        translate([nozzleOffset.y,nozzleOffset.x,length-endInnerLeadin-fudgeFactor])
          hull() for (i= [ 0 : len(circlepositions) - 1 ])
            translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(endInnerLeadin+fudgeFactor*3, r=_nozzleRadius+fudgeFactor);

       }

      // Nozzle
      translate([nozzleOffset.y,nozzleOffset.x,length+fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
        translate([circlepositions[i][0], circlepositions[i][1], 0])
        cylinder(nozzleSize.z+fudgeFactor*2, r=_nozzleRadius+fudgeFactor);
    }

    // Chamfer
    if(widthChamfer > 0 && lengthChamfer > 0)
    {
      translate([nozzleOffset.y,nozzleOffset.x,nozzleSize.z+length+fudgeFactor*3] )
      rotate([90,0,180])
        linear_extrude(nozzleDepth+1, center=true)
          polygon( points = [[nozzleWidth/2-widthChamfer,0],
                              [nozzleWidth/2+fudgeFactor*2,0],
                              [nozzleWidth/2+fudgeFactor*2,-lengthChamfer]] );
    }
  }

  HelpTxt("Nozzle",[
    "innerStartDiameter", innerStartDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "nozzleShape", nozzleShape,
    "nozzleSize", nozzleSize,
    "nozzleTipWallThickness", nozzleTipWallThickness,
    "nozzleRadius", nozzleRadius,
    "nozzleOffset", nozzleOffset,
    "nozzleChamferPercentage", nozzleChamferPercentage,
    "nozzleChamferAngle", nozzleChamferAngle,
    "_nozzleWidth", nozzleWidth,
    "_nozzleDepth", nozzleDepth,
    "_nozzleWidthChamfer", nozzleWidthChamfer,
    "_nozzleLengthChamfer", nozzleLengthChamfer,
    "_nozzleRadius", _nozzleRadius,
    "_circlepositions", circlepositions,
    ],help);
}