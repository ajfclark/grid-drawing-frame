/* [Rendering] */
// Precision: The power of 2 to use as $fn
precision=6; // [4:10]

/* [Cell] */
// Size of each cell (mm)
cellSize=10; // [1:50]
// Width in cells
cellsWide=10; // [1:50]
// Height in cells
cellsHigh=10; // [1:50]

/* [Frame] */
// Frame thickness: A multiple of your intended layer height works well
frameThickness = 2; // [1:.1:10]
// Frame width
frameWidth = 10; // [.5:.1:20]

/* [Hole]*/
// Hole radius: The size of the holes
holeRadius = 0.5;
// Hole margin: The inset from the inner edge of the frame to the holes
holeMargin = 1; // [.1:.1:2]

/* [Groove] */
// Radius of the grooves: Do not exceed Frame Thickness. Half hole radius is a good starting point.
grooveRadius = 0.25; // [.1:.05:5]

/* [Hidden] */
$fn=2^precision;

module groove(w, h, z, s, r, m) {
	x1=-w/2;
	x2=-x1;
	y1=-h/2;
	y2=-y1;

	for(i = [x1 + s: s : x2 - s]) {
			translate([i,0,z/2])
				rotate([90,0,0])
					cylinder(h = h + r*2 + m*2, r=r, center=true);
	}
}
module grooves(w, h, z, s, r, m) {
    groove(w=w,h=h,z=z,s=s,r=r,m=m);
    rotate([0,0,90])
    groove(w=h,h=w,z=z,s=s,r=r,m=m);
}
module hole(w, h, z, s, r, m) {
	x1=-w/2;
	x2=-x1;
	y1=-h/2;
	y2=-y1;

	for(i = [0 : 180 : 360])
		rotate([0,0,i])
			for(i = [x1+s : s : x2-s]) {
				translate([i,y1-r-m])
					cylinder(h = z+.1, r=r, center=true);
			}
}

module cutout(w, h, z, s, hr, gr, m) {
    hole(w=w,h=h,z=z,s=s,r=hr,m=m);
    groove(w=w,h=h,z=z,s=s,r=gr,m=m);
}

module cutouts(w, h, z, s, hr, gr, m) {
    cube([w, h, z+.1], true);
    cutout(w=w,h=h,z=z,s=s,hr=hr, gr=gr,m=m);
    rotate([0,0,90])
    cutout(w=h,h=w,z=z,s=s,hr=hr, gr=gr,m=m);
}

windowWidth=cellSize*cellsWide;
windowHeight=cellSize*cellsHigh;
overallWidth=windowWidth+2*frameWidth;
overallHeight=windowHeight+2*frameWidth;

difference () {
    cube([overallWidth, overallHeight, frameThickness], true);
    cutouts(w=windowWidth,h=windowHeight,s=cellSize,z=frameThickness,hr=holeRadius,gr=grooveRadius,m=holeMargin);
}
