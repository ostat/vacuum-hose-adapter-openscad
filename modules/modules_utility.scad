include <constants.scad>
include <module_rounded_text.scad>
include <thirdparty/ostat/rounded_shapes.scad>

// rotate as per a, v, but around point pt
module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();
}
