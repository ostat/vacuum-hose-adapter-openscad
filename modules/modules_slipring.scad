
slipring_demo = false;

if(slipring_demo){
  $fn = 128;

  color("green")
  translate([0,-10])
  slipring_profile(taper = "notaper");

  color("lightblue")
  translate([0,0])
  slipring_profile(taper = "inner");

  color("pink")
  translate([0,10])
  slipring_profile(taper = "outer");

  color("green")
  slipring(
    diamater = 50,
    ring_width = 5,
    slip_clearance = 0.1,
    rounded_clearance = true,
    taper = "notaper", //notaper, inner, outer
    );

  color("lightblue")
  translate([0,0, 10])
  slipring(
    diamater = 50,
    ring_width = 5,
    slip_clearance = 0.1,
    rounded_clearance = false,
    taper = "inner", //notaper, inner, outer
    );

  color("pink")
  translate([0,0, 20])
  slipring(
    diamater = 50,
    ring_width = 5,
    slip_clearance = 0.1,
    rounded_clearance = false,
    taper = "outer", //notaper, inner, outer
    );
}

function calculate_slipring_size(
  slipring = "disabled", //disabled, notaper, inner, outer
  width = 5
  ) = let(
    size = (slipring == "disabled") ? [0, 0] : [width, width * (4 - 2 * sqrt(2))],
    start_wall_thickness = slipring == "notaper" ? width : width/2,
    end_wall_thickness = slipring == "notaper" ? width : width/2,
    delta_diameter =
      slipring == "inner" ? -width :
      slipring == "outer" ? width : 0,
    unit_dimension = width / (4 * (1 + sqrt(2))),
    unit_angled_dimension = unit_dimension * sqrt(2),
    result = [size, start_wall_thickness, end_wall_thickness, delta_diameter, unit_dimension, unit_angled_dimension]
)
  echo("calculate_slipring_size", result = result)
  result ;

function slipring_dimension_from_width(width) = width / (4 * (1 + sqrt(2)));

function slipring_inner_radius_offset(width, taper) =
  taper == "inner"
    ? slipring_dimension_from_width(width) * (2 + 2 * sqrt(2)) - width
    : 0;

module slipring_profile_part_a(points) {
  polygon(points);
}

module slipring_profile_part_b(
  points,
  profile_width,
  profile_height) {
  translate([profile_width, profile_height])
    rotate(180)
    polygon(points);
}


/*
    Expands a shape by the requested amount.
    offset(r=...) gives a true radial offset and rounds corners.
    offset(delta=...) preserves the sharp angled profile.
*/
module clearance_expansion(amount, rounded = true) {
  if (rounded)
    offset(r = amount)
      children();
  else
    offset(delta = amount, chamfer = false)
      children();
}


