use <../../modules/thirdparty/ub.scad>

Case = 9;
ending = 3 + floor(Case / 8);
orientation = floor(Case / 2) % 4;
length = Case % 2 == 0 ? 10 : 30;

intersection() {
  Caliper(on=2, messpunkt=false, size=7, h=0.1, l=length,
    end=ending, in=orientation, txt2="outer diameter");
  cube([1000,1000,1000], center=true);
}
