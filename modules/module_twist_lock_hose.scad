//generic twistlock hose adapter for osVAC and festool

use <thirdparty/ub.scad>
include <constants.scad>
use <modules_utility.scad>
use <modules_pipe.scad>

TwistLock_demo = false;
if(TwistLock_demo && $preview){
  $fn = 128;

  wallThickness = 5;
  facingDiameter = 50;

iscenario_taper = 0;
iscenario_wallthickness2 = 1;
scenarios = [
  [1, wallThickness/2], 
  [0.5, wallThickness], 
  [5, wallThickness/4]];
 
  for(iscenario = [0 : len(scenarios)-1])
  translate([65*iscenario,0,0])
  { 
    /*translate([0,-35,0])
    BayonetLugConnector(
      innerDiameter = facingDiameter-wallThickness,
      wallThickness1 = wallThickness/2,
      wallThickness2 = scenarios[iscenario][iscenario_wallthickness2],
      hoseEndTaper=scenarios[iscenario][iscenario_taper],
      outerLugTopBottomTaperz = [3, 0],
      help=true);*/
    translate([0,35,0])
    !BayonetSlotConnector(
      innerDiameter = facingDiameter,
      wallThickness = wallThickness,
      //innerSubWallDiameter = facingDiameter+wallThickness/2,
      help=true);
 }
 
 translate([300,0,0])
   BayonetLugConnector(
    outerDiameter1 = 50,
    outerDiameter2 = 55,
    wallThickness1 = 5,
    wallThickness2 = 2,
    hoseEndTaper=1,
    outerLugTopBottomTaperz = [3, 0],
    help=true);
    
 lug_leans = [45,25,15,10,5,0,-5,-10,-15,-25,-45];
 lug_size=[10,20];   
 
  for(ilug_lean = [0 : len(lug_leans)-1])
  translate([0,100 + 25*ilug_lean,0])
  union(){
    translate([0,0,0])
    rounded_lug(
      radius=facingDiameter/2,
      width=20,
      tilt = lug_leans[ilug_lean],
      side_radius=2,
      child_size=lug_size)
    rounded_rectangle(size=lug_size,
      r=2, chamfer_r = 1);
  
    translate([35,0,0])
    rounded_lug(
      radius=facingDiameter/2,
      width=20,
      tilt = lug_leans[ilug_lean],
      side_radius=2,
      side_radius_outer = false, 
      side_radius_inner = true, 
      child_size=lug_size)
    rounded_rectangle(
      size=lug_size,
      r_tl=2, chamfer_tl = 1,
      r_bl=2, chamfer_bl = 1);
    
    
    translate([40,0,0])
    rounded_lug(
      radius=facingDiameter/2,
      width=20,
      tilt = lug_leans[ilug_lean],
      side_radius = 2,
      side_radius_outer = true, 
      side_radius_inner = false, 
      child_size=lug_size)
    rounded_rectangle(
      size=lug_size,
      r_tr=2, chamfer_tr = 1,
      r_br=2, chamfer_br = 1);
  }
      
  rounded_rectangle(
    size=lug_size,
    r=2, chamfer_r = 1);

  translate([15,0,0])
  rounded_rectangle(
    size = [2, 9.8], r_tl = 2, chamfer_tl = 1);
     
   
  //semi_circle(r=10, chamfer_r=5);
}
/*
Mapping from lug → slot:

Lug parameter	Slot equivalent	Note
outerLugWidth	slotWidth	Usually outerLugWidth + clearance
lugLength	slotLength	Usually longer to allow entry/twist travel
outerLugHeight	slotDepth	Must clear lug radial projection
outerLugOffset	slotOffset	Matching axial position
lugCount	slotCount	Same count
lugStartAngle	slotStartAngle	Usually offset by entry angle
lockAngle	lockAngle	Same mating rotation
*/

