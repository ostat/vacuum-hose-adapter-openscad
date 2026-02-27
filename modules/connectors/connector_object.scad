
iConnector=0;
iStyle=iConnector+1;
iWallThickness=iStyle+1;
iMeasurement=iWallThickness+1;
iDiameter=iMeasurement+1;
iLength=iDiameter+1;
iRotation=iLength+1;
iTaper=iRotation+1;
iEndCapDiameter=iTaper+1;
iEndCapThickness=iEndCapDiameter+1;
iEndCapGridSize=iEndCapThickness+1;
iEndCapGridWallThickness=iEndCapGridSize+1;
iStopThickness=iEndCapGridWallThickness+1;
iStopLength=iStopThickness+1;
iStopSymmetrical=iStopLength+1;
iBarbsCount=iStopSymmetrical+1;
iBarbsThickness=iBarbsCount+1;
iBarbsSymmetrical=iBarbsThickness+1;
iMagnetCount=iBarbsSymmetrical+1;
iMagnetDiameter=iMagnetCount+1;
iMagnetThickness=iMagnetDiameter+1;
iMagnetBorder=iMagnetThickness+1;
iMagnetZOffset=iMagnetBorder+1;
iMagnetFlangeThickness=iMagnetZOffset+1;
iMagnetTwistLockSize=iMagnetFlangeThickness+1;
iFlangeWidth=iMagnetTwistLockSize+1;
iFlangeThickness=iFlangeWidth+1;
iFlangeScrewPosition=iFlangeThickness+1;
iFlangeScrewBorder=iFlangeScrewPosition+1;
iFlangeScrewCount=iFlangeScrewBorder+1;
iFlangeScrewDiameter=iFlangeScrewCount+1;
iNozzleShape=iFlangeScrewDiameter+1;
iNozzleSize=iNozzleShape+1;
iNozzleTipWallThickness=iNozzleSize+1;
iNozzleRadius=iNozzleTipWallThickness+1;
iNozzleOffset=iNozzleRadius+1;
iNozzleChamferPercentage=iNozzleOffset+1;
iNozzleChamferAngle=iNozzleChamferPercentage+1;
iExtensionLength=iNozzleChamferAngle+1;
iExtensionGridSize=iExtensionLength+1;
iExtensionGridWallThickness=iExtensionGridSize+1;
iExtensionText=iExtensionGridWallThickness+1;
iExtensionTextSize=iExtensionText+1;
iAlignmentRing=iExtensionTextSize+1;

//end of user connector settings
iAlignmentDepth=iAlignmentRing+1;
iAlignmentUpperWidth=iAlignmentDepth+1;
iAlignmentLowerWidth=iAlignmentUpperWidth+1;
iAlignmentSideClearance=iAlignmentLowerWidth+1;
iAlignmentDepthClearance=iAlignmentSideClearance+1;
iAdapterColor=iAlignmentDepthClearance+1;
iInnerDiameter=iAdapterColor+1;
iInnerStartDiameter=iInnerDiameter+1;
iOuterStartDiameter=iInnerStartDiameter+1;
iInnerEndDiameter=iOuterStartDiameter+1;
iOuterEndDiameter=iInnerEndDiameter+1;