/*
    tolerance is the total gap.

    Each part is moved away from the nominal interface
    by tolerance / 2.
*/
module slipring_profile(
  width = 5,
  tolerance = 0.3,
  rounded_clearance = true,
  taper = "inner", //disabled, inner, outer
){

  function splitring_profile_points(dimension, angled_dimension, split_taper) = [
      //start point
      [0,                                         angled_dimension * 2+split_taper],
      [split_taper,                               angled_dimension * 2],
      [dimension * 2,                             angled_dimension * 2],
      [dimension * 2 + angled_dimension,          angled_dimension],
      [dimension * 2 + angled_dimension * 3,      angled_dimension * 3],
      [dimension * 2 + angled_dimension,          angled_dimension * 5],
      [dimension * 2 + angled_dimension * 3,      angled_dimension * 7],
      [dimension * 2 + angled_dimension * 4,      angled_dimension * 6],
      //[dimension * 4 + angled_dimension * 4,      angled_dimension * 6],
      [dimension * 4 + angled_dimension * 4-split_taper,      angled_dimension * 6],
      [dimension * 4 + angled_dimension * 4,      angled_dimension * 6+split_taper],
      //top right
      [dimension * 4 + angled_dimension * 4,      angled_dimension * 8],

      [dimension * 2 + angled_dimension * 2,      angled_dimension * 8],

      //taper section
      [corner_taper_size ,                               angled_dimension * 8],
      [0,                                         angled_dimension * 8-corner_taper_size],

      //end
      [0,                                         angled_dimension * 8]
  ];

  function dimension_from_x(x) = x / (4 * (1 + sqrt(2)));

  dimension = dimension_from_x(width);
  angled_dimension = dimension * sqrt(2);

  size = calculate_slipring_size(width=width, slipring=taper);
  profile_width = size[0].x; //dimension * 4 + angled_dimension * 4;
  profile_height = size[0].y; //angled_dimension * 8;

  corner_taper_size = taper != "notaper" ? dimension * 2 + angled_dimension * 2 : 0;

  split_taper = 0;//angled_dimension;

  // Exact-contact profile for part A.
  //
  // Important: [0,0] was removed because it caused the
  // closing edge to overlap the first edge.
  points = splitring_profile_points(dimension, angled_dimension, split_taper);
  points_negative = splitring_profile_points(dimension, angled_dimension, 0);

  translate(taper == "inner" ? [corner_taper_size,0] : [0,0])
  mirror(taper == "inner" ? [1,0] : [0,0])
  union(){
    //slipring_part_a
    if (tolerance == 0) {
      slipring_profile_part_a(points);
    } else {
      difference() {
        slipring_profile_part_a(points);

        clearance_expansion(tolerance / 2, rounded_clearance)
          slipring_profile_part_b(points_negative, profile_width, profile_height);
      }
    }

    //slipring_part_b
    if (tolerance == 0) {
      slipring_profile_part_b(points);
    } else {
      difference() {
        slipring_profile_part_b(points, profile_width, profile_height);

        clearance_expansion(tolerance / 2, rounded_clearance)
          slipring_profile_part_a(points_negative);
      }
    }
  }
}

// true  = constant radial distance around corners
// false = preserve sharp/mitered corners
// Total assembled gap between the two parts.

module slipring(
  diamater = 50,
  ring_width = 5,
  slip_clearance = 0.1,
  rounded_clearance = true,
  taper = "inner",
  internal_support = "disabled", //disabled, enabled, internal, external
  internal_support_size = 0.2,
  internal_support_spacing = 5
){
  assert(internal_support == "disabled" || internal_support == "enabled" || internal_support == "internal" || internal_support == "external",
    "internal_support must be 'disabled', 'enabled', 'internal', or 'external'");
  assert(is_num(internal_support_size) && internal_support_size >= 0,
    "internal_support_size must be a non-negative number");
  assert(is_num(internal_support_spacing) && internal_support_spacing > 0,
    "internal_support_spacing must be greater than 0");

  slipring_dimentions = calculate_slipring_size(width=ring_width, slipring=taper);
  profile_height = slipring_dimentions[0].y;
  inner_radius = diamater/2 + slipring_inner_radius_offset(ring_width, taper);
  outer_radius = inner_radius + ring_width;
  internal_support_count = max(1, round(2 * PI * inner_radius / internal_support_spacing));
  external_support_count = max(1, round(2 * PI * outer_radius / internal_support_spacing));

  union(){
    rotate_extrude()
    translate([diamater/2,0])
    slipring_profile(
      width = ring_width,
      tolerance = slip_clearance,
      rounded_clearance = rounded_clearance,
      taper = taper);

    if(internal_support_size > 0 && (internal_support == "enabled" || internal_support == "internal"))
      for(index = [0:internal_support_count-1])
        rotate([0, 0, index * 360/internal_support_count])
        translate([inner_radius + internal_support_size/2, 0, (taper == "inner" ? profile_height-slipring_dimentions[5]*2 : slipring_dimentions[5]*2)-slip_clearance/2])
        cylinder(h=slip_clearance, d=internal_support_size, $fn = 6);

    if(internal_support_size > 0 && (internal_support == "enabled" || internal_support == "external"))
      for(index = [0:external_support_count-1])
        rotate([0, 0, index * 360/external_support_count])
        translate([outer_radius - internal_support_size/2, 0, (taper == "inner" ? slipring_dimentions[5]*2 : profile_height-slipring_dimentions[5]*2)-slip_clearance/2])
        cylinder(h=slip_clearance, d=internal_support_size, $fn = 6);
  }
}
