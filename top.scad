use <se/antoneliasson/operations.scad>
use <se/antoneliasson/shapes.scad>

include <parameters.scad>

module standoff() {
	translate([pcbw/2-PCBHoleEdgeDst-PCBHoleR, pcbl/2-PCBHoleEdgeDst-PCBHoleR, 0])
		linear_extrude(height=TopHeaderHeight+WallClearance) circle(r=3);
}

module snap() {
	translate([pcbw/2+WallClearance+WallThickness-outerFlangeW, 16-4, -2*snapH])
		rotate([90, 0, 180]) linear_extrude(height=4) triangle(snapD, snapH);
}

module Top() {
	// floor (roof when flipped)
	linear_extrude(height=WallThickness)
		offset(delta=WallClearance) pcb();

	#fourwaymirror() translate([0, 0, WallThickness]) standoff();

	// walls
	linear_extrude(height=WallThickness+WallClearance)
		difference() {
			offset(delta=WallClearance+WallThickness) pcb();
			offset(delta=WallClearance) pcb();
		}

	// flange
	translate([0, 0, WallThickness+WallClearance]) {
		linear_extrude(height=flangeHeight)
			difference() {
				offset(delta=WallClearance+WallThickness) pcb();
				offset(delta=WallClearance+WallThickness-outerFlangeW) pcb();
			}
		// snaps
		fourwaymirror() {
			translate([0, 0, flangeHeight]) snap();
		}
	}

}

render() Top();