module BayonetSlotConnector(
  innerDiameter,
  innerDiameter1,
  innerDiameter2,
  outerDiameter,
  outerDiameter1,
  outerDiameter2,
  wallThickness,
  wallThickness1,
  wallThickness2,
  length = 40,
  //innerSubWallDiameter = 42,
  //innerShaftLength = 30.5,
  slotCount = 3,                // Number of equally spaced slots.
  slotWidth = 10.2,             // Circumferential size of the slot (Usually outerLugWidth + clearance).
  slotAxialLength = 6.35,       // Axial size of the lug
  slotDepth = 2,                // Radial depth of the slot (Must clear lug radial projection)
  slotOffset = 3.7,             // Distance from connector face to the start (or center) of the slot.
  lockAngle = 35,               // Axial size of the lug
  lockBumpDepth = 1.6,          // Depth of lock bump that creates the lock when twisted
  hoseEndTaper = 1,
  help){
  //assert(is_num(innerSubWallDiameter) && innerSubWallDiameter > 0, "innerSubWallDiameter must be positive");
  assert(is_num(length) && length > 0, "length must be positive");
  assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be positive");
  assert(is_num(slotCount) && slotCount > 0, "slotCount must be positive");
  //assert(is_num(innerShaftLength) && innerShaftLength > 0, "innerShaftLength must be positive");
  assert(is_num(slotAxialLength) && slotAxialLength > 0, "slotAxialLength must be positive");
  assert(is_num(slotDepth) && slotDepth > 0, "slotDepth must be positive");
  assert(is_num(lockBumpDepth) && lockBumpDepth > 0, "lockBumpDepth must be positive");
  assert(is_num(slotWidth) && slotWidth > 0, "slotWidth must be positive");
  assert(is_num(lockAngle) && lockAngle > 0, "lockAngle must be positive");
  assert(is_num(lockBumpDepth) && is_num(slotDepth) && lockBumpDepth < slotDepth, "lockBumpDepth must be smaller than slotDepth");
  
    // dimentions 1 are the base, or connected end, dimentions 2 are the tip or free end.
  wt1 = is_undef(wallThickness) ? wallThickness1 : wallThickness;
  wt2 = is_undef(wallThickness) ? wallThickness2 : wallThickness;
  innerDiameters = let(
      id1 = is_undef(innerDiameter) ? innerDiameter1 : innerDiameter,
      id2 = is_undef(innerDiameter) ? innerDiameter2 : innerDiameter,

      od1 = is_undef(outerDiameter) ? outerDiameter1 : outerDiameter,
      od2 = is_undef(outerDiameter) ? outerDiameter2 : outerDiameter
    ) (is_undef(id1) || is_undef(id2)) ? [od1-wt1*2, od2-wt2*2] : [id1, id2];
  
  id1 = innerDiameters[0];
  id2 = innerDiameters[1];
  id = id1;
  od1 = innerDiameters[0]+wt1*2;
  od2 = innerDiameters[1]+wt2*2;
  od = od1;
  
  slotAxialHeight = length - slotOffset;
  slotFaceRadius = id/2+slotDepth;

  cutoutArcLength = lockAngle/180*PI*(id/2+slotDepth);

  difference(){
    //main pipe
    pipe(
      diameter1= id1,
      diameter2= id2,
      length = length,
      wallThickness1 = wt1,
      wallThickness2 = wt2,
      chamfer1 = [slotDepth,hoseEndTaper]);
  
    //Main inner body removal
    union(){
     translate([0,0,-fudgeFactor])
        union()
        for(i = [0:slotCount-1]){
          rotate([0,0,i*360/slotCount])
          union(){
            rounded_lug(
              radius=slotFaceRadius-slotDepth*2,//-slotAxialHeight*2,
              width=slotWidth,
              side_radius=2,
              side_radius_outer = true, 
              side_radius_inner = false, 
              child_size=[slotDepth*2,slotAxialHeight])
            rounded_rectangle(size=[slotDepth*2,slotAxialHeight],
              r=0, chamfer_r=0);

           lock_radius = slotDepth;
           rotate([0,0,lockAngle/2])
           translate([0,0,slotAxialHeight-slotAxialLength-fudgeFactor-lock_radius])
           rounded_lug(
              radius=slotFaceRadius-slotDepth*2,
              width=cutoutArcLength+slotWidth/2,
              side_radius=2,
              side_radius_outer = true, 
              side_radius_inner = false, 
              child_size=[slotDepth*2,slotAxialLength+lock_radius])
            rounded_rectangle(size=[slotDepth*2,slotAxialLength+lock_radius],
              r_tr=0, chamfer_tr = 0,
              r_br=lock_radius, chamfer_br = slotDepth/4);
        }
      }
    }
  }

  HelpTxt("BayonetSlotConnector",[
    "innerDiameter", innerDiameter,
    "innerDiameter1", innerDiameter1,
    "innerDiameter2", innerDiameter2,
    "outerDiameter", outerDiameter,
    "outerDiameter1", outerDiameter1,
    "outerDiameter2", outerDiameter2,
    "length", length,
    "wallThickness", wallThickness,
    "wallThickness1", wallThickness1,
    "wallThickness2", wallThickness2,
    //"innerTaperSize", innerTaperSize,
    //"innerWallDiameter", innerWallDiameter,
    //"finalShaftLength", finalShaftLength,
    //"innerShaftLength", innerShaftLength,
    "slotAxialLength", slotAxialLength,
    "slotCount", slotCount,
    "slotOffset", slotOffset,
    "slotAxialHeight", slotAxialHeight,
    "slotDepth", slotDepth,
    "cutoutArcLength",cutoutArcLength,
    "lockAngle",lockAngle,
    "lockBumpDepth", lockBumpDepth,
    "slotFaceRadius", slotFaceRadius,
    "slotWidth", slotWidth,
    "wt", [wt1, wt2],
    "id", [id1, id2],
    "od", [od1, od2]
    ],help);
}


