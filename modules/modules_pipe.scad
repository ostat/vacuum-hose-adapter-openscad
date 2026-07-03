include <constants.scad>
include <thirdparty/dotSCAD/shape_circle.scad>
include <thirdparty/dotSCAD/ring_extrude.scad>

//diameter1: Inner start diameter.
//diameter2: Inner end diameter.
//length: pipe length
//wallThickness1 Thickness of the walls at the start
//wallThickness2 Thickness of the walls at the end
//zPosition: Start Z position.

debug_pipe = false;

if(debug_pipe){

  difference(){
    radius = 25;
    height = 10;
    thickness = 10;

    union(){
      pipe(
          diameter1 = 100,
          diameter2 = 40,
          length = 20,
          wallThickness = 2);
      translate([0,0,30])
      pipe(
          diameter1 = 40,
          diameter2 = 100,
          length = 20,
          wallThickness = 2);
      translate([0,0,60])
      pipe(
          diameter1 = 20,
          diameter2 = 100,
          length = 10,
          wallThickness = 2);
      translate([100,0,0])
      pipe(
          diameter1 = radius*2,
          diameter2 = radius*2-thickness*2,
          length = height+fudgeFactor*2,
          wallThickness1 = fudgeFactor,
          wallThickness2 = thickness+fudgeFactor);

      translate([100,0,25])
      pipe(
          diameter1 = 28.5,
          diameter2 = 30.1,
          length =0.8,
          wallThickness1 = 2.8,
          wallThickness2 = 2);
    }

    translate([-200,0,-10])
    cube([400,100,100]);
  }


  translate([0,-150,0])
  pipe_demo_helper(
      diameter1=100,
      diameter2=70,
      length=50,
      wallThickness = 2);

  translate([0,150,0])
  pipe_demo_helper(
      diameter1=100,
      diameter2=70,
      length=50,
      wallThickness = 2,
      Offset = [15,0]);


  wallthicknessess = [10, 1];
  for(iwallthickness = [0,len(wallthicknessess)-1])
  translate([iwallthickness*75,250,0])
  pipe_demo_helper(
      diameter=25,
      length=50,
      wallThickness1 = 10,
      wallThickness2 = wallthicknessess[iwallthickness],
      chamfer1 = [0.5,0.5],
      chamfer2 = [1,1]);

  centerSmallerWalls = [true, false];
  for(icenterSmallerWall = [0,len(centerSmallerWalls)-1])
  //translate([icenterSmallerWall*75,350,0])
  translate([0,350,0])
  pipe_demo_helper(
      diameter=25,
      length=50,
      wallThickness1 = 10,
      wallThickness2 = 1,
      chamfer1 = [0.5,0.5],
      chamfer2 = [1,1],
      centerSmallerWall = centerSmallerWalls[icenterSmallerWall]);

  translate([0,0,75])
  Stopper(
      diameter = 100,
      outer = true,
      totalLength = 20,
      taper1 = [10,10],
      taper2 = [5,5],
      wallThickness = 10,
      stopThickness = 20,
      marker = false);

  translate([0,0,150])
  Stopper(
      diameter = 100,
      outer = true,
      totalLength = 20,
      taper1 = 0.33,
      taper2 = 0.33,
      wallThickness = 10,
      stopThickness = 20,
      marker = false);
}

module pipe_demo_helper(
    diameter,
    diameter1,
    diameter2,
    length,
    wallThickness,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    Offset = [0,0],
    chamfer,
    chamfer1 = [0,0],
    chamfer2 = [0,0],
    centerSmallerWall = false)
{
 pipe(
    diameter = diameter,
    diameter1 = diameter1,
    diameter2 = diameter2,
    length = length,
    wallThickness = wallThickness,
    wallThickness1 = wallThickness1,
    wallThickness2 = wallThickness2,
    zPosition = zPosition,
    chamfer = chamfer,
    chamfer1 = chamfer1,
    chamfer2 = chamfer2,
    centerSmallerWall = centerSmallerWall);

 translate([0,-50,0])
 pipe_with_offset(
    diameter = diameter,
    diameter1 = diameter1,
    diameter2 = diameter2,
    length = length,
    wallThickness = wallThickness,
    wallThickness1 = wallThickness1,
    wallThickness2 = wallThickness2,
    zPosition = zPosition,
    Offset = Offset,
    chamfer = chamfer,
    chamfer1 = chamfer1,
    chamfer2 = chamfer2,
    centerSmallerWall = centerSmallerWall);
}

