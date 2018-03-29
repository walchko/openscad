$fn=90;

module twall(){
    translate([0,15,0]) scale(.9) import("stl/t-wall.stl");
}

module emboss(image, imgscale=[1,1,1]){
    rotate([0,0,0]) scale(imgscale) surface(file=image, center=true, invert=true);
}

module ttext(txt,fontsize=8){
    font = "Courier:style=Bold Italic";
    height = 4.5;
    depth = 5;
    length = len(txt);
    for (a = [0:1:len(txt)]){
        translate([(a-length/2)*fontsize*.7,0,0]) rotate([90,0,0]) 
            linear_extrude(height=depth)
            text(txt[a],fontsize,font=font, halign="center");
    }
}

//emboss("iraq/isaf-2.png",[.5,.5,.5]); 

module ring(){
    dia = 40+4;
    thick = 3+4;
    difference()
    {
        cylinder(d=dia, h=thick, center=true);      // main ring
        cylinder(d=dia-6, h=thick*2, center=true);  // inner hole
        cylinder(d=dia-3.25, h=3+0.25, center=true);      // coin grove
        translate([0,0,-thick/2]) cube([2*dia, 2*dia,thick], center=true); // cut in half
    }
}

module coin(){
    dia = 40;
    thick = 3;
    color("gray", 0.5) cylinder(d=dia, h=thick, center=true);
}

module all(){
    translate([0,-1.5,0]) difference()
    {
        twall();
        translate([0,0,0]) ttext("Maj Walchko",6);
        translate([0,0,-15]) ttext("IJC/CJ2", 6);
        translate([0,0,-25]) ttext("NRO LNO",6);
        translate([0,0,-35]) ttext("OEF 2013");
        translate([0,25,-10]) rotate([90,0,180]) emboss("iraq/isaf-4.png",[.2,.2,.2]); 
        translate([0,0,40]) rotate([90,0,0]) cylinder(h=50,d=45,center=true);  // coin hole
    }
}

//color("green", 0.5) all();
//translate([0,0,40]) rotate([90,0,0]) coin();
translate([0,0,40]) rotate([90,0,0]) ring();
//translate([0,0,40]) rotate([-90,0,0]) ring();

//translate([0,0,30]) rotate([90,0,0]) cylinder(h=50,d=45,center=true);