module BayonetLugConnector(
  innerDiameter,
  innerDiameter1,
  innerDiameter2,
  outerDiameter,
  outerDiameter1,
  outerDiameter2,
  length = 40,
  wallThickness,
  wallThickness1,
  wallThickness2,
  centerSmallerWall = false,
  hoseEndTaper=0.7,
  
  lugCount = 3,                 // Number of equally spaced lugs.
  outerLugEnabled = false,
  outerLugWidth = 9.8,          // Circumferential size of the lug.
  outerLugHeight = 2,           // Radial projection from the base surface.
  outerLugAxialLength = 6.95,   // Axial size of the lug
  outerLugSideRadius,           // side radius of the lug
  outerLugOffset = 3.2,         // Distance from connector face to the start (or center) of the lug.
  outerLugTopBottomRadius,        // Top/bottom of lug radius
  outerLugTopBottomChamferRadius, // Top/bottom of lug champfer corner radius
  outerLugTopBottomTaperz,        // Tob bottom of lug taper
  innerLugEnabled = false,
  innerLugWidth = 9.8,          // Circumferential size of the lug.
  innerLugHeight = 2,           // Radial projection from the base surface.
  innerLugAxialLength = 6.95,   // Axial size of the lug
  innerLugSideRadius,           // side radius of the lug
  innerLugOffset = 3.2,         // Distance from connector face to the start (or center) of the lug.
  innerLugTopBottomRadius,        // Top/bottom of lug radius
  innerLugTopBottomChamferRadius, // Top/bottom of lug champfer corner radius
  innerLugTopBottomTaperz,        // Tob bottom of lug taper
  help
){
  assert(is_num(length) && length > 0, "length must be positive");
  assert((is_num(wallThickness) && wallThickness > 0) || (is_num(wallThickness1) && is_num(wallThickness2) && wallThickness1 > 0 && wallThickness2 > 0), "wallThickness must be positive");
  assert(is_num(hoseEndTaper) && hoseEndTaper > 0, "hoseEndTaper must be positive");
  assert(is_num(lugCount) && lugCount > 0, "lugCount must be positive");
  assert(is_num(outerLugAxialLength) && outerLugAxialLength > 0, "outerLugAxialLength must be positive");
  assert(is_num(outerLugOffset) && outerLugOffset > 0, "outerLugOffset must be positive");
  assert(is_undef(outerLugTopBottomRadius) || (is_list(outerLugTopBottomRadius)), "outerLugTopBottomRadius must be a list");
  assert(is_undef(outerLugTopBottomChamferRadius) || (is_list(outerLugTopBottomChamferRadius)), "outerLugTopBottomChamferRadius must be a list");
  assert(is_undef(outerLugTopBottomTaperz) || (is_list(outerLugTopBottomTaperz)), "outerLugTopBottomTaperz must be a list");
  assert(is_num(outerLugHeight) && outerLugHeight > 0, "outerLugHeight must be positive");
  assert(is_num(outerLugWidth) && outerLugWidth > 0, "outerLugWidth must be positive");
  assert(is_num(innerLugAxialLength) && innerLugAxialLength > 0, "innerLugAxialLength must be positive");
  assert(is_num(innerLugOffset) && innerLugOffset > 0, "innerLugOffset must be positive");
  assert(is_num(innerLugHeight) && innerLugHeight > 0, "innerLugHeight must be positive");
  assert(is_num(innerLugWidth) && innerLugWidth > 0, "innerLugWidth must be positive");
  assert(is_undef(innerLugTopBottomRadius) || (is_list(innerLugTopBottomRadius)), "innerLugTopBottomRadius must be a list");
  assert(is_undef(innerLugTopBottomChamferRadius) || (is_list(innerLugTopBottomChamferRadius)), "innerLugTopBottomChamferRadius must be a list");
  assert(is_undef(innerLugTopBottomTaperz) || (is_list(innerLugTopBottomTaperz)), "innerLugTopBottomTaperz must be a list");

  // dimentions 1 are the base, or connected end, dimentions 2 are the tip or free end.
  wt1 = is_undef(wallThickness) ? wallThickness1 : wallThickness;
  wt2 = is_undef(wallThickness) ? wallThickness2 : wallThickness;
  innerDiameters = let(
      id1 = is_undef(innerDiameter) ? innerDiameter1 : innerDiameter,
      id2 = is_undef(innerDiameter) ? innerDiameter2 : innerDiameter,

      od1 = is_undef(outerDiameter) ? outerDiameter1 : outerDiameter,
      od2 = is_undef(outerDiameter) ? outerDiameter2 : outerDiameter
    ) (is_undef(id1) || is_undef(id2)) ? [od1-wt1*2, od2-wt2*2] : [id1, id2];
  
  id1 = innerDiameters[0];
  id2 = innerDiameters[1];
  id = id1;
  od1 = innerDiameters[0]+wt1*2;
  od2 = innerDiameters[1]+wt2*2;
  od = od1;
  
  //main pipe
  pipe(
    diameter1= id1,
    diameter2= id2,
    length = length,
    wallThickness1 = wt1,
    wallThickness2 = wt2,
    chamfer1 = [hoseEndTaper,hoseEndTaper],
    centerSmallerWall = centerSmallerWall);

  //Correction for tapered pipes.
  //tan(x) = o / a;

  outer_angle = (od1 > od2) 
    ? 90 - atan(length/(abs(od1-od2)/2))
    : 0 - atan((abs(od2-od1)/2)/length);
    
 inner_angle = (od1 > od2) 
    ? 90 - atan(length/(abs(od1-od2)/2))
    : 0 - atan((abs(od2-od1)/2)/length);

  padding_patch = min(wt1,wt2)/2; //Lazy hack to save trig
  
  if(outerLugEnabled)
    BayonetOuterLugs(
      outerDiameter = od1-padding_patch*2,
      tilt=outer_angle,
      lugCount = lugCount,
      outerLugWidth = outerLugWidth,
      outerLugHeight = outerLugHeight+padding_patch,
      outerLugAxialLength = outerLugAxialLength,
      outerLugSideRadius = outerLugSideRadius,
      outerLugOffset = outerLugOffset,
      outerLugTopBottomRadius = outerLugTopBottomRadius,
      outerLugTopBottomChamferRadius = outerLugTopBottomChamferRadius,
      outerLugTopBottomTaperz = outerLugTopBottomTaperz,
      debug=help);

  if(innerLugEnabled)
    BayonetInnerLugs(
      innerDiameter = id+padding_patch*2,
      tilt=inner_angle,
      lugCount = lugCount,
      innerLugWidth = innerLugWidth,
      innerLugHeight = innerLugHeight+padding_patch,
      innerLugSideRadius = innerLugSideRadius,
      innerLugAxialLength = innerLugAxialLength,
      innerLugOffset = innerLugOffset,
      innerLugTopBottomRadius = innerLugTopBottomRadius,
      innerLugTopBottomChamferRadius = innerLugTopBottomChamferRadius,
      innerLugTopBottomTaperz = innerLugTopBottomTaperz,
      debug=help);

  HelpTxt("BayonetLugConnector",[
    "innerDiameter", innerDiameter,
    "innerDiameter1", innerDiameter1,
    "innerDiameter2", innerDiameter2,
    "outerDiameter", outerDiameter,
    "outerDiameter1", outerDiameter1,
    "outerDiameter2", outerDiameter2,
    "length", length,
    "wallThickness", wallThickness,
    "wallThickness1", wallThickness1,
    "wallThickness2", wallThickness2,
    "outerDiameter", outerDiameter,
    "hoseEndTaper", hoseEndTaper,
    "outerLugEnabled", outerLugEnabled,
    "outerLugOffset", outerLugOffset,
    "outerLugHeight", outerLugHeight,
    "outerLugWidth", outerLugWidth,
    "innerLugEnabled", innerLugEnabled,
    "innerLugOffset", innerLugOffset,
    "innerLugHeight", innerLugHeight,
    "innerLugWidth", innerLugWidth,
    "wt", [wt1, wt2],
    "id", [id1, id2],
    "od", [od1, od2]
    ], help);
}

