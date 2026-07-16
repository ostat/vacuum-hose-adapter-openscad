//version 1
rounded_shapes_demo = false;


if(rounded_shapes_demo && $preview){
  $fn = 64;

  angles = [360, 270, 210, 180, 90];
  support_reductions = [[0,0], [-1,0], [0,-1], [-1,-1]];
  
  translate([550, 0, 0]) 
  CubeWithRoundedCorner(size = [50, 50, 50], cornerRadius = 5);

  translate([650,0,0])
  union() {
    rounded_cube(
      size = [40,30,20],
      //cornerRadius=2,
      topRadius = 0, bottomRadius = 2, sideRadius = 4,
      supportReduction_z=[-1,0],
      $fn=128);
      
    translate([0,150,0])
    rounded_cube(
      size = [30,30,20],
      //cornerRadius=2,
      topRadius = 5, bottomRadius = 2, sideRadius = 5,
      supportReduction_x = [-1, -1],
      supportReduction_y = [-1, 0],
      supportReduction_z = [-1, 0],
      $fn=128);
    
    for(iSR_x = [0:1:len(support_reductions)-1])
    for(iSR_y = [0:1:len(support_reductions)-1])
    for(iSR_z = [0:1:len(support_reductions)-1])
    translate([200+50*iSR_x,50*iSR_y,50*iSR_z])
    *rounded_cube(
      size = [30,30,20],
      cornerRadius=5,
      supportReduction_x = support_reductions[iSR_x], 
      supportReduction_y = support_reductions[iSR_y], 
      supportReduction_z = support_reductions[iSR_z], 
      $fn=128);
      
    for(iSR_x = [0:1:len(support_reductions)-1])
    for(iSR_y = [0:1:len(support_reductions)-1])
    for(iSR_z = [0:1:len(support_reductions)-1])
    translate([600+50*iSR_x,50*iSR_y,50*iSR_z])
    *rounded_cube_v2(
      size = [30,30,20],
      cornerRadius=5,
      supportReduction_x = support_reductions[iSR_x], 
      supportReduction_y = support_reductions[iSR_y], 
      supportReduction_z = support_reductions[iSR_z], 
      $fn=128);
   }
   

  for(iAngle = [0:1:len(angles)-1])
  for(iSR = [0:1:len(support_reductions)-1])
  {
    translate([50*iSR,50*iAngle,0])
    roundedDisk(
      r=20, 
      roundedr=4, 
      half=0,
      angle=angles[iAngle],
      supportReduction = support_reductions[iSR]
      );

    translate([50*iSR,250+50*iAngle,0])
    roundedDisk(
      r=20, 
      roundedr=4, 
      half=1,
      angle=angles[iAngle],
      supportReduction = support_reductions[iSR]
      );

    translate([50*iSR,500+50*iAngle,0])
    roundedDisk(
      r=20, 
      roundedr=4, 
      half=-1,
      angle=angles[iAngle],
      supportReduction = support_reductions[iSR]
      );
      
    translate([250+50*iSR,50*iAngle,0])
    roundedCylinder(
      h = 50,
      r = 20, 
      roundedr = 4, 
      angle = angles[iAngle],
      supportReduction = support_reductions[iSR]
      );
      
      // add test case for Remove inner half so we dont get error when r<roundedr*2
  }
     
  translate([500, 0, 0]) 
    rounded_taper(
      upperRadius=35,
      upperLength=20,
      lowerRadius=10,
      lowerLength=20,
      transitionLength=15,
      cornerRadius=5,
      roundedUpper=true,
      roundedLower=true,
      alignTop = false);
}

module simple_rounded_cube(dimentions = [5,5,5])
{
  positions=[
     [0, 0, 0]
    ,[dimentions[0], 0, 0]
    ,[dimentions[0], dimentions[1], 0]
    ,[0, dimentions[1], 0]
    ];
    
  intersection()
  {
    hull(){
      for (x =[0:1:len(positions)-1])
      {
        translate(positions[x]) 
          sphere(dimentions[2]);
      }
    }
    
    translate([-dimentions[2],-dimentions[2],0]) 
      cube(dimentions*2);
  }
}

