use <se/antoneliasson/operations.scad>
use <se/antoneliasson/shapes.scad>

include <parameters.scad>

module Button(text) {
	buttonHeight = WallThickness+WallClearance+TopHeaderHeight-PCBButtonH;

	linextr(buttonFlange)
		offset(delta=buttonFlange)
			rsquare4(buttonW, buttonR);

	difference() {
		translate([0, 0, buttonFlange])
			linextr(buttonHeight-buttonFlange)
				rsquare4(buttonW, buttonR);
		translate([0, 0, buttonHeight-0.2]) linextr(0.2) text(text, size=4, font="Liberation Sans", halign="center", valign="center");
	}
}

render() Button("B");