module BayonetOuterLugs(
  outerDiameter,
  tilt,
  lugCount,
  outerLugWidth,
  outerLugHeight,
  outerLugAxialLength,
  outerLugSideRadius,
  outerLugOffset,
  outerLugTopBottomRadius,
  outerLugTopBottomChamferRadius,
  outerLugTopBottomTaperz,
  debug = false
){
  lugSideRadius = max(min((is_undef(outerLugSideRadius) ? outerLugWidth/2 :outerLugSideRadius), outerLugWidth/2), 0);
  lugTopBottomRadius = is_undef(outerLugTopBottomRadius) ?  [outerLugWidth, outerLugWidth] : outerLugTopBottomRadius;
  lugTopBottomChamferRadius = is_undef(outerLugTopBottomChamferRadius) ?  [outerLugWidth/4, outerLugWidth/4] : outerLugTopBottomChamferRadius;
  lugArcRadius = outerDiameter/2 + outerLugHeight/2;
  lugAngle = outerLugWidth * 180 / (PI * (lugArcRadius*0.9));

  if(debug || true){
    echo("BayonetOuterLugs",
      outerDiameter=outerDiameter,
      lugCount=lugCount,
      outerLugWidth=outerLugWidth,
      outerLugHeight=outerLugHeight,
      outerLugAxialLength=outerLugAxialLength,
      outerLugOffset=outerLugOffset,
      outerLugSideRadius=outerLugSideRadius,
      lugTopBottomRadius=lugTopBottomRadius,
      outerLugTopBottomRadius=outerLugTopBottomRadius,
      outerLugTopBottomChamferRadius=outerLugTopBottomChamferRadius,
      outerLugTopBottomTaperz=outerLugTopBottomTaperz,
      lugSideRadius=lugSideRadius,
      lugTopBottomRadius=lugTopBottomRadius,
      lugTopBottomChamferRadius=lugTopBottomChamferRadius,
      lugArcRadius=lugArcRadius,
      lugAngle=lugAngle);
  }
  translate([0,0,outerLugOffset])
  difference(){
    union()
    for(i = [0:lugCount-1])
      rotate([0,0,i*360/lugCount])
      {
        lug_size=[outerLugHeight, outerLugAxialLength]; 
        rounded_lug(
          radius=outerDiameter/2,
          width=outerLugWidth,
          tilt=tilt,
          side_radius=lugSideRadius,
          side_radius_outer = true, 
          side_radius_inner = false, 
          child_size=lug_size)
        rounded_rectangle(
          size=lug_size,
          r_tr=lugTopBottomRadius[0], chamfer_tr = lugTopBottomChamferRadius[0],
          r_br=lugTopBottomRadius[1], chamfer_br = lugTopBottomChamferRadius[1]);
          }
    if(!is_undef(outerLugTopBottomTaperz)){
      pad_taper = 1; //when we angle the walls the taper does not match, I made it 1 to save doing the math
      if(outerLugTopBottomTaperz[0] > 0){
        pipe(
          diameter1 = outerDiameter+outerLugHeight*2+fudgeFactor*2+pad_taper*2,
          diameter2 = outerDiameter-fudgeFactor*2-pad_taper*2,
          length = outerLugTopBottomTaperz[0]+pad_taper*2,
          wallThickness1 = 0,
          wallThickness2 = outerLugHeight+fudgeFactor+pad_taper*2,
          zPosition = outerLugAxialLength - outerLugTopBottomTaperz[0]+fudgeFactor-pad_taper);
      }
      if(outerLugTopBottomTaperz[1] > 0){
        pipe(
          diameter1 = outerDiameter-fudgeFactor*2-pad_taper*2,
          diameter2 = outerDiameter+outerLugHeight*2+fudgeFactor*2+pad_taper*2,
          length = outerLugTopBottomTaperz[1]+pad_taper*2,
          wallThickness1 = outerLugHeight+fudgeFactor+pad_taper*2,
          wallThickness2 = 0,
          zPosition = fudgeFactor-pad_taper);
      }
    }
  }
}

