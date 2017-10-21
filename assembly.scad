include <parameters.scad>

use <bottom.scad>
use <top.scad>

//projection(cut=true) translate([0, 0, 12]) rotate([90, 0, 0])
{
color("firebrick") import("core-module.stl");

render() translate([0, 0, -(BottomHeaderHeight+WallClearance+WallThickness)]) Bottom();

render() translate([0, 0, 0]) translate([0, 0, pcbt+TopHeaderHeight+WallClearance+WallThickness])
	rotate([0, 180, 0]) Top();

}