// Builds a hollow pipe segment with optional taper, offset axis, and end chamfers.
// Parameters:
// diameter: Optional single inner diameter override for both ends.
// diameter1: Inner diameter at the start of the pipe.
// diameter2: Inner diameter at the end of the pipe.
// length: Pipe length along Z.
// wallThickness: Optional single wall thickness override for both ends.
// wallThickness1: Wall thickness at the start.
// wallThickness2: Wall thickness at the end.
// zPosition: Z offset for placing the pipe.
// Offset: XY offset vector [x, y] applied to the end profile.
// chamfer: Optional single chamfer value/vector applied to both ends.
// chamfer1: Start-end chamfer [inner, outer].
// chamfer2: End-end chamfer [inner, outer].
// centerSmallerWall: When true, increases the thinner-wall end inner diameter by half wall delta.
module pipe_with_offset(
    diameter,
    diameter1,
    diameter2,
    length,
    wallThickness,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    Offset = [0,0],
    chamfer,
    chamfer1 = [0,0],
    chamfer2 = [0,0],
    centerSmallerWall = false)
{
  wallThickness1 = is_undef(wallThickness) ? wallThickness1 : wallThickness;
  wallThickness2 = is_undef(wallThickness) ? wallThickness2 : wallThickness;

  wallThicknessDelta = abs(wallThickness1 - wallThickness2) / 2;


  diameter1 = let (diam = is_undef(diameter) ? diameter1 : diameter)
              centerSmallerWall && wallThickness1 < wallThickness2 ? diam + wallThicknessDelta : diam;

  diameter2 = let (diam = is_undef(diameter) ? diameter2 : diameter)
              centerSmallerWall && wallThickness2 < wallThickness1 ? diam + wallThicknessDelta : diam;

  chamfer1 = let(c = is_undef(chamfer) ? chamfer1 : chamfer)
             is_num(c) ? [c,c] : c;
  chamfer2 = let(c = is_undef(chamfer) ? chamfer2 : chamfer)
             is_num(c) ? [c,c] : c;

  innerChamferStart = !is_undef(chamfer1) ? max(0, chamfer1[0]) : 0;
  outerChamferStart = !is_undef(chamfer1) ? max(0, chamfer1[1]) : 0;
  innerChamferEnd = !is_undef(chamfer2) ? max(0, chamfer2[0]) : 0;
  outerChamferEnd = !is_undef(chamfer2) ? max(0, chamfer2[1]) : 0;

  // Keep chamfers valid on tapered/thin ends: inner + outer cannot exceed local wall.
  startChamferBudget = max(0, wallThickness1 - fudgeFactor);
  endChamferBudget = max(0, wallThickness2 - fudgeFactor);

  startChamferSum = innerChamferStart + outerChamferStart;
  endChamferSum = innerChamferEnd + outerChamferEnd;

  startChamferScale = startChamferSum > 0 && startChamferSum > startChamferBudget ? startChamferBudget / startChamferSum : 1;
  endChamferScale = endChamferSum > 0 && endChamferSum > endChamferBudget ? endChamferBudget / endChamferSum : 1;

  innerChamferStartEff = innerChamferStart * startChamferScale;
  outerChamferStartEff = outerChamferStart * startChamferScale;
  innerChamferEndEff = innerChamferEnd * endChamferScale;
  outerChamferEndEff = outerChamferEnd * endChamferScale;

  outerDiameter1 = diameter1 + wallThickness1*2;
  outerDiameter2 = diameter2 + wallThickness2*2;
  // When OD reduces toward end2, enlarge the end chamfer cut to match taper slope.
  outerEndTaperComp = outerChamferEndEff * max(0, outerDiameter1 - outerDiameter2) / max(length, fudgeFactor);

  //todo, add correction to ensure that the thickness of the walls never reduce to less than wallThickness1 and wallThickness2
  //using wallThickness/2 is a sloppy approximation, really need to use trig to would out the correct value
  leadIn = max(fudgeFactor, min(wallThickness1, wallThickness2, length)/2);

  //a = b × tan(α)
  //atan(a/b) = angle;

  startOuterLeadIn = diameter1+wallThickness1*2 > diameter2+wallThickness2*2 ? leadIn : fudgeFactor;
  startInnerLeadIn = diameter1 > diameter2 ? fudgeFactor : leadIn;
  endOuterLeadIn = diameter2+wallThickness2*2> diameter1+wallThickness1*2 ? leadIn : fudgeFactor;
  endInnerLeadIn = diameter2 > diameter1 ? fudgeFactor : leadIn;
  hasLeadInWallCorrection =
    startOuterLeadIn != fudgeFactor ||
    startInnerLeadIn != fudgeFactor ||
    endOuterLeadIn != fudgeFactor ||
    endInnerLeadIn != fudgeFactor;

  difference ()
  {
    //outer cylinder
    translate([0,0,zPosition])
    hull()
    {
      if(Offset.x>0 || Offset.y>0 || hasLeadInWallCorrection) {
        //(diameter1 != diameter2 && diameter1+wallThickness1*2 != diameter2+wallThickness2*2)) {
        cylinder(h=startOuterLeadIn, d=diameter1+wallThickness1*2);
        translate([Offset.x,Offset.y,length-endOuterLeadIn])
          cylinder(h=endOuterLeadIn, d=diameter2+wallThickness2*2);
      }
      else{
        cylinder(length,
          d1=diameter1+wallThickness1*2,
          d2=diameter2+wallThickness2*2);
      }
    }

    //Inner cylinder to remove
    translate([0,0,zPosition])
      union()
      {
      if(Offset.x > 0 || Offset.y>0 || hasLeadInWallCorrection) {
        //(diameter1 != diameter2 && diameter1+wallThickness1*2 != diameter2+wallThickness2*2)) {

        translate([0,0,-fudgeFactor])
        cylinder(startInnerLeadIn+fudgeFactor*2, d=diameter1);

        translate([0,0,startInnerLeadIn])
        hull() {
          cylinder(fudgeFactor, d=diameter1);
          translate([Offset.x,Offset.y,length-startInnerLeadIn-endInnerLeadIn])
            cylinder(fudgeFactor, d=diameter2);
        }
        translate([Offset.x,Offset.y,length-endInnerLeadIn-fudgeFactor])
        cylinder(endInnerLeadIn+fudgeFactor*2, d=diameter2);
      } else {
        // main removal
        cylinder(length, d1=diameter1, d2=diameter2);
      }
      // bottom top glitch correction
      translate([0,0,-fudgeFactor])
        cylinder(fudgeFactor*2, d=diameter1);

      // top glitch correction
      translate([Offset.x,Offset.y,length-fudgeFactor])
        cylinder(fudgeFactor*2, d=diameter2);
    }

    echo(chamfer1=chamfer1, chamfer2=chamfer2);

    if(innerChamferStartEff > 0)
      //remove bottom inner taper
      pipe(
        diameter1 = diameter1-fudgeFactor,
        diameter2 = diameter1-fudgeFactor,
        length = innerChamferStartEff+fudgeFactor,
        wallThickness1 = innerChamferStartEff,
        wallThickness2 = 0,
        zPosition = -fudgeFactor);

      //remove bottom outer taper
      if(outerChamferStartEff > 0)
        pipe(
          diameter1 = diameter1+wallThickness1*2-outerChamferStartEff*2+fudgeFactor,
          diameter2 = diameter1+wallThickness1*2+fudgeFactor,
          length = outerChamferStartEff,
          wallThickness1 = outerChamferStartEff,
          wallThickness2 = 0,
          zPosition = -fudgeFactor);

    if(innerChamferEndEff > 0)
      //remove top inner taper
      translate([Offset.x,Offset.y,length-innerChamferEndEff+fudgeFactor])
      pipe(
        diameter1 = diameter2-fudgeFactor,
        diameter2 = diameter2-fudgeFactor,
        length = innerChamferEndEff+fudgeFactor,
        wallThickness1 = 0,
        wallThickness2 = innerChamferEndEff,
        zPosition = -fudgeFactor);

      //remove bottom outer taper
      if(outerChamferEndEff > 0)
        translate([Offset.x,Offset.y,length-outerChamferEndEff+fudgeFactor])
        pipe(
          diameter1 = outerDiameter2 + outerEndTaperComp + fudgeFactor,
          diameter2 = diameter2+wallThickness2*2-outerChamferEndEff*2+fudgeFactor,
          length = outerChamferEndEff+fudgeFactor,
          wallThickness1 = 0,
          wallThickness2 = outerChamferEndEff,
          zPosition = -fudgeFactor);
  }
}