module BayonetOuterLugArc(
  outerDiameter,
  outerLugHeight,
  outerLugWidth,
  outerLugAxialLength,
  outerLugRadius,
  lugAngle,
  debug = false
){
  baseRadius = outerDiameter/2;
  lugRadius = min(
    is_undef(outerLugRadius) ? outerLugHeight : outerLugRadius,
    outerLugHeight/2-fudgeFactor,
    outerLugAxialLength/2-fudgeFactor);

  if(debug){
    echo("BayonetOuterLugArc",
      outerDiameter=outerDiameter,
      outerLugHeight=outerLugHeight,
      outerLugWidth=outerLugWidth,
      outerLugAxialLength=outerLugAxialLength,
      outerLugRadius=outerLugRadius,
      lugAngle=lugAngle,
      baseRadius=baseRadius,
      lugRadius=lugRadius);
  }

  intersection() {
    translate([outerDiameter/2-outerLugHeight,-outerLugWidth/2,-fudgeFactor])
    hull(){
      rounded_cube(
        size=[outerLugHeight,outerLugWidth,outerLugAxialLength],
        topRadius = 0,
        bottomRadius = outerLugHeight/2,
        sideRadius = outerLugHeight/2);

      rounded_cube(
        size=[outerLugHeight,outerLugWidth,outerLugAxialLength],
        topRadius = 0,
        bottomRadius = outerLugHeight/2,
        sideRadius = outerLugHeight);
    }

    rotate([0,0,-lugAngle/2])
    rotate_extrude(angle=lugAngle)
      translate([baseRadius,0])
      hull(){
        translate([lugRadius, lugRadius])
          circle(r=lugRadius);
        translate([0, lugRadius])
          circle(r=lugRadius);
        translate([lugRadius, outerLugAxialLength])
          circle(r=lugRadius);
        translate([0, outerLugAxialLength])
          circle(r=lugRadius);
      }
  }
}