module echoConnector(name, end, help){
  assert(is_list(end), "end must be a list");
  HelpTxt(name,[
    "style", end[iStyle],
    "iWallThickness", end[iWallThickness],
    "iMeasurement", end[iMeasurement],
    "iDiameter", end[iDiameter],
    "iLength", end[iLength],
    "iRotation", end[iRotation],
    "iTaper", end[iTaper],
    "iEndCapDiameter", end[iEndCapDiameter],
    "iEndCapThickness", end[iEndCapThickness],
    "iEndCapGridSize", end[iEndCapGridSize],
    "iEndCapGridWallThickness", end[iEndCapGridWallThickness],
    "iStopThickness", end[iStopThickness],
    "iStopLength", end[iStopLength],
    "iStopSymmetrical", end[iStopSymmetrical],
    "iBarbsCount", end[iBarbsCount],
    "iBarbsThickness", end[iBarbsThickness],
    "iBarbsSymmetrical", end[iBarbsSymmetrical],
    "iMagnetCount", end[iMagnetCount],
    "iMagnetDiameter", end[iMagnetDiameter],
    "iMagnetThickness", end[iMagnetThickness],
    "iMagnetBorder", end[iMagnetBorder],
    "iMagnetZOffset", end[iMagnetZOffset],
    "iMagnetFlangeThickness", end[iMagnetFlangeThickness],
    "iMagnetTwistLockSize", end[iMagnetTwistLockSize],
    "iAlignmentRing", end[iAlignmentRing],
    "iAlignmentDepth", end[iAlignmentDepth],
    "iAlignmentUpperWidth", end[iAlignmentUpperWidth],
    "iAlignmentLowerWidth", end[iAlignmentLowerWidth],
    "iAlignmentSideClearance", end[iAlignmentSideClearance],
    "iAlignmentDepthClearance", end[iAlignmentDepthClearance],
    "iFlangeWidth", end[iFlangeWidth],
    "iFlangeThickness", end[iFlangeThickness],
    "iFlangeScrewPosition", end[iFlangeScrewPosition],
    "iFlangeScrewBorder", end[iFlangeScrewBorder],
    "iFlangeScrewCount", end[iFlangeScrewCount],
    "iFlangeScrewDiameter", end[iFlangeScrewDiameter],
    "iNozzleShape", end[iNozzleShape],
    "iNozzleSize", end[iNozzleSize],
    "iNozzleTipWallThickness", end[iNozzleTipWallThickness],
    "iNozzleRadius", end[iNozzleRadius],
    "iNozzleOffset", end[iNozzleOffset],
    "iNozzleChamferPercentage", end[iNozzleChamferPercentage],
    "iNozzleChamferAngle", end[iNozzleChamferAngle],
    "iExtensionLength", end[iExtensionLength],
    "iExtensionGridSize", end[iExtensionGridSize],
    "iExtensionGridWallThickness", end[iExtensionGridWallThickness],
    "iExtensionText", end[iExtensionText],
    "iExtensionTextSize", end[iExtensionTextSize],
    "iadapterColor", end[iAdapterColor],
    "iInnerDiameter", end[iInnerDiameter],
    "iInnerStartDiameter", end[iInnerStartDiameter],
    "iOuterStartDiameter", end[iOuterStartDiameter],
    "iInnerEndDiameter", end[iInnerEndDiameter],
    "iOuterEndDiameter", end[iOuterEndDiameter]
    ] ,help);
  }

function getConnector3Setting(transitionHullCenter, con1, con2, con3) =
  transitionHullCenter == "end1" ? con1
  : transitionHullCenter == "end2" ? con2
  : con3;

 i_measurement_inch = 1;
 i_measurement_mm = 0;

//input can be number of mm or [mm, inch], mm is deafault inch overrides mm.
function measurement_to_mm(input) =
  assert(is_num(input) || (is_list(input) && len(input) == 2), "input must be number or list of length 2 ")
  is_num(input)
    ? input
    : is_num(input[i_measurement_inch]) && input[i_measurement_inch] > 0 ? input[i_measurement_inch] * 25.4 : input[i_measurement_mm];


function UserConnectorSettings(
  connector,
  style="hose",
  wallThickness=2,
  measurement = "outer",
  diameter = [100,0],
  length = [40,0],
  rotation= 0,
  taper = 1,
  endCapDiameter = 0,
  endCapThickness = 0,
  endCapGridSize = 0,
  endCapGridWallThickness = 0,
  stopThickness = 0,
  stopLength = 0,
  stopSymmetrical = false,
  barbsCount = 0,
  barbsThickness = 0,
  barbsSymmetrical = false,
  magnetCount = 0,
  magnetDiameter = 0,
  magnetThickness = 0,
  magnetBorder = 2,
  magnetZOffset = 0,
  magnetFlangeThickness = 6,
  magnetTwistLockSize = "0",
  alignmentRing = "no",
  flangeWidth = 20,
  flangeThickness = 5,
  flangeScrewPosition = 0,
  flangeScrewBorder = 0,
  flangeScrewCount = 4,
  flangeScrewDiameter = 5,
  nozzleShape = "square",
  nozzleSize = [10,5,10],
  nozzleTipWallThickness = 0,
  nozzleRadius = 0,
  nozzleOffset = [0,0],
  nozzleChamferPercentage = 0,
  nozzleChamferAngle = 0,
  extensionLength = 0,
  extensionGridSize = 0,
  extensionGridWallThickness = 0,
  extensionText = "",
  extensionTextSize = 0
  ) =
  let(result = [
    connector,
    style,
    wallThickness,
    measurement,
    diameter,
    length,
    rotation,
    taper,
    endCapDiameter,
    endCapThickness,
    endCapGridSize,
    endCapGridWallThickness,
    stopThickness,
    stopLength,
    stopSymmetrical,
    barbsCount,
    barbsThickness,
    barbsSymmetrical,
    magnetCount,
    magnetDiameter,
    magnetThickness,
    magnetBorder,
    magnetZOffset,
    magnetFlangeThickness,
    magnetTwistLockSize,
    flangeWidth,
    flangeThickness,
    flangeScrewPosition,
    flangeScrewBorder,
    flangeScrewCount,
    flangeScrewDiameter,
    nozzleShape,
    nozzleSize,
    nozzleTipWallThickness,
    nozzleRadius,
    nozzleOffset,
    nozzleChamferPercentage,
    nozzleChamferAngle,
    extensionLength,
    extensionGridSize,
    extensionGridWallThickness,
    extensionText,
    extensionTextSize,
    alignmentRing])
    ValidateUserConnectorSettings(result);

