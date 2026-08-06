// Hose connector
// version 2024-04-30
// repo https://github.com/ostat/vacuum-hose-adapter-openscad
//
// I give permision to use this script as you want, you are also free to sell models generated using this script. When sharing or selling models generated please provide attribution, with a link to the repo.
//
// I don't approve of you hosting or uploading this script it to any site or 3d modeling site.

use <thirdparty/ub.scad>
include <constants.scad>
include <module_conditional.scad>
include <modules_utility.scad>
include <modules_pipe.scad>
include <modules_slipring.scad>

include <connectors/connectors.scad>

//colorSetting=["colour", alpha]
//defaultColor="colour"
function getColor(colorSetting, defaultColor) =
  assert(is_list(colorSetting), str("colorSetting must be a list colorSetting=", colorSetting, " defaultColor", defaultColor))
  assert(len(colorSetting) == 2, "colorSetting be length 2")
  let(
    c = colorSetting[0] == "" ? defaultColor : colorSetting[0],
    a = is_num(colorSetting[1]) && colorSetting[1] >=0 && colorSetting[1] <=1 ? colorSetting[1] : 1) [c, a];

function renderModeEnabled(mode) =
  assert(mode == "disable" || mode == "enable" || mode == "preview only",
    str("render mode must be 'disable', 'enable', or 'preview only'. Provided: ", mode))
  mode == "enable" || (mode == "preview only" && $preview);

module adapterAlignmentRing(
  centerDiameter = 0,
  alignmentDepth = 0,
  alignmentUpperWidth = 0,
  alignmentLowerWidth = 0,
  alignmentSideClearance = 0,
  alignmentDepthClearance = 0,
  magnetBorder = 0,
  debug = false,
  showCaliper=false,
  help){

  difference(){
    AlignmentRing(
      centerDiameter = centerDiameter,
      alignmentDepth = alignmentDepth,
      alignmentUpperWidth = alignmentUpperWidth,
      alignmentLowerWidth = alignmentLowerWidth,
      alignmentSideClearance = alignmentSideClearance,
      alignmentDepthClearance = alignmentDepthClearance,
      magnetBorder = magnetBorder);

    if(debug){
      cubeSizex = centerDiameter+max(alignmentUpperWidth, alignmentLowerWidth);
      cubeSizey = centerDiameter/2+max(alignmentUpperWidth, alignmentLowerWidth);
      cubeSizez = alignmentDepth*2;
      translate([-cubeSizex/2, -cubeSizey, -cubeSizez/2])
        cube([cubeSizex,cubeSizey,cubeSizez]);
      }
    }

    if(showCaliper){
      color("Gold")
      union(){
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, size = 5,h = 0.1,
          //center=false,
          l=centerDiameter+max(alignmentUpperWidth, alignmentLowerWidth),
          end=0, in=1,
          translate= [0,10,0],
          txt2 = "centerDiameter");
        translate([(centerDiameter)/2,0,0])
        rotate([90,90,0])
        Caliper(on=2, messpunkt = false, help=0, size = 5,h = 0.1,
          l=(alignmentDepth-alignmentDepthClearance)*2,
          end=0, in=4,
          cx= 0,
          translate= [0,5,0],
          txt2 = "alignmentDepth");
        }
    }

  HelpTxt("adapterAlignmentRing",[
    "centerDiameter", centerDiameter,
    "magnetBorder", magnetBorder,
    "alignmentDepth", alignmentDepth,
    "alignmentUpperWidth", alignmentUpperWidth,
    "alignmentLowerWidth", alignmentLowerWidth,
    "alignmentSideClearance", alignmentSideClearance,
    "alignmentDepthClearance", alignmentDepthClearance,
    "debug", debug]
    ,help);
}

