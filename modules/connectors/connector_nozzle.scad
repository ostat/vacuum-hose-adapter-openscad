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
        nozzleBaseSize = [10,10],
        nozzleLength = 2,
        nozzleTipWallThickness = 1,
        nozzleRadius = 2);

      translate([0,0,20])
      Nozzle(
        innerStartDiameter = 10,
        length = 10,
        wallThickness = 2,
        nozzleShape = "square",
        nozzleBaseSize = [100,10],
        nozzleLength = 2,
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
        nozzleBaseSize = [render_options[iRender][1].x, render_options[iRender][1].y],
        nozzleLength = render_options[iRender][1].z,
        nozzleTipWallThickness = render_options[iRender][2],
        nozzleRadius = render_options[iRender][3].x,
        nozzleOffset = render_options[iRender][3],
        nozzleChamferPercentage = render_options[iRender][4],
        nozzleChamferAngle = render_options[iRender][5],
        help = true);
}

function nozzleCirclePositions(nozzleShape, size, radius) = let(
  x = size.x/2 - radius,
  y = size.y/2 - radius)
  nozzleShape == "square" ? [[x, y], [-x, y], [x, -y], [-x, -y]] : [[0, 0]];

nozzleSettings = ["nozzle", [
  [iSettingsTaper, 0],
  [iSettingsVersion, nozzleVersion]
  ]];