module rounded_cube_v2(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0 ,
  centerxy = false,
  supportReduction_x = [0,0],
  supportReduction_y = [0,0],
  supportReduction_z = [0,0])
{
  minSideRadius = 0.01;
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];

  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = max(minSideRadius, sideRadius > 0 ? sideRadius : cornerRadius);

  supportReduction_z = is_num(supportReduction_z) ? [supportReduction_z, supportReduction_z] : supportReduction_z;
  supportReduction_x = is_num(supportReduction_x) ? [supportReduction_x, supportReduction_x] : supportReduction_x;
  supportReduction_y = is_num(supportReduction_y) ? [supportReduction_y, supportReduction_y] : supportReduction_y;

  assert(topRadius <= sideRadius, str("topRadius must be less than or equal to sideRadius. topRadius:", topRadius, " sideRadius:", sideRadius));
  assert(bottomRadius <= sideRadius, str("bottomRadius must be less than or equal to sideRadius. bottomRadius:", bottomRadius, " sideRadius:", sideRadius));

  //Support reduction should move in to roundedCylinder
  function auto_support_reduction(supportReduction, corner_radius, center_radius) =
    let(center_radius = is_num(center_radius) ? center_radius : corner_radius,
      sr = (supportReduction == -1 ? corner_radius/2 : supportReduction)+max(0,center_radius-corner_radius))
    min(sr, center_radius);

  //z needs to account for the side radius as the side radius can be greater than the top and bottom radius.
  supReduction_z = [auto_support_reduction(supportReduction_z[0], bottomRadius, sideRadius), auto_support_reduction(supportReduction_z[1], topRadius, sideRadius)];
  supReduction_x = [auto_support_reduction(supportReduction_x[0], sideRadius), auto_support_reduction(supportReduction_x[1], sideRadius)];
  supReduction_y = [auto_support_reduction(supportReduction_y[0], sideRadius), auto_support_reduction(supportReduction_y[1], sideRadius)];

  //x and y need and offset to account for the top and bottom radius
  supReduction_x_offset = [auto_support_reduction(supportReduction_x[0], bottomRadius), auto_support_reduction(supportReduction_x[1], topRadius)];
  supReduction_y_offset = [auto_support_reduction(supportReduction_y[0], bottomRadius), auto_support_reduction(supportReduction_y[1], topRadius)];

  positions=[
     [[sideRadius                         ,sideRadius]                        ,[0,0],[0,0,180]]
    ,[[max(size.x-sideRadius, sideRadius) ,sideRadius]                        ,[1,0],[0,0,270]]
    ,[[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)],[1,1],[0,0,0]]
    ,[[sideRadius                         ,max(size.y-sideRadius, sideRadius)],[0,1],[0,0,90]]
    ];

  translate(centerxy ? [-size.x/2,-size.y/2,0] : [0,0,0])
  hull()
  {
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i][0])
        union(){
        rotate(positions[i][2])
        roundedCylinder(
          h=size.z,
          r=sideRadius,
          roundedr2=topRadius,
          roundedr1=bottomRadius, 
          supportReduction=supReduction_z,
          angle=90);

        if(supReduction_x[0] > 0 && positions[i][1].x ==0){
          if(topRadius ==0 && bottomRadius == 0)
          {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[0]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[0]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
            //top
            translate([0,0,size.z-supReduction_x[0]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
          }
        }

        if(supReduction_x[1] > 0 && positions[i][1].x ==1){
         if(topRadius == 0 && bottomRadius == 0)
         {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[1]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[1]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
            //top
            translate([0,0,size.z-supReduction_x[1]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
          }
        }

        if(supReduction_y[0] > 0 && positions[i][1].y == 0){
            //bottom
            translate([0,0,supReduction_y[0]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
            //top
            translate([0,0,size.z-supReduction_y[0]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
        }
        if(supReduction_y[1] > 0 && positions[i][1].y == 1){
            //bottom
            translate([0,0,supReduction_y[1]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
            //top
            translate([0,0,size.z-supReduction_y[1]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
        }
      }
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
module rounded_cube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0 ,
  centerxy = false,
  supportReduction_x = [0,0],
  supportReduction_y = [0,0],
  supportReduction_z = [0,0])
{
  minSideRadius = 0.01;
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];

  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = max(minSideRadius, sideRadius > 0 ? sideRadius : cornerRadius);

  supportReduction_z = is_num(supportReduction_z) ? [supportReduction_z, supportReduction_z] : supportReduction_z;
  supportReduction_x = is_num(supportReduction_x) ? [supportReduction_x, supportReduction_x] : supportReduction_x;
  supportReduction_y = is_num(supportReduction_y) ? [supportReduction_y, supportReduction_y] : supportReduction_y;

  assert(topRadius <= sideRadius, str("topRadius must be less than or equal to sideRadius. topRadius:", topRadius, " sideRadius:", sideRadius));
  assert(bottomRadius <= sideRadius, str("bottomRadius must be less than or equal to sideRadius. bottomRadius:", bottomRadius, " sideRadius:", sideRadius));

  //Support reduction should move in to roundedCylinder
  function auto_support_reduction(supportReduction, corner_radius, center_radius) =
    let(center_radius = is_num(center_radius) ? center_radius : corner_radius,
      sr = (supportReduction == -1 ? corner_radius/2 : supportReduction)+max(0,center_radius-corner_radius))
    min(sr, center_radius);

  //z needs to account for the side radius as the side radius can be greater than the top and bottom radius.
  supReduction_z = [auto_support_reduction(supportReduction_z[0], bottomRadius, sideRadius), auto_support_reduction(supportReduction_z[1], topRadius, sideRadius)];
  supReduction_x = [auto_support_reduction(supportReduction_x[0], sideRadius), auto_support_reduction(supportReduction_x[1], sideRadius)];
  supReduction_y = [auto_support_reduction(supportReduction_y[0], sideRadius), auto_support_reduction(supportReduction_y[1], sideRadius)];

  //x and y need and offset to account for the top and bottom radius
  //TODO the offsets are [x and y] but are treated at top and bottom
  supReduction_x_offset = [auto_support_reduction(supportReduction_x[0], bottomRadius), auto_support_reduction(supportReduction_x[1], topRadius)];
  supReduction_y_offset = [auto_support_reduction(supportReduction_y[0], bottomRadius), auto_support_reduction(supportReduction_y[1], topRadius)];

  echo("rounded_cube", supReduction_x=supReduction_x, supReduction_y=supReduction_y, supReduction_z=supReduction_z, supReduction_x_offset=supReduction_x_offset, supReduction_y_offset=supReduction_y_offset);
  
  positions=[
     [[sideRadius                         ,sideRadius]                        ,[0,0],[0,0,180]]
    ,[[max(size.x-sideRadius, sideRadius) ,sideRadius]                        ,[1,0],[0,0,270]]
    ,[[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)],[1,1],[0,0,0]]
    ,[[sideRadius                         ,max(size.y-sideRadius, sideRadius)],[0,1],[0,0,90]]
    ];

  translate(centerxy ? [-size.x/2,-size.y/2,0] : [0,0,0])
  hull()
  {
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i][0])
        union(){
        rotate(positions[i][2])
        roundedCylinder(
          h=size.z,
          r=sideRadius,
          roundedr2=topRadius,
          roundedr1=bottomRadius, 
          angle=90);
        if(supReduction_z[1] > 0)
          translate([0,0,size.z-topRadius])
          cylinder(h=topRadius, r=supReduction_z[1]);

        if(supReduction_z[0] > 0)
          cylinder(h=bottomRadius, r=supReduction_z[0]);

        if(supReduction_x[0] > 0 && positions[i][1].x ==0){
          if(topRadius ==0 && bottomRadius == 0)
          {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[0]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[0]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
            //top
            #translate([0,0,size.z-supReduction_x[0]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
          }
        }

        if(supReduction_x[1] > 0 && positions[i][1].x ==1){
         if(topRadius == 0 && bottomRadius == 0)
         {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[1]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[1]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
            //top
            #translate([0,0,size.z-supReduction_x[1]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
          }
        }

        if(supReduction_y[0] > 0 && positions[i][1].y == 0){
            //bottom
            translate([0,0,supReduction_y[0]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
            //top
            #translate([0,0,size.z-supReduction_y[0]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
        }
        if(supReduction_y[1] > 0 && positions[i][1].y == 1){
            //bottom
            translate([0,0,supReduction_y[1]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
            //top
            translate([0,0,size.z-supReduction_y[1]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
        }
      }
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
module roundedCubeV1(
  x,
  y,
  z,
  cornerRadius)
{
  positions=[
     [cornerRadius                      ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ,[cornerRadius                      ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ];

  hull(){
    for (x =[0:1:len(positions)-1])
    {
      translate(positions[x])
        sphere(cornerRadius);
      translate(positions[x])
        cylinder(z-cornerRadius,r=cornerRadius);
    }
  }
}

//Creates a cube with a single rounded corner.
//Centered around the rounded corner
module CubeWithRoundedCorner(
  size=[10,10,10],
  cornerRadius = 2,
  edgeRadius = 0,
  center=false){
  assert(is_list(size) && len(size)==3, "size should be a list of size 3");
  assert(is_num(cornerRadius) && cornerRadius >= 0, "cornerRadius should be a number greater than 0");
  assert(is_num(edgeRadius), "edgeRadius should be a number");

  fudgeFactor = 0.01;

  translate(center ? -size/2 : [0,0,0])
  if(edgeRadius <=0) {
    hull(){
      translate([cornerRadius,cornerRadius,0])
      cylinder(r=cornerRadius, h=size.z+fudgeFactor);
      translate([cornerRadius,0,0])
        cube([size.x-cornerRadius,size.y,size.z+fudgeFactor]);
      translate([0,cornerRadius,0])
        cube([size.x,size.y-cornerRadius,size.z+fudgeFactor]);
    }
  }
  else{
    hull(){
      translate([cornerRadius,cornerRadius,0])
      roundedCylinder(h=size.z+fudgeFactor,r=cornerRadius,roundedr2=edgeRadius);

      translate([(size.x+cornerRadius)/2,size.y/2,size.z/2])
      rotate([0,90,0])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius],
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);

      translate([size.x/2,(size.y+cornerRadius)/2,size.z/2])
      rotate([0,90,270])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius],
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);
    }
  }
}

module roundedCylinder(
  h,
  r,
  roundedr=0,
  roundedr1=0,
  roundedr2=0, 
  supportReduction=[0,0],
  angle=360)
{
  assert(is_num(h), "h must have a value");
  assert(is_num(r), "r must have a value");
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;

  assert(is_num(roundedr1), "roundedr1 or roundedr must have a value");
  assert(is_num(roundedr2), "roundedr2 or roundedr must have a value");

  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1,angle=angle, supportReduction);
      else
        cylinder(r=r,h=h-roundedr2);

      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2])
          roundedDisk(r,roundedr2,half=1,angle=angle, supportReduction);
      else
        translate([0,0,roundedr1])
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}

module roundedDisk(
  r,
  roundedr, 
  half=0, 
  supportReduction=[0,0],
  angle=360){
  
  fudge_factor = 0.001;
  //Support reduction
  function auto_support_reduction(supportReduction, radius) = 
    supportReduction == -1 ? radius/2 : supportReduction;
  
  supportReduction = 
    let(srz_temp = is_num(supportReduction) ? [supportReduction,supportReduction] : supportReduction,
        srz = [auto_support_reduction(srz_temp[0], roundedr), auto_support_reduction(srz_temp[1], roundedr)]) 
      [min(srz[0], r),min(srz[1], r)];

      
  translate([0,0,roundedr])
  rotate_extrude(angle=angle, convexity=10)
  hull()
  difference(){
    // generate shape in 2D to be rotate_extrude as this will perform better than doing it in 3d
    union(){
      translate([r-roundedr,0,0])
      circle(roundedr);
      
      translate([0,-roundedr])
      square([r-roundedr,roundedr*2]);
      
      if(supportReduction[1] > 0)
        translate([0,-roundedr])
        square(size=[supportReduction[1]+(r-roundedr), roundedr]);

      if(supportReduction[0] > 0)
        square(size=[supportReduction[0]+(r-roundedr), roundedr]);
    }
    
    
    //Remove inner half so we dont get error when r<roundedr*2
    if(r < roundedr*2){
      translate([-roundedr*2+r,-roundedr])
      square([roundedr*2-r,roundedr*2]);
    }

    if(half<0){
      //Remove top half
      translate([-roundedr,0,0])
      square([roundedr+r,roundedr+fudge_factor]);
    }
    if(half>0){
      //Remove bottom half
      translate([0,-roundedr-fudge_factor])
      square([r,roundedr+fudge_factor]);
    }
  }
}

module rounded_taper(
  upperRadius=35,
  upperLength=20,
  lowerRadius=10,
  lowerLength=20,
  transitionLength=10,
  cornerRadius=0,
  roundedUpper=false,
  roundedLower=false,
  alignTop = false) {

  bottomWidth = lowerRadius*2;
  //topWidth = lowerWidth+(height/tan(wallAngle))*2;
  topWidth = upperRadius*2;
  height = upperLength+transitionLength+lowerLength;

  translate([0,0,alignTop?-height:0])
  rotate_extrude(angle=360, convexity=10)
  intersection(){
    square([topWidth,height]);

    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      hull(){
        //upper
        translate([-topWidth/2,lowerLength+transitionLength])
          square([topWidth,upperLength+(roundedUpper?0:cornerRadius)]);
        //transition
        translate([-bottomWidth/2,lowerLength])
          square([bottomWidth,transitionLength]);
      }
      //lower
      translate([-bottomWidth/2,roundedLower?0:-cornerRadius])
      square([bottomWidth,lowerLength+(roundedLower?0:cornerRadius)]);
    }
  }
}