module adapter(
    con =[],
    connectorPos = 1,
    transitionAngle = 0,
    debug = false,
    showCaliper=false,
    help
){
  assert(is_list(con), "con must be a list")
  assert(is_num(con[iLength]), str("length must be a number :", con[iLength]));
  assert(is_list(con[iAdapterColor]), "adapterColor must be a list")
  assert(len(con[iAdapterColor]) == 2, "adapterColor be length 2")

  //Create the start connector
  if(con[iLength] > 0)
  {
    difference()
    {
      color(con[iAdapterColor][0], con[iAdapterColor][1])
      rotate([0,0,con[iRotation]])
      union(){
        if(con[iStyle] == "mag")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          MagneticConnector(
              innerStartDiameter = con[iInnerStartDiameter],
              innerEndDiameter = con[iInnerEndDiameter],
              length = con[iLength],
              wallThickness = con[iWallThickness],
              magnetDiameter = con[iMagnetDiameter],
              magnetThickness = con[iMagnetThickness],
              magnetBorder = con[iMagnetBorder],
              magnetZOffset = con[iMagnetZOffset],
              flangeThickness = con[iMagnetFlangeThickness],
              magnetCount = con[iMagnetCount],
              alignmentRing = con[iAlignmentRing],
              alignmentDepth = con[iAlignmentDepth],
              alignmentUpperWidth = con[iAlignmentUpperWidth],
              alignmentLowerWidth = con[iAlignmentLowerWidth],
              alignmentSideClearance = con[iAlignmentSideClearance],
              alignmentDepthClearance = con[iAlignmentDepthClearance],
              twistLockSize = con[iMagnetTwistLockSize],
              roundover = con[iMagnetFlangeRoundover],
              $fn = $fn);
        }
        else if(con[iStyle] == "flange")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          FlangeConnector(
            innerStartDiameter = con[iInnerStartDiameter],
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            flangeThickness = con[iFlangeThickness],
            flangeWidth = con[iFlangeWidth],
            screwPosition = con[iFlangeScrewPosition],
            screwBorder = con[iFlangeScrewBorder],
            screwCount = con[iFlangeScrewCount],
            screwDiameter = con[iFlangeScrewDiameter],
            help = help,
            $fn = $fn);
        }

        else if(con[iStyle] == "hose")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          HoseConnector(
            innerStartDiameter = con[iInnerStartDiameter],
            innerEndDiameter = con[iInnerEndDiameter],
            connectorMeasurement = con[iMeasurement],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            barbsCount  = con[iBarbsCount],
            barbsThickness = con[iBarbsThickness],
            barbsSymmetrical = con[iBarbsSymmetrical],
            endCapDiameter = con[iEndCapDiameter],
            endCapThickness = con[iEndCapThickness],
            endCapGridSize = con[iEndCapGridSize],
            endCapGridWallThickness = con[iEndCapGridWallThickness],
            enableThreads = con[iEnableThreads],
            threadPitch = con[iThreadPitch],
            threadToothAngle = con[iThreadToothAngle],
            threadToothHeight = con[iThreadToothHeight],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "dyson")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          DysonConnector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            IncludeOrientationClip = true,
            $fn = $fn);
        }
        else if(con[iStyle] == "camlock")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          CamlockConnector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            $fn = $fn);
        }
        else if(con[iStyle] == "dw735")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          Dw735Connector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            connectorCount = transitionAngle > 0 ? 6 : 1,
            $fn = $fn);
        }
        else if(con[iStyle] == "centec_female")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          CenTecFemaleConnector($fn = $fn);
        }
        else if(con[iStyle] == "centec_male")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          CenTecMaleConnector($fn = $fn);
        }
        else if(con[iStyle] == "makita_male")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          MakitaMaleConnector(
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "kobalt")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          KobaltConnector(
        else if(con[iStyle] == "bosch_sander")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          BoschSanderConnector(
            innerEndDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "rigid_nxt" || con[iStyle] == "nxt")
        {
          translate([0, 0, con[iLength]+con[iStopLength]])
          mirror ([0,0,1])
          RigidNXTConnector(
            outerStartDiameter = con[iOuterStartDiameter],
            outerEndDiameter = con[iOuterEndDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "osvacm" || con[iStyle] == "osvacm32")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          osVacMaleConnector(
            innerDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "osvacf" || con[iStyle] == "osvacf32")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          osVacFemaleConnector(
            innerDiameter = con[iInnerEndDiameter],
            length = con[iLength],
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "festoolcleanteclug")
        {
          translate([0, 0, con[iLength]])
          mirror ([0,0,1])
          FestoolCleantecLugConnector(
            help = help,
            $fn = $fn);
        }
        else if(con[iStyle] == "nozzle")
        {
          Nozzle(
            innerStartDiameter = con[iInnerStartDiameter],
            length = con[iLength],
            wallThickness = con[iWallThickness],
            nozzleShape = con[iNozzleShape],
            nozzleSize = con[iNozzleSize],
            nozzleTipWallThickness = con[iNozzleTipWallThickness],
            nozzleRadius = con[iNozzleRadius],
            nozzleOffset = con[iNozzleOffset],
            nozzleChamferPercentage = con[iNozzleChamferPercentage],
            nozzleChamferAngle = con[iNozzleChamferAngle],
            help = help,
            $fn = $fn);
        } else if(con[iStyle] == "none"){ }
        else {
         assert(false, str("style not supported style: ", con[iStyle]));
        }
      }
      if(debug&&con[iStyle]!="none"){
        cubeSizex = max(con[iInnerStartDiameter],con[iInnerEndDiameter])*2;
        cubeSizey = max(con[iInnerStartDiameter],con[iInnerEndDiameter])*1.5;
        cubeSizez = con[iLength]+fudgeFactor*4
          +(con[iStyle] == "nozzle"? con[iNozzleSize].z+fudgeFactor : 0)
          +(con[iStyle] == "mag"? con[iAlignmentDepth]: 0);
        translate([-cubeSizex/2, -cubeSizey, -fudgeFactor*2])
        cube([cubeSizex,cubeSizey,cubeSizez]);
      }
    }
  }

  if(showCaliper&&con[iStyle]!="none"){
    color("Gold")
    translate([0, 0, con[iLength]])
    mirror ([0,0,1])
    mirror (connectorPos == 1 ? [0,0,0] : [1,0,0])
    union(){
      endStyle = con[iMeasurement] == "inner" ? 3 : 4;
      addwidth = con[iMeasurement] == "outer" ? con[iWallThickness]*2 : 0;
      translate(con[iStyle] == "nozzle" ? [0,0,con[iLength]] :[0,0,con[iLength]/2])
      rotate([90,0,0])
       Caliper(on=2, messpunkt = false, help=0, size = 7,h = 0.1,
          l=con[iInnerDiameter] + addwidth,
          end=endStyle,
          in=connectorPos == 1 ? 1 : 0,
          txt2 = str("con", con[iConnector], " ", con[iMeasurement]));
      if(con[iInnerDiameter] != con[iInnerStartDiameter]){
        translate([0,0,0])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, size = 5,h = 0.1,
            l=con[iInnerStartDiameter] + addwidth,
            end=endStyle,
            in=connectorPos == 1 ? 1 : 0,
            txt2 = str("con", con[iConnector], " start ", con[iMeasurement]));
      }
      if(con[iInnerDiameter] != con[iInnerEndDiameter]){
        translate([0,0,con[iLength]])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, size = 5,h = 0.1,
            l=con[iInnerEndDiameter] + addwidth,
            end=3,
            in=connectorPos == 1 ? 1 : 0,
            txt2 = str("con", con[iConnector], " end ", con[iMeasurement]));
      }

      barWidth = con[iWallThickness]*8;
      position = con[iInnerDiameter]/2 + con[iWallThickness]*2;
      translate([(connectorPos == 1 ? position  : -position), 0, con[iLength]/2])
      rotate([90,0,0])
      Caliper(on=2, messpunkt = false, help=0, h = 0.1,
            center=true,
            l=con[iLength],
            cx= 0,
            end=0,
            size = 8,
            in=connectorPos == 1 ? 2 : 3,
            translate= connectorPos == 1 ? [15,0,0] : [-15,0,0],
            txt2 = str("con", con[iConnector], " length"));

      if(con[iStyle] == "nozzle")
      {
        translate([(connectorPos == 1 ? position  : -position), 0,-con[iNozzleSize].z/2])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, h = 0.1,
              l=con[iNozzleSize].z,
              cx= 0,
              end=0,
              size = 8,
              in=connectorPos == 1 ? 2 : 3,
              translate= connectorPos == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("nozzle ", con[iConnector], " length"));
      }
    }
  }
  HelpTxt("adapter",[
    "con", con,
    "transitionAngle", transitionAngle,
    "debug", debug]
    ,help);
}

