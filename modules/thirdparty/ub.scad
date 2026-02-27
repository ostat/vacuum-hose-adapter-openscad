/*
cut  version of
works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
*/

/*[Hidden]*/
Version=23.305;//                <<< ---   VERSION  VERSION VERSION ••••••••••••••••
useVersion=undef;

/// render with Hires
hires=false;
ub_fn=$fn?$fn:$preview?36:
                          hires?144:
                                72;


ub_fs=$preview?.75:hires?.1:.2;
ub_fa=$preview?10:hires?.5:1;

needs2D=["Rand","WKreis","Welle","Rund","Rundrum", "LinEx", "RotEx","SBogen","Bogen","HypKehle","Roof"]; /// modules needing 2D children

styles=[

"Condensed",
"Condensed Oblique",
"Condensed Bold",
"Condensed Bold Oblique",
"Condensed Bold Italic",
"SemiCondensed",
"SemiLight Condensed",
"SemiLight SemiCondensed",
"SemiBold SemiCondensed",
"SemiBold Condensed",
"Light Condensed",
"Light SemiCondensed",
"SemiLight",
"Light",
"ExtraLight",
"Light Italic",
"Bold",
"Bold SemiCondensed",
"Semibold",
"Semibold Italic",
"Bold Italic",
"Bold Oblique",
"Black",
"Black Italic",
"Book",
"Regular",
"Italic",
"Medium",
"Oblique",
];


co=[
["silver","lightgrey","darkgrey","grey","slategrey","red","orange","lime","cyan","lightblue","darkblue","purple",[.8,.8,.8,.3],[.8,.8,.8,.6],"cyan","magenta","yellow","black","white","red","green","blue",[0.77,0.75,0.72]],//std
["White","Yellow","Magenta","Red","Cyan","Lime","Blue","Gray","Silver","Olive","Purple","Maroon","Teal","Green","Navy","Black"],//VGA
["Gainsboro","LightGray","Silver","DarkGray","Gray","DimGray","LightSlateGray","SlateGray","DarkSlateGray","Black"],//grey
["Pink","LightPink","HotPink","DeepPink","PaleVioletRed","MediumVioletRed"],//pink
["LightSalmon","Salmon","DarkSalmon","LightCoral","IndianRed","Crimson","Firebrick","DarkRed","Red"],//red
["OrangeRed","Tomato","Coral","DarkOrange","Orange"],//orange
["Yellow","LightYellow","LemonChiffon","LightGoldenrodYellow","PapayaWhip","Moccasin","PeachPuff","PaleGoldenrod","Khaki","DarkKhaki","Gold"],//yellows
["Cornsilk","BlanchedAlmond","Bisque","NavajoWhite","Wheat","Burlywood","Tan","RosyBrown","SandyBrown","Goldenrod","DarkGoldenrod","Peru","Chocolate","SaddleBrown","Sienna","Brown","Maroon"],//browns
["DarkOliveGreen","Olive","OliveDrab","YellowGreen","LimeGreen","Lime","LawnGreen","Chartreuse","GreenYellow","SpringGreen","MediumSpringGreen","LightGreen","PaleGreen","DarkSeaGreen","MediumAquamarine","MediumSeaGreen","SeaGreen","ForestGreen","Green","DarkGreen"],//greens
["Cyan","LightCyan","PaleTurquoise","Aquamarine","Turquoise","MediumTurquoise","DarkTurquoise","LightSeaGreen","CadetBlue","DarkCyan","Teal"],//cyans
["LightSteelBlue","PowderBlue","LightBlue","SkyBlue","LightSkyBlue","DeepSkyBlue","DodgerBlue","CornflowerBlue","SteelBlue","RoyalBlue","Blue","MediumBlue","DarkBlue","Navy","MidnightBlue"],//blue
["Lavender","Thistle","Plum","Violet","Orchid","Magenta","MediumOrchid","MediumPurple","BlueViolet","DarkViolet","DarkOrchid","DarkMagenta","Purple","Indigo","DarkSlateBlue","SlateBlue","MediumSlateBlue"],//violetts
["White","Snow","Honeydew","MintCream","Azure","AliceBlue","GhostWhite","WhiteSmoke","Seashell","Beige","OldLace","FloralWhite","Ivory","AntiqueWhite","Linen","LavenderBlush","MistyRose"],//white
["Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple","magenta"],//rainbow
["magenta","Purple","Blue","dodgerblue","deepskyblue","cyan","turquoise","limegreen","lime","Greenyellow","Yellow","Orange","darkorange","Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple"]//rainbow2
];

