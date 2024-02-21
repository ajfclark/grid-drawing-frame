x=100;
y=100;
z=2;
b=10;
r=1;
s=10;
m=1;
$fn=32;

module holes_row(x1,x2,y,z) {
	for(i = [x1+s : s : x2-s]) {
		translate([i,y])
			cylinder(h = z*2, r=r, center=true);
	}
}

module holes_column(y1,y2,x,z) {
	for(i = [y1+s : s : y2-s]) {
		translate([x,i])
			cylinder(h = z*2, r=r, center=true);
	}
}

module holes(x, y, z, b, r, m) {
	x1=-(x-b)/2-r-m;
	x2=-x1;
	y1=-(y-b)/2-r-m;
	y2=-y1;

	union() {
		holes_row(x1,x2,y1,z);
		holes_row(x1,x2,y2,z);
		holes_column(y1,y2,x1,z);
		holes_column(y1,y2,x2,z);
	}
}

difference() {
difference() {
	cube([x,y,z], true);
	cube([x-b, y-b, z+.1], true);
}
holes(x,y,z,b,r,m);
}

