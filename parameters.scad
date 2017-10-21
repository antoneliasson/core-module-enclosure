WallClearance = 0.5;
WallThickness = 2.4;

pcbw = 33;
pcbl = 55;
pcbt = 1;

PCBHoleR = 1.6;
PCBHoleEdgeDst = 2.2;

BottomHeaderHeight=8.6;
TopHeaderHeight=7.5; // TODO actually measured to 7.70

TightFit = 0.15;
LooseFit = 0.25;

flangeHeight = 2;
flangeW = 1.2;
outerFlangeW = 0.8;

snapH = 0.5;
snapD = 0.4;

buttonW = 6; // TODO merge?
PCBButtonW = 6;
PCBButtonH = 5;

buttonFlange = 1; // W & H
buttonR = 1;

$fs=1;

module pcb() {
	rrect4(pcbw, pcbl, 3);
}
