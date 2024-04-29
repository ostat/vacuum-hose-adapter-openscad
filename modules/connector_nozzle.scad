fudgeFactor = 0.015;

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleSize,
  nozzleTipWallThickness,
  nozzleRadius,
  nozzleOffset = [0,0],
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0,
  help
)
{
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

  difference()
  {
    //Outer Shape
    union()
    {
      // Nozzle base
      hull()
      {
        cylinder(fudgeFactor*2, r=innerRadius+wallThickness);
        translate([nozzleOffset.y,nozzleOffset.x,length + fudgeFactor])
        hull() for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=_nozzleRadius+wallThickness+fudgeFactor);
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
      hull()
      {
        translate([00,0,-fudgeFactor])
          cylinder(fudgeFactor*2, r=innerRadius);
        translate([nozzleOffset.y,nozzleOffset.x,length+fudgeFactor])
          hull() for (i= [ 0 : len(circlepositions) - 1 ])
            translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(fudgeFactor*2, r=_nozzleRadius+fudgeFactor);
      }

      // Nozzle
      translate([nozzleOffset.y,nozzleOffset.x,length+fudgeFactor*2])
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