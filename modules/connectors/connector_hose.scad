include <../constants.scad>
use <../thirdparty/ub.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>
use <../modules_threads.scad>

connector_hose_demo = false;

if(connector_hose_demo){
$fn = 64;
spacer = 100;

render_options = [
  ["threads_disabled", "endcap_disabled", "stop_disabled", "barbs_disabled", "outer", 50, 40, 2, 0, 0, 0, 0, 0, 0, 0, 0],
  ["threads_enabled", "endcap_disabled", "stop_disabled", "barbs_disabled", "outer", 50, 40, 2, 0, 0, 0, 0, 0, 0, 0, 0],
  ["threads_reversed", "endcap_disabled", "stop_disabled", "barbs_disabled", "inner", 50, 40, 2, 0, 0, 0, 0, 0, 0, 0, 0],
  ["threads_disabled", "endcap_enabled", "stop_disabled", "barbs_disabled", "outer", 50, 40, 2, 0, 0, 5, 3, 0.8, 0, 0.25, 0.5],
  ["threads_disabled", "endcap_disabled", "stop_enabled", "barbs_disabled", "outer", 50, 40, 2, 5, 5, 0, 0, 0, 0, 0, 0],
  ["threads_disabled", "endcap_disabled", "stop_disabled", "barbs_enabled", "outer", 50, 40, 2, 0, 0, 0, 5, 0, 0, 0, 0],
  ["threads_enabled", "endcap_enabled", "stop_enabled", "barbs_enabled", "outer", 50, 40, 2, 5, 5, 5, 5, 1.2, 0, 1, 0.75],
  ["threads_reversed", "endcap_enabled", "stop_enabled", "barbs_disabled", "inner", 38, 55, 2.5, 5, 5, 5, 4, 0.6, 0, 0.75, 0.25],
  ["threads_enabled", "endcap_disabled", "stop_enabled", "barbs_enabled", "inner", 60, 35, 3, 6, 6, 0, 4, 0, 0, 0, 0],
  ["threads_disabled", "endcap_enabled", "stop_disabled", "barbs_disabled", "inner", 32, 25, 1.5, 0, 0, 4, 0, 0, 0, 0, 0],
  ["threads_enabled", "endcap_disabled", "stop_disabled", "barbs_enabled", "outer", 75, 60, 3, 0, 0, 0, 6, 0, 0, 0, 0],
  ["threads_reversed", "endcap_disabled", "stop_enabled", "barbs_enabled", "inner", 100, 50, 4, 8, 7, 0, 8, 0, 0, 0, 0],
  ["threads_disabled", "endcap_enabled", "stop_disabled", "barbs_disabled", "outer", 40, 45, 2, 0, 0, 3, 2, 0.4, 0, 0.5, 0.25],
  ];

render()
  for(iRender = [0:len(render_options)-1])
  union(){
    translate([spacer*(iRender % 3), spacer*floor(iRender / 3), 0])
    HoseConnector(
      innerStartDiameter = render_options[iRender][5],
      innerEndDiameter = render_options[iRender][5],
      connectorMeasurement = render_options[iRender][4],
      length = render_options[iRender][6],
      wallThickness = render_options[iRender][7],
      stopLength = render_options[iRender][2] == "stop_enabled" ? render_options[iRender][8] : 0,
      stopWidth = render_options[iRender][2] == "stop_enabled" ? render_options[iRender][9] : 0,
        stopSymmetrical = false,
      barbsCount = (render_options[iRender][3] == "barbs_enabled" ? render_options[iRender][11] : 0),
        barbsThickness = 0,
        barbsSymmetrical = false,
      endCapDiameter = render_options[iRender][1] == "endcap_enabled" ? render_options[iRender][5] * 0.1 : 0,
      endCapThickness = (render_options[iRender][1] == "endcap_enabled" ? render_options[iRender][10] : 0),
        endCapGridSize = render_options[iRender][12],
        endCapGridWallThickness = render_options[iRender][13],
        chamferLength = render_options[iRender][14],
        chamferWidth = render_options[iRender][15],
        enableThreads =
          render_options[iRender][0] == "threads_enabled" ? "enabled"
          : render_options[iRender][0] == "threads_reversed" ? "reversed"
          : "disabled",
        threadPitch = 0,
        threadToothAngle = 30,
        threadToothHeight = 0,
        help = true
    );
  }
}

