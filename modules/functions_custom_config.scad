include <functions_string.scad>

//Takes a string and converts it in to an array of arrays.
//I.E.  "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";
//becomes  [[0, 0, 0.5, 3, 2, 6], [0.5, 0, 0.5, 3, 2, 6], [1, 0, 3, 1.5], [1, 1.5, 3, 1.5]]
function splitCustomConfig(customConfig) = let(
  compartments = split(customConfig, "|")
) [for (x =[0:1:len(compartments)-1]) csv_parse(compartments[x])];

function outputCustomConfig(typecode, arr) = let(
  config = createCustomConfig(arr),
  dynamicConfig = str("\"", typecode,"\"", ",", config)
) str("🟦 Generating 'tray' config, to be used in custom config.\r\nLocal Config\r\n\t", config, "\r\nDynamic Config\r\n\t", dynamicConfig,"\r\n");

function createCustomConfig(arr, pos=0, sep = ",") = pos >= len(arr) ? "" :
  let(
    current = is_list(arr[pos]) ? createCustomConfig(arr[pos], sep=";")
      : is_string(arr[pos]) ? str("\"",arr[pos],"\"")
      : arr[pos],
    strNext = createCustomConfig(arr, pos+1, sep)
  ) str(current, strNext!=""?str(sep, strNext):"");