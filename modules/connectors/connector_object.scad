
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
  assert(is_num(userSettings[iConnector]) && userSettings[iConnector] >= 0, str("connector must be a non-negative number:", userSettings[iConnector]))
  assert(is_string(userSettings[iStyle]), str("style must be a string:", userSettings[iStyle]))
  //assert(userSettings[iStyle] == "hose" || userSettings[iStyle] == "mag" || userSettings[iStyle] == "flange" || userSettings[iStyle] == "nozzle", "style must be 'hose', 'mag', 'flange', or 'nozzle'")
  assert(is_num(userSettings[iWallThickness]) && userSettings[iWallThickness] >= 0, str("wallThickness must be a non-negative number:", userSettings[iWallThickness]))
  assert(is_string(userSettings[iMeasurement]), str("measurement must be a string:", userSettings[iMeasurement]))
  assert(userSettings[iMeasurement] == "inner" || userSettings[iMeasurement] == "outer", str("measurement must be 'inner' or 'outer':", userSettings[iMeasurement]))
  assert(is_num(userSettings[iDiameter]) || (is_list(userSettings[iDiameter]) && len(userSettings[iDiameter]) == 2), str("diameter must be a number or list of length 2:", userSettings[iDiameter]))
  assert(is_num(userSettings[iLength]) || (is_list(userSettings[iLength]) && len(userSettings[iLength]) == 2), str("length must be a number or list of length 2:", userSettings[iLength]))
  assert(is_num(userSettings[iRotation]), str("rotation must be a number:", userSettings[iRotation]))
  assert(is_num(userSettings[iTaper]), str("taper must be a number:", userSettings[iTaper]))
  assert(is_num(userSettings[iEndCapDiameter]) && userSettings[iEndCapDiameter] >= 0, str("endCapDiameter must be a non-negative number:", userSettings[iEndCapDiameter]))
  assert(is_num(userSettings[iEndCapThickness]) && userSettings[iEndCapThickness] >= 0, str("endCapThickness must be a non-negative number:", userSettings[iEndCapThickness]))
  assert(is_num(userSettings[iEndCapGridSize]) && userSettings[iEndCapGridSize] >= 0, str("endCapGridSize must be a non-negative number:", userSettings[iEndCapGridSize]))
  assert(is_num(userSettings[iEndCapGridWallThickness]) && userSettings[iEndCapGridWallThickness] >= 0, str("endCapGridWallThickness must be a non-negative number:", userSettings[iEndCapGridWallThickness]))
  assert(is_num(userSettings[iStopThickness]) && userSettings[iStopThickness] >= 0, str("stopThickness must be a non-negative number:", userSettings[iStopThickness]))
  assert(is_num(userSettings[iStopLength]) && userSettings[iStopLength] >= 0, str("stopLength must be a non-negative number:", userSettings[iStopLength]))
  assert(is_bool(userSettings[iStopSymmetrical]), str("stopSymmetrical must be a boolean:", userSettings[iStopSymmetrical]))
  assert(is_num(userSettings[iBarbsCount]) && userSettings[iBarbsCount] >= 0, str("barbsCount must be a non-negative number:", userSettings[iBarbsCount]))
  assert(is_num(userSettings[iBarbsThickness]) && userSettings[iBarbsThickness] >= 0, str("barbsThickness must be a non-negative number:", userSettings[iBarbsThickness]))
  assert(is_bool(userSettings[iBarbsSymmetrical]), str("barbsSymmetrical must be a boolean:", userSettings[iBarbsSymmetrical]))
  assert(is_num(userSettings[iMagnetCount]) && userSettings[iMagnetCount] >= 0, str("magnetCount must be a non-negative number:", userSettings[iMagnetCount]))
  assert(is_num(userSettings[iMagnetDiameter]) && userSettings[iMagnetDiameter] >= 0, str("magnetDiameter must be a non-negative number:", userSettings[iMagnetDiameter]))
  assert(is_num(userSettings[iMagnetThickness]) && userSettings[iMagnetThickness] >= 0, str("magnetThickness must be a non-negative number:", userSettings[iMagnetThickness]))
  assert(is_num(userSettings[iMagnetBorder]) && userSettings[iMagnetBorder] >= 0, str("magnetBorder must be a non-negative number:", userSettings[iMagnetBorder]))
  assert(is_num(userSettings[iMagnetZOffset]), str("magnetZOffset must be a number:", userSettings[iMagnetZOffset]))
  assert(is_num(userSettings[iMagnetFlangeThickness]) && userSettings[iMagnetFlangeThickness] >= 0, str("magnetFlangeThickness must be a non-negative number:", userSettings[iMagnetFlangeThickness]))
  assert(is_string(userSettings[iMagnetTwistLockSize]), str("magnetTwistLockSize must be a string:", userSettings[iMagnetTwistLockSize]))
  assert(is_string(userSettings[iAlignmentRing]), str("alignmentRing must be a string:", userSettings[iAlignmentRing]))
  assert(userSettings[iAlignmentRing] == "no" || userSettings[iAlignmentRing] == "inner" || userSettings[iAlignmentRing] == "outer", str("alignmentRing must be 'no', 'inner', or 'outer':", userSettings[iAlignmentRing]))
  assert(is_num(userSettings[iFlangeWidth]) && userSettings[iFlangeWidth] >= 0, str("flangeWidth must be a non-negative number:", userSettings[iFlangeWidth]))
  assert(is_num(userSettings[iFlangeThickness]) && userSettings[iFlangeThickness] >= 0, str("flangeThickness must be a non-negative number:", userSettings[iFlangeThickness]))
  assert(is_num(userSettings[iFlangeScrewPosition]) && userSettings[iFlangeScrewPosition] >= 0, str("flangeScrewPosition must be a non-negative number:", userSettings[iFlangeScrewPosition]))
  assert(is_num(userSettings[iFlangeScrewBorder]) && userSettings[iFlangeScrewBorder] >= 0, str("flangeScrewBorder must be a non-negative number:", userSettings[iFlangeScrewBorder]))
  assert(is_num(userSettings[iFlangeScrewCount]) && userSettings[iFlangeScrewCount] >= 0, str("flangeScrewCount must be a non-negative number:", userSettings[iFlangeScrewCount]))
  assert(is_num(userSettings[iFlangeScrewDiameter]) && userSettings[iFlangeScrewDiameter] >= 0, str("flangeScrewDiameter must be a non-negative number:", userSettings[iFlangeScrewDiameter]))
  assert(is_string(userSettings[iNozzleShape]), str("nozzleShape must be a string:", userSettings[iNozzleShape]))
  assert(userSettings[iNozzleShape] == "square" || userSettings[iNozzleShape] == "circle", str("nozzleShape must be 'square', or 'oval':", userSettings[iNozzleShape]))
  assert(is_list(userSettings[iNozzleSize]) && len(userSettings[iNozzleSize]) == 3, str("nozzleSize must be a list of length 3:", userSettings[iNozzleSize]))
  assert(is_num(userSettings[iNozzleTipWallThickness]) && userSettings[iNozzleTipWallThickness] >= 0, str("nozzleTipWallThickness must be a non-negative number:", userSettings[iNozzleTipWallThickness]))
  assert(is_num(userSettings[iNozzleRadius]) && userSettings[iNozzleRadius] >= 0, str("nozzleRadius must be a non-negative number:", userSettings[iNozzleRadius]))
  assert(is_list(userSettings[iNozzleOffset]) && len(userSettings[iNozzleOffset]) == 2, str("nozzleOffset must be a list of length 2:", userSettings[iNozzleOffset]))
  assert(is_num(userSettings[iNozzleChamferPercentage]) && userSettings[iNozzleChamferPercentage] >= 0 && userSettings[iNozzleChamferPercentage] <= 100, str("nozzleChamferPercentage must be between 0 and 100:", userSettings[iNozzleChamferPercentage]))
  assert(is_num(userSettings[iNozzleChamferAngle]) && userSettings[iNozzleChamferAngle] >= 0 && userSettings[iNozzleChamferAngle] <= 90, str("nozzleChamferAngle must be between 0 and 90 degrees:", userSettings[iNozzleChamferAngle]))
  assert(is_num(userSettings[iExtensionLength]) && userSettings[iExtensionLength] >= 0, str("extensionLength must be a non-negative number:", userSettings[iExtensionLength]))
  assert(is_num(userSettings[iExtensionGridSize]) && userSettings[iExtensionGridSize] >= 0, str("extensionGridSize must be a non-negative number:", userSettings[iExtensionGridSize]))
  assert(is_num(userSettings[iExtensionGridWallThickness]) && userSettings[iExtensionGridWallThickness] >= 0, str("extensionGridWallThickness must be a non-negative number:", userSettings[iExtensionGridWallThickness]))
  assert(is_string(userSettings[iExtensionText]), str("extensionText must be a string:", userSettings[iExtensionText]))
  assert(is_num(userSettings[iExtensionTextSize]) && userSettings[iExtensionTextSize] >= 0, str("extensionTextSize must be a non-negative number:", userSettings[iExtensionTextSize]))
  userSettings;

