x=120;
y=120;
z=2;
b=10;
r=1;
s=10;
m=1;
$fn=32;


module groove(x1,x2,y1,y2,z) {
}

module holes(x, y, z, b, r, m) {
	x1=-x/2+b;
	x2=-x1;
	y1=-y/2+b;
	y2=-y1;

	union() {
		for(i = [0 : 90 : 360])
			rotate([0,0,i])
				for(i = [x1+s : s : x2-s]) {
					translate([i,y1-r-m])
						cylinder(h = z*2, r=r, center=true);
				}
		for(i = [0 : 90 : 180])
			rotate([0,0,i])
				for(i = [x1+s : s : x2-s]) {
					translate([i,0,z-r])
						rotate([90,0,0])
							cylinder(h = y2 - y1 + r + m*2, d=1, center=true);
				}
	}
}

difference() {
	cube([x,y,z], true);
	cube([x-b*2, y-b*2, z+.1], true);
	holes(x,y,z,b,r,m);
}
