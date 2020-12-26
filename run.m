clc
clear all
close all
%% Variable Initialization
clear all; close all;clc;
A=imread('map2.jpg');
imshow(A)
for i=1:size(A,1)
    for j=1:size(A,2)
if A(i,j,2)>150 && A(i,j,1)<150 && A(i,j,3)<150
    A(i,j,1)=0;
    A(i,j,2)=255;
    A(i,j,3)=0;
else
    A(i,j,2)=255;
    A(i,j,1)=255; 
    A(i,j,3)=255;
end
    end
end
imshow(A)
B=A(:,:,2);
C=A(:,:,1);
D=A(:,:,3);
B(B==255 & C==0 & D==0)=255;
B(B==255 & C==255 & D==255)=0;
B=double(B);
Area_Map=zeros(size(B));
Area_Map(B==255)=1;
Discovered_Map_init=2.*ones(size(Area_Map));
%% Area Map
 [r,t]=size(Area_Map);
% figure()
% for i=1:r-1
%     for j=1:t-1
%         v=t-[i i i+1 i+1];
%         u=[j j+1 j+1 j];
%         if Area_Map(i,j)==1
%             color='green';
%         else
%             color='white';
%         end
%         patch(u,v,color)
%         hold on
%     end
% end
% title('Area Map')
% hold off
%% Origin Coordinates
% Discovered_Map=2.*ones(size(Area_Map));
R=50;
xi(rem(size(Area_Map,2),2)==0)=size(Area_Map,2)/2;
xi(rem(size(Area_Map,2),2)~=0)=(size(Area_Map,2)+1)/2;
yi(rem(size(Area_Map,1),2)~=0)=(size(Area_Map,1)+1)/2;
yi(rem(size(Area_Map,1),2)==0)=size(Area_Map,1)/2;
% xi=15;
% yi=15;
origin=[xi yi];

%% Initial Pass
x_origin=origin(1);
y_origin=origin(2);
% a=R/5;
% x=x_origin.*ones(1,8)+[0 a/2 a/2 -a/2 -a/2 a/2 a/2 0];
% y=y_origin.*ones(1,8)-[0 0 a/2 a/2 -a/2 -a/2 0 0];
% %y=x_origin.*ones(1,4)+[0 a -a 0];
% %x=y_origin.*ones(1,4)+[0 0 0 0];
theta = 0:0.5:360;
h = animatedline;
X=[];
Y=[];
k=1;
for p=1:(length(theta))
    x = R*cosd(theta(p)).*cosd(2*theta(p)).*sind(2*theta(p));
    y = R*sind(2*theta(p)).*cosd(2*theta(p)).*sind(theta(p));     
    %Discovered_Map(yi-floor(y/2),floor(x/2)+xi)=1;    
    %addpoints(h,x+xi,y+yi);
    %drawnow
    x=floor(x);y=floor(y);
    if k<=1
    X=[X,x];Y=[Y,y];k=k+1;
    elseif k>1 && x~=X(1,k-1) && y~=Y(1,k-1)
        X=[X,x];Y=[Y,y]
     k=k+1;
    end
end
X=x_origin.*ones(1,length(X))+X;
Y=y_origin.*ones(1,length(Y))-Y;
X=[X x_origin];Y=[Y y_origin];
coordinates=[X' Y'];
Discovered_Map_first_pass=DM_update_4(Discovered_Map_init,Area_Map,coordinates,R);
figure()
plotter2(Discovered_Map_first_pass,coordinates,origin)
% imshow(Discovered_Map)
Discovered_Map_old=Discovered_Map_first_pass;
%% Path-Planning
percent_discovered=0.1;
figure()
while ((percent_discovered<0.8) | (percent_discovered==1))
    check=false;
    for i=1:r
    if check==true
            break
    end
    for j=1:t
        if check==true
            break
        elseif (Discovered_Map_old(i,j)>0 & Discovered_Map_old(i,j)<1)
            check=true;
            continue
        else
            check=false;
        end
    end
    end
switch check
    case true
        coordinates=path_planning(Discovered_Map_old,origin,R);
        [p,q]=size(coordinates);
%         f1=coordinates(:,1);
%         f2=coordinates(:,2);
%         coordinates(:,1)=f2;
%         coordinates(:,2)=f1;
            if p==0
                 break
            else
        
        Discovered_Map_New=DM_update_4(Discovered_Map_old,Area_Map,coordinates,R);
            end
    case false
        Discovered_Map_New=random_aiming(Discovered_Map_old,Area_Map,origin,R);
end
     
[a,b]=size(Discovered_Map_New);
counter=0;
counter2=0;
for i=1:a
    for j=1:b
        if ((Discovered_Map_New(i,j)==2) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R/2))
            counter=counter+1;
        elseif (((Discovered_Map_New(i,j)==1) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R/2)) | ((Discovered_Map_New(i,j)==0) & (sqrt((i-x_origin)^2+(j-y_origin)^2)<R/2)))
            counter2=counter2+1;
        end
    end
end
percent_discovered=counter2/(counter2+counter);
Discovered_Map_old=Discovered_Map_New;
plotter2(Discovered_Map_New,coordinates,origin)
hold on
pause(0.2)
end