module transitionExtension(
  connector,
  connectorMeasurement = "inner",
  innerDiameter = 0,
  exitDiameter = 0,
  taperLength = 0,
  wallThickness = 0,
  length = 0 ,
  stopLength = 0,
  stopWidth = 0,
  stopSymmetrical = false,
  gridSize = 0,
  gridWallThickness = 0,
  txt="",
  txtSize=0,
  includeHook = 0,
  extensionSlipRing="disabled",
  extensionSlipRingWidth=5,
  extensionSlipRingSupport="disabled",
  extensionSlipRingSupportSize=0.2,
  extensionSlipRingSupportSpacing=5,
  transitionColor = ["LightGreen", 1],
  debug = false,
  showCaliper=false,
  help){
  assert(is_list(transitionColor), "transitionColor must be a list");
  assert(len(transitionColor) == 2, "transitionColor be length 2");
  assert(is_num(connector) && (connector == 1 || connector == 2 || connector == 3), "connector must be 1 or 2");
  assert(is_num(innerDiameter), "innerDiameter must be a number");
  assert(is_num(exitDiameter) && exitDiameter >= 0, str("exitDiameter must be a non-negative number. Provided:", exitDiameter));
  assert(is_num(wallThickness), "wallThickness must be a number");
  assert(is_num(length), "length must be a number");
  assert(is_num(gridSize), "gridSize must be a number");
  assert(is_num(gridWallThickness), "gridWallThickness must be a number");

  effectiveExitDiameter = exitDiameter == 0 ? innerDiameter : exitDiameter;

  slipRing = calculate_slipring_size(slipring = extensionSlipRing, width = extensionSlipRingWidth);
  slipRingSize = slipRing[0];
  slipRingStartWallThickness = slipRing[1];
  slipRingEndWallThickness = slipRing[2];
  slipRingDeltaDiameter = slipRing[3];

  spliRingPreTaper = abs(wallThickness - slipRingStartWallThickness);

  totalLength = length + stopLength + taperLength + spliRingPreTaper + slipRingSize.y;

  //gridWallThickness, -1 use wall thickness
  gridWallThickness = gridWallThickness < 0
    ? min(wallThickness, length)
    : min(gridWallThickness, length);

  //gridWallThickness == 0 will disable grid
  gridSize = gridWallThickness <= 0
    ? 0
    : gridSize <=0
      ? innerDiameter/6 - gridWallThickness
      : gridSize;

  if(totalLength > 0)
  {
    difference(){
      color(transitionColor[0], transitionColor[1])
      union(){
        if(length > 0 || stopLength > 0)
          HoseConnector(
            innerStartDiameter = innerDiameter,
            innerEndDiameter = innerDiameter,
            connectorMeasurement = connectorMeasurement,
            length = length,
            wallThickness = wallThickness,
            stopLength = stopLength,
            stopWidth = stopWidth,
            stopSymmetrical = stopSymmetrical,
            endCapThickness = gridWallThickness,
            endCapGridSize = gridSize,
            endCapGridWallThickness = gridWallThickness,
            help = help);

        if(extensionSlipRing != "disabled"){
          // needed entry taper

          translate([0,0,spliRingPreTaper])
          translate([0, 0, length + stopLength])
           slipring(
            diamater = innerDiameter,
            ring_width = extensionSlipRingWidth,
            slip_clearance = 0.3,
            rounded_clearance = true,
            taper = extensionSlipRing,
            internal_support = extensionSlipRingSupport,
            internal_support_size = extensionSlipRingSupportSize,
            internal_support_spacing = extensionSlipRingSupportSpacing);

          if(spliRingPreTaper > 0)
            translate([0, 0, length + stopLength])
            pipe(
              diameter = innerDiameter,
              length = spliRingPreTaper,
              wallThickness1 = wallThickness,
              wallThickness2 = slipRingStartWallThickness,
              enableWallThicknessCompensation = false);
        }

        if(taperLength > 0)
          translate([0, 0, length + stopLength])
          pipe(
            diameter1 = innerDiameter,
            diameter2 = effectiveExitDiameter,
            length = taperLength,
            wallThickness = wallThickness);

        if(includeHook == 1){
          hootLength = max(15, length + stopLength);
          hookSize = wallThickness*2;
          intersection(){
            difference(){
              Stopper(
                diameter = (innerDiameter+wallThickness),
                outer = (innerDiameter+wallThickness*2)+hookSize*2,
                totalLength = hootLength,
                taper1 = 0.25,
                taper2 = 0.25,
                wallThickness = wallThickness/2,
                stopThickness = hookSize);

              translate([0,0,wallThickness])
              Stopper(
                diameter = (innerDiameter-wallThickness),
                outer = (innerDiameter+wallThickness),
                totalLength = hootLength-wallThickness*2,
                taper1 = 0.3,
                taper2 = 0.3,
                wallThickness = wallThickness/2,
                stopThickness = hookSize);
              }

              cubeSize = [innerDiameter+hookSize,5,hootLength];
              translate([-cubeSize.x,-cubeSize.y/2,0])
              cube([innerDiameter+hookSize,cubeSize.y,cubeSize.z]);
          }
        /*
          difference(){
            cylinder(h=length, d=(innerDiameter+wallThickness*2)+hookSize);
            translate([0,0,-fudgeFactor])
            cylinder(h=length+fudgeFactor*2, d=(innerDiameter+wallThickness));
          }*/
        }
      }
      if(debug){
        cubeSize = [max(innerDiameter, effectiveExitDiameter)*2,max(innerDiameter, effectiveExitDiameter)*1.5, totalLength+fudgeFactor*4];
        translate([-cubeSize.x/2, (connector == 1 ? -cubeSize.y : 0), -fudgeFactor*2])
        cube(cubeSize);
      }

      if(length > 0 && is_string(txt) && len(txt) > 0){
        textExtrude = min(wallThickness,1);
        border = length * .2; //border above and below the text
        translate([0,0,border])
        RoundText(
          text = txt,
          font = "Liberation:style=Bold",
          fontSize = txtSize > 0 ? txtSize : length-border*2,
          radius = innerDiameter/2+wallThickness - textExtrude/2,
          textExtrude = textExtrude,
          forceRound = true,
          center = true,
          $fn=64);
      }
    }

    if(showCaliper){
    /*render on left side
      color("Gold")
      translate(connector == 1 ? [0, 0, length] : [0, 0, length] )
      mirror(connector == 1 ? [0,0,1] : [0,0,1])
      rotate(connector == 1 ? [0,0,180] : [0,0,0])
      union(){
        barWidth = wallThickness*8;
        position = innerDiameter/2 + wallThickness*2;
        translate([(connector == 1 ? position  : -position), 0, length/2])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, h = 0.1,
              center=true,
              l=length,
              cx= -1,
              end=0,
              size = 8,
              in=connector == 1 ? 3 : 2,
              translate= connector == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("Extension ", connector, " length"));
      }
    }
    */

    if(taperLength > 0)
      color("Aquamarine")
      translate(connector == 1 ? [0, 0, 0] : [0, 0, 0] )
      mirror(connector == 1 ? [0,0,0] : [0,0,0])
      rotate(connector == 1 ? [0,0,0] : [0,0,180])
      union(){
        barWidth = wallThickness*8;
        position = innerDiameter/2 + wallThickness*2;
        translate([(connector == 1 ? position  : -position), 0, length + taperLength/2])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, h = 0.1,
              center=true,
              l=taperLength,
              cx=0,
              end=0,
              size=6,
              in=connector == 1 ? 2 : 3,
              translate= connector == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("Extension Taper ", connector, " length"));
      }

      if(length > 0)
      color("Aquamarine")
      translate(connector == 1 ? [0, 0, 0] : [0, 0, 0] )
      mirror(connector == 1 ? [0,0,0] : [0,0,0])
      rotate(connector == 1 ? [0,0,0] : [0,0,180])
      union(){
        barWidth = wallThickness*8;
        position = innerDiameter/2 + wallThickness*2;
        translate([(connector == 1 ? position  : -position), 0, length/2])
        rotate([90,0,0])
        Caliper(on=2, messpunkt = false, help=0, h = 0.1,
              center=true,
              l=length,
              cx=0,
              end=0,
              size=6,
              in=connector == 1 ? 2 : 3,
              translate= connector == 1 ? [15,0,0] : [-15,0,0],
              txt2 = str("Extension ", connector, " length"));
      }
    }
  }
  HelpTxt("transitionExtension",[
    "connector", connector,
    "innerDiameter", innerDiameter,
    "exitDiameter", effectiveExitDiameter,
    "taperLength", taperLength,
    "wallThickness", wallThickness,
    "length", length,
    "stopLength", stopLength,
    "stopWidth", stopWidth,
    "stopSymmetrical", stopSymmetrical,
    "taperLength", taperLength,
    "gridSize", gridSize,
    "gridWallThickness", gridWallThickness,
    "transitionColor", transitionColor,
    "debug", debug,
    "showCaliper", showCaliper]
    ,help);
}