module HoseConnector(
    innerStartDiameter,
    innerEndDiameter,
    connectorMeasurement,
    length,
    wallThickness,
    stopLength = 0,
    stopWidth = 0,
    stopSymmetrical = false,
    barbsCount = 0,
    barbsThickness = 0,
    barbsSymmetrical = false,
    endCapDiameter = 0,
    endCapThickness = 0,
    endCapGridSize = 0,
    endCapGridWallThickness = 0,
    chamferLength = 0,
    chamferWidth = 0,
    enableThreads="disabled",
    threadPitch=0,
    threadToothAngle=30,
    threadToothHeight=0,
    help
)
{
  assert(is_num(innerEndDiameter) && innerEndDiameter > 0, "innerEndDiameter must be a number greater than 0");
  assert(is_num(innerStartDiameter) && innerStartDiameter > 0, "innerStartDiameter must be a number greater than 0");
  assert(is_string(connectorMeasurement) && (connectorMeasurement == "outer" || connectorMeasurement == "inner"),
    "connectorMeasurement must be 'outer' or 'inner'");
  assert(is_num(length) && length > 0, "length must be a number greater than 0");
  assert(is_num(wallThickness) && wallThickness > 0, "wallThickness must be a number greater than 0");
  assert(is_num(stopLength) && stopLength >= 0, "stopLength must be a number greater than or equal to 0");
  assert(is_num(stopWidth) && stopWidth >= 0, "stopWidth must be a number greater than or equal to 0");
  assert(is_bool(stopSymmetrical), "stopSymmetrical must be a boolean");
  assert(is_num(barbsCount) && barbsCount >= 0 && floor(barbsCount) == barbsCount, "barbsCount must be a non-negative integer");
  assert(is_num(barbsThickness) && barbsThickness >= 0, "barbsThickness must be a number greater than or equal to 0");
  assert(is_bool(barbsSymmetrical), "barbsSymmetrical must be a boolean");
  assert(is_num(endCapDiameter) && endCapDiameter >= 0, "endCapDiameter must be a number greater than or equal to 0");
  assert(is_num(endCapThickness) && endCapThickness >= 0, "endCapThickness must be a number greater than or equal to 0");
  assert(is_num(endCapGridSize) && endCapGridSize >= 0, "endCapGridSize must be a number greater than or equal to 0");
  assert(is_num(endCapGridWallThickness) && endCapGridWallThickness >= 0, "endCapGridWallThickness must be a number greater than or equal to 0");
  assert(is_num(chamferLength) && chamferLength >= 0, "chamferLength must be a number greater than or equal to 0");
  assert(is_num(chamferWidth) && chamferWidth >= 0, "chamferWidth must be a number greater than or equal to 0");
  assert(is_string(enableThreads) && (enableThreads == "disabled" || enableThreads == "enabled" || enableThreads == "reversed"),
    "enableThreads must be 'disabled', 'enabled', or 'reversed'");
  assert(is_num(threadPitch) && threadPitch >= 0, "threadPitch must be a number greater than or equal to 0");
  assert(is_num(threadToothAngle) && threadToothAngle >= 0 && threadToothAngle <= 90, "threadToothAngle must be between 0 and 90");
  assert(is_num(threadToothHeight) && threadToothHeight >= 0, "threadToothHeight must be a number greater than or equal to 0");

  assert(stopLength == 0 || stopWidth > 0, "stopWidth must be greater than 0 when stopLength is enabled");
  assert(barbsCount == 0 || wallThickness > 0, "wallThickness must be greater than 0 when barbs are enabled");
  assert(endCapGridSize == 0 || endCapThickness > 0, "endCapThickness must be greater than 0 when endCapGridSize is enabled");

  _barbsThickness = barbsThickness == 0 ? wallThickness/2 : barbsThickness;
  barbLength = length/(barbsCount*2+1);

  union() {
    difference ()
    {
      //outer cylinder
      translate([0,0,0])
      hull()
      {
        cylinder(fudgeFactor, d=innerStartDiameter+2*wallThickness);
        translate([0,0,length-fudgeFactor])
          cylinder(fudgeFactor, d=innerEndDiameter+2*wallThickness);
      }

      //Inner cylinder to remove
      translate([0,0,0-fudgeFactor])
      hull()
      {
        cylinder(fudgeFactor, d=innerStartDiameter);
        translate([0,0,length+2*fudgeFactor])
          cylinder(fudgeFactor, d=innerEndDiameter);
      }
      if(chamferLength >0)
      {
        pipe(
          diameter1 = connectorMeasurement == "outer" ?
            innerStartDiameter + wallThickness*2 - chamferWidth*2 :
            innerStartDiameter - chamferWidth*2,
          diameter2 = connectorMeasurement == "outer" ?
            innerStartDiameter + wallThickness*2 + chamferWidth*2 :
            innerStartDiameter - chamferWidth*2,
          length = chamferLength*2,
          wallThickness1 = chamferWidth*2,
          wallThickness2 = 0,
          zPosition = -fudgeFactor);
      }
    }

    if(enableThreads != "disabled"){
      if(connectorMeasurement == "outer"){
        ExternalHoseThread(
          diameter = innerStartDiameter+wallThickness,
          wallThickness=wallThickness,
          height=length,
          pitch=threadPitch,
          tooth_angle=threadToothAngle,
          tooth_height=threadToothHeight,
          reverse_thread=(enableThreads == "reversed"));
      } else {
       InternalHoseThread(
        diameter = innerStartDiameter,
        wallThickness=wallThickness,
        height=length,
        pitch=threadPitch,
        tooth_angle=threadToothAngle,
        tooth_height=threadToothHeight,
        reverse_thread=(enableThreads == "reversed"));
      }
    }

    //barbs
    if(barbsCount > 0)
    {
      for (i = [0: barbsCount-1]) {
          translate([0,0,length/(barbsCount*2+1)*(i*2+1)])
          Stopper(
            diameter = connectorMeasurement == "outer" ? innerStartDiameter+wallThickness : innerStartDiameter,
            outer = connectorMeasurement == "outer",
            totalLength = barbLength,
            taper1 = barbsSymmetrical ? 0.4 : 1,
            taper2 = barbsSymmetrical ? 0.4 : 0,
            wallThickness = wallThickness/2,
            stopThickness = _barbsThickness);
      }
    }

    // Create the end cap
    if(endCapThickness > 0)
    {
      difference ()
      {
        //Main endcap
        cylinder(endCapThickness, d=innerStartDiameter + wallThickness/2);

        //endcap grid
        if(endCapGridSize>0)
        intersection(){
          hexwalls = endCapGridWallThickness == 0 ? wallThickness :    endCapGridWallThickness;
          gridspacing = (endCapGridSize*(sqrt(3)/2))*2 +hexwalls;
          gridsize = ceil(innerEndDiameter*1.4/gridspacing);
          innergridDiameter = endCapDiameter > 0 ? endCapDiameter+wallThickness*2 : 0;

          pipe(
            diameter=innergridDiameter,
            length=endCapThickness+fudgeFactor*2,
            wallThickness = (innerEndDiameter-(innergridDiameter))/2,
            zPosition = -fudgeFactor);

          translate([0,0,-fudgeFactor])
            HexGrid([gridsize,gridsize],gridspacing)
            cylinder(r=endCapGridSize, h=endCapThickness+fudgeFactor*4, $fn=6);
        }
        if(endCapDiameter > 0)
          //Endcap center hole
          translate([0,0,-fudgeFactor])
            cylinder(endCapThickness + fudgeFactor * 2, d=endCapDiameter);
      }
    }

    // Create the hose stop
    if(stopWidth > 0 && stopLength > 0)
    {
      translate([0,0,-fudgeFactor])
      Stopper(
        diameter = innerEndDiameter,
        outer = innerStartDiameter <= innerEndDiameter,
        totalLength = stopLength+fudgeFactor*2,
        taper1 = stopSymmetrical ? 0.4 : 0.5,
        taper2 = stopSymmetrical ? 0.4 : 0,
        wallThickness = wallThickness,
        stopThickness = stopWidth,
        zPosition = length,
        marker = false,
        help = help);
    }
  }

   HelpTxt("HoseConnector",[
    "connectorMeasurement", connectorMeasurement,
    "innerStartDiameter", innerStartDiameter,
    "innerEndDiameter", innerEndDiameter,
    "length", length,
    "wallThickness", wallThickness,
    "stopLength", stopLength,
    "stopWidth", stopWidth,
    "stopSymmetrical", stopSymmetrical,
    "barbsCount", barbsCount,
    "barbsThickness", barbsThickness,
    "barbsSymmetrical", barbsSymmetrical,
    "endCapDiameter", endCapDiameter,
    "endCapThickness", endCapThickness,
    "endCapGridSize", endCapGridSize,
    "endCapGridWallThickness", endCapGridWallThickness,
    "chamferLength", chamferLength,
    "chamferWidth", chamferWidth,
    "enableThreads", enableThreads,
    "threadPitch", threadPitch,
    "threadToothAngle", threadToothAngle,
    "threadToothHeight", threadToothHeight
    ],help);
}