/** \name stringChunk
\page Functions
stringChunk() separates charcter from a string
\param txt input string
\param start start of extraction
\param length number of characters to extract
*/

function stringChunk(txt,start=0,length,string="")=
  let(
    start=abs(start),
    length=is_undef(length)?len(str(txt))-start:length
  )
  len(string)<length&&start<len(txt)?stringChunk(txt=txt,length=length,start=start+1,string=str(string,str(txt)[start])):string;


// list of parent modules [["name",id]]
function parentList(n=-1,start=1)=  is_undef($parent_modules)||$parent_modules==start?undef:[for(i=[start:$parent_modules +n])[parent_module(i),i]];

function is_parent(parent= needs2D, i= 0)=
is_list(parent)?is_num(search(parent,parentList())[i])?true:
                                                      i<len(parent)-1?is_parent(parent=parent,i=i+1):
                                                                      false:
                is_num(search([parent],parentList())[0]);



function bool(n,bool)= b(n,bool);
function b(n,bool)=  is_list(n)?[for(i=[0:len(n)-1])b(n[i],bool)]:
                               is_num(n)?bool||is_undef(bool)?n?true:
                                                                false:
                                                              n?n:
                                                                0:
                                         bool?n?true:  // n = bool
                                                false:
                                              n?1:
                                                0;

function gradB(b,r)=360/(PI*r*2)*b; // winkel zur Bogen strecke b des Kreisradiuses r

function v3(v)= [
is_num(v.x)?v.x:is_num(v)?v:0,
is_num(v.y)?v.y:0,
is_num(v.z)?v.z:0,
 ];

/** \page Functions \name kreis
kreis() generates points on a circle or arc
\param r radius
\param rand dist second radius
\param grad angle
\param grad2 angle second arc
\param fn fragments

\param center center angle
\param sek  chord or center point
\param r2  y component
\param rand2  y component
\param rot rotate points
\param t translate points
\param z z value for polyhedron
\param d ovewrite radius with diameter
\param endPoint end angle with point
\param fs fragment size
\param fs2 fragment size second arc
\param fn2 fragments second arc
\param minF minimum fragments
*/

function Kreis(r=10,rand=+5,grad=360,grad2,fn=ub_fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,ub_fn,center,sek,r2,rand2,rcenter,rot,t);




function kreis(r=10,rand=+5,grad=360,grad2,fn=ub_fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=ub_fs,fs2,fn2,minF=1,fa=ub_fa)=
let (
minF=bool(minF,bool=false),
grad2=is_undef(grad2)?grad:grad2,
r=is_num(d)?rcenter?(d+rand)/2:d/2:
            rcenter?r+rand/2:r,
rand2=is_undef(rand2)?rand:rand2,
r2=r2?
    rcenter?r2+rand2/2:r2
    :r,
ifn=is_num(fn)&&ub_fn>0?max(1,ceil(abs(fn)))
                    :min(max(abs(grad)<180?1
                                       :abs(grad)==360?3
                                                      :2,ceil(abs(PI*r*2/360*grad/max(fs,0.001))),minF),round(abs(grad)/fa) ),
fs2=is_undef(fs2)?fs:fs2,

fn2=is_num(fn)&&ub_fn>0?is_undef(fn2)?ifn:max(1,ceil(abs(fn2)))
                    :min(max(abs(grad2)<180?1:abs(grad2)==360?3:2,ceil(abs(PI*(r-rand)*2/360*grad2/max(fs2,0.001))),minF),round(grad/fa)),

step=grad/ifn,
step2=grad2/fn2,
t=is_list(t)?t:[t,0],
endPoint=rand?true:endPoint
)
is_num(z)?[
if(!sek&&!rand&&abs(grad)!=360&&grad)[0+t[0],0+t[1],z], // single points replacement
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1],
     z],
if(grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r  +t[0],
     cos(rot+(center?-grad/2-90:0)+iw*step)*r2 +t[1],
     z],
