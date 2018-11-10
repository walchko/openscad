$fn=90;
/* use <lib/misc.scad>; */
use <lib/pi.scad>;


module M3(){
    cylinder(h=40, d=3.3, center=true);
}

module M2(){
    cylinder(h=40, d=2.4, center=true);
}

module base(width, length, thick, dia){
    linear_extrude(height=thick) hull(){
        circle(d=dia);
        translate([width,0,0]) circle(d=dia);
        translate([width,length,0]) circle(d=dia);
        translate([0,length,0]) circle(d=dia);
    }
}

module hcut(dia, length){
    translate([0,0,-5]) linear_extrude(height=15) hull(){
        circle(d=dia);
        translate([length,0,0]) circle(d=dia);
    }
}

module vcut(dia, length){
    translate([0,0,-5]) linear_extrude(height=15) hull(){
        circle(d=dia);
        translate([0,length,0]) circle(d=dia);
    }
}

module plate(width, length, thick=3){
    dia = 4;
    scale = 0.65;
    xbase = 6.4;
    ybase = 9.3;

    dx = (1-scale)*width/2;
    dy = (1-scale)*length/2;
    difference()
    {
        union(){
            base(width, length, thick, dia);
            // stand-offs
            translate([xbase, ybase, 0]){
                sd1 = 8;
                sd2 = 4;
                up = 8;
                translate([0,0,0]) cylinder(h=up, d1=sd1,d2=sd2);
                translate([49,0,0]) cylinder(h=up, d1=sd1, d2=sd2);
                translate([49,58,0]) cylinder(h=up, d1=sd1, d2=sd2);
                translate([0,58,0]) cylinder(h=up, d1=sd1, d2=sd2);
            }
        }

        // center cut
        translate([dx,dy,-thick/2]) base(scale*width, scale*length, thick*2, dia);

        // mounting holes
        translate([dia/2,dia/2,0]) M3();
        translate([width-dia/2,dia/2,0]) M3();
        translate([width-dia/2,length-dia/2,0]) M3();
        translate([dia/2,length-dia/2,0]) M3();

        // pi mounting holes
        translate([xbase, ybase, 0]){
            translate([0,0,0]) M2();
            translate([49,0,0]) M2();
            translate([49,58,0]) M2();
            translate([0,58,0]) M2();
        }

        // horizontal cuts
        cw = 35;
        cd = 8;
        translate([(width-cw)/2,cd/2,0]) hcut(cd, cw);
        translate([(width-cw)/2,length-cd/2,0]) hcut(cd, cw);

        // vertical cuts
        cl = 40;
        cld = 6;
        translate([cld/2,(length-cl)/2,0]) vcut(cld, cl);
        translate([width-cld/2,(length-cl)/2,0]) vcut(cld, cl);

        // nut cutouts
        translate([xbase, ybase, -1]){
            sdia = 6;
            up = 3;
            translate([0,0,0]) cylinder(h=up, d=sdia);
            translate([49,0,0]) cylinder(h=up, d=sdia);
            translate([49,58,0]) cylinder(h=up, d=sdia);
            translate([0,58,0]) cylinder(h=up, d=sdia);
        }
    }

    /* translate([xbase, ybase, 0]){
        dia = 7;
        up = 6;
        translate([0,0,0]) cylinder(h=up, d=dia);
        translate([49,0,0]) cylinder(h=up, d=dia);
        translate([49,58,0]) cylinder(h=up, d=dia);
        translate([0,58,0]) cylinder(h=up, d=dia);
    } */

    /* cl = 40;
    cd = 6;
    translate([cd/2,(length-cl)/2,0]) vcut(cd, cl);
    translate([width-cd/2,(length-cl)/2,0]) vcut(cd, cl); */

}

width = 61.72;
height = 76.6;
thickness = 4;
plate(width, height, thickness);

/* translate([49/2,58/2, 10]) rotate([0,0,-90]) rpi3(); */
