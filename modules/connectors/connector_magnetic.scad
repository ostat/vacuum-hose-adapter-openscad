include <../constants.scad>
include <../modules_utility.scad>


module MagneticConnector(
    innerStartDiameter,
    innerEndDiameter,
    length,
    wallThickness,
    magnetDiameter,
    magnetThickness,
    magnetBorder,
    magnetZOffset,
    flangeThickness,
    magnetCount,
    alignmentRing,
    alignmentDepth,
    alignmentUpperWidth,
    alignmentLowerWidth,
    alignmentSideClearance,
    alignmentDepthClearance,
    twistLockSize,
)
{
  //These sizes need to be tested.
  //head, outer thread for slot, thread hole size
  lockingSize =
    twistLockSize == "3" ? [5.5+0.3,3,2.5] //m3
    : twistLockSize == "3cnc" ? [5.5+0.3,3,4] //m3
    : twistLockSize == "4" ? [7+0.3,4,3.3] //m4
    : twistLockSize == "4cnc" ? [7+0.3,4,5.6] //m4
    : twistLockSize == "5" ? [8.5+0.3,5,4.2] //m5
    : twistLockSize == "5cnc" ? [8.5+0.3,5,6.5] //m5
    : [0,0,0];

  locking = lockingSize != [0,0,0];

  alignmentBorder = alignmentRing != "no" ? magnetBorder/2 : 0;
  magnetPosition = (innerStartDiameter + magnetDiameter) / 2 + magnetBorder +
      (alignmentRing != "no" ? alignmentBorder + alignmentUpperWidth : 0);

  //lockingOffset = magnetCount % 2 == 0 ? lockingOffset : false;
  //lockingDivisions = lockingOffset ? magnetCount/2 : magnetCount;

  magnetDivisionAngle = 360 / magnetCount;
  magnetCir = 2*PI*magnetPosition;
  magnetDivisionCir = magnetCir / magnetCount;
  lockingSystemSize =  magnetDiameter+lockingSize[0]+lockingSize[1]*2+magnetBorder*3;
  twistLockBorder = magnetBorder * 1.5; //Mostly because the magent would be bigger than the bolt any way
  lockingOffset = magnetCount % 2 == 0 ? (magnetDivisionCir < lockingSystemSize) : false;
  lockingDivisions = lockingOffset ? magnetCount/2 : magnetCount;

  endAngleoffset = magnetDivisionAngle * ((magnetDiameter+lockingSize[1])/2+magnetBorder)/magnetDivisionCir; //This needs to be calcualted based on magnet size and bot size.

  startAngleoffset = lockingOffset ? magnetDivisionAngle * ((magnetDiameter+lockingSize[0])/2+magnetBorder)/magnetDivisionCir : endAngleoffset;


  echo("MagneticConnector_locking", magnetDivisionAngle=magnetDivisionAngle, magnetCir=magnetCir, magnetDivisionCir=magnetDivisionCir, minLockSpace = lockingSystemSize, endAngleoffset=endAngleoffset, endAngleoffset=endAngleoffset);
  fillet = flangeThickness;
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

            // flange aound the magnets
            hull () {
                roundover = lockingSize !=[0,0,0] ? 0
                  : max(flangeThickness-magnetThickness-magnetZOffset,0);
                  echo(roundover=roundover);
                for (i = [0: magnetCount-1]) {
                    rotate ([0, 0, i * magnetDivisionAngle])
                    translate ([magnetPosition, 0, 0])
                    if(roundover > 0){
                      roundedCylinder(
                        h = flangeThickness,
                        r = (magnetDiameter + magnetBorder)/2,
                        roundedr2=roundover);
                    }else {
                      cylinder (d = magnetDiameter + magnetBorder * 2, flangeThickness);
                    }
                }

              //flage around locks
              if(locking)
              for (i = [0: magnetCount-1])
              rotate ([0, 0, i* magnetDivisionAngle])
              union(){
                  rotate ([0, 0, 0.5*magnetDivisionAngle])
                  translate ([magnetPosition, 0, 0])
                  cylinder (d = lockingSize[0]+twistLockBorder*2, h = flangeThickness + fudgeFactor*2);

                  rotate ([0, 0, magnetDivisionAngle-endAngleoffset])
                  translate ([magnetPosition, 0, 0])
                  cylinder (d = lockingSize[0]+twistLockBorder*2, h = flangeThickness + fudgeFactor*2);

                  rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*magnetDivisionAngle])
                  rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
                  translate ([magnetPosition, flangeThickness/2, 0])
                  square([lockingSize[0]+twistLockBorder*2,flangeThickness],center=true);
                }

            }


            // protuding magent rung
            if(alignmentRing == "protruding")
            {
                AlignmentRing(
                    centerDiameter = innerStartDiameter + alignmentBorder*2 + alignmentUpperWidth,
                    alignmentDepth = alignmentDepth,
                    alignmentUpperWidth = alignmentUpperWidth,
                    alignmentLowerWidth = alignmentLowerWidth,
                    alignmentSideClearance = alignmentSideClearance,
                    alignmentDepthClearance = alignmentDepthClearance,
                    magnetBorder = magnetBorder
                );
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
                    // incase the connector is less
                    cylinder(
                        d=innerEndDiameter*2,
                        h=length);
                }
            }
        }

        //Magnet cut out
        for (i = [0: magnetCount-1]) {
            rotate ([0, 0, i* 360 / magnetCount])
            translate ([magnetPosition, 0, magnetZOffset - fudgeFactor])
            cylinder (d = magnetDiameter, h = magnetThickness + fudgeFactor);
        }

        //Lock cut out
        if(locking){
          for (i = [0: lockingDivisions-1]) {

            rotate ([0, 0, i*360/lockingDivisions])
            union(){
              rotate ([0, 0, endAngleoffset-(lockingOffset ? 360/magnetCount : 0)])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[2], h = length + fudgeFactor*2);

              rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[0], h = length + fudgeFactor*2);

              rotate ([0, 0, 360/magnetCount-endAngleoffset])
              translate ([magnetPosition, 0, - fudgeFactor])
              cylinder (d = lockingSize[1], h = length + fudgeFactor*2);

              rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
              rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
              translate ([magnetPosition, length/2, 0])
              square([lockingSize[1],length+fudgeFactor*2],center=true);

              translate ([0, 0, flangeThickness/2])
              union(){
                rotate ([0, 0, 360/magnetCount-endAngleoffset])
                translate ([magnetPosition, 0, - fudgeFactor])
                cylinder (d = lockingSize[0], h = length + fudgeFactor*2);

                rotate ([0, 0, lockingOffset ? startAngleoffset : 0.5*360/magnetCount])
                rotate_extrude(angle=lockingOffset ? (magnetDivisionAngle-endAngleoffset-startAngleoffset) : (magnetDivisionAngle-endAngleoffset*2)/2)
                translate ([magnetPosition, length/2, 0])
                square([lockingSize[0],length+fudgeFactor*2],center=true);
              }
            }
          }
        }
        //Flange inner
        translate([0, 0, -fudgeFactor])
            cylinder (
                d1 = innerStartDiameter,
                d2 = innerEndDiameter,
                h = length + 2 * fudgeFactor);

        if(alignmentRing == "recessed")
        {
            // Create recessed alignment ring
            AlignmentRing(
                    centerDiameter = innerStartDiameter + alignmentBorder*2 + alignmentUpperWidth,
                    alignmentDepth = alignmentDepth,
                    alignmentUpperWidth = alignmentUpperWidth,
                    alignmentLowerWidth = alignmentLowerWidth,
                    alignmentSideClearance = 0,
                    alignmentDepthClearance = 0,
                    magnetBorder = magnetBorder);
        }
    }
}