if(rand)for(i=[0:endPoint?fn2:fn2 -1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r  -rand )+t[0],
     cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2 -rand2)+t[1],
    z]
]:
[ // if 2D
if(!sek&&!rand&&abs(grad)!=360&&grad||r==0)[0+t[0],0+t[1]], // single points replacement
if(r&&grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r+t[0],
    cos(rot+(center?-grad/2-90:0)+iw*step)*r2+t[1]],
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1]],
if(rand)for(i=[0:endPoint?fn2:fn2-1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r-rand)+t[0],
    cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2-rand2)+t[1]]
];


/** \page Polygons
Pfeil() creates an arrow
\brief creates an arrow
\name Pfeil
\param l length [tail,head] or total length
\param b width  [tail,head] or teil and head is calculated by angle(grad)
\param shift shifting center and end points
\param grad arrow head angle
\param d form circular arrow
\param angle angle of circular arrow (optional)
\param center centers arrow
\param name  names arrow
\param help activate help
*/

//Pfeil(d=20,angle=-70,shift=-1);


module Pfeil(l=[+2,+3.5],b=+2,shift=0,grad=60,d=0,angle=0,center=true,name,help){
 shift=is_list(shift)?shift:[shift,-shift];
 l=is_list(l)?l:[l/2,l/2];
 b=is_list(b)?b:[b,2*(l[1]-(d?0:shift[0]))*tan(grad/2)];
 center=is_bool(center)?center?[1,1]:[0,0]:is_list(center)?center:[center,center];
 dir=sign(d)*(angle?sign(angle):1);
 d=d?max(abs(d),abs(b[1])):0;

 lD=[angle?min(abs(d)*PI/360*abs(angle),PI*abs(d)-l[1]-shift[0]-.01 ) :l[0],l[1]];// lenght circular arrow
 angle=angle?angle:gradB(r=d/2,b=l[0])*dir;

 gradB=d?gradB(b=lD[1]+ shift[1],r=d/2)  :0; // länge Pfeilspitze auf Kreis

 fnD=max(8,ceil(norm([b[1]/2,lD[1]])/$fs)); // fraqments gebogene Spitze
 fnDend=max(10,ceil(abs(lD[0])/$fs));

 spitze=false; // gebogene Spitze = false

 points=[
     [l[1],0],//spitze
     [shift[0],b[1]/2],
     [0,b[0]/2],
  if(!d)[-l[0],b[0]/2],//End oben
  if(!d)[-l[0]+shift[1],0],//End mitte
  if(!d)[-l[0],-b[0]/2],//End unten
     [0,-b[0]/2],
     [shift[0],-b[1]/2],
    ];


  pointsD=[
    [0,d/2-b[0]/2],
    each kreis(rand=0,grad=dir*gradB(r=d/2+b[0]/2*0,b=-lD[0]),d=d+b[0],center=0,fn=fnDend),
    [sin(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2,cos(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2],//shift End

    each kreis(rand=0,grad=dir*-gradB(r=d/2-b[0]/2*0,b=-lD[0]),d=d-b[0],center=0,rot=dir*gradB(r=d/2-b[0]/2*0,b=-lD[0]),fn=fnDend),

    [0,d/2+b[0]/2],
    for(i=[0:fnD ])    let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 +(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],
    for(i=[fnD :-1:0]) let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 -(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],

    ];

  if(d)translate(center.y?center.y<0?[0,d/2]:
                                  [0,0]:
                  [0,-d/2]){
      if(spitze)union(){
      Kreis(d=d,rand=b[0],b=-l[0],center=false,rcenter=true,rot=-90);
      T(y=d/2)polygon(points);
      }
      else polygon(pointsD);

  }
  else translate([center.x?center.x>0?0:-l[1]:l[0],center.y?center.y>0?0:-b[1]/2:b[1]/2]) polygon(points);

InfoTxt("Pfeil",["Winkel",2*atan((b[1]/2)/(l[1]-shift[0]))],name);
HelpTxt("Pfeil",[
    "l",l,
    "b",b,
    "shift",shift,
    "grad",grad,
    "d",d,
    "angle",angle,
    "center",center,
    "name",name],help);
}

/// display variable values
module InfoTxt(name,string,info,help=false){
  $tab=is_undef($tab)?0:$tab;
  info=is_undef(info)?is_undef($info)?false:
                                $info:
  info;

  //  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Function_Literals
 noInfo=is_undef($noInfo)?false:$noInfo;
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 joinArray= function(in,out="",pos=0) pos>=len(in)?out: // scad version > 2021
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);

 if(version()[0]<2021){
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",is_num(string[i+1])?negRed(string[i+1]):string[i+1],i<len(string)-2?", ":"")];

if(info)if(is_list(string))echo(
 str(is_bool(info)?"":"<b>",info," ",name," ",
infoText[0]
,infoText[1]?infoText[1]:""
,infoText[2]?infoText[2]:""
,infoText[3]?infoText[3]:""
,infoText[4]?infoText[4]:""
,infoText[5]?infoText[5]:""
,infoText[6]?infoText[6]:""
,infoText[7]?infoText[7]:""
,infoText[8]?infoText[8]:""
,infoText[9]?infoText[9]:""
));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
else { // current version info
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],i<len(string)-2?", ":"")];

if(info&&(!idx||idxON)&&!noInfo)if(is_list(string))echo(
 str(is_string(info)?$tab?"⏩\t":
                          "🟩\t••":
                     "",$tab?" ╞▷   ":
                             "",b($tab,false)>1?" ┗▶   ":
                                                " ",info," ",name," ",
joinArray(infoText)));

else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=help);
}


