$fn=90;

module twall(){
    translate([0,14.70,0]) scale(.9) import("stl/t-wall.stl");
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
    // 1.5 in coin
    //dia = 40+4;
    //thick = 3+4;
    dia = 50+4;
    coin_t = 4;
    thick = coin_t+9;
    difference()
    {
        cylinder(d=dia, h=thick, center=true);      // main ring
        cylinder(d=dia-6, h=thick*2, center=true);  // inner hole/ window
        cylinder(d=dia-3.25, h=4+0.25, center=true);      // coin grove
        translate([0,0,-thick/2]) cube([2*dia, 2*dia,thick], center=true); // cut in half
//        cylinder(h=4.5, d1=dia, d2=
        //translate([0,0,-0.01]) cylinder(h=4.5, d1=dia, d2=dia-3.25, center=false);
        translate([0,0,(4+0.25)/2]) cylinder(h=thick, d1=dia-6, d2=dia+10, center=false);
    }
    //color("blue", 0.5) translate([0,0,(3+0.25)/2]) cylinder(h=thick, d1=dia-6, d2=dia+10, center=false);
}

module coin(){
    dia = 40;  // 1.5 in
    thick = 3;
    color("gray", 0.5) cylinder(d=dia, h=thick, center=true);
}

module all(complex=false){
    translate([0,-1.5,0]) difference()
    {
        scale(1.15) twall();
        if(complex){
            translate([0,0,0]) ttext("Maj Walchko",6);
            translate([0,0,-15]) ttext("IJC/CJ2", 6);
            translate([0,0,-25]) ttext("NRO LNO",6);
            translate([0,0,-35]) ttext("OEF 2013");
            translate([0,25,-15]) rotate([90,0,180]) emboss("iraq/isaf-4.png",[.2,.2,.2]); 
        }
        translate([0,0,40]) rotate([90,0,0]) cylinder(h=50,d=54.5,center=true);  // coin hole
    }
}


ring();
//color("green", 1) all();
//all(true);
//translate([0,0,40]) rotate([90,0,0]) coin();
//translate([0,0,40]) rotate([90,0,0]) ring();
//translate([0,0,40]) rotate([-90,0,0]) ring();

//translate([0,0,30]) rotate([90,0,0]) cylinder(h=50,d=45,center=true);

