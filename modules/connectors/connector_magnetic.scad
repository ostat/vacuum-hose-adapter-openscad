include <../constants.scad>
include <../modules_utility.scad>
include <../modules_pipe.scad>

connector_magnetic_demo = false;

if(connector_magnetic_demo && $preview){
    $fn = 64;
    diameter = 50;
    spacer = diameter * 1.8;

    imagnetic_demo_length = 0;
    imagnetic_demo_magnetDiameter = 1;
    imagnetic_demo_alignmentRing = 2;
    imagnetic_demo_twistLockSize = 3;
    imagnetic_demo_magnetCount = 4;
    
    render_options = [
        [7.5, 8, "no", "0", 8],
        [8, 8, "no", "0", 8],
        [20, 10.5, "no", "0", 8],
        [20, 10.5, "protruding", "0", 8],
        [20, 10.5, "recessed", "0", 8],
        [20, 10.5, "no", "4", 8],
        [20, 10.5, "no", "4cnc", 8],
        [20, 10.5, "no", "0", 12]
    ];

    for(iRender = [0:len(render_options)-1])
        translate([spacer * (iRender % 3), spacer * floor(iRender / 3), 0])
        MagneticConnector(
            innerStartDiameter = diameter,
            innerEndDiameter = diameter,
            length = render_options[iRender][imagnetic_demo_length],
            wallThickness = 2,
            magnetDiameter = render_options[iRender][imagnetic_demo_magnetDiameter],
            magnetThickness = 4,
            magnetBorder = 2,
            magnetZOffset = 0,
            flangeThickness = 7.5,
            magnetCount = render_options[iRender][imagnetic_demo_magnetCount],
            alignmentRing = render_options[iRender][imagnetic_demo_alignmentRing],
            alignmentDepth = 2,
            alignmentUpperWidth = 3,
            alignmentLowerWidth = 1,
            alignmentSideClearance = 0.25,
            alignmentDepthClearance = 0.75,
            twistLockSize = render_options[iRender][imagnetic_demo_twistLockSize]);
}

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
    roundover = true,
)
{
    assert(is_num(innerStartDiameter) && innerStartDiameter > 0, "innerStartDiameter must be a number greater than 0");
    assert(is_num(innerEndDiameter) && innerEndDiameter > 0, "innerEndDiameter must be a number greater than 0");
    assert(is_num(length) && length > 0, "length must be a number greater than 0");
    assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be a number greater than 0");
    assert(is_num(magnetDiameter) && magnetDiameter > 0, "magnetDiameter must be a number greater than 0");
    assert(is_num(magnetThickness) && magnetThickness > 0, "magnetThickness must be a number greater than 0");
    assert(is_num(magnetBorder) && magnetBorder >= 0, "magnetBorder must be a number greater than or equal to 0");
    assert(is_num(magnetZOffset) && magnetZOffset >= 0, "magnetZOffset must be a number greater than or equal to 0");
    assert(is_num(flangeThickness) && flangeThickness > 0, "flangeThickness must be a number greater than 0");
    assert(is_num(magnetCount) && magnetCount > 0 && floor(magnetCount) == magnetCount, "magnetCount must be a positive integer");
    assert(is_num(alignmentDepth) && alignmentDepth >= 0, "alignmentDepth must be a number greater than or equal to 0");
    assert(is_num(alignmentUpperWidth) && alignmentUpperWidth >= 0, "alignmentUpperWidth must be a number greater than or equal to 0");
    assert(is_num(alignmentLowerWidth) && alignmentLowerWidth >= 0, "alignmentLowerWidth must be a number greater than or equal to 0");
    assert(is_num(alignmentSideClearance) && alignmentSideClearance >= 0, "alignmentSideClearance must be a number greater than or equal to 0");
    assert(is_num(alignmentDepthClearance) && alignmentDepthClearance >= 0, "alignmentDepthClearance must be a number greater than or equal to 0");
    assert(is_string(alignmentRing) && (alignmentRing == "no" || alignmentRing == "protruding" || alignmentRing == "recessed"),
        "alignmentRing must be one of 'no', 'protruding', or 'recessed'");
    assert(is_string(twistLockSize) && (twistLockSize == "0" || twistLockSize == "3" || twistLockSize == "3cnc" || twistLockSize == "4" || twistLockSize == "4cnc" || twistLockSize == "5" || twistLockSize == "5cnc"),
        "twistLockSize must be one of '0', '3', '3cnc', '4', '4cnc', '5', or '5cnc'");
    assert(is_bool(roundover), "roundover must be a boolean");

    assert(magnetZOffset + magnetThickness <= flangeThickness + fudgeFactor, "magnetZOffset + magnetThickness must be less than or equal to flangeThickness");
    assert(alignmentDepthClearance <= alignmentDepth, "alignmentDepthClearance must be less than or equal to alignmentDepth");
    assert(alignmentRing == "no" || (alignmentUpperWidth > alignmentSideClearance && alignmentLowerWidth > alignmentSideClearance),
        "alignmentUpperWidth and alignmentLowerWidth must be greater than alignmentSideClearance when alignment ring is enabled");


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
  roundoverSize = !roundover || lockingSize != [0,0,0] ? 0
    : max(flangeThickness-magnetThickness-magnetZOffset,0);

  fillet = flangeThickness - roundoverSize;
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

            // flange aound the magnets
            hull () {

                for (i = [0: magnetCount-1]) {
                    rotate ([0, 0, i * magnetDivisionAngle])
                    translate ([magnetPosition, 0, 0])
                    if(roundoverSize > 0){
                      roundedCylinder(
                        h = flangeThickness,
                        r = (magnetDiameter + magnetBorder)/2,
                        roundedr2=roundoverSize);
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
            pipe (
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