//Text("fhpbdlqQPXMALTfF",size=10,trueSize="cap",cy=+0);
//%square([100,10]);

//Text("HTAMpqf",radius=20,rot=0);
//Text("HTAMMMMMM",trueSize="textl",size=20,textmetrics=0,spacing=1);


module Text(text="»«",size=5,h,cx,cy,cz,center=0,spacing=1,fn,fs=ub_fs,radius=0,rot=[0,0,0],font="Bahnschrift:style=bold",style,help,name,textmetrics=true,viewPos=false,trueSize="body")
{

text=str(text);
lenT=len(text);
textmetrics=version()[0]<2022?false:textmetrics;

Echo(str("Sizing inactive trueSize=",trueSizeSW),color="warning",condition=trueSize!="size"&&( (!textmetrics&&trueSize!="body")||(is_num(useVersion)&&useVersion<22.208) ) );

trueSizeSW=is_num(useVersion)&&useVersion<22.208?"size":trueSize;
inputSize=size;

style=is_string(style)?style:styles[style];
font=is_num(font)?fonts[font]:font;
fontstr=is_undef(style)?font:str(font,":style=",style);

hp=textmetrics?textmetrics(text="hpbdlq",font=fontstr,size=1,spacing=spacing).size.y:1;
cap=textmetrics?textmetrics(text="HTAME",font=fontstr,size=1,spacing=spacing).size.y:1;
textSize=textmetrics?textmetrics(text=text,font=fontstr,size=1,spacing=spacing).size:[lenT*spacing,1];
fontS=textmetrics?fontmetrics(font=fontstr,size=1).nominal:1;


size=trueSizeSW=="body"?size*.72:
     trueSizeSW=="hp"?size/hp:
     trueSizeSW=="cap"?size/cap:
     trueSizeSW=="text"?size/textSize.y:
     trueSizeSW=="textl"?size/textSize.x:
     trueSizeSW=="font"?size/(fontS.ascent-fontS.descent):
     size;

    h=is_parent(needs2D)?0:is_undef(h)?size:h;
    cx=center?is_undef(cx)?1:cx:is_undef(cx)?0:cx;
    cy=center?is_undef(cy)?1:cy:is_undef(cy)?0:cy;
    cz=center?is_undef(cz)?1:cz:is_undef(cz)?0:cz;



    txtSizeX=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.x:size*spacing*lenT;
    txtSizeY=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.y:size;
    fontSize=[for(i=[0:max(lenT-1,0)])textmetrics?
      textmetrics(text=stringChunk(txt=text,length=i),font=fontstr,size=size,spacing=spacing).advance.x + textmetrics(text=text[i],font=fontstr,size=size,spacing=1).advance.x/2*(cx?1:1)
      :
      (size*spacing)*i];