module BayonetInnerLugs(
  innerDiameter,
  tilt=0,
  lugCount,
  innerLugWidth,
  innerLugHeight,
  innerLugAxialLength,
  innerLugSideRadius,
  innerLugOffset,
  innerLugTopBottomRadius,
  innerLugTopBottomChamferRadius,
  innerLugTopBottomTaperz,
  debug = false
){
  lugSideRadius = max(min((is_undef(innerLugSideRadius) ? innerLugWidth/2 : innerLugSideRadius), innerLugWidth/2), 0);
  lugTopBottomRadius = is_undef(innerLugTopBottomRadius) ?  [innerLugWidth, innerLugWidth] : innerLugRadius;
  lugTopBottomChamferRadius = is_undef(innerLugTopBottomChamferRadius) ?  [innerLugWidth/4, innerLugWidth/4] : innerLugTopBottomChamferRadius;
  lugArcRadius = innerDiameter/2 + innerLugHeight/2;
  lugAngle = innerLugWidth * 180 / (PI * (lugArcRadius*0.9));

  if(debug){
    echo("BayonetInnerLugs",
      innerDiameter=innerDiameter,
      lugCount=lugCount,

      innerLugWidth=innerLugWidth,
      innerLugHeight=innerLugHeight,
      innerLugAxialLength=innerLugAxialLength,
      innerLugOffset=innerLugOffset,
      innerLugSideRadius=innerLugSideRadius,
      innerLugTopBottomRadius=innerLugTopBottomRadius,
      innerLugTopBottomChamferRadius=innerLugTopBottomChamferRadius,
      innerLugTopBottomTaperz=innerLugTopBottomTaperz,
      lugTopBottomRadius=lugTopBottomRadius,
      lugTopBottomChamferRadius=lugTopBottomChamferRadius,
      lugArcRadius=lugArcRadius,
      lugAngle=lugAngle);
  }

  lug_version = 2;
    
  translate([0,0,innerLugOffset])
  difference(){
    union()
    for(i = [0:lugCount-1])
      rotate([0,0,i*360/lugCount])
      {
       if(lug_version == 1)
        BayonetInnerLugArc(
          innerDiameter = innerDiameter,
          innerLugHeight = innerLugHeight,
          innerLugWidth = innerLugWidth,
          innerLugAxialLength = innerLugAxialLength,
          innerLugTopTaperz = innerLugTopTaperz,
          innerLugRadius = innerLugRadius,
          lugAngle = lugAngle,
          debug=debug);
        if(lug_version == 2){
          lug_size=[innerLugHeight, innerLugAxialLength]; 
          rounded_lug(
            radius=innerDiameter/2,
            width=innerLugWidth,
            tilt=tilt,
            side_radius=lugSideRadius,
            side_radius_outer = false, 
            side_radius_inner = true, 
            child_size=lug_size)
          rounded_rectangle(
            size=lug_size,
            r_tl=lugTopBottomRadius[0], chamfer_tl = lugTopBottomChamferRadius[0],
            r_bl=lugTopBottomRadius[1], chamfer_bl = lugTopBottomChamferRadius[1]);
            }
        }
        
       if(!is_undef(innerLugTopTaperz)){
          pad_taper = 1; //when we angle the walls the taper does not match, I made it 1 to save doing the math
          if(innerLugTopTaperz[0] > 0){
          pipe(
            diameter1 = innerDiameter-innerLugHeight*2-fudgeFactor,
            diameter2 = innerDiameter-innerLugHeight*2-fudgeFactor,
            length = innerLugTopTaperz,
            wallThickness1 = 0,
            wallThickness2 = innerLugHeight+fudgeFactor,
            zPosition = innerLugAxialLength - innerLugTopTaperz);
          }
          if(innerLugTopTaperz[1] > 0){
          
          }

          }
  }
}