function ValidateUserConnectorSettings(userSettings) =
  // Parameter validation asserts
  assert(is_num(userSettings[iConnector]) && userSettings[iConnector] >= 0, "connector must be a non-negative number")
  assert(is_string(userSettings[iStyle]), "style must be a string")
  assert(userSettings[iStyle] == "hose" || userSettings[iStyle] == "mag" || userSettings[iStyle] == "flange" || userSettings[iStyle] == "nozzle", "style must be 'hose', 'mag', 'flange', or 'nozzle'")
  assert(is_num(userSettings[iWallThickness]) && userSettings[iWallThickness] >= 0, "wallThickness must be a non-negative number")
  assert(is_string(userSettings[iMeasurement]), "measurement must be a string")
  assert(userSettings[iMeasurement] == "inner" || userSettings[iMeasurement] == "outer", "measurement must be 'inner' or 'outer'")
  assert(is_num(userSettings[iDiameter]) || (is_list(userSettings[iDiameter]) && len(userSettings[iDiameter]) == 2), "diameter must be a number or list of length 2")
  assert(is_num(userSettings[iLength]) || (is_list(userSettings[iLength]) && len(userSettings[iLength]) == 2), "length must be a number or list of length 2")
  assert(is_num(userSettings[iRotation]), "rotation must be a number")
  assert(is_num(userSettings[iTaper]), "taper must be a number")
  assert(is_num(userSettings[iEndCapDiameter]) && userSettings[iEndCapDiameter] >= 0, "endCapDiameter must be a non-negative number")
  assert(is_num(userSettings[iEndCapThickness]) && userSettings[iEndCapThickness] >= 0, "endCapThickness must be a non-negative number")
  assert(is_num(userSettings[iEndCapGridSize]) && userSettings[iEndCapGridSize] >= 0, "endCapGridSize must be a non-negative number")
  assert(is_num(userSettings[iEndCapGridWallThickness]) && userSettings[iEndCapGridWallThickness] >= 0, "endCapGridWallThickness must be a non-negative number")
  assert(is_num(userSettings[iStopThickness]) && userSettings[iStopThickness] >= 0, "stopThickness must be a non-negative number")
  assert(is_num(userSettings[iStopLength]) && userSettings[iStopLength] >= 0, "stopLength must be a non-negative number")
  assert(is_bool(userSettings[iStopSymmetrical]), "stopSymmetrical must be a boolean")
  assert(is_num(userSettings[iBarbsCount]) && userSettings[iBarbsCount] >= 0, "barbsCount must be a non-negative number")
  assert(is_num(userSettings[iBarbsThickness]) && userSettings[iBarbsThickness] >= 0, "barbsThickness must be a non-negative number")
  assert(is_bool(userSettings[iBarbsSymmetrical]), "barbsSymmetrical must be a boolean")
  assert(is_num(userSettings[iMagnetCount]) && userSettings[iMagnetCount] >= 0, "magnetCount must be a non-negative number")
  assert(is_num(userSettings[iMagnetDiameter]) && userSettings[iMagnetDiameter] >= 0, "magnetDiameter must be a non-negative number")
  assert(is_num(userSettings[iMagnetThickness]) && userSettings[iMagnetThickness] >= 0, "magnetThickness must be a non-negative number")
  assert(is_num(userSettings[iMagnetBorder]) && userSettings[iMagnetBorder] >= 0, "magnetBorder must be a non-negative number")
  assert(is_num(userSettings[iMagnetZOffset]), "magnetZOffset must be a number")
  assert(is_num(userSettings[iMagnetFlangeThickness]) && userSettings[iMagnetFlangeThickness] >= 0, "magnetFlangeThickness must be a non-negative number")
  assert(is_string(userSettings[iMagnetTwistLockSize]), "magnetTwistLockSize must be a string")
  assert(is_string(userSettings[iAlignmentRing]), "alignmentRing must be a string")
  assert(userSettings[iAlignmentRing] == "no" || userSettings[iAlignmentRing] == "inner" || userSettings[iAlignmentRing] == "outer", "alignmentRing must be 'no', 'inner', or 'outer'")
  //assert(is_num(userSettings[iAlignmentDepth]) && userSettings[iAlignmentDepth] >= 0, "alignmentDepth must be a non-negative number")
  //assert(is_num(userSettings[iAlignmentUpperWidth]) && userSettings[iAlignmentUpperWidth] >= 0, "alignmentUpperWidth must be a non-negative number")
  //assert(is_num(userSettings[iAlignmentLowerWidth]) && userSettings[iAlignmentLowerWidth] >= 0, "alignmentLowerWidth must be a non-negative number")
  //assert(is_num(userSettings[iAlignmentSideClearance]) && userSettings[iAlignmentSideClearance] >= 0, "alignmentSideClearance must be a non-negative number")
  //assert(is_num(userSettings[iAlignmentDepthClearance]) && userSettings[iAlignmentDepthClearance] >= 0, "alignmentDepthClearance must be a non-negative number")
  assert(is_num(userSettings[iFlangeWidth]) && userSettings[iFlangeWidth] >= 0, "flangeWidth must be a non-negative number")
  assert(is_num(userSettings[iFlangeThickness]) && userSettings[iFlangeThickness] >= 0, "flangeThickness must be a non-negative number")
  assert(is_num(userSettings[iFlangeScrewPosition]) && userSettings[iFlangeScrewPosition] >= 0, "flangeScrewPosition must be a non-negative number")
  assert(is_num(userSettings[iFlangeScrewBorder]) && userSettings[iFlangeScrewBorder] >= 0, "flangeScrewBorder must be a non-negative number")
  assert(is_num(userSettings[iFlangeScrewCount]) && userSettings[iFlangeScrewCount] >= 0, "flangeScrewCount must be a non-negative number")
  assert(is_num(userSettings[iFlangeScrewDiameter]) && userSettings[iFlangeScrewDiameter] >= 0, "flangeScrewDiameter must be a non-negative number")
  assert(is_string(userSettings[iNozzleShape]), "nozzleShape must be a string")
  assert(userSettings[iNozzleShape] == "square" || userSettings[iNozzleShape] == "circle", "nozzleShape must be 'square', or 'oval'")
  assert(is_list(userSettings[iNozzleSize]) && len(userSettings[iNozzleSize]) == 3, "nozzleSize must be a list of length 3")
  assert(is_num(userSettings[iNozzleTipWallThickness]) && userSettings[iNozzleTipWallThickness] >= 0, "nozzleTipWallThickness must be a non-negative number")
  assert(is_num(userSettings[iNozzleRadius]) && userSettings[iNozzleRadius] >= 0, "nozzleRadius must be a non-negative number")
  assert(is_list(userSettings[iNozzleOffset]) && len(userSettings[iNozzleOffset]) == 2, "nozzleOffset must be a list of length 2")
  assert(is_num(userSettings[iNozzleChamferPercentage]) && userSettings[iNozzleChamferPercentage] >= 0 && userSettings[iNozzleChamferPercentage] <= 100, "nozzleChamferPercentage must be between 0 and 100")
  assert(is_num(userSettings[iNozzleChamferAngle]) && userSettings[iNozzleChamferAngle] >= 0 && userSettings[iNozzleChamferAngle] <= 90, "nozzleChamferAngle must be between 0 and 90 degrees")
  assert(is_num(userSettings[iExtensionLength]) && userSettings[iExtensionLength] >= 0, "extensionLength must be a non-negative number")
  assert(is_num(userSettings[iExtensionGridSize]) && userSettings[iExtensionGridSize] >= 0, "extensionGridSize must be a non-negative number")
  assert(is_num(userSettings[iExtensionGridWallThickness]) && userSettings[iExtensionGridWallThickness] >= 0, "extensionGridWallThickness must be a non-negative number")
  assert(is_string(userSettings[iExtensionText]), "extensionText must be a string")
  assert(is_num(userSettings[iExtensionTextSize]) && userSettings[iExtensionTextSize] >= 0, "extensionTextSize must be a non-negative number")
  userSettings;

