use <se/antoneliasson/operations.scad>
use <se/antoneliasson/shapes.scad>

include <parameters.scad>

module standoff() {
	translate([pcbw/2-PCBHoleEdgeDst-PCBHoleR, pcbl/2-PCBHoleEdgeDst-PCBHoleR, 0])
		linear_extrude(height=TopHeaderHeight+WallClearance) circle(r=3);
}

module snap() {
	translate([pcbw/2+WallClearance+WallThickness-outerFlangeW, 16-8, -2*snapH])
		rotate([90, 0, 180]) linear_extrude(height=8) triangle(snapD, snapH);
}

module buttonGuide() {
	linextr(WallClearance+TopHeaderHeight-(buttonFlange+PCBButtonH))
		difference() {
			offset(delta=LooseFit+1.6) rsquare4(buttonW, buttonR);
			offset(delta=LooseFit) rsquare4(buttonW, buttonR);
		}
}

module Top() {
	// floor (roof when flipped)
	difference() {
		hull() fourwaymirror() translate([pcbw/2-3, pcbl/2-3, 0])
		cylinder(h=WallThickness, r1=3+WallClearance+WallThickness-WallThickness, r2=3+WallClearance+WallThickness);
		mirrorYZ() translate([2+PCBButtonW/2, 8+PCBButtonW/2, 0])
			linear_extrude(height=WallThickness)
				offset(delta=LooseFit) rsquare4(buttonW, buttonR);
	}
	fourwaymirror() translate([0, 0, WallThickness]) standoff();

	// walls
	translate([0, 0, WallThickness]) linear_extrude(height=WallClearance)
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

	mirrorYZ() translate([2+PCBButtonW/2, 8+PCBButtonW/2, WallThickness])
		buttonGuide();

}

render() Top();
