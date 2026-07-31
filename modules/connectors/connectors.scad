include <connector_object.scad>
include <connector_common.scad>

// generic connectors
include <connector_flange.scad>
include <connector_hose.scad>
include <connector_magnetic.scad>
include <connector_nozzle.scad>

// specialised connectors
include <connector_bosch_sander.scad>
include <connector_camlock.scad>
include <connector_centec.scad>
include <connector_dyson.scad>
include <connector_dw735.scad>
include <connector_festool.scad>
include <connector_makita.scad>
include <connector_osvac.scad>

// order matters needs to come after the connectors
include <connector_common_post.scad>