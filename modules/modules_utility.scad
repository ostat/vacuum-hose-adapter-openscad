include <constants.scad>

// rotate as per a, v, but around point pt
module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();
}

// takes part of an array
function getRunningTextWidth(charsMetrics,position=0,end) = //= [for (i = [start:end]) list[i]];
  assert(is_list(charsMetrics), "charsMetricsmust be a list")
  assert(is_num(position), str("position must be a number", "provided '", position, "'"))
  assert(is_num(end), str("end must be a number", "provided '", end, "'"))
  position < end
    ? charsMetrics[position].size.y + getRunningTextWidth(charsMetrics, position + 1, end)
    : charsMetrics[position].size.y;

function subStr(s,length=5) =
  assert(is_string(s), "s must be a string")
  assert(is_num(length), "length must be a number")
  str(chr([for(i=[0 :min(length,len(s))-1])ord(s[i])]));

module RoundText(
  textvalue = "",
  font = "Liberation:style=Bold",
  fontSize = 6.5,
  radius = 20,
  textExtrude = 1,
  forceRound = false,
  center = true,
  $fn=64)
{
  _radius = forceRound ? radius - textExtrude : radius;
  charsCount = len(textvalue);
  charsMetrics = [for(i=[0:1:charsCount-1]) textmetrics(text=str(textvalue[i]),size=fontSize,font=font)];


  offsetAngle = center ? textmetrics(text=textvalue,size=fontSize,font=font).size.x/2 : 0;

  // takes part of an array
  rotate([0,0,-offsetAngle*180/(PI*_radius)])
  intersection(){
    union(){
      for(i=[0:1:charsCount-1]){
        char = textvalue[i];

        runningMetrix = textmetrics(text=subStr(textvalue, i+1),size=fontSize,font=font);
        runningLength = runningMetrix.size.x - charsMetrics[i].size.x/2;
        arcAngle=runningLength*180/(PI*_radius);
        rotate([0,0,arcAngle])
          translate( [_radius,0,0])
            rotate([90,0,90])
              linear_extrude(textExtrude * (forceRound ? 2:1))
                text(
                  textvalue[i],
                  //valign="center",
                  halign="center",
                  size=fontSize,
                  font=font);
        }
    }
    if(forceRound)
    {
      translate([0,0,-fontSize])
      difference(){
        cylinder(r=radius+textExtrude,h = fontSize*3,$fn=$fn);
        translate([0,0,-fudgeFactor])
        cylinder(r=radius,h = fontSize*3+fudgeFactor*2,$fn=$fn);
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
//fn = overrides the #fn function for the corners
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0,
  fn = 64)
{
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];

  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = sideRadius > 0 ? sideRadius : cornerRadius;

  if(sideRadius < topRadius || sideRadius < bottomRadius)
  {
    echo("roundedCube", "Error, sideRadius must be >= than bottomRadius and topRadius", sideRadius=sideRadius, topRadius=topRadius, bottomRadius=bottomRadius);
  }

  positions=[
     [sideRadius                    ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)]
    ,[sideRadius                         ,max(size.y-sideRadius, sideRadius)]
    ];

  hull(){
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i])
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius,$fn=fn);
    }
  }
}


module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1);
      else
        cylinder(r=r,h=h-roundedr2);

      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2])
          roundedDisk(r,roundedr2,half=1);
      else
        translate([0,0,roundedr1])
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}

module roundedDisk(r,roundedr, half=0){
 hull(){
    translate([0,0,roundedr])
    rotate_extrude()
    translate([r-roundedr,0,0])
    difference(){
      circle(roundedr);
      //Remove inner half so we dont get error when r<roundedr*2
      translate([-roundedr*2,-roundedr,0])
      square(roundedr*2);

      if(half<0){
        //Remove top half
        translate([-roundedr,0,0])
        square(roundedr*2);
      }
      if(half>0){
        //Remove bottom half
        translate([-roundedr,-roundedr*2,0])
        square(roundedr*2);
      }
    }
  }
}