module transition(
  style,
  length,
  bendTaperLengthBefore,
  bendTaperLengthAfter,
  bendPipeDiameter,
  bendPipeWallThickness,
  connector1InnerEndDiameter,
  connector2InnerStartDiameter,
  connector3InnerStartDiameter,
  connector1WallThickness,
  connector2WallThickness,
  connector3WallThickness,
  thickness,
  bendRadius,
  angle,
  baseType,
  baseThickness,
  baseWidth,
  baseLength,
  baseAngle,
  connector2Count,
  connector2Angle,
  lengthInHull,
  hullLength,
  hullCenterLength,
  edgeOffset,
  hullCenter,
  centerHeight,
  Offset,
  debug = false,
  transitionColor = ["LightGreen",1],
  showCaliper = false,
  help
){
  assert(is_list(transitionColor), "adapterColor must be a list");
  assert(len(transitionColor) == 2, "adapterColor be length 2");

  multiConnectorAngle = connector2Angle > 0 ? connector2Angle : 360/connector2Count;

  difference()
  {
    union()
    {
      if(style == "flat")
      {
        transDiameter = min(connector1InnerEndDiameter,  connector2InnerStartDiameter);
        transThickness = abs(connector1InnerEndDiameter - connector2InnerStartDiameter)/2 + max(connector1WallThickness,connector2WallThickness);
        color(transitionColor[0], transitionColor[1])
        pipe(
            diameter = transDiameter,
            length = length,
            wallThickness = transThickness);
      }
      if(style == "organicbend")
      {
        //Bent pipe that tapers through the bend.
        color(transitionColor[0], transitionColor[1])
        TaperedBentPipe(
          bendRadius = bendRadius,
          end1InnerPipeDiameter = connector1InnerEndDiameter,
          end2InnerPipeDiameter = connector2InnerStartDiameter,
          end1WallThickness = connector1WallThickness,
          end2WallThickness = connector2WallThickness,
          pipeAngle = angle,
          baseType = baseType,
          baseThickness = baseThickness,
          baseWidth = baseWidth,
          baseLength = baseLength,
          baseAngle = baseAngle,
          end2Count = connector2Count);
      }
      else if(style == "hull")
      {
        color(transitionColor[0], transitionColor[1])
        BentPipeHull(
          inner1PipeRadius = connector1InnerEndDiameter/2,
          inner2PipeRadius = connector2InnerStartDiameter/2,
          inner3PipeRadius = connector3InnerStartDiameter/2,
          end1WallThickness = connector1WallThickness,
          end2WallThickness = connector2WallThickness,
          end3WallThickness = connector3WallThickness,
          pipeAngle = angle,
          end2Count = connector2Count,
          end2Angle = connector2Angle,
          lengthInHull = lengthInHull,
          lengthOutHull = hullLength,
          lengthOutHullCenter = hullCenterLength,
          edgeOffset = edgeOffset,
          addCenter = hullCenter,
          centerHeight= centerHeight
        );
      }
      else if(style == "bend+taper")
      {
        // General bend and taper transition. A taper is added on either side
        // of the bend only when the selected bend pipe differs from that end.
        taperBeforeBend = bendPipeDiameter != connector1InnerEndDiameter;
        taperAfterBend = bendPipeDiameter != connector2InnerStartDiameter;

        if(taperBeforeBend)
        {
          color(transitionColor[0], transitionColor[1])
          pipe_with_offset(
            diameter1 = connector1InnerEndDiameter,
            diameter2 = bendPipeDiameter,
            length = bendTaperLengthBefore,
            wallThickness1 = connector1WallThickness,
            wallThickness2 = bendPipeWallThickness,
            Offset = [0,0]);
        }

        if(angle > 0)
        {
          translate([0, 0, bendTaperLengthBefore])
          color(transitionColor[0], transitionColor[1])
          BentPipe(
            bendRadius = bendRadius,
            innerPipeDiameter = bendPipeDiameter,
            wallThickness = bendPipeWallThickness,
            pipeAngle = angle,
            baseType = baseType,
            baseThickness = baseThickness,
            baseWidth = baseWidth,
            baseLength = baseLength,
            baseAngle = baseAngle,
            end2Count = connector2Count,
            end2Angle = connector2Angle);
        }

        if(taperAfterBend)
        {
          // Tapered section positioned at the outlet of each bent pipe.
          for (rotation = [0:connector2Count-1])
          {
            color(transitionColor[0], transitionColor[1])
            rotate([0, 0, rotation*multiConnectorAngle])
            translate([0, 0, bendTaperLengthBefore])
              translate([-bendRadius, 0, 0])
              rotate([0, -angle, 0])
              translate([bendRadius, 0, 0])
              pipe_with_offset(
                diameter1 = bendPipeDiameter,
                diameter2 = connector2InnerStartDiameter,
                length = bendTaperLengthAfter,
                wallThickness1 = bendPipeWallThickness,
                wallThickness2 = connector2WallThickness,
                Offset = Offset);
          }
        }
      }
      else if(style == "taper+bend")
      {
        //Tapered section position to the end of the bent pipe
        //color("SpringGreen")
        color(transitionColor[0], transitionColor[1])
        pipe_with_offset(
          diameter1 = connector1InnerEndDiameter,
          diameter2 = connector2InnerStartDiameter,
          length = length,
          wallThickness1 = connector1WallThickness,
          wallThickness2 = connector2WallThickness,
          Offset = Offset);

        if(angle > 0)
        {
          //the bent pipe section, diameter matches connector 2.
          translate([Offset.x, Offset.y, 0])
          color(transitionColor[0], transitionColor[1])
          BentPipe(
            bendRadius = bendRadius,
            innerPipeDiameter = connector2InnerStartDiameter,
            wallThickness = connector2WallThickness,
            pipeAngle = angle,
            zPosition = length,
            baseType = baseType,
            baseThickness = baseThickness,
            baseWidth = baseWidth,
            baseLength = baseLength,
            baseAngle = baseAngle,
            end2Count = connector2Count,
            end2Angle = connector2Angle);
        }
      }
    }
    if(debug){
      cubeSize = max(connector1InnerEndDiameter,connector2InnerStartDiameter)*3;
      translate([-cubeSize/2, -cubeSize , -fudgeFactor*2])
          cube([cubeSize, cubeSize, cubeSize ]);
      //translate([-100/2, -200, -fudgeFactor*2])
      //    cube([200,200,200]);
    }

    if(showCaliper){
    }
  }

  HelpTxt("transition",[
    "style", style,
    "length", length,
    "connector1InnerEndDiameter", connector1InnerEndDiameter,
    "connector2InnerStartDiameter", connector2InnerStartDiameter,
    "connector3InnerStartDiameter", connector3InnerStartDiameter,
    "connector1WallThickness", connector1WallThickness,
    "connector2WallThickness", connector2WallThickness,
    "connector3WallThickness", connector3WallThickness,
    "thickness", thickness,
    "bendRadius", bendRadius,
    "angle", angle,
    "baseType", baseType,
    "baseThickness", baseThickness,
    "baseWidth", baseWidth,
    "baseLength", baseLength,
    "baseAngle", baseAngle,
    "connector2Count", connector2Count,
    "connector2Angle", connector2Angle,
    "lengthInHull", lengthInHull,
    "hullLength", hullLength,
    "hullCenterLength", hullCenterLength,
    "edgeOffset", edgeOffset,
    "hullCenter", hullCenter,
    "centerHeight", centerHeight,
    "offset", Offset,
    "debug", debug]
    ,help);
}

