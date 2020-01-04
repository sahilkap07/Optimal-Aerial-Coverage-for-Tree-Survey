function Discovered_Map_New=random_aiming(Discovered_Map_New,Area_Map,origin,R)
[m,n]=size(Discovered_Map_New);
angle_options=ones(1,36);
r=randi([1,length(angle_options)],1,1);
    while angle_options(r)==0
    r=randi([1,length(angle_options)],1,1);
    end
    angle_span=2*360/length(angle_options);
    teta=r*angle_span/2;
    angle_options(r)=0;
    x=R/(2+2*sind(angle_span/2));
    y=x*sind(angle_span/2);
    r_ax=x*cosd(teta-angle_span/2)
    r_ay=x*sind(teta-angle_span/2);
    r_bx=x*cosd(teta+angle_span/2)
    r_by=x*sind(teta+angle_span/2);
    coordinates=floor([origin;origin(1)-r_ay,origin(2)+r_ax;origin(1)-r_by origin(2)+r_bx;origin]);
    Discovered_Map_New=DM_update_4(Discovered_Map_New,Area_Map,coordinates,R);
end