module AlignmentRing(
    centerDiameter,
    alignmentDepth,
    alignmentUpperWidth,
    alignmentLowerWidth,
    alignmentSideClearance,
    alignmentDepthClearance,
    magnetBorder
)
{

//rotate_extrude()
//translate([45, 0, 0])
//circle(r = 4);


    ringHeight = 2*(alignmentDepth-alignmentDepthClearance);
    ringMaxWidth = (alignmentUpperWidth - alignmentSideClearance);
    ringMinWidth = (alignmentLowerWidth - alignmentSideClearance);
    intersection()
    {
        union()
        {

            ConeRing (
                centerDiameter = centerDiameter,
                length = alignmentDepth,
                wallThickness1 = ringMaxWidth,
                wallThickness2 = ringMinWidth,
                zPosition = 0);
            //Add a StraightPipe between the two to block clipping without impacting the angle of the cones.
            StraightPipe (
                diameter = centerDiameter - ringMaxWidth + fudgeFactor,
                length = fudgeFactor,
                wallThickness = ringMaxWidth- fudgeFactor,
                zPosition = -fudgeFactor/2);
            ConeRing (
                centerDiameter = centerDiameter,
                length = alignmentDepth,
                wallThickness1 = ringMinWidth,
                wallThickness2= ringMaxWidth,
                zPosition = -alignmentDepth);
       }

        translate([0, 0, -ringHeight/2])
        {
            cylinder(
                d=centerDiameter + alignmentUpperWidth,
                h=ringHeight);
        }
    }
}