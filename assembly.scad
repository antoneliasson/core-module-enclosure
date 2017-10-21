include <parameters.scad>

use <bottom.scad>
use <top.scad>

color("firebrick") import("core-module.stl");

render() translate([0, 0, -BottomHeaderHeight-WallClearance-WallThickness]) Bottom();
