clc;
clear all;
close all;
Map=zeros(30,30);
Map(1:3,1)=1;
Map(7,1:end-2)=1;
%% Define Map
Area_Map=Map;
[r,t]=size(Area_Map)
figure()
for i=1:r-1
    for j=1:t-1
        v=t-[i i i+1 i+1];
        u=[j j+1 j+1 j];
        if Area_Map(i,j)==1
            color='green';
        else
            color='white';
        end
        patch(u,v,color)
        hold on
    end
end
title('Actual Map')
hold on
%% Origin Coordinates
Discovered_Map=2.*ones(size(Area_Map));
PM=zeros(size(Area_Map));
R=20;
xi(rem(size(Area_Map,2),2)==0)=size(Area_Map,2)/2;
xi(rem(size(Area_Map,2),2)~=0)=(size(Area_Map,2)+1)/2;
yi(rem(size(Area_Map,1),2)~=0)=(size(Area_Map,1)+1)/2;
yi(rem(size(Area_Map,1),2)==0)=size(Area_Map,1)/2;
origin(1)=xi;
origin(2)=yi;
%% Initial Pass
theta = 0:0.25:360;
[r,t]=size(Discovered_Map);
figure()
for i=1:r-1
    for j=1:t-1
        v=t-[i i i+1 i+1];
        u=[j j+1 j+1 j];
        
        switch Discovered_Map(i,j)
            case 0
                color='white';
            case 1
                color='green';
            case 2
                color=[0.9290 0.6940 0.1250];
        end
        patch(u,v,color)
        caxis([0 1])
        hold on
    end
end
xlabel('X')
ylabel('Y')
title('Discovered Map')
h = animatedline;
x1=origin(1);
y1=origin(2);
for p=1:(length(theta))
    x = R*cosd(theta(p)).*cosd(2*theta(p)).*sind(2*theta(p));
    y = R*sind(2*theta(p)).*cosd(2*theta(p)).*sind(theta(p));
    x2=x;
    y2=y;
    coordinates=[x1 y1;x2 y2];
%     if Area_Map(yi-floor(y/2),floor(x/2)+xi)==1
%        Discovered_Map(yi-floor(y/2),floor(x/2)+xi)=1;
%     else
%        Discovered_Map(yi-floor(y/2),floor(x/2)+xi)=0; 
%     end
    Discovered_Map=update_discovered(Discovered_Map,Area_Map,coordinates);
    addpoints(h,x+xi,y+yi);
    x1=x;
    y1=y;
    %drawnow
%     [u,v,color]=discovered_plotter(Discovered_Map);
%     patch(u,v,color);
end

% imshow(Discovered_Map);
% title('Discovered Map')
% probability_map=zeros(size(Area_Map));
PM=probability_update(Area_Map,Discovered_Map,R,PM,origin);
% subplot(1,3,3)
% imshow(PM)
% title('Probability Map')
%% Path-Planning
percent_discovered=0.1;
while ((percent_discovered<0.8) | (percent_discovered==1))
coordinates=path_planning(PM,origin,R);
Discovered_Map=update_discovered(Discovered_Map,Area_Map,coordinates);
PM=probability_update(Area_Map,Discovered_Map,R,PM,origin);
[a,b]=size(Discovered_Map);
counter=0;
counter2=0;
for i=1:a
    for j=1:b
        if ((Discovered_Map(i,j)==2) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R))
            counter=counter+1;
        elseif (((Discovered_Map(i,j)==1) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R)) | ((Discovered_Map(i,j)==0) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R)))
            counter2=counter2+1
    end
    end
end
percent_discovered=counter2/(counter2+counter);
pause(0.2)
end