module Nozzle(
  innerStartDiameter,
  length,
  wallThickness,
  nozzleShape,
  nozzleMeasurement = "inner",
  nozzleBaseSize = [0,0],
  nozzleTipSize = [0,0],
  nozzleLength = 0,
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
  assert(nozzleMeasurement == "inner" || nozzleMeasurement == "outer", str("nozzleMeasurement must be inner or outer. Provided:'", nozzleMeasurement ,"'"));
  assert(is_list(nozzleBaseSize) && len(nozzleBaseSize) == 2, str("nozzleBaseSize must be a list of length 2. Provided:", nozzleBaseSize));
  assert(is_list(nozzleTipSize) && len(nozzleTipSize) == 2, str("nozzleTipSize must be a list of length 2. Provided:", nozzleTipSize));
  assert(is_num(nozzleLength) && nozzleLength >= 0, str("nozzleLength must be a number greater than or equal to 0. Provided:", nozzleLength));
  assert(is_num(nozzleTipWallThickness) && nozzleTipWallThickness >= 0, str("nozzleTipWallThickness must be a number greater than or equal to 0. Provided:", nozzleTipWallThickness));
  assert(is_num(nozzleRadius) && nozzleRadius >= 0, str("nozzleRadius must be a number greater than or equal to 0. Provided:", nozzleRadius));
  assert(is_list(nozzleOffset) && len(nozzleOffset) == 2, str("nozzleOffset must be a list of length 2. Provided:", nozzleOffset));
  assert(is_num(nozzleOffset.x) && is_num(nozzleOffset.y), str("nozzleOffset values must be numeric. Provided:", nozzleOffset));
  assert(is_num(nozzleChamferPercentage) && nozzleChamferPercentage >= 0 && nozzleChamferPercentage <= 100,
    str("nozzleChamferPercentage must be between 0 and 100. Provided:", nozzleChamferPercentage));
  assert(is_num(nozzleChamferAngle) && nozzleChamferAngle >= 0 && nozzleChamferAngle <= 90,
    str("nozzleChamferAngle must be between 0 and 90 degrees. Provided:", nozzleChamferAngle));

  innerRadius = innerStartDiameter/2;
  tipWallThickness = nozzleTipWallThickness == 0 ? wallThickness : nozzleTipWallThickness;

  //For a circle x is the diameter, the radius is only used when x is not set
  baseDiameter = nozzleBaseSize.x > 0 ? nozzleBaseSize.x : nozzleRadius*2;
  tipDiameter = nozzleTipSize.x > 0 ? nozzleTipSize.x : baseDiameter;
  measuredBaseSize = nozzleShape == "square" ? nozzleBaseSize : [baseDiameter, baseDiameter];
  //A tip size of 0 keeps the base size, so there is no taper on that axis
  measuredTipSize = nozzleShape == "square"
    ? [nozzleTipSize.x > 0 ? nozzleTipSize.x : nozzleBaseSize.x, nozzleTipSize.y > 0 ? nozzleTipSize.y : nozzleBaseSize.y]
    : [tipDiameter, tipDiameter];

  //The geometry is built from the opening, so outer measurements have the wall removed
  baseWallAllowance = nozzleMeasurement == "outer" ? wallThickness : 0;
  tipWallAllowance = nozzleMeasurement == "outer" ? tipWallThickness : 0;
  _nozzleBaseSize = [measuredBaseSize.x - baseWallAllowance*2, measuredBaseSize.y - baseWallAllowance*2];
  _nozzleTipSize = [measuredTipSize.x - tipWallAllowance*2, measuredTipSize.y - tipWallAllowance*2];
  assert(nozzleMeasurement == "inner" || (_nozzleBaseSize.x > 0 && _nozzleBaseSize.y > 0 && _nozzleTipSize.x > 0 && _nozzleTipSize.y > 0),
    str("nozzle outer size must be larger than twice the wall thickness. Base opening:", _nozzleBaseSize, " Tip opening:", _nozzleTipSize));

  _nozzleRadius = nozzleShape == "square" ? min(_nozzleBaseSize.x/2, _nozzleBaseSize.y/2, max(nozzleRadius - baseWallAllowance, 0))
    : _nozzleBaseSize.x/2;
  circlepositions = nozzleCirclePositions(nozzleShape, _nozzleBaseSize, _nozzleRadius);

  _nozzleTipRadius = nozzleShape == "square" ? min(_nozzleTipSize.x/2, _nozzleTipSize.y/2, max(nozzleRadius - tipWallAllowance, 0))
    : _nozzleTipSize.x/2;
  tipCirclePositions = nozzleCirclePositions(nozzleShape, _nozzleTipSize, _nozzleTipRadius);

  nozzleBaseWidth = _nozzleBaseSize.x + wallThickness*2;
  nozzleBaseDepth = _nozzleBaseSize.y + wallThickness*2;
  nozzleWidth = _nozzleTipSize.x + wallThickness*2;
  nozzleDepth = max(nozzleBaseDepth, _nozzleTipSize.y + wallThickness*2);
  nozzleWidthChamfer = nozzleWidth * nozzleChamferPercentage /100;
  nozzleLengthChamfer = nozzleWidthChamfer * tan(nozzleChamferAngle);

  widthChamfer = min(nozzleWidthChamfer, nozzleWidth);
  lengthChamfer = min(nozzleLengthChamfer, nozzleLength);
  //The chamfer is sized from the tip, extend it so it also clears a nozzle that is wider below the tip
  chamferOverhang = max(nozzleBaseWidth - nozzleWidth, 0)/2;

  //todo, add correction to ensure that the thickness of the walls never reduce to less than wallthickenss1 and wallThickness2
  //using wallThickness/2 is a sloppy approximation, really need to use trig to would out the correct value
  leadin = max(fudgeFactor, wallThickness/2);
  nozzleBaseMaxSize = max(_nozzleBaseSize.x,_nozzleBaseSize.y);
  startOuterLeadin = innerStartDiameter < nozzleBaseMaxSize ? leadin : fudgeFactor;
  startInnerLeadin = innerStartDiameter > nozzleBaseMaxSize ? fudgeFactor : leadin;
  endOuterLeadin = nozzleBaseMaxSize > innerStartDiameter ? leadin : fudgeFactor;
  endInnerLeadin = nozzleBaseMaxSize > innerStartDiameter ? fudgeFactor : leadin;

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
      hull()
      {
        for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(fudgeFactor, r=_nozzleRadius+wallThickness+fudgeFactor);
        for (i= [ 0 : len(tipCirclePositions) - 1 ])
          translate([tipCirclePositions[i][0], tipCirclePositions[i][1], nozzleLength])
            cylinder(fudgeFactor, r=_nozzleTipRadius+tipWallThickness+fudgeFactor);
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
      hull()
      {
        for (i= [ 0 : len(circlepositions) - 1 ])
          translate([circlepositions[i][0], circlepositions[i][1], 0])
            cylinder(fudgeFactor, r=_nozzleRadius+fudgeFactor);
        for (i= [ 0 : len(tipCirclePositions) - 1 ])
          translate([tipCirclePositions[i][0], tipCirclePositions[i][1], nozzleLength+fudgeFactor])
            cylinder(fudgeFactor, r=_nozzleTipRadius+fudgeFactor);
      }
    }

    // Chamfer
    if(widthChamfer > 0 && lengthChamfer > 0)
    {
      translate([nozzleOffset.y,nozzleOffset.x,nozzleLength+length+fudgeFactor*3] )
      rotate([90,0,180])
        linear_extrude(nozzleDepth+1, center=true)
          polygon( points = [[nozzleWidth/2-widthChamfer,0],
                              [nozzleWidth/2+chamferOverhang+fudgeFactor*2,0],
                              [nozzleWidth/2+chamferOverhang+fudgeFactor*2,-lengthChamfer*(widthChamfer+chamferOverhang)/widthChamfer]] );
    }
  }

  HelpTxt("Nozzle",[
    "innerStartDiameter", innerStartDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "nozzleShape", nozzleShape,
    "nozzleMeasurement", nozzleMeasurement,
    "nozzleBaseSize", nozzleBaseSize,
    "nozzleTipSize", nozzleTipSize,
    "nozzleLength", nozzleLength,
    "nozzleTipWallThickness", nozzleTipWallThickness,
    "nozzleRadius", nozzleRadius,
    "nozzleOffset", nozzleOffset,
    "nozzleChamferPercentage", nozzleChamferPercentage,
    "nozzleChamferAngle", nozzleChamferAngle,
    "_nozzleWidth", nozzleWidth,
    "_nozzleDepth", nozzleDepth,
    "_nozzleWidthChamfer", nozzleWidthChamfer,
    "_nozzleLengthChamfer", nozzleLengthChamfer,
    "_nozzleBaseSize", _nozzleBaseSize,
    "_nozzleTipSize", _nozzleTipSize,
    "_nozzleRadius", _nozzleRadius,
    "_nozzleTipRadius", _nozzleTipRadius,
    "_circlepositions", circlepositions,
    "_tipCirclePositions", tipCirclePositions,
    ],help);
}