// Basic revolve-based pipe without endpoint XY offset support.
// Parameters:
// diameter: Optional single inner diameter override for both ends.
// diameter1: Inner diameter at the start of the pipe.
// diameter2: Inner diameter at the end of the pipe.
// length: Pipe length along Z.
// wallThickness: Optional single wall thickness override for both ends.
// wallThickness1: Wall thickness at the start.
// wallThickness2: Wall thickness at the end.
// zPosition: Z offset for placing the pipe.
// chamfer: Optional single chamfer value/vector applied to both ends.
// chamfer1: Start-end chamfer [inner, outer].
// chamfer2: End-end chamfer [inner, outer].
// centerSmallerWall: When true, increases the thinner-wall end inner diameter by half wall delta.
module pipe(
    diameter,
    diameter1,
    diameter2,
    length,
    wallThickness,
    wallThickness1,
    wallThickness2,
    zPosition = 0,
    chamfer,
    chamfer1 = [0,0],
    chamfer2 = [0,0],
    centerSmallerWall = false)
{
  wallThickness1 = is_undef(wallThickness) ? wallThickness1 : wallThickness;
  wallThickness2 = is_undef(wallThickness) ? wallThickness2 : wallThickness;

  wallThicknessDelta = abs(wallThickness1 - wallThickness2) / 2;

  diameter1 = let (diam = is_undef(diameter) ? diameter1 : diameter)
              centerSmallerWall && wallThickness1 < wallThickness2 ? diam + wallThicknessDelta : diam;

  diameter2 = let (diam = is_undef(diameter) ? diameter2 : diameter)
              centerSmallerWall && wallThickness2 < wallThickness1 ? diam + wallThicknessDelta : diam;

  chamfer1 = let(c = is_undef(chamfer) ? chamfer1 : chamfer)
             is_num(c) ? [c,c] : c;
  chamfer2 = let(c = is_undef(chamfer) ? chamfer2 : chamfer)
             is_num(c) ? [c,c] : c;

  innerRadius1 = diameter1 / 2;
  innerRadius2 = diameter2 / 2;
  outerRadius1 = innerRadius1 + wallThickness1;
  outerRadius2 = innerRadius2 + wallThickness2;

  innerChamferStart = !is_undef(chamfer1) ? max(0, chamfer1[0]) : 0;
  outerChamferStart = !is_undef(chamfer1) ? max(0, chamfer1[1]) : 0;
  innerChamferEnd = !is_undef(chamfer2) ? max(0, chamfer2[0]) : 0;
  outerChamferEnd = !is_undef(chamfer2) ? max(0, chamfer2[1]) : 0;

  // Keep chamfers valid on tapered/thin ends: inner + outer cannot exceed local wall.
  startChamferBudget = max(0, wallThickness1 - fudgeFactor);
  endChamferBudget = max(0, wallThickness2 - fudgeFactor);

  startChamferSum = innerChamferStart + outerChamferStart;
  endChamferSum = innerChamferEnd + outerChamferEnd;

  startChamferScale = startChamferSum > 0 && startChamferSum > startChamferBudget ? startChamferBudget / startChamferSum : 1;
  endChamferScale = endChamferSum > 0 && endChamferSum > endChamferBudget ? endChamferBudget / endChamferSum : 1;

  innerChamferStartEff = innerChamferStart * startChamferScale;
  outerChamferStartEff = outerChamferStart * startChamferScale;
  innerChamferEndEff = innerChamferEnd * endChamferScale;
  outerChamferEndEff = outerChamferEnd * endChamferScale;

  startInnerZ = min(length, innerChamferStartEff);
  startOuterZ = min(length, outerChamferStartEff);
  endInnerZ = max(0, length - min(length, innerChamferEndEff));
  endOuterZ = max(0, length - min(length, outerChamferEndEff));

  assert(length > 0, "length must be greater than 0");
  assert(innerRadius1 > 0 && innerRadius2 > 0, "Inner diameters must be greater than 0");
  assert(wallThickness1 >= 0 && wallThickness2 >= 0, str("Wall thicknesses must be greater than 0 wallThickness1:", wallThickness1, " wallThickness2:", wallThickness2));

  translate([0,0,zPosition])
  rotate_extrude(convexity = 10)
    polygon(points = [
      [max(fudgeFactor, outerRadius1 - outerChamferStartEff), 0],    // 1) Outer start edge at z=0 (after optional start outer chamfer).
      [outerRadius1, startOuterZ],                                // 2) Outer start wall at chamfer end.
      [outerRadius2, endOuterZ],                                  // 3) Outer end wall just before end chamfer.
      [max(fudgeFactor, outerRadius2 - outerChamferEndEff), length], // 4) Outer end edge at z=length (after optional end outer chamfer).
      [innerRadius2 + innerChamferEndEff, length],                   // 5) Inner end edge at z=length (after optional end inner chamfer).
      [innerRadius2, endInnerZ],                                  // 6) Inner end wall just before end chamfer.
      [innerRadius1, startInnerZ],                                // 7) Inner start wall at chamfer end.
      [innerRadius1 + innerChamferStartEff, 0]                       // 8) Inner start edge at z=0 (after optional start inner chamfer).
    ]);
}

