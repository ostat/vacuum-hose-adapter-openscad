
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
iAlignmentRing=iMagnetTwistLockSize+1;
iAlignmentDepth=iAlignmentRing+1;
iAlignmentUpperWidth=iAlignmentDepth+1;
iAlignmentLowerWidth=iAlignmentUpperWidth+1;
iAlignmentSideClearance=iAlignmentLowerWidth+1;
iAlignmentDepthClearance=iAlignmentSideClearance+1;
iFlangeWidth=iAlignmentDepthClearance+1;
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
iAdapterColor=iExtensionTextSize+1;
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
    : is_num(input[i_measurement_inch]) && input[i_measurement_inch] > 0 ? input[i_measurement_inch] * 2.54 : input[i_measurement_mm];
  
function getConnectorSettings(
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
  alignmentRing,
  alignmentDepth,
  alignmentUpperWidth,
  alignmentLowerWidth,
  alignmentSideClearance,
  alignmentDepthClearance,
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
  adapterColor,
  con1Measurement, con1Diameter, con1WallThickness) = 
  let(
    _diameter = measurement_to_mm(diameter),
    _length = measurement_to_mm(length),
    //For nozzle, if the diameter is 0, then set it to the D1, this will look nice.
    conMeasurement = let(
      m = retriveConnectorSetting(style, iSettingsMeasurement, measurement),
      d = retriveConnectorSetting(style, iSettingsDiameter, _diameter))
        (style == "nozzle" && d == 0) ? connector1Measurement : m,
    conDiameter = let(d = retriveConnectorSetting(style, iSettingsDiameter, _diameter)) 
      (style == "nozzle" && d == 0) ? connector1Diameter : d,
    conWallThickness = let(w = retriveConnectorSetting(style, iSettingsWallThickness, wallThickness))
      (style == "nozzle" && w == 0) ? connector1WallThickness : w,
    conLength = retriveConnectorSetting(style, iSettingsLength, _length),
    conTaper = retriveConnectorSetting(style, iSettingsTaper, taper),
    conInnerDiameter = conMeasurement == "inner" ? conDiameter : conDiameter - conWallThickness * 2,
    conInnerStartDiameter = conInnerDiameter - conTaper / 2,
    conOuterStartDiameter = conInnerStartDiameter + wallThickness*2,
    conInnerEndDiameter = conInnerDiameter + conTaper / 2,
    conOuterEndDiameter = conInnerEndDiameter + wallThickness*2,
    //If the connector hose is not showm the stop has no thickenss
    conStopThickness = (conLength <= 0 || style == "mag" || style == "flange") ? 0 : stopThickness,
    //If the stop has no thickness, it needs no length
    conStopLength = (conStopThickness > 0 && style == "hose") ? stopLength : 0
    ) [
        connector,
        style, 
        conWallThickness, 
        conMeasurement, 
        conDiameter, 
        conLength, 
        rotation,
        conTaper, 
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
        alignmentRing,
        alignmentDepth,
        alignmentUpperWidth,
        alignmentLowerWidth,
        alignmentSideClearance,
        alignmentDepthClearance,
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
        adapterColor,
        conInnerDiameter,
        conInnerStartDiameter,
        conOuterStartDiameter,
        conInnerEndDiameter,
        conOuterEndDiameter,
        conStopThickness,
        conStopLength];