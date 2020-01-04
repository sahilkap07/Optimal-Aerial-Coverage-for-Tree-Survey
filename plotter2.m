function Path=plotter2(Discovered_Map_New,coordinates,origin)
m=size(Discovered_Map_New,1);
n=size(Discovered_Map_New,2);
% [p,q]=size(coordinates);
figure;
for i=1:m-1
    for j=1:n-1
%         u=origin(1)-[i i i+1 i+1];
%         v=origin(2)+[j j+1 j+1 j];
            v=n-[i i i+1 i+1];
            u=[j j+1 j+1 j];
        switch Discovered_Map_New(i,j)
            case 0
                color='white';
            case 1
                color='green';
            case 2
                color=[0.9290 0.6940 0.1250];
            case 3
                color='green'; 
            otherwise
                color='red';
        end
        Path=patch(u,v,color)
    end
end
hold on
xi=origin(1,1);
yi=origin(1,2);
x=coordinates(1,1);
if coordinates(1,2)<yi
    y = coordinates(1,2)+2*(yi-coordinates(1,2))+n-m;
    else
        y=coordinates(1,2)-2*(coordinates(1,2)-yi)+n-m;
    end
h = animatedline(x,y,'Color','r','LineWidth',3);
for p=1:length(coordinates)
    x = coordinates(p,1)
    if coordinates(p,2)<yi
    y = coordinates(p,2)+2*(yi-coordinates(p,2))+n-m;
    else
        y=coordinates(p,2)-2*(coordinates(p,2)-yi)+n-m;
    end
    addpoints(h,x,y);
    %drawnow
    scatter(x,y)
end
hold off
end