// Creates a straight inner diameter with wall thickness transitioning along the length.
// Parameters:
// diameter: Inner diameter at both ends.
// length: Pipe length along Z.
// wallThickness1: Wall thickness at the start.
// wallThickness2: Wall thickness at the end.
// zPosition: Z offset for placing the pipe.
module HalfConePipe(diameter, length, wallThickness1, wallThickness2, zPosition)
{
    pipe(
        diameter1 = diameter,
        diameter2 = diameter,
        length = length,
        wallThickness1 = wallThickness1,
        wallThickness2 = wallThickness2,
        zPosition = zPosition);
}

// Generates a tapered ring around a center diameter by subtracting inner from outer cones.
// Parameters:
// centerDiameter: Mean diameter used to build outer and inner tapers.
// length: Ring length along Z.
// wallThickness1: Radial wall thickness at the start.
// wallThickness2: Radial wall thickness at the end.
// zPosition: Z offset for placing the ring.
module ConeRing(centerDiameter, length, wallThickness1, wallThickness2, zPosition)
{
    difference ()
    {
        //outer cylinder
        translate([0, 0, zPosition])
        cylinder(
            d1=centerDiameter+wallThickness1,
            d2=centerDiameter+wallThickness2,
            h=length);

        //Inner cylinder to remove
        translate([0, 0, zPosition-fudgeFactor])
        cylinder(
            d1=centerDiameter-wallThickness1,
            d2=centerDiameter-wallThickness2,
            h=length + 2*fudgeFactor);
    }
}

