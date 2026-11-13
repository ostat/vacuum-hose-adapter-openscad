use <../../demos/vacuum_hose_adapter_demo.scad>
use <../../modules/functions_general.scad>

cases = [
  ["hose_demo", ["inner", "outer"]],
  ["hose_stopthickness", ["outer", "outer", "outer", "inner", "inner", "inner"]],
  ["hose_stoplength", ["outer", "outer", "outer", "inner", "inner", "inner"]],
  ["hose_stopsymmetrical", ["outer", "outer", "inner", "inner"]]
];

for (entry = cases, step = [0:len(entry[1])-1]) {
  settings = getCurrentStep(entry[0], step);
  expected = entry[1][step];
  assert(DictGet(settings, "connector1Measurement") == expected,
    str("Stop side mismatch: ", entry[0], " step ", step, " must be ", expected));
  assert(DictGet(settings, "connector1Taper") == (expected == "outer" ? 1 : -1),
    str("Stop taper changed: ", entry[0], " step ", step));
}

cube(1);
