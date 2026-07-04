include <../constants.scad>
use <../modules_pipe.scad>
use <../thirdparty/ub.scad>

connector_flange_demo = false;

if(connector_flange_demo && $preview){
  $fn = 64;
  spacer = 100;

  render_options = [
    [40, 32, 40, 2, 6, 8, 20, 2, 4, 5],
    [40, 32, 45, 2.5, 8, 10, 18, 1.5, 4, 6],
    [50, 36, 48, 3, 10, 12, 24, 2, 5, 6],
    [50, 42, 55, 3, 12, 14, 30, 3, 6, 8]
  ];

  for(iRender = [0:len(render_options)-1])
    translate([spacer * (iRender % 2), spacer * floor(iRender / 2), 0])
      FlangeConnector(
        innerStartDiameter = render_options[iRender][0],
        innerEndDiameter = render_options[iRender][1],
        length = render_options[iRender][2],
        wallThickness = render_options[iRender][3],
        flangeThickness = render_options[iRender][4],
        flangeWidth = render_options[iRender][5],
        screwPosition = render_options[iRender][6],
        screwBorder = render_options[iRender][7],
        screwCount = render_options[iRender][8],
        screwDiameter = render_options[iRender][9],
        help = true);
}

module FlangeConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    flangeThickness,
    flangeWidth,
    screwPosition,
    screwBorder,
    screwCount,
    screwDiameter,
    help
)
{
  assert(is_num(innerStartDiameter) && innerStartDiameter > 0, str("innerStartDiameter must be a number greater than 0. Provided:", innerStartDiameter));
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, str("innerEndDiameter must be a number greater than 0. Provided:", innerEndDiameter));
  assert(is_num(length) && length > 0, str("length must be a number greater than 0. Provided:", length));
  assert(is_num(wallThickness) && wallThickness > 0, str("wallThickness must be a number greater than 0. Provided:", wallThickness));
  assert(is_num(flangeThickness) && flangeThickness > 0, str("flangeThickness must be a number greater than 0. Provided:", flangeThickness));
  assert(is_num(flangeWidth) && flangeWidth > 0, str("flangeWidth must be a number greater than 0. Provided:", flangeWidth));
  assert(is_num(screwPosition) && screwPosition >= 0, str("screwPosition must be a number greater than or equal to 0. Provided:", screwPosition));
  assert(is_num(screwBorder) && screwBorder >= 0, str("screwBorder must be a number greater than or equal to 0. Provided:", screwBorder));
  assert(is_num(screwCount) && screwCount >= 1 && floor(screwCount) == screwCount, str("screwCount must be an integer greater than or equal to 1. Provided:", screwCount));
  assert(is_num(screwDiameter) && screwDiameter > 0, str("screwDiameter must be a number greater than 0. Provided:", screwDiameter));
  assert(is_bool(help), str("help must be a boolean. Provided:", help));

  //The fillet around the edge
  fillet = flangeThickness;
  border = screwBorder == 0 ? flangeWidth/4 : screwBorder;
  flangeOuterDiameter = innerStartDiameter + flangeWidth;
  screwPositionRadius = screwPosition != 0
    ? innerStartDiameter/2 + screwDiameter/2 + screwPosition/2
    : (innerStartDiameter/2 + fillet + (flangeWidth/2-fillet)/2);

  assert(innerEndDiameter <= innerStartDiameter, str("innerEndDiameter should not exceed innerStartDiameter for this flange form. innerEndDiameter=", innerEndDiameter, " innerStartDiameter=", innerStartDiameter));
  assert(flangeOuterDiameter > innerStartDiameter, str("flangeOuterDiameter must be greater than innerStartDiameter. flangeOuterDiameter=", flangeOuterDiameter, " innerStartDiameter=", innerStartDiameter));
  assert(border >= 0, str("border must be greater than or equal to 0. Provided:", border));
  assert(screwPositionRadius > 0, str("screwPositionRadius must be greater than 0. Provided:", screwPositionRadius));
//  assert(screwPositionRadius + screwDiameter/2 <= flangeOuterDiameter/2 + screwDiameter, str("screwPositionRadius is too large for flangeOuterDiameter. screwPositionRadius=", screwPositionRadius, " flangeOuterDiameter=", flangeOuterDiameter));

  echo("FlangeConnector", screwCount=screwCount, screwDiameter=screwDiameter, screwPosition=screwPosition, border=border);
  echo("FlangeConnector", screwPositionRadius=screwPositionRadius, fillet=fillet, flangeOuterDiameter=flangeOuterDiameter, innerStartDiameter=innerStartDiameter, flangeWidth=flangeWidth);

  difference ()
  {
    //flange
    union() {
      pipe(
        diameter1 = innerStartDiameter,
        diameter2 = innerEndDiameter,
        length = length,
        wallThickness1 = wallThickness,
        wallThickness2 = wallThickness);

      // flange aound the screws
      hull () {
        cylinder (d = flangeOuterDiameter, flangeThickness);

        for (i = [0: screwCount-1]) {
            // The rotation should try to avoid the screw being under the bent hose.
            rotate ([fudgeFactor, 0, 180/screwCount * (i * 2 - 1 + screwCount)])
            translate ([screwPositionRadius, 0, 0])
            cylinder (d = screwDiameter + border*2, h = flangeThickness);
        }
      }

      // taper
      intersection()
      {
        HalfConePipe (
            diameter = innerEndDiameter,
            length = fillet,
            wallThickness1 = fillet - fudgeFactor,
            wallThickness2 = 0,
            zPosition= flangeThickness - fudgeFactor);

        translate([0, 0, 0])
        {
            // limit fillet to length
            cylinder(
                d=innerEndDiameter*2,
                h=length);
        }
      }
    }

    //Screw cut out
    for (i = [0: screwCount-1]) {
        // The rotation should try to avoid the screw being under the bent hose.
        rotate ([fudgeFactor, 0, 180/screwCount * (i * 2 - 1 + screwCount)])
        translate ([screwPositionRadius, 0, - fudgeFactor*2])
        cylinder (d = screwDiameter, h = flangeThickness + length + fudgeFactor*4);
    }

    //Flange inner
    translate([0, 0, -fudgeFactor])
        cylinder (
            d1 = innerStartDiameter,
            d2 = innerEndDiameter,
            h = length + 2 * fudgeFactor*2);
  }

  HelpTxt("FlangeConnector",[
    "innerStartDiameter", innerStartDiameter,
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "flangeThickness", flangeThickness,
    "flangeWidth", flangeWidth,
    "screwPosition", screwPosition,
    "screwBorder", screwBorder,
    "screwCount", screwCount,
    "screwDiameter", screwDiameter,
    "border", border,
    "flangeOuterDiameter", flangeOuterDiameter,
    "screwPositionRadius", screwPositionRadius
    ],help);
}