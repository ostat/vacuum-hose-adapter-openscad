use <../../modules/connectors/connector_hose.scad>

for (i = [0:1])
  translate([60 * i, 0, 0])
    HoseConnector(
      innerStartDiameter=40,
      innerEndDiameter=40,
      connectorMeasurement="outer",
      length=10,
      wallThickness=2,
      endCapDiameter=i * 12,
      endCapThickness=2,
      endCapGridSize=5,
      endCapGridWallThickness=2,
      $fn=64);