// Creates a multi-end bent junction body by hulling outer/inner pipe endpoints.
// Parameters:
// inner1PipeRadius: Inner radius of the primary (end1) port.
// inner2PipeRadius: Inner radius of repeated side (end2) ports.
// inner3PipeRadius: Inner radius of optional center (end3) port.
// end1WallThickness: Wall thickness at the primary port.
// end2WallThickness: Wall thickness at side ports.
// end3WallThickness: Wall thickness at optional center port.
// pipeAngle: Tilt angle for side ports.
// zPosition: Reserved Z placement parameter.
// end2Count: Number of repeated side ports.
// end2Angle: Per-port rotation angle; defaults to 360/end2Count.
// lengthInHull: Length included in the hull blend region.
// lengthOutHull: Extra length added beyond hull on side ports.
// lengthOutHullCenter: Extra length for the optional center port.
// edgeOffset: Lateral offset of side ports from the primary centerline.
// addCenter: Enables/disables the optional center port.
// centerHeight: Z position of the optional center port.
module BentPipeHull(
    inner1PipeRadius,
    inner2PipeRadius,
    inner3PipeRadius,
    end1WallThickness,
    end2WallThickness,
    end3WallThickness,
    pipeAngle = 0,
    zPosition=0,
    end2Count=1,
    end2Angle=0,
    lengthInHull=0,
    lengthOutHull=0,
    lengthOutHullCenter=0,
    edgeOffset = 0,
    addCenter = false,
    centerHeight= 0
)
{
  assert(is_num(inner1PipeRadius), "inner1PipeRadius must be a number");
  assert(is_num(inner2PipeRadius), "inner2PipeRadius must be a number");
  assert(is_num(inner3PipeRadius), "inner3PipeRadius must be a number");
  assert(is_num(end1WallThickness), "end1WallThickness must be a number");
  assert(is_num(end2WallThickness), "end2WallThickness must be a number");
  assert(is_num(end3WallThickness), "end3WallThickness must be a number");
  assert(is_num(pipeAngle), "pipeAngle must be a number");
  assert(is_num(zPosition), "zPosition must be a number");
  assert(is_num(end2Count), "end2Count must be a number");
  assert(is_num(lengthInHull), "lengthInHull must be a number");
  assert(is_num(lengthOutHull), "lengthOutHull must be a number");
  assert(is_num(edgeOffset), "edgeOffset must be a number");
  assert(is_bool(addCenter), "addCenter must be a boolean");
  assert(is_num(centerHeight), "centerHeight must be a number");

  outer1PipeRadius = inner1PipeRadius + end1WallThickness;
  outer2PipeRadius = inner2PipeRadius + end2WallThickness;
  outer3PipeRadius = inner3PipeRadius + end3WallThickness;
  //_edgeOffset = outer1PipeRadius - outer2PipeRadius - edgeOffset;
  _edgeOffset = edgeOffset;

  end1BaseHeight = end1WallThickness;
  end2BaseHeight = end2WallThickness;

  //echo("BentPipeHull", _edgeOffset = _edgeOffset, lengthInHull = lengthInHull, centerHeight=centerHeight, lengthOutHull=lengthOutHull, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, a= (cos(pipeAngle) * outer2PipeRadius*2));
  multiRotationAngle = end2Angle > 0 ? end2Angle : 360/end2Count;

  difference(){
    //Outer shape
    union(){
      //The main body hull shape
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*multiRotationAngle])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, lengthInHull])
          cylinder(r=outer2PipeRadius, h=end2WallThickness);
        }

        if(addCenter)
        {
          //end 2 center
          translate([0, 0, centerHeight-end3WallThickness])
          cylinder(r=outer3PipeRadius, h=end3WallThickness);
        }

        //end1
        cylinder(r=outer1PipeRadius, h=end1BaseHeight+fudgeFactor);
      }

      //Extensions tubes
      for (rotation = [0:end2Count-1])
      {
        //End 2 extensions
        //echo("Outer shape", pipeAngle=pipeAngle, outer1PipeRadius=outer1PipeRadius, outer2PipeRadius=outer2PipeRadius, _edgeOffset=_edgeOffset, lengthInHull=lengthInHull, end2WallThickness=end2WallThickness );

        rotate([0,0,rotation*multiRotationAngle])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, lengthInHull])
        cylinder(r=outer2PipeRadius, h=lengthOutHull+end2WallThickness+fudgeFactor);
      }

      if(addCenter)
      {
          translate([0, 0, centerHeight])
          cylinder(r=outer3PipeRadius, h=lengthOutHullCenter);
      }
    }

    //inner/negative shape
    union(){
      //The Inner Main body hull shape
      hull(){
        for (rotation = [0:end2Count-1])
        {
          //End 2
          rotate([0,0,rotation*multiRotationAngle])
          rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
          translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
          cylinder(r=inner2PipeRadius, h=end2WallThickness+fudgeFactor*2);
        }

        if(addCenter)
        {
        //End 2 center
          translate([0, 0, centerHeight-end3WallThickness-fudgeFactor])
          cylinder(r=inner3PipeRadius, h=end3WallThickness+fudgeFactor*2);
        }

        //End 1
        cylinder(r=inner1PipeRadius, h=end1BaseHeight+fudgeFactor*2);
      }

      //Extension tubes
      for (rotation = [0:end2Count-1])
      {
        //End 2 extensions
        rotate([0,0,rotation*multiRotationAngle])
        rotate_about_pt(0, -pipeAngle, [-outer1PipeRadius,0,0])
        translate([-_edgeOffset, 0, -end2BaseHeight+fudgeFactor+lengthInHull])
        cylinder(r=inner2PipeRadius, h=lengthOutHull+end2WallThickness*2+fudgeFactor*2);
      }

      if(addCenter)
      {
          translate([0, 0, centerHeight-fudgeFactor])
          cylinder(r=inner3PipeRadius, h=lengthOutHullCenter+fudgeFactor*2);
      }
    }

    //Clear start from clipping
    rotate([0, 0, pipeAngle])
    translate([0, 0, -fudgeFactor])
      cylinder(
          r=inner1PipeRadius,
          h=fudgeFactor*2);

  }
}