function getConnectorSettings(
  userSettings = [],
  alignmentDepth,
  alignmentUpperWidth,
  alignmentLowerWidth,
  alignmentSideClearance,
  alignmentDepthClearance,
  adapterColor,
  con1OuterEndDiameter,
  con1Measurement,
  con1WallThickness) =
  let(
    style = userSettings[iStyle],
    measurement = userSettings[iMeasurement],
    diameter = userSettings[iDiameter],
    length = userSettings[iLength],
    taper = userSettings[iTaper],
    wallThickness = userSettings[iWallThickness],
    stopThickness = userSettings[iStopThickness],
    stopLength = userSettings[iStopLength],

    _diameter = measurement_to_mm(diameter),
    _length = measurement_to_mm(length),
    //For nozzle, if the diameter is 0, then set it to the D1, this will look nice.
    conMeasurement = let(
      m = retriveConnectorSetting(style, iSettingsMeasurement, measurement),
      d = retriveConnectorSetting(style, iSettingsDiameter, _diameter))
        (style == "nozzle" && d == 0) ? "outer" : m,
    conDiameter = let(d = retriveConnectorSetting(style, iSettingsDiameter, _diameter))
      (style == "nozzle" && d == 0) ? con1OuterEndDiameter : d,
    conWallThickness = let(w = retriveConnectorSetting(style, iSettingsWallThickness, wallThickness))
      (style == "nozzle" && w == 0) ? con1WallThickness : w,
    conLength = retriveConnectorSetting(style, iSettingsLength, _length),
    conTaper = let(t = (style == "nozzle") ? 0 : retriveConnectorSetting(style, iSettingsTaper, taper)) conMeasurement == "inner" ? t*-1 : t,
    conInnerDiameter = conMeasurement == "inner" ? conDiameter : conDiameter - conWallThickness * 2,
    conInnerStartDiameter = conInnerDiameter - conTaper / 2,
    conOuterStartDiameter = conInnerStartDiameter + conWallThickness*2,
    conInnerEndDiameter = conInnerDiameter + conTaper / 2,
    conOuterEndDiameter = conInnerEndDiameter + conWallThickness*2,
    //If the connector hose is not showm the stop has no thickenss
    conStopThickness = (conLength <= 0 || style == "mag" || style == "flange") ? 0 : stopThickness,
    //If the stop has no thickness, it needs no length
    conStopLength = (conStopThickness > 0 && style == "hose") ? stopLength : 0
    ) [
        userSettings[iConnector],
        style,
        userSettings[iWallThickness],
        measurement,
        diameter,
        conLength,
        userSettings[iRotation],
        conTaper,
        userSettings[iEndCapDiameter],
        userSettings[iEndCapThickness],
        userSettings[iEndCapGridSize],
        userSettings[iEndCapGridWallThickness],
        userSettings[iStopThickness],
        userSettings[iStopLength],
        userSettings[iStopSymmetrical],
        userSettings[iBarbsCount],
        userSettings[iBarbsThickness],
        userSettings[iBarbsSymmetrical],
        userSettings[iMagnetCount],
        userSettings[iMagnetDiameter],
        userSettings[iMagnetThickness],
        userSettings[iMagnetBorder],
        userSettings[iMagnetZOffset],
        userSettings[iMagnetFlangeThickness],
        userSettings[iMagnetTwistLockSize],
        userSettings[iFlangeWidth],
        userSettings[iFlangeThickness],
        userSettings[iFlangeScrewPosition],
        userSettings[iFlangeScrewBorder],
        userSettings[iFlangeScrewCount],
        userSettings[iFlangeScrewDiameter],
        userSettings[iNozzleShape],
        userSettings[iNozzleSize],
        userSettings[iNozzleTipWallThickness],
        userSettings[iNozzleRadius],
        userSettings[iNozzleOffset],
        userSettings[iNozzleChamferPercentage],
        userSettings[iNozzleChamferAngle],
        userSettings[iExtensionLength],
        userSettings[iExtensionGridSize],
        userSettings[iExtensionGridWallThickness],
        userSettings[iExtensionText],
        userSettings[iExtensionTextSize],
        userSettings[iAlignmentRing],

        //End of user settings
        alignmentDepth,
        alignmentUpperWidth,
        alignmentLowerWidth,
        alignmentSideClearance,
        alignmentDepthClearance,
        adapterColor,
        conInnerDiameter,
        conInnerStartDiameter,
        conOuterStartDiameter,
        conInnerEndDiameter,
        conOuterEndDiameter,
        conStopThickness,
        conStopLength
        ];