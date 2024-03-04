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
    screwDiameter
)
{
  //The fillet around the edge
  fillet = flangeThickness;
  border = screwBorder == 0 ? flangeWidth/4 : screwBorder;
  flangeOuterDiameter = innerStartDiameter + flangeWidth;
  screwPositionRadius = screwPosition != 0
    ? innerStartDiameter/2 + screwPosition/2
    : (innerStartDiameter/2 + fillet + (flangeWidth/2-fillet)/2);

  echo("FlangeConnector", screwCount=screwCount, screwDiameter=screwDiameter, screwPosition=screwPosition, border=border);
  echo("FlangeConnector", screwPositionRadius=screwPositionRadius, fillet=fillet, flangeOuterDiameter=flangeOuterDiameter, innerStartDiameter=innerStartDiameter, flangeWidth=flangeWidth);

  difference ()
  {
    //flange
    union() {
      Pipe (
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
}