module HoseAdapter(
  connector1 = UserConnectorSettings(connector=1),
  connector2 = UserConnectorSettings(connector=2),
  connector3 = UserConnectorSettings(connector=3),

  transitionStyle = "bend+taper",
  transitionLength = 10,
  transitionBendRadius = 0,
  transitionBendPipeDiameter = "larger",
  transitionCustomBendPipeDiameter = 40,
  transitionAngle = 0,
  transitionOffset = [0,0],
  transitionBaseType = "none",
  transitionBaseThickness = 0,
  transitionBaseWidth = 0,
  transitionBaseLength = 0,
  transitionBaseAngle = 0,
  transitionEnd2Count = 1,
  transitionEnd2Angle = 0,
  transitionHullLength = 0,
  transitionHullCenterLength = 0,
  transitionHullyOffset = 0,
  transitionHullCenter = 0,
  transitionHullCenterHeight= 0,

  drawAlignmentRing = "no",
  alignmentDepth = 2,
  alignmentUpperWidth = 3,
  alignmentLowerWidth = 0.5,
  alignmentSideClearance = 0.25,
  alignmentDepthClearance = .75,

  sliceDebug = false,
  showCaliper = false,
  end1Color = [DefaultEnd1Color,1],
  end2Color = [DefaultEnd2Color,1],
  end3Color = [DefaultEnd3Color,1],
  transitionColor = [DefaultTransitionColor,1],
  extensionColor = [DefaultExtensionColor,1],
  help = false
){
  $gha=[["connector1",[0,0,0]],["connector2",[0,0,0]],["transition",[0,0,0]]];

  end1 = getConnectorSettings(
    userSettings=connector1,
    slipRingSettings=calculate_slipring_size(slipring=connector1[iExtensionSlipRing], width=connector1[iExtensionSlipRingWidth]),
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end1Color, DefaultEnd1Color),
    con1Measurement=connector1[iMeasurement],
    con1WallThickness=connector1[iWallThickness]);

  end2 = getConnectorSettings(
    userSettings=connector2,
    slipRingSettings=calculate_slipring_size(slipring=connector2[iExtensionSlipRing], width=connector2[iExtensionSlipRingWidth]),
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end2Color, DefaultEnd2Color),
    con1Measurement=end1[iMeasurement],
    con1OuterEndDiameter=end1[iInterfaceOuterDiameter],
    con1WallThickness=end1[iWallThickness]);

  end3 = getConnectorSettings(
    userSettings=connector3,
    slipRingSettings=calculate_slipring_size(slipring=connector3[iExtensionSlipRing], width=connector3[iExtensionSlipRingWidth]),
    alignmentDepth=alignmentDepth,
    alignmentUpperWidth=alignmentUpperWidth,
    alignmentLowerWidth=alignmentLowerWidth,
    alignmentSideClearance=alignmentSideClearance,
    alignmentDepthClearance=alignmentDepthClearance,
    adapterColor = getColor(end3Color, DefaultEnd3Color),
    con1Measurement=end1[iMeasurement],
    con1OuterEndDiameter=end1[iInterfaceOuterDiameter],
    con1WallThickness=end1[iWallThickness]);

  echoConnector("end1", end1, help);
  echoConnector("end2", end2, help);
  echoConnector("end3", end3, transitionHullCenter == "end3" ? help : false);

  //Transition settings
  // transitionLength is not wanted for sweep
  _transitionAngle = (transitionStyle == "flat") ? 0 : transitionAngle;
  _transitionStyle = _transitionAngle == 0 && transitionStyle == "organicbend" ? "bend+taper" : transitionStyle;

  echo("_transitionLength", _transitionLength=_transitionLength, end1_iInterfaceOuterDiameter=end1[iInterfaceOuterDiameter], end2iInterfaceOuterDiameter=end2[iInterfaceOuterDiameter], end1iInterfaceInnerDiameter=end1[iInterfaceInnerDiameter], end2iInterfaceInnerDiameter=end2[iInterfaceInnerDiameter]);
  _transitionLength = _transitionStyle == "organicbend" //|| _transitionStyle == "hull"
    ? 0
    : transitionLength == 0
      ? max(
          abs(end1[iInterfaceOuterDiameter] - end2[iInterfaceOuterDiameter])/2,
          abs(end1[iInterfaceInnerDiameter] - end2[iInterfaceInnerDiameter])/2)+(end1[iInterfaceWallThickness]/2+end2[iInterfaceWallThickness]/2)
      : transitionLength;

  bendPipeDiameter = transitionBendPipeDiameter == "custom"
    ? transitionCustomBendPipeDiameter
    : transitionBendPipeDiameter == "smaller"
      ? min(end1[iInterfaceInnerDiameter], end2[iInterfaceInnerDiameter])
      : max(end1[iInterfaceInnerDiameter], end2[iInterfaceInnerDiameter]);

  assert(transitionBendPipeDiameter != "custom" || transitionCustomBendPipeDiameter > 0, "Transition custom bend pipe diameter must be greater than zero");

  // Preserve the wall of a matching end. For an in-between custom bore,
  // interpolate the wall; outside that range, use the nearest end's wall.
  bendPipeWallThickness = end1[iInterfaceInnerDiameter] == end2[iInterfaceInnerDiameter]
    ? max(end1[iInterfaceWallThickness], end2[iInterfaceWallThickness])
    : let(
        blend = max(0, min(1,
          (bendPipeDiameter - end1[iInterfaceInnerDiameter]) /
          (end2[iInterfaceInnerDiameter] - end1[iInterfaceInnerDiameter]))))
      end1[iInterfaceWallThickness] +
        blend * (end2[iInterfaceWallThickness] - end1[iInterfaceWallThickness]);

  bendPipeOuterDiameter = bendPipeDiameter + bendPipeWallThickness*2;
  bendDiameterChangeBefore = abs(bendPipeDiameter - end1[iInterfaceInnerDiameter]);
  bendDiameterChangeAfter = abs(end2[iInterfaceInnerDiameter] - bendPipeDiameter);
  bendTotalDiameterChange = bendDiameterChangeBefore + bendDiameterChangeAfter;

      // With automatic length, size each taper independently so the steepest
      // of its inner or outer surfaces is approximately 45 degrees.
      bendTaperLengthBefore = transitionLength == 0
        ? max(
            bendDiameterChangeBefore/2,
            abs(bendPipeOuterDiameter - end1[iInterfaceOuterDiameter])/2)
        : bendTotalDiameterChange == 0
          ? 0
          : transitionLength * bendDiameterChangeBefore / bendTotalDiameterChange;
      bendTaperLengthAfter = transitionLength == 0
        ? max(
            bendDiameterChangeAfter/2,
            abs(end2[iInterfaceOuterDiameter] - bendPipeOuterDiameter)/2)
        : bendTotalDiameterChange == 0
          ? 0
          : transitionLength * bendDiameterChangeAfter / bendTotalDiameterChange;

      //Calculate the bend radius
      //organicbend, the '0' value must be max of connector 1 or 2 diameter, plus the wall thickness * 2 otherwise it will clip, then add provided radius.
      //transition the '0' value must be end 1 diameter/2 + wall thickenss *2 to prevent clipping, then addd provided radius.

      //((end2[iInnerStartDiameter] + connector1WallThickness)/ sin(_transitionAngle / 2)/2)/ sin(_transitionAngle) + transitionBendRadius
      //For organic bend only
      taperedAverageDiameter = (max(end1[iInterfaceOuterDiameter],end2[iOuterStartDiameter])*2 + min(end1[iInterfaceOuterDiameter],end2[iOuterStartDiameter]))/3;

      hoseSpacer = end2[iWallThickness];
      shapeOverlap = ((end1[iInterfaceOuterDiameter]/2-hoseSpacer)-(cos(_transitionAngle)*end2[iInterfaceOuterDiameter]))/sin(_transitionAngle);
      lengthInHull = _transitionStyle == "hull"
        ? (shapeOverlap > 0 ? 0 : shapeOverlap * -1) + _transitionLength
        : 0;
      transitionCenterHeight = transitionHullCenterHeight == 0 ? lengthInHull * 2 : transitionHullCenterHeight;

      //Push end horizontially out from verticle center line
      edgeOffset = _transitionStyle == "hull"
        ? (shapeOverlap > 50
          ? (end1[iInterfaceOuterDiameter] - end2[iInterfaceOuterDiameter])/2-shapeOverlap/2 + transitionHullyOffset
          : (end1[iInterfaceOuterDiameter] - end2[iInterfaceOuterDiameter])/2 + transitionHullyOffset) * cos(_transitionAngle)
        : 0;

     function bend_radius(transitionAngle, transitionBendRadius, end1OuterEndDiameter, end2OuterEndDiameter, taperedAverageDiameter) =
         let(organic_bend_radius = transitionEnd2Count > 1
                ? -(taperedAverageDiameter/2)/(cos(transitionAngle)-1)-taperedAverageDiameter/2 + transitionBendRadius
                : taperedAverageDiameter + transitionBendRadius,
             bendPipeOuterDiameter = bendPipeDiameter + bendPipeWallThickness*2,
             bend_taper_radius = transitionEnd2Count > 1
                ? -(bendPipeOuterDiameter/2)/(cos(transitionAngle)-1)-bendPipeOuterDiameter/2 + transitionBendRadius
                : bendPipeOuterDiameter/2 + transitionBendRadius,
             taper_bend_radius = transitionEnd2Count > 1
                ? -(end2OuterEndDiameter/2)/(cos(transitionAngle)-1)-end2OuterEndDiameter/2 + transitionBendRadius
                : end2OuterEndDiameter/2 + transitionBendRadius,
             hull_radius = 0 )
                  transitionStyle == "organicbend" ? organic_bend_radius
                  : _transitionStyle == "bend+taper" ? bend_taper_radius
                  : _transitionStyle == "taper+bend" ? taper_bend_radius
                  : _transitionStyle == "hull" ? hull_radius
                  : 0;

      //end hull settings
      bendRadius = bend_radius(
        transitionAngle=_transitionAngle,
        transitionBendRadius=transitionBendRadius,
        end1OuterEndDiameter=end1[iInterfaceOuterDiameter],
        end2OuterEndDiameter=end2[iInterfaceOuterDiameter],
        taperedAverageDiameter=taperedAverageDiameter);

  if(drawAlignmentRing == "end1" || drawAlignmentRing == "end2")
  {
    adapterAlignmentRing(
      centerDiameter = drawAlignmentRing == "end1"
        ? end1[iInnerStartDiameter] + end1[iMagnetBorder] + alignmentUpperWidth
        : end2[iInnerStartDiameter] + end2[iMagnetBorder] + alignmentUpperWidth,
      alignmentDepth = alignmentDepth,
      alignmentUpperWidth = alignmentUpperWidth,
      alignmentLowerWidth = alignmentLowerWidth,
      alignmentSideClearance = alignmentSideClearance,
      alignmentDepthClearance = alignmentDepthClearance,
      magnetBorder = drawAlignmentRing == "end1" ? end1[iMagnetBorder] : end2[iMagnetBorder],
      debug = sliceDebug,
      showCaliper = showCaliper,
      help = help);
  } else {
    difference()
    {
      union()
      {
        //End1
        translate([0, 0, end1[iLength]])
        mirror ([0,0,1])
        adapter(
          con = end1,
          connectorPos=1,
          transitionAngle =_transitionAngle,
          debug = sliceDebug,
          showCaliper = showCaliper,
          help = help);

        let(active_end = end1)
        translate([0, 0, active_end[iLength]])
        transitionExtension(
          connector = 1,
          connectorMeasurement = active_end[iMeasurement],
          innerDiameter = active_end[iInnerEndDiameter],
          exitDiameter = active_end[iInterfaceInnerDiameter],
          taperLength = active_end[iExtensionTaperLength],
          wallThickness = active_end[iWallThickness],
          length = active_end[iExtensionLength],
          stopLength = active_end[iExtensionStopLength],
          stopWidth = active_end[iExtensionStopThickness],
          stopSymmetrical = active_end[iExtensionStopSymmetrical],
          gridSize = active_end[iExtensionGridSize],
          gridWallThickness = active_end[iExtensionGridWallThickness],
          txt = active_end[iExtensionText],
          txtSize=active_end[iExtensionTextSize],
          extensionSlipRing=active_end[iExtensionSlipRing],
          extensionSlipRingWidth=active_end[iExtensionSlipRingWidth],
          extensionSlipRingSupport=active_end[iExtensionSlipRingSupport],
          extensionSlipRingSupportSize=active_end[iExtensionSlipRingSupportSize],
          extensionSlipRingSupportSpacing=active_end[iExtensionSlipRingSupportSpacing],
          transitionColor = getColor(extensionColor, DefaultEnd1ExtensionColor),
          debug = sliceDebug,
          showCaliper = showCaliper,
          help = help);

        echo("end1[iInterfaceLength]", end1_iInterfaceLength=end1[iInterfaceLength], _transitionLength=_transitionLength, end1_iInterfaceInnerDiameter=end1[iInterfaceInnerDiameter], end1_iInterfaceWallThickness=end1[iInterfaceWallThickness]);
        translate([0, 0, end1[iInterfaceLength]])
        transition(
          style = _transitionStyle,
          length = _transitionLength,
          bendTaperLengthBefore = bendTaperLengthBefore,
          bendTaperLengthAfter = bendTaperLengthAfter,
          bendPipeDiameter = bendPipeDiameter,
          bendPipeWallThickness = bendPipeWallThickness,
          connector1InnerEndDiameter = end1[iInterfaceInnerDiameter],
          connector2InnerStartDiameter = end2[iInterfaceInnerDiameter],
          connector3InnerStartDiameter = getConnector3Setting(transitionHullCenter, end1, end2, end3)[iInterfaceInnerDiameter],
          connector1WallThickness = end1[iInterfaceWallThickness],
          connector2WallThickness = end2[iInterfaceWallThickness],
          connector3WallThickness = getConnector3Setting(transitionHullCenter, end1, end2, end3)[iInterfaceWallThickness],
          bendRadius = bendRadius,
          angle = _transitionAngle,
          baseType = transitionBaseType,
          baseThickness = transitionBaseThickness,
          baseWidth = transitionBaseWidth,
          baseLength = transitionBaseLength,
          baseAngle = transitionBaseAngle,
          connector2Count = transitionEnd2Count,
          connector2Angle = transitionEnd2Angle,
          lengthInHull = lengthInHull,
          hullLength = transitionHullLength,
          hullCenterLength = transitionHullCenterLength,
          edgeOffset = edgeOffset,
          hullCenter = transitionHullCenter != "disabled",
          centerHeight = transitionCenterHeight,
          Offset = transitionOffset,
          debug = sliceDebug,
          transitionColor = getColor(transitionColor, DefaultTransitionColor),
          showCaliper = showCaliper,
          help = help);

        // Create the end connector
        if(end2[iLength] > 0)
        {
          taperBeforeBend = _transitionStyle == "bend+taper"
            && bendPipeDiameter != end1[iInterfaceInnerDiameter];
          taperAfterBend = _transitionStyle == "bend+taper"
            && bendPipeDiameter != end2[iInterfaceInnerDiameter];
          postRotation = [
            ((_transitionStyle == "taper+bend") ? transitionOffset.x
              : _transitionStyle == "hull" ? -end1[iInterfaceOuterDiameter]/2
              : 0) - bendRadius,
            ((_transitionStyle == "taper+bend") ? transitionOffset.y : 0),
            ((_transitionStyle == "taper+bend" || _transitionStyle == "flat" || _transitionStyle == "none") ? _transitionLength
              : _transitionStyle == "hull" ? 0
              : 0) + end1[iInterfaceLength]];

          preRotation = [
            ((_transitionStyle == "bend+taper") ? transitionOffset.x
              : _transitionStyle == "hull" ? end1[iInterfaceOuterDiameter]/2-edgeOffset
              : 0) + bendRadius,
            ((_transitionStyle == "bend+taper") ? transitionOffset.y : 0),
            ((_transitionStyle == "bend+taper") ? _transitionLength
              : _transitionStyle == "hull" ? transitionHullLength+lengthInHull+end2[iWallThickness]
              : 0)];

          multiConnectorAngle = transitionEnd2Angle > 0 ? transitionEnd2Angle : 360/transitionEnd2Count;

          for (rotation = [0:transitionEnd2Count-1])
          {
            if(sliceDebug == false || rotation ==0)
            rotate([0, 0, rotation*multiConnectorAngle])
            if(_transitionStyle == "bend+taper")
              translate([0, 0, end1[iInterfaceLength]])
              translate([0, 0, bendTaperLengthBefore])
              translate([-bendRadius, 0, 0])
              rotate([0, -_transitionAngle, 0])
              translate([
                bendRadius + (taperAfterBend ? transitionOffset.x : 0),
                taperAfterBend ? transitionOffset.y : 0,
                bendTaperLengthAfter])
              union(){
                let(active_end = end2)
                translate([0, 0, active_end[iExtensionTotalLength]])
                mirror([0,0,1])
                mirror([0,1,0])
                transitionExtension(
                  connector = 2,
                  connectorMeasurement = active_end[iMeasurement],
                  innerDiameter = active_end[iInnerEndDiameter],
                  exitDiameter = active_end[iInterfaceInnerDiameter],
                  taperLength = active_end[iExtensionTaperLength],
                  wallThickness = active_end[iWallThickness],
                  length = active_end[iExtensionLength],
                  stopLength = active_end[iExtensionStopLength],
                  stopWidth = active_end[iExtensionStopThickness],
                  stopSymmetrical = active_end[iExtensionStopSymmetrical],
                  gridSize = active_end[iExtensionGridSize],
                  gridWallThickness = active_end[iExtensionGridWallThickness],
                  txt = active_end[iExtensionText],
                  txtSize=active_end[iExtensionTextSize],
                  extensionSlipRing=active_end[iExtensionSlipRing],
                  extensionSlipRingWidth=active_end[iExtensionSlipRingWidth],
                  extensionSlipRingSupport=active_end[iExtensionSlipRingSupport],
                  extensionSlipRingSupportSize=active_end[iExtensionSlipRingSupportSize],
                  extensionSlipRingSupportSpacing=active_end[iExtensionSlipRingSupportSpacing],
                  transitionColor = getColor(extensionColor, DefaultEnd2ExtensionColor),
                  debug = sliceDebug,
                  showCaliper = showCaliper,
                  help = help);

                translate([0, 0, end2[iExtensionTotalLength]])
                adapter(
                  con = end2,
                  connectorPos=2,
                  transitionAngle =_transitionAngle,
                  debug = sliceDebug,
                  showCaliper = rotation == 0 ? showCaliper : false,
                  help = help);
              }
            else
              translate(postRotation)
              rotate([0, -_transitionAngle, 0])
              translate(preRotation)
            union(){
              let(active_end = end2)
              translate([0, 0, active_end[iExtensionTotalLength]])
              mirror([0,0,1])
              mirror([0,1,0])
              transitionExtension(
                connector = 2,
                connectorMeasurement = active_end[iMeasurement],
                innerDiameter = active_end[iInnerEndDiameter],
                exitDiameter = active_end[iInterfaceInnerDiameter],
                taperLength = active_end[iExtensionTaperLength],
                wallThickness = active_end[iWallThickness],
                length = active_end[iExtensionLength],
                stopLength = active_end[iExtensionStopLength],
                stopWidth = active_end[iExtensionStopThickness],
                stopSymmetrical = active_end[iExtensionStopSymmetrical],
                gridSize = active_end[iExtensionGridSize],
                gridWallThickness = active_end[iExtensionGridWallThickness],
                txt = active_end[iExtensionText],
                txtSize=active_end[iExtensionTextSize],
                extensionSlipRing=active_end[iExtensionSlipRing],
                extensionSlipRingWidth=active_end[iExtensionSlipRingWidth],
                extensionSlipRingSupport=active_end[iExtensionSlipRingSupport],
                extensionSlipRingSupportSize=active_end[iExtensionSlipRingSupportSize],
                extensionSlipRingSupportSpacing=active_end[iExtensionSlipRingSupportSpacing],
                transitionColor = getColor(extensionColor, DefaultEnd2ExtensionColor),
                debug = sliceDebug,
                showCaliper = showCaliper,
                help = help);

              translate([0, 0, end2[iExtensionTotalLength]])
              adapter(
                con = end2,
                connectorPos=2,
                transitionAngle =_transitionAngle,
                debug = sliceDebug,
                showCaliper = rotation == 0 ? showCaliper : false,
                help = help);
              }
          }

          if(_transitionStyle == "hull" && transitionHullCenter != "disabled")
          {
            translate([0, 0, end1[iInterfaceLength] + transitionCenterHeight + transitionHullCenterLength])
              union(){
                let(active_end = end3)
                translate([0, 0, active_end[iExtensionLength]])
                mirror([0,0,1])
                mirror([0,1,0])
                transitionExtension(
                  connector = 3,
                  connectorMeasurement = active_end[iMeasurement],
                  innerDiameter = active_end[iInnerEndDiameter],
                  exitDiameter = active_end[iInterfaceInnerDiameter],
                  taperLength = active_end[iExtensionTaperLength],
                  wallThickness = active_end[iWallThickness],
                  length = active_end[iExtensionLength],
                  stopLength = active_end[iExtensionStopLength],
                  stopWidth = active_end[iExtensionStopThickness],
                  stopSymmetrical = active_end[iExtensionStopSymmetrical],
                  gridSize = active_end[iExtensionGridSize],
                  gridWallThickness = active_end[iExtensionGridWallThickness],
                  txt = active_end[iExtensionText],
                  txtSize=active_end[iExtensionTextSize],
                  extensionSlipRing=active_end[iExtensionSlipRing],
                  extensionSlipRingWidth=active_end[iExtensionSlipRingWidth],
                  extensionSlipRingSupport=active_end[iExtensionSlipRingSupport],
                  extensionSlipRingSupportSize=active_end[iExtensionSlipRingSupportSize],
                  extensionSlipRingSupportSpacing=active_end[iExtensionSlipRingSupportSpacing],
                  transitionColor = getColor(extensionColor, DefaultEnd3ExtensionColor),
                  debug = sliceDebug,
                  showCaliper = showCaliper,
                  help = help);
                translate([0, 0, end2[iExtensionLength]])
                adapter(
                  con = getConnector3Setting(transitionHullCenter, end1, end2, end3),
                  connectorPos=3,
                  transitionAngle =_transitionAngle,
                  debug = sliceDebug,
                  showCaliper = showCaliper,
                  help = help);
                }
            }
        }
      }
    }
  }
}