module BayonetInnerLugArc(
  innerDiameter,
  innerLugHeight,
  innerLugWidth,
  innerLugAxialLength,
  innerLugTopTaperz,
  innerLugRadius,
  lugAngle,
  debug = false
){
  baseRadius = innerDiameter/2;
  lugRadius = min(
    innerLugRadius,
    innerLugHeight/2-fudgeFactor,
    innerLugAxialLength/2-fudgeFactor);

  if(debug){
    echo("BayonetInnerLugArc",
      innerDiameter=innerDiameter,
      innerLugHeight=innerLugHeight,
      innerLugWidth=innerLugWidth,
      innerLugAxialLength=innerLugAxialLength,
      innerLugTopTaperz=innerLugTopTaperz,
      innerLugRadius=innerLugRadius,
      lugAngle=lugAngle,
      baseRadius=baseRadius,
      lugRadius=lugRadius,
      innerLugHeight12 =       innerLugHeight*1.2,
      innerlugRadus = baseRadius-innerLugHeight*2);
  }

  
  intersection() {
    //sizing of the inner lug is not correct.
    //innerLugHeight*1.2this is not correct at all, but its matches
    translate([innerDiameter/2-innerLugHeight*1.2,-innerLugWidth/2,-fudgeFactor])
    hull(){
      translate([2,0,0])
      rounded_cube(
        size=[innerLugHeight,innerLugWidth,innerLugAxialLength],
        topRadius = 0,
        bottomRadius = innerLugHeight/2,
        sideRadius = innerLugHeight/2);
      rounded_cube(
        size=[innerLugHeight,innerLugWidth,innerLugAxialLength],
        topRadius = 0,
        bottomRadius = innerLugHeight/2,
        sideRadius = innerLugHeight);
    }

    rotate([0,0,-lugAngle/2])
    rotate_extrude(angle=lugAngle)
      translate([baseRadius-lugRadius,0])
      hull(){
        translate([lugRadius, lugRadius])
          circle(r=lugRadius);
        translate([0, lugRadius])
          circle(r=lugRadius);
        translate([lugRadius, innerLugAxialLength])
          circle(r=lugRadius);
        translate([0, innerLugAxialLength])
          circle(r=lugRadius);
      }
  }
}

//This has a bug that the side radius is added to the angle
module rounded_lug(
  radius, 
  angle, 
  width,
  tilt = 0,
  side_radius,
  side_radius_outer = true, 
  side_radius_inner = true, 
  child_size){
  
  side_radius = min(side_radius, child_size.x/2);
  
  asin_input = (width - side_radius*2) / (2 * radius);
  assert(asin_input >= -1 && asin_input <= 1,
    str("rounded_lug asin input out of range [-1,1]: ", asin_input,
      " (radius=", radius,
      ", width=", width,
      ", side_radius=", side_radius,
      ")"));

  angle = 2 * asin(asin_input);

  //body
  rotate([0,0,-angle/2])
  rotate_extrude(angle=angle)
  translate([radius,0,0])
  rotate(tilt)
  translate(side_radius_outer ? [0,0,0] : [-child_size.x,0,0])
  children();

  rotate([0,0,-angle/2])
  translate([radius,0,0])
  rotate([0,0,-90])
  rotate([tilt,0,0])
  translate(side_radius_outer ? [0,0,0] : [0,-child_size.x,0])
  rounded_lug_end(angle=angle, side_radius=side_radius, side_radius_inner=side_radius_inner, side_radius_outer=side_radius_outer, child_size=child_size)
    children();
  /*
  difference(){
    translate([-child_size.x+side_radius,0,0])
    children();

    translate([-child_size.x,0,0])
    square(child_size+[0.01,0.01]);
  }*/

  rotate([0,0,angle/2])
  translate([radius,0,0])
  mirror([0,1,0])
  rotate([0,0,-90])
  rotate([tilt,0,0])
  translate(side_radius_outer ? [0,0,0] : [0,-child_size.x,0])
  rounded_lug_end(angle=angle, side_radius=side_radius, side_radius_inner=side_radius_inner, side_radius_outer=side_radius_outer, child_size=child_size)
  
    children();
  /*
  difference(){
    translate([-child_size.x+side_radius,0,0])
    children();

    translate([-child_size.x,0,0])
    square(child_size+[0.01,0.01]);
  }*/
}

module rounded_lug_end(angle, side_radius, side_radius_inner, side_radius_outer, child_size){
  
  center_width = child_size.x-(side_radius_outer ? side_radius : 0)-(side_radius_inner ? side_radius : 0);

  //echo("rounded_lug_end" , side_radius_inner=side_radius_inner, side_radius_outer=side_radius_outer, center_width=center_width);
  
