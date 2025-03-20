// values for making smooth arcs
$fa = 2;
$fs = 0.25;

function inchesToMilliMeters(inches) = inches * 25.4;

// ** change these values for a different sized tubing **
square_tubing_dimension_in_mm = 20;
square_tubing_inner_dimension_in_mm = 17;
footing_height_in_mm = inchesToMilliMeters(1);

module rounded_corner_rect(size, center=[0,0,0], r=1){
    if (r <= 0) { unrounded_corner_rect(size, center); }
    x = size[0];
    y = size[1];
    z = size[2];
   translate([center[0]-x*0.5+r, center[1]-y*0.5+r, center[2]-z*0.5]) {
        minkowski(){
            cube([x-2*r, y-2*r, z/2]);
            cylinder(r=r,h=z/2);
        }
    }
}

module unrounded_corner_rect(size, center=[0,0,0]){
    x = size[0];
    y = size[1];
    z = size[2];
    translate([center[0]-x*0.5, center[1]-y*0.5, center[2]-z*0.5]) {
        cube([x, y, z]);
    }
}

difference() {
    group() {
        dimension = square_tubing_dimension_in_mm;
        rounded_corner_rect(size=[dimension,dimension,footing_height_in_mm], center=[0,0,footing_height_in_mm*0.5], r=dimension*0.1);
   
        dimension2 = square_tubing_inner_dimension_in_mm;
        top_height = dimension2*0.8;
        rounded_corner_rect(size=[dimension2,dimension2,top_height], center=[0,0,footing_height_in_mm+top_height*0.5], r=dimension2*0.4);
    }
    cylinder(h=(footing_height_in_mm+square_tubing_inner_dimension_in_mm)*2.0, d=square_tubing_inner_dimension_in_mm*0.6, center=true);
}