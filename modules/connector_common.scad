// associative searching
// dp 2019
// - define the dictionary

iSettingsLength = 0;
iSettingsMeasurement = 1;
iSettingsDiameter = 2;
iSettingsWallThickness = 3;
iSettingsTaper = 4;

include <connector_camlock.scad>
include <connector_centec.scad>
include <connector_dyson.scad>
include <connector_dw735.scad>

connectorSettings =[
  camlockSettings,
  centecSettings,
  dysonSettings,
  dw735Settings];

function lookupKey(dictionary, key, default=undef) = let(results = [
  for (record = dictionary)
  if (record[0] == key)
  record
]) is_undef(results) || !is_list(results) 
  ? default 
  : results[0][1];

function retriveConnectorConfig(connector, default = undef) = lookupKey(connectorSettings,connector,default);
function retriveConnectorSetting(connector, setting, default = -1) = let(
  config = retriveConnectorConfig(connector),
  setting = config == undef ? default 
    : lookupKey(config, setting, default=default)
  ) 
   setting == undef 
    ? default 
    : setting;