  fudgeFactor = 0.01;
  hull(){
    //Outer
    //Back extension to prevent glitching
    translate([-fudgeFactor,child_size.x-side_radius])
    rotate([90,0,90])
    linear_extrude(h=fudgeFactor)
      if(side_radius_outer){
        difference(){
          translate([-child_size.x+side_radius,0,0])
          children();

          translate([-child_size.x,0,0])
          square(child_size+[0.01,0.01]);
        }
      } else {
        square([side_radius,child_size.y]);
      }
      
    
    if(side_radius_outer) {
      echo("side_radius_outer", child_size);
      translate([0,child_size.x-side_radius])
      rotate_extrude(angle=90)
        difference(){
          translate([-child_size.x+side_radius,0,0])
          children();

          translate([-child_size.x,-0.01,0])
          square(child_size+[0.01,0.02]);
        }
    }
    
    //inner
    translate([0,side_radius])
    rotate([0,0,-90])
    rotate([90,0,00])
    linear_extrude(h=fudgeFactor)
      if(side_radius_inner){
        difference(){
          translate([side_radius,0,0])
          rotate([0,180])
          children();

          translate([-child_size.x,0,0])
          square(child_size+[0.01,0.01]);
        }
      } else {
        square([side_radius,child_size.y]);
      }

    //Back extension to prevent glitching
    if(side_radius_inner) {
      translate([0,side_radius])
      rotate_extrude(angle=-90)
        difference(){
          translate([side_radius,0,0])
          rotate([0,180])
          children();

          translate([-child_size.x,0,0])
          square(child_size+[0.01,0.01]);
        }
    }
    
    //center
    translate([0,center_width+(side_radius_inner ? side_radius : 0)])
    rotate([90,0,0])
    linear_extrude(h=center_width)
      if(side_radius_outer){
        difference(){
          translate([-child_size.x+side_radius,0,0])
          children();

          translate([-child_size.x,0,0])
          square(child_size+[0.01,0.01]);
        }
      } else {
        difference(){
          translate([side_radius,0,0])
          rotate([0,180])
          children();

          translate([-child_size.x,0,0])
          square(child_size+[0.01,0.01]);
        }
      }
  }
}

module rounded_rectangle(
  size=[1,2],
  r = 0, chamfer_r,
  r_tl,
  chamfer_tl,
  r_tr,
  chamfer_tr,
  r_bl,
  chamfer_bl,
  r_br,
  chamfer_br){

  function calc_radius(corner_r, r, size) = 
    max(min(is_undef(corner_r) ? r : corner_r, size.x/2, size.y/2), 0.001);
    
  r_tl = calc_radius(corner_r = r_tl, r, size);
  r_tr = calc_radius(corner_r = r_tr, r, size);
  r_bl = calc_radius(corner_r = r_bl, r, size);
  r_br = calc_radius(corner_r = r_br, r, size);
  
  function calc_chamfer(corner_chamfer, chamfer_r, corner_r) = 
    let(chamfer = is_undef(corner_chamfer) ? chamfer_r : corner_chamfer)
    is_undef(chamfer) || chamfer < 0 ? undef : 
    max(min(chamfer, corner_r/2), 0.001);
  
  chamfer_tl = calc_chamfer(corner_chamfer = chamfer_tl, chamfer_r, r_tl);
  chamfer_tr = calc_chamfer(corner_chamfer = chamfer_tr, chamfer_r, r_tr);
  chamfer_bl = calc_chamfer(corner_chamfer = chamfer_bl, chamfer_r, r_bl);
  chamfer_br = calc_chamfer(corner_chamfer = chamfer_br, chamfer_r, r_br);

  /*echo("rounded_rectangle", 
    size=size,
    r=r,
    chamfer_r=chamfer_r,
    r_tl = r_tl,
    r_tr = r_tr,
    r_bl = r_bl,
    r_br = r_br,
    chamfer_tl = chamfer_tl,
    chamfer_tr = chamfer_tr,
    chamfer_bl = chamfer_bl,
    chamfer_br =chamfer_br);*/

  hull(){
    translate([r_bl, r_bl])
      semi_circle(r=r_bl, chamfer_r= chamfer_bl);
    translate([size.x-r_br, r_br])
      rotate(90)
      semi_circle(r=r_br, chamfer_r= chamfer_br);
    translate([r_tl, size.y-r_tl])
      rotate(270)
      semi_circle(r=r_tl, chamfer_r= chamfer_tl);
    translate([size.x-r_tr, size.y-r_tr])
      rotate(180)
      semi_circle(r=r_tr, chamfer_r= chamfer_tr);
  }
}

module semi_circle(r, chamfer_r){
  difference(){
    if(is_undef(chamfer_r) || chamfer_r < 0){
      circle(r=r);
    } else {
      hull(){
        corner_square_size = min(r/2,chamfer_r/2);
        translate([-corner_square_size,-corner_square_size])
        square(size=[corner_square_size,corner_square_size]) ;
       translate([-r+chamfer_r,0,0])
        circle(r=chamfer_r);
       translate([0,-r+chamfer_r,0])
        circle(r=chamfer_r);
      }
    }
    translate([0,-r,0])
      square(size=[r,r*2]);
    translate([-r,0,0])
      square(size=[r*2,r]);
  }
}