// Creates a constant-diameter elbow with optional printable support base.
// Parameters:
// bendRadius: Centerline bend radius.
// innerPipeDiameter: Inner diameter of the elbow.
// wallThickness: Uniform wall thickness.
// pipeAngle: Sweep angle of the elbow.
// zPosition: Z offset for placing the elbow.
// baseType: Support base style: "none", "rectangle", or "oval".
// baseWidth: Optional base width override.
// baseLength: Optional base length override.
// baseThickness: Extra base thickness added under the pipe.
// baseAngle: Rotation angle for the base; defaults to half pipeAngle.
// end2Count: Number of repeated elbows around 360 degrees.
// end2Angle: Reserved branch spacing parameter.
module BentPipe(
    bendRadius,
    innerPipeDiameter,
    wallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1,
    end2Angle=0
)
{
  outerPipeDiameter  = innerPipeDiameter + wallThickness * 2;

  baseSupportThickness = outerPipeDiameter/2 + baseThickness;
  baseSupportWidth =  baseWidth == 0 ? outerPipeDiameter / 2  : baseWidth;
  baseSupportLength =  baseLength == 0 ? outerPipeDiameter / 1.5  : baseLength;
  baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

  //echo("BentPipe", bendRadius=bendRadius, innerPipeDiameter=innerPipeDiameter,wallThickness=wallThickness, pipeAngle=pipeAngle, zPosition=zPosition);
  //echo("BentPipe", baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);


  difference() {
    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){
        // printing base
        if (end2Count <= 1 && baseType != "none"){
          rotate([0,0,baseSupportAngle])
          translate([bendRadius,0,0])
          rotate([0,90,0])
          if (baseType == "rectangle")
            translate([0,0,baseSupportThickness*3/4]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness/2],center=true);
          else if (baseType == "oval")
            translate([0,0,baseSupportThickness/2])
            resize([baseSupportWidth,0,0])
            cylinder(h=baseSupportThickness/2,d=baseSupportLength);
        }

        rotate_extrude(angle=pipeAngle, convexity=10)
          translate([bendRadius, 0, 0])
          circle(d=outerPipeDiameter);
      }
    }

    for (rotation = [0:end2Count-1])
    {
      rotate([0,0,rotation*(360/end2Count)])
      translate([-bendRadius, 0, zPosition])
      rotate([90, 0, 0])
      union(){

     rotate([0, 0, -1])
     rotate_extrude(angle=pipeAngle+2,convexity=10)
            translate([bendRadius, 0, 0])
            circle(d=innerPipeDiameter);

      //Clear start from clipping
      rotate([90, 0, pipeAngle])
      translate([bendRadius, 0, -baseSupportThickness])
      cylinder(
          d=innerPipeDiameter,
          h=baseSupportThickness);

    //Clear end of the pipe from clipping
    rotate([90, 0, 0])
      translate([bendRadius, 0, 0])
      cylinder(d=innerPipeDiameter, h=fudgeFactor*2);
    }}
  }
}

