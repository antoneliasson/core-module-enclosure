use <se/antoneliasson/operations.scad>
use <se/antoneliasson/shapes.scad>

include <parameters.scad>

module standoff() {
	translate([pcbw/2+WallClearance, pcbl/2+WallClearance, 0]) {
		rotate(180)
			linear_extrude(height=BottomHeaderHeight+WallClearance)
				rsquare1(WallClearance+2*PCBHoleEdgeDst+2*PCBHoleR, 3);
	}
	translate([pcbw/2-PCBHoleEdgeDst-PCBHoleR, pcbl/2-PCBHoleEdgeDst-PCBHoleR, BottomHeaderHeight+WallClearance])
		linear_extrude(height=pcbt) circle(r=PCBHoleR-TightFit);
}

module snap() {
	translate([pcbw/2+WallClearance+flangeW, 16, -snapH])
		rotate([90, 0, 0]) linear_extrude(height=8) triangle(snapD, snapH);
}

module Bottom () {
	// floor
	hull() fourwaymirror() translate([pcbw/2-3, pcbl/2-3, 0])
		cylinder(h=WallThickness, r1=3+WallClearance+WallThickness-WallThickness, r2=3+WallClearance+WallThickness);

	fourwaymirror() translate([0, 0, WallThickness]) standoff();

	// walls
	translate([0, 0, WallThickness]) difference () {
		linear_extrude(height=WallClearance
				+BottomHeaderHeight+pcbt+TopHeaderHeight-flangeHeight)
			difference() {
				offset(delta=WallClearance+WallThickness) pcb();
				offset(delta=WallClearance) pcb();
			}

		// usb cutout
		translate([0, -(pcbl/2+WallThickness+WallClearance), BottomHeaderHeight+WallClearance+pcbt]) linear_extrude(height=2.8)
			translate([-4, 0, 0]) square([8, WallThickness]);
	}
	// flange
	translate([0, 0, WallThickness+WallClearance
			+BottomHeaderHeight+pcbt+TopHeaderHeight-flangeHeight]) {
		linear_extrude(height=flangeHeight)
			difference() {
				offset(delta=WallClearance+flangeW) pcb();
				offset(delta=WallClearance) pcb();
			}
		// snaps
		fourwaymirror() {
			translate([0, 0, flangeHeight]) snap();
			translate([0, 0, flangeHeight-snapH]) snap();
		}

	}
}

render() Bottom();
