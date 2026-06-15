include <../constants.scad>
use <../thirdparty/ub.scad>
use <../modules_utility.scad>
use <../modules_pipe.scad>
use <../modules_threads.scad>

connector_hose_demo = false;

if(connector_hose_demo){
$fn = 64;
diameter = 50;
spacer = diameter*1.5;

render_options = [
  ["threads_disabled", "endcap_disabled", "stop_disabled", "barbs_disabled"],
  ["threads_enabled", "endcap_disabled", "stop_disabled", "barbs_disabled"],
  ["threads_reversed", "endcap_disabled", "stop_disabled", "barbs_disabled"],
  ["threads_disabled", "endcap_enabled", "stop_disabled", "barbs_disabled"],
  ["threads_disabled", "endcap_disabled", "stop_disabled", "barbs_disabled"],
  ["threads_disabled", "endcap_disabled", "stop_enabled", "barbs_enabled"],
  ];

connector_measurements = ["outer", "inner"]; 
 
render()
  for(iRender = [0:len(render_options)-1])
  for(iConnectorMeasurement = [0:len(connector_measurements)-1])
  union(){
    translate([spacer*iConnectorMeasurement, spacer*iRender, 0])
    HoseConnector(
        innerStartDiameter = diameter,
        innerEndDiameter = diameter,
        connectorMeasurement = connector_measurements[iConnectorMeasurement],
        length = 40,
        wallThickness = 2,
        stopLength = (render_options[iRender][2] == "stop_enabled" ? 5 : 0),
        stopWidth = 5,
        stopSymmetrical = false,
        barbsCount = (render_options[iRender][3] == "barbs_enabled" ? 5 : 0),
        barbsThickness = 0,
        barbsSymmetrical = false,
        endCapDiameter = 5,
        endCapThickness = (render_options[iRender][1] == "endcap_enabled" ? 5 : 0),
        endCapGridSize = 0,
        endCapGridWallThickness = 0,
        chamferLength = 0,
        chamferWidth = 0,
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
        Pipe (
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

          StraightPipe(
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