 valign=cy?b(cy,false)<0?"bottom":
                         b(cy,false)>1?"top":
                                       "center":
           "baseline";

 halign=bool(cx,false)>0?"center"
                        :bool(cx,false)<0?"right"
                                         :"left";

 if(text)
  if(!radius){
    if(h)
    rotate(rot)translate([0,0,cz?-abs(h)/2:h<0?h:0]) linear_extrude(abs(h),convexity=10){
    text(str(text),size=size,halign=halign,valign=valign,font=fontstr,spacing=spacing,$fn=fn,$fs=fs);
    }
    else rotate(rot)translate([0,0,cz?-h/2:0])text(text,size=size,halign=halign,valign=valign,spacing=spacing,font=fontstr,$fn=fn,$fs=fs);
  }
  else if (lenT){
   iRadius=radius+(cy?-txtSizeY/2:0);
    rotate(center?textmetrics?gradB(txtSizeX/2,iRadius):gradB(max(fontSize),iRadius)/2:0)
    for(i=[0:lenT-1])rotate(-gradB(fontSize[i],iRadius))
    if(h)
    translate([0,radius,0])rotate(rot)Tz(cz?-abs(h)/2:h<0?h:0){
    %color("Chartreuse")if(viewPos&&$preview)translate([0,-1])rotate(-30)circle($fn=3);// pos Marker
    linear_extrude(abs(h),convexity=10)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
    }
    else  translate([0,radius,cz?-h/2:0])rotate(rot)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
  }

 InfoTxt("Text",["font",font,"style",style,"trueSize",trueSizeSW,"size",str(inputSize," ⇒ ",size)],name);

 HelpTxt("Text",[
"text",str("\"",text,"\""),
"size",inputSize,
"h",str(h," /*0 for 2D*/"),
"cx",cx,
"cy",cy,
"cz",cz,
"center",center,
"spacing",spacing,
"fn",fn,
"fs",fs,
"radius",radius,
"rot",rot,
"font",str("\"",font,"\""),
"style",str("\"",style,"\""),
"name",name,
"textmetrics",textmetrics,
"viewPos",viewPos,
"trueSize",str("\"",trueSize,"\""," /* body,size,hp,cap,text,textl,font */")
],help);


}

/// short for translate[];
module T(x=0,y=0,z=0,help=false)
{
    //translate([x,y,z])children();
if(is_list(x))
    multmatrix(m=[
    [1,0,0,x[0]],
    [0,1,0,x[1]],
    [0,0,1,is_undef(x.z)?z:x[2]+z],
    [0,0,0,1]
    ])children();
else
    multmatrix(m=[
    [1,0,0,x],
    [0,1,0,y],
    [0,0,1,z],
    [0,0,0,1]
    ])children();


    MO(!$children);
    HelpTxt("T",["x",x,"y",y,"z",z],help);
}

/// missing object text
module MO(condition=true,warn=false){
$idx=is_undef($idx)?false:$idx;
Echo(str(parent_module(2)," has no children!"),color=warn?"warning":"red",condition=condition&&$parent_modules>1&&!$idx,help=false);
}

/// echo color differtiations
module Echo(title,color="#FF0000",size=2,condition=true,help=false){
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 if(condition&&(!idx||idxON))
     if(version()[0]<2021)echo(str("<H",size,"><font color=",color,">",title));
     else if (color=="#FF0000"||color=="red")echo(str("\n🔴\t»»» ",title));
     else if (color=="redring")echo(str("\n⭕\t»»» ",title));
     else if (color=="#FFA500"||color=="orange")echo(str("\n🟠\t»»» ",title));
     else if (color=="#00FF00"||color=="green"||color=="info")echo(str("🟢\t ",title));
     else if (color=="#0000FF"||color=="blue") echo(str("🔵\t ",title));
     else if (color=="#FF00FF"||color=="purple") echo(str("🟣\t ",title));
     else if (color=="#000000"||color=="black") echo(str("⬤\t ",title));
     else if (color=="#FFFFFF"||color=="white") echo(str("◯\t ",title));
     else if (color=="#FFFF00"||color=="yellow"||color=="warning") echo(str("⚠\t ",title));
         else echo(str("• ",title));