// Creates a bent pipe that transitions between different end diameters and wall thicknesses.
// Parameters:
// bendRadius: Centerline bend radius.
// end1InnerPipeDiameter: Inner diameter at the start of the bend.
// end2InnerPipeDiameter: Inner diameter at the end of the bend.
// end1WallThickness: Wall thickness at the start.
// end2WallThickness: Wall thickness at the end.
// pipeAngle: Sweep angle of the bend.
// zPosition: Z offset for placing the part.
// baseType: Support base style: "none", "rectangle", or "oval".
// baseWidth: Optional base width override.
// baseLength: Optional base length override.
// baseThickness: Extra base thickness added under the pipe.
// baseAngle: Rotation angle for the base; defaults to half pipeAngle.
// end2Count: Number of repeated bends around 360 degrees.
module TaperedBentPipe(
    bendRadius,
    end1InnerPipeDiameter,
    end2InnerPipeDiameter,
    end1WallThickness,
    end2WallThickness,
    pipeAngle,
    zPosition = 0,
    baseType="none",
    baseWidth=0,
    baseLength=0,
    baseThickness=0,
    baseAngle=0,
    end2Count=1
)
{
    assert(is_num(pipeAngle) &&  pipeAngle > 0, "pipeAngle must be greater than 0");
    //echo("TaperedBentPipe", bendRadius=bendRadius, end1InnerPipeDiameter=end1InnerPipeDiameter, end2InnerPipeDiameter=end2InnerPipeDiameter, end1WallThickness=end1WallThickness, end2WallThickness=end2WallThickness);

    outerPipeDiameter  = end1InnerPipeDiameter + end1WallThickness * 2;

    sizeStart = end1InnerPipeDiameter / 2 + end1WallThickness ;
    sizeEnd = end2InnerPipeDiameter / 2 + end2WallThickness ;

    //baseSupportThickness should be between the start and end, but weighted to the thicker end.
    supportBaseValue = (max(sizeStart,sizeEnd)*2 + min(sizeStart,sizeEnd))/3;
    baseSupportThickness = supportBaseValue + baseThickness;
    baseSupportWidth =  baseWidth == 0 ? supportBaseValue *1.5 : baseWidth;
    baseSupportLength =  baseLength == 0 ? supportBaseValue * 2: baseLength;
    baseSupportAngle = baseAngle == 0 ? pipeAngle/2 : baseAngle;

    shapeOuter = shape_circle(sizeStart);
    shapeInner = shape_circle(sizeStart-end1WallThickness);

    //echo("TaperedBentPipe", baseSupportThickness=baseSupportThickness,  baseSupportAngle=baseSupportAngle,  baseSupportWidth=baseSupportWidth, baseSupportLength=baseSupportLength);

    translate([0, 0, zPosition])
    difference(){
        difference(){

          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            translate([-bendRadius, 0, 0])
            rotate([90, 0, 0])
            union(){
              // printing base
              if (end2Count <= 1 && baseType != "none"){
                rotate([0,0,baseSupportAngle])
                translate([bendRadius,0,0])
                rotate([0,90,0])
                if (baseType == "rectangle")
                   translate([0,0,baseSupportThickness/2]) cube( [baseSupportWidth,baseSupportLength,baseSupportThickness],center=true);
                else if (baseType == "oval")
                    resize([baseSupportWidth,0,0]) cylinder(h=baseSupportThickness,d=baseSupportLength);
                }
                ring_extrude(shapeOuter, radius = bendRadius, angle = pipeAngle, scale = (sizeEnd/sizeStart           ));
              }
          }


          for(rotation = [0:end2Count-1])
          {
            rotate([0, 0, rotation*(360/end2Count)])
            union(){
              translate([-bendRadius, 0, 0])
              rotate([90, 0, 0])
              ring_extrude(
                shapeInner,
                radius = bendRadius,
                angle = pipeAngle,
                scale = ((sizeEnd-end2WallThickness)/(sizeStart-end1WallThickness)));

              //Clear start from clipping
              translate([0, 0, -fudgeFactor])
              cylinder(
                  d=end1InnerPipeDiameter,
                  h=2*fudgeFactor);

              //Clear end of the pipe from clipping
              translate([-bendRadius+fudgeFactor, 0, 0])
              rotate([0, -pipeAngle, 0])
                  translate([bendRadius, 0, 0])
                  cylinder(
                      d=end2InnerPipeDiameter,
                      h=2*fudgeFactor);

          }
        }
      }
    }
  }

