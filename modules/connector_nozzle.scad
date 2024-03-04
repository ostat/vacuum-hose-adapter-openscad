fudgeFactor = 0.015;

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleSquareWidth,
  nozzleSquareDepth,
  nozzleTipWallThickness,
  nozzleRadius,
  nozzleLength,
  nozzlexOffset = 0,
  nozzleyOffset = 0,
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0
)
{
  innerRadius = innerStartDiameter/2;

  circlepositionx = nozzleShape == "square" ? nozzleSquareDepth/2 - nozzleRadius : 0;
  circlepositiony = nozzleShape == "square" ? nozzleSquareWidth/2 - nozzleRadius : 0;
  circlepositions = nozzleShape == "square" ?
    [[ circlepositionx, circlepositiony ],
    [ -circlepositionx, circlepositiony ],
    [ circlepositionx, -circlepositiony ],
    [ -circlepositionx, -circlepositiony ]] : [[ circlepositionx, circlepositiony ]] ;

  nozzleWidth = (nozzleShape == "square" ? nozzleSquareDepth : nozzleRadius * 2) + wallThickness*2;
  nozzleDepth = (nozzleShape == "square" ? nozzleSquareWidth : nozzleRadius * 2) + wallThickness*2;
  nozzleWidthChamfer = nozzleWidth * nozzleChamferPercentage /100;
  nozzleLengthChamfer = nozzleWidthChamfer * tan(nozzleChamferAngle);

  tipWallThickness = nozzleTipWallThickness == 0 ? wallThickness : nozzleTipWallThickness;

  widthChamfer = min(nozzleWidthChamfer, nozzleWidth);
  lengthChamfer = min(nozzleLengthChamfer, nozzleLength);

  echo("nozzle", innerRadius=innerRadius, circlepositionx=circlepositionx, circlepositiony=circlepositiony, nozzleWidth=nozzleWidth, nozzleDepth=nozzleDepth, nozzleWidthChamfer=nozzleWidthChamfer, nozzleLengthChamfer=nozzleLengthChamfer, widthChamfer=widthChamfer, lengthChamfer=lengthChamfer);

  difference()
  {
    //Outer Shape
    union()
    {
      // Nozzle base
      hull()
      {
        cylinder(fudgeFactor*2, r=innerRadius+wallThickness);
        translate([nozzleyOffset,nozzlexOffset,length + fudgeFactor])
        hull() for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=nozzleRadius+wallThickness+fudgeFactor);
      }

      // Nozzle
      translate([nozzleyOffset,nozzlexOffset,length + fudgeFactor])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
      {
        translate([circlepositions[i][0], circlepositions[i][1], 0])
          cylinder(fudgeFactor, r=nozzleRadius+wallThickness+fudgeFactor);
        translate([circlepositions[i][0], circlepositions[i][1], nozzleLength])
          cylinder(fudgeFactor, r=nozzleRadius+tipWallThickness+fudgeFactor);
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
        translate([nozzleyOffset,nozzlexOffset,length+fudgeFactor])
          hull() for (i= [ 0 : len(circlepositions) - 1 ])
            translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(fudgeFactor*2, r=nozzleRadius+fudgeFactor);
      }

      // Nozzle
      translate([nozzleyOffset,nozzlexOffset,length+fudgeFactor*2])
      hull() for (i= [ 0 : len(circlepositions) - 1 ])
        translate([circlepositions[i][0], circlepositions[i][1], 0])
        cylinder(nozzleLength+fudgeFactor*2, r=nozzleRadius+fudgeFactor);
    }

    // Chamfer
    if(widthChamfer > 0 && lengthChamfer > 0)
    {
      translate([0,0,nozzleLength+length+fudgeFactor*3] )
        rotate([90,0,180])
        linear_extrude(nozzleDepth+1, center=true)
          polygon( points = [[nozzleWidth/2-widthChamfer,0],
                              [nozzleWidth/2+fudgeFactor*2,0],
                              [nozzleWidth/2+fudgeFactor*2,-lengthChamfer]] );
    }
  }
}