function ValidateConnectorSettings(userSettings) =
  assert(is_num(userSettings[iAlignmentDepth]) && userSettings[iAlignmentDepth] >= 0, str("alignmentDepth must be a non-negative number:", userSettings[iAlignmentDepth]))
  assert(is_num(userSettings[iAlignmentUpperWidth]) && userSettings[iAlignmentUpperWidth] >= 0, str("alignmentUpperWidth must be a non-negative number:", userSettings[iAlignmentUpperWidth]))
  assert(is_num(userSettings[iAlignmentLowerWidth]) && userSettings[iAlignmentLowerWidth] >= 0, str("alignmentLowerWidth must be a non-negative number:", userSettings[iAlignmentLowerWidth]))
  assert(is_num(userSettings[iAlignmentSideClearance]) && userSettings[iAlignmentSideClearance] >= 0, str("alignmentSideClearance must be a non-negative number:", userSettings[iAlignmentSideClearance]))
  assert(is_list(userSettings[iAdapterColor]), str("adapterColor must be a list:", userSettings[iAdapterColor]))
  assert(is_num(userSettings[iInnerDiameter]) && userSettings[iInnerDiameter] >= 0, str("innerDiameter must be a non-negative number:", userSettings[iInnerDiameter]))
  assert(is_num(userSettings[iInnerStartDiameter]) && userSettings[iInnerStartDiameter] >= 0, str("innerStartDiameter must be a non-negative number:", userSettings[iInnerStartDiameter]))
  assert(is_num(userSettings[iInnerEndDiameter]) && userSettings[iInnerEndDiameter] >= 0, str("innerEndDiameter must be a non-negative number:", userSettings[iInnerEndDiameter]))
  assert(is_num(userSettings[iOuterStartDiameter]) && userSettings[iOuterStartDiameter] >= 0, str("outerStartDiameter must be a non-negative number:", userSettings[iOuterStartDiameter]))
  assert(is_num(userSettings[iOuterEndDiameter]) && userSettings[iOuterEndDiameter] >= 0, str("outerEndDiameter must be a non-negative number:", userSettings[iOuterEndDiameter]))
  ValidateUserConnectorSettings(userSettings);

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
    ) let (
      result = [
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
        ])
        ValidateConnectorSettings(result);