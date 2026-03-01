// Creates a line of text that goes around a circle, with each character extruded along the circle's surface,
// Tries to space the chars based on the the character width.

// takes part of an array
function getRunningTextWidth(charsMetrics,position=0,end) = //= [for (i = [start:end]) list[i]];
  assert(is_list(charsMetrics), "charsMetrics must be a list")
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
  text = "",
  font = "Liberation:style=Bold",
  fontSize = 6.5,
  radius = 20,
  textExtrude = 1,
  forceRound = false,
  center = true,
  $fn=64)
{
  _radius = forceRound ? radius - textExtrude : radius;
  charsCount = len(text);
  charsMetrics = [for(i=[0:1:charsCount-1]) textmetrics(text=str(text[i]),size=fontSize,font=font)];


  offsetAngle = center ? textmetrics(text=text,size=fontSize,font=font).size.x/2 : 0;

  // takes part of an array
  rotate([0,0,-offsetAngle*180/(PI*_radius)])
  intersection(){
    union(){
      for(i=[0:1:charsCount-1]){
        char = text[i];

        runningMetrix = textmetrics(text=subStr(text, i+1),size=fontSize,font=font);
        runningLength = runningMetrix.size.x - charsMetrics[i].size.x/2;
        arcAngle=runningLength*180/(PI*_radius);
        rotate([0,0,arcAngle])
          translate( [_radius,0,0])
            rotate([90,0,90])
              linear_extrude(textExtrude * (forceRound ? 2:1))
                text(
                  text[i],
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
