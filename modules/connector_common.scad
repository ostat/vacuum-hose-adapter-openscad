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