// TODO This seems slow, especially when used for barbs.
// Creates a retention stopper ring with optional top/bottom tapers and marker.
// Parameters:
// diameter: Inner diameter if outer=true, otherwise the outer target reference.
// outer: True for external stopper geometry, false for internal-fit geometry.
// totalLength: Overall axial stopper length.
// taper1: Bottom taper as ratio (0..1) or [width, length].
// taper2: Top taper as ratio (0..1) or [width, length].
// wallThickness: Base wall thickness under the stopper feature.
// stopThickness: Radial thickness of the stopper lip.
// zPosition: Z offset for placing the stopper.
// marker: Adds a spherical orientation marker when true.
// help: Reserved/unused placeholder parameter.
module Stopper(
    diameter,
    outer = true,
    totalLength,
    taper1,
    taper2,
    wallThickness,
    stopThickness,
    zPosition = 0,
    marker = false,
    help
)
{
  if(is_num(taper1)){ assert(taper1 >= 0 || taper1 <= 1, "taper1 should be between 0 to 1");}
  if(is_num(taper2)){ assert(taper2 >= 0 || taper2 <= 1, "taper1 should be between 0 to 1");}


  _diameter = outer ? diameter : diameter + wallThickness*2;
  markPos = (outer ? diameter+wallThickness : diameter-stopThickness*2)/2;

  taperLength1 = (is_list(taper1) ? taper1.y : totalLength * taper1);
  zOffSet1 = wallThickness*taperLength1/stopThickness;
  length1= (zOffSet1 + totalLength);
  taperWidth1 = is_list(taper1) ? taper1.x : length1 * stopThickness / taperLength1;

  taperLength2 = (is_list(taper2) ? taper2.y : totalLength * taper2);
  zOffSet2 = wallThickness * taperLength2 / stopThickness;
  length2 = (zOffSet2 + totalLength);
  taperWidth2 = is_list(taper2) ? taper2.x : length2 * stopThickness / taperLength2;

  translate([0,0,zPosition])
  union(){
    if(marker)
      translate([markPos,0,+stopThickness])
      sphere(d=stopThickness);
    intersection()
    {
      flat = totalLength - taperLength1 - taperLength2;
      pipe (
        diameter = outer ? diameter : diameter-stopThickness*2,
        length = totalLength,
        wallThickness = wallThickness + stopThickness);

        //Bottom taper
        if(taperLength1 > 0)
        {
          //taperLength1 = totalLength * taper1;
          //zOffSet1 = wallThickness*taperLength1/stopThickness;
          //length1= (zOffSet1 + totalLength);
          //width1 = length1 * stopThickness / taperLength1;
          diameterStart1 = _diameter;
          diameterEnd1 = outer ? _diameter :_diameter - taperWidth1*2;
          pipe(
            diameter1 = diameterStart1,
            diameter2 = diameterEnd1,
            length = length1,
            wallThickness1 = 0,
            wallThickness2 = taperWidth1,
            zPosition = -zOffSet1);
        }

        //Top taper
        if(taperLength2 > 0)
        {
          //taperLength2 = totalLength * taper2;
          //zOffSet2 = wallThickness * taperLength2 / stopThickness;
          //length2 = (zOffSet2 + totalLength);
          //width2 = length2 * stopThickness / taperLength2;
          diameterStart2 = outer ? _diameter :_diameter - taperWidth2*2;
          diameterEnd2 = _diameter;
          pipe(
            diameter1 = diameterStart2,
            diameter2 = diameterEnd2,
            length = length2,
            wallThickness1 = taperWidth2,
            wallThickness2 = 0);

        }
      }
   }
}