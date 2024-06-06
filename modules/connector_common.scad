function lookupKey(dictionary, key, default=undef) = let(results = [
  for (record = dictionary)
  if (record[0] == key)
  record
]) is_undef(results) || !is_list(results) 
  ? default 
  : results[0][1];

function retriveConnectorConfig(connector, default = undef) = lookupKey(connectorSettings,connector,default);
function retriveConnectorSetting(connector, iSetting, default = -1) = let(
  config = retriveConnectorConfig(connector),
  settingValue = config == undef ? default 
    : lookupKey(config, iSetting, default=default)
  ) 
   settingValue == undef 
    ? default 
    : settingValue;