 HelpTxt("Echo",["title",title,"color",color,"size",size,"condition",condition],help);
}

//Clone and mirror object
module MKlon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx,my,mz,help=false)
{
    mx=is_undef(mx)?sign(abs(tx)):mx;
    my=is_undef(my)?sign(abs(ty)):my;
    mz=is_undef(mz)?!mx&&!my?1:sign(abs(tz)):mz;

  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children();

    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
        translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children();
    }
    MO(!$children);
    HelpTxt("MKlon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz,"mx",mx,"my",my,"mz",mz],help);

}

// Clone and mirror (replaced by MKlon)
module Mklon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx=0,my=0,mz=1)
{
    mx=tx?1:mx;
    my=ty?1:my;
    mz=tz?1:mz;
  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children();
    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children(); }
   MO(!$children);
}


// color by color lists
module Col(no=0,alpha=1,pal=0,name=0,help){
   palette=["std","VGA","grey","pink","red","orange","yellow","brown","green","cyan","blue","violett","white","rainbow"];

HelpTxt("Col",["no",no,"alpha",alpha,"pal",pal,"name",name],help);

    for(i=[0:1:$children-1]){
    $idx=i;
    color(co[pal][(no+i)%len(co[pal])],alpha)children(i);
    union(){
      $idx=0;
    InfoTxt("Col",["Color children ($idx)",str(i," Farb№: ",no+i,"- ",co[pal][(no+i)%len(co[pal])])," von ",len(co[pal])-1,"Palette",str(pal,"/",palette[pal],(no+i>len(co[pal])-1)?" — Out of Range":"")],name);
    }
    }
    MO(!$children);
}


/** \page Helper
 Caliper() shows a distance and can be used as annotation
 \brief Caliper shows a distance and can be used as annotation
 \param l length to show
 \param in direction
 \param center centered length
 \param messpunkt show / size of gizmo
 \param translate  translates the text and arrow
 \param end differnt end options [0:none,1:triangle, 2:square, 3:arrow in, 4:arrow out]
 \param h height while end=0,3,4 can be 2D if h=0
 \param on switch on=2 if Caliper should be rendered
 \param l2 arrow width
 \param txt  l+mm is used optional text
 \param txt2  optional second text
 \param size size
*/
//Caliper(end=0,messpunkt=0,in=1,translate=[20,-5],center=+1);

//Caliper(end=3);
//Caliper(end=3,txt2="X—Length",in=+1);


module Caliper(l=40,in=1,center=true,messpunkt=true,translate=[0,0,0],end=1,h,on=$preview,l2,txt,txt2,size=$vpd/15,render,s,t,cx,cy,help=false){

    on=render?render:on;
    s=s?s:size;
    txt=is_undef(txt)?str(l,end==2?"":"mm"):str(txt);
    center=is_bool(center)?center?1:0:center;
    textl=in>1?s/2.5:s/4*(len(str(txt)));// end=0,3,4 use own def
    line=s/20;
    translate=t?v3(t):v3(translate);
    //l2=is_undef(l2)?s:l2;


    if(on&&$preview||on==2)translate(translate)translate(in>1?center?[0,0]:[0,l/2]:center?[0,0]:[l/2,0]){
      if(end==1)Col(5){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=l/2,mz=0)polygon([[max(-5,-l/3),0],[0,s],[0,0]]);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=-l/2,mz=0)polygon([[max(-5,-l/3),0],[0,-s],[0,0]]);

        Text(h=h+.1,text=txt,center=true,size=s/4,trueSize="size",cx=cx,cy=cy);
        }
     else if(end==2)Col(3)union(){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)T(-(l-textl*2)/4,0)cube([max(l-textl*2,.01)/2,line,h],center=true);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)cube([line,s,h],center=true);
        translate([(l<textl+1&&in<2)?l/2+textl/2+1.5:0,
          l<s/2 +1&&in>1?l/2+s/4+1:0,0])
            Text(h=h+.1,text=txt,center=true,size=s/2,trueSize="size",cx=cx,cy=cy);
         if(l<textl+1&&in<2)translate([.25,0])square([l+.5,line],true);
         if(l<s+1&&in>=2) translate([0,.25])square([line,l+.5],true);

        }
        else Col(1) {
        h=is_undef(h)?.1:h;
          if(h) linear_extrude(h,convexity=5) Dimensioning();
          else Dimensioning();
        }
    }

