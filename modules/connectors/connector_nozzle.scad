include <../constants.scad>

nozzleVersion = "1.0";

connector_nozzle_demo = false;

if(connector_nozzle_demo && $preview){

  translate([0,-100,0])
  difference(){
    union(){
      Nozzle(
        innerStartDiameter = 100,
        length = 10,
        wallThickness = 2,
        nozzleShape = "square",
        nozzleSize = [10,10,2],
        nozzleTipWallThickness = 1,
        nozzleRadius = 2);

      translate([0,0,20])
      Nozzle(
        innerStartDiameter = 10,
        length = 10,
        wallThickness = 2,
        nozzleShape = "square",
        nozzleSize = [100,10,2],
        nozzleTipWallThickness = 1,
        nozzleRadius = 2);
    }

    translate([-100,0,-10])
    cube([200,100,100]);
  }

  $fn = 64;
  diameter = 50;
  spacer = diameter * 2;

  render_options = [
    ["square", [40, 20, 20], 2, [0, 0], 0, 0],
    ["square", [60, 35, 30], 1.2, [8, 4], 80, 25],
    ["circle", [20, 20, 30], 1.2, [0, 0], 0, 0],
    ["circle", [30, 30, 45], 2, [5, 0], 60, 20],
    ["square", [80, 24, 18], 1.5, [0, 6], 40, 15],
    ["square", [25, 60, 35], 2, [6, 0], 55, 30],
    ["circle", [40, 40, 60], 0.8, [10, 2], 70, 35],
    ["circle", [55, 55, 25], 2.5, [8, 4], 20, 10]
  ];

  for(iRender = [0:len(render_options)-1])
    translate([spacer * (iRender % 2), spacer * floor(iRender / 2), 0])
      Nozzle(
        innerStartDiameter = diameter,
        length = 20,
        wallThickness = 2,
        nozzleShape = render_options[iRender][0],
        nozzleSize = render_options[iRender][1],
        nozzleTipWallThickness = render_options[iRender][2],
        nozzleRadius = render_options[iRender][3].x,
        nozzleOffset = render_options[iRender][3],
        nozzleChamferPercentage = render_options[iRender][4],
        nozzleChamferAngle = render_options[iRender][5],
        help = true);
}

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
  assert(is_num(innerStartDiameter) && innerStartDiameter > 0, str("innerStartDiameter must be a number greater than 0. Provided:", innerStartDiameter));
  assert(is_num(length) && length > 0, str("length must be a number greater than 0. Provided:", length));
  assert(is_num(wallThickness) && wallThickness > 0, str("wallThickness must be a number greater than 0. Provided:", wallThickness));
  assert(is_string(nozzleShape) && (nozzleShape == "square" || nozzleShape == "circle"), str("nozzleShape only supports square and circle. Provided:'", nozzleShape ,"'"));
  assert(is_list(nozzleSize) && len(nozzleSize) == 3, str("nozzleSize must be a list of length 3. Provided:", nozzleSize));
  //assert(is_num(nozzleSize.x) && is_num(nozzleSize.y) && is_num(nozzleSize.z) && nozzleSize.x > 0 && nozzleSize.y > 0 && nozzleSize.z >= 0, str("nozzleSize values must be numeric and nozzleSize.x/nozzleSize.y must be greater than 0. Provided:", nozzleSize));
  assert(is_num(nozzleTipWallThickness) && nozzleTipWallThickness >= 0, str("nozzleTipWallThickness must be a number greater than or equal to 0. Provided:", nozzleTipWallThickness));
  assert(is_num(nozzleRadius) && nozzleRadius >= 0, str("nozzleRadius must be a number greater than or equal to 0. Provided:", nozzleRadius));
  assert(is_list(nozzleOffset) && len(nozzleOffset) == 2, str("nozzleOffset must be a list of length 2. Provided:", nozzleOffset));
  assert(is_num(nozzleOffset.x) && is_num(nozzleOffset.y), str("nozzleOffset values must be numeric. Provided:", nozzleOffset));
  assert(is_num(nozzleChamferPercentage) && nozzleChamferPercentage >= 0 && nozzleChamferPercentage <= 100,
    str("nozzleChamferPercentage must be between 0 and 100. Provided:", nozzleChamferPercentage));
  assert(is_num(nozzleChamferAngle) && nozzleChamferAngle >= 0 && nozzleChamferAngle <= 90,
    str("nozzleChamferAngle must be between 0 and 90 degrees. Provided:", nozzleChamferAngle));

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