Echo("Caliper will render",color="warning",condition=on==2);
if(h&&end&&on&&end<3)
Pivot(messpunkt=messpunkt,p0=translate,active=[1,1,1,1,norm(translate)]);

    HelpTxt("Caliper",[
    "l",l,
    "in",in,
    "size",size,
    "center",center,
    "messpunkt",messpunkt,
    "translate",translate,
    "end",end,
    "h",h,
    "on",on,
    "l2",l2,
    "txt",txt,
    "txt2",txt2]
    ,help);


  module Dimensioning (t=translate){
            s=s==$vpd/15?5:s;
            txt2=txt2?str(txt2):"";
            line=s/20;
            textS=len(txt2)?s/2*.72:s*.72;//text size
            l2=l2?l2:s/1.5;
            textl=in>1?(len(txt2)?3:1.5)*textS:1+textS*max(len(txt),len(txt2))*0.95;
            arrowL=min(l/6,s);
            textOut=l<textl+arrowL*2||(abs(translate.y)>l/2&& (in==2||in==3) )||(abs(translate.x)>l/2&&in!=2&&in!=3); // is text outside l
            textOffset=l<textl+arrowL*2?l/2+textl/2+1:0;
            diffT=in!=2&&in!=3? t.x:-t.y;

// text line
        if(l-textl>0)rotate(in?in==2?90:in==3?-90:180:0){
         if(!textOut&&l-textl - diffT*2>0) T(-l/2)T((l-textl)/4 +diffT/2,0)square([(l-textl)/2-diffT,line],center=true);
         if(!textOut&&l-textl + diffT*2>0) T( l/2)T(-(l-textl)/4 +diffT/2,0)square([(l-textl)/2+diffT,line],center=true);
        }
//End lines vertical
        translate(in!=2&&in!=3?[-translate.x,0]:[0,-translate.y])rotate(in?in==2?90:in==3?-90:180:0){
        MKlon(tx=l/2){
           T(end?end==4?-line/2:+line/2:0) square([line,s],center=true);
           if(end)rotate(end==4?180:0)Pfeil([0,arrowL],b=[line,l2],center=[-1,1],name=false);
        }
        if(textOut) square([l,line],true); // Verbindung Pfeile
// text pos
        translate(in!=2&&in!=3?[(in?1:-1) * -translate.x,0]:[(in==2?1:-1)*translate.y,0]){
          translate([textOffset,0])rotate(in>1?-90:180){
            if(len(txt2))translate([0,-textS/1.5])Text(h=0,text=txt2,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
            translate([0,len(txt2)?textS/1.5:0])Text(h=0,text=txt,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
          }
        }
// verbindung text ausserhalb
        tOutDist=(in!=2&&in!=3)? t.x *(in   ?-1:1) + textOffset :
                                 t.y *(in==3?-1:1) + textOffset ;

        if(textOut&&tOutDist)rotate(tOutDist<0?180:0)translate([0,-line/2])square([abs(tOutDist)-textl/2 ,line]);
        }

// verlängerungen translate auf 0.5
      mkL=end?end==4?l/2-line:l/2:l/2-line/2;
       if(abs(translate.y)>(l2/2+.5)&&in!=2&&in!=3)translate([-translate.x,0])MKlon(tx=mkL) mirror([0,translate.y>0?1:0,0])square([line,abs(translate.y)-.5],false);
       if(abs(translate.x)>(l2/2+.5)&&(in==2||in==3))translate([0,-translate.y])MKlon(ty=mkL) mirror([translate.x>0?1:0,0,0])square([abs(translate.x)-.5,line],false);
       //if(translate.x) mirror([translate.x>0?1:0,0,0])T(l/2,-line/2)square([abs(translate.x),line],false);

  }// end Dimensioning


}// end Caliper


// display the module variables in a copyable format
module HelpTxt(titel,string,help){
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;

   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);

helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){
if(help)if(is_list(string))echo(

str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:""
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""


// ," name=",name,
," help);"));
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help
if(help&&!idx)if(is_list(string))echo(

str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}