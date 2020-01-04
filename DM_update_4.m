function [Discovered_Map_New]=DM_update_4(Discovered_Map_Old,Area_Map,coordinates,R)
[p,q]=size(coordinates);
[u,v]=size(Discovered_Map_Old);
DM=Discovered_Map_Old;
Discovered_Map_Old(DM==1)=3;
for o=1:p-1
    t1x=coordinates(o,1);
    t1y=coordinates(o,2);
    t2x=coordinates(o+1,1);
    t2y=coordinates(o+1,2);
    t1=[t1x,t1y];
    t2=[t2x,t2y];
    for i=1:u
        for j=1:v
            if (Discovered_Map_Old(i,j)==2 || (Discovered_Map_Old(i,j)<1 && Discovered_Map_Old(i,j)>0))  & (Distance(i,j,t1,t2)<sqrt(1/2) & (j<max(t1(1),t2(1))+sqrt(1/2)) & (j>min(t1(1),t2(1))-sqrt(1/2)) & (i<max(t1(2),t2(2))+sqrt(1/2)) & (i>min(t1(2),t2(2))-sqrt(1/2)))
                if Area_Map(i,j)==1
                    Discovered_Map_Old(i,j)=1;
                else
                    Discovered_Map_Old(i,j)=0;
                end
            end
        end
    end     
end
Discovered_Map_New=Discovered_Map_Old;
for i=1:u
    for j=1:v
if (Discovered_Map_New(i,j)==1) 
        switch i
            case 1
                switch j
                    case 1
                            for m=i:i+1
                                for n=j:j+1
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                end
                            end
                
                    case v
                        
                            for m=i:i+1
                                 for n=j-1:j
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                            end
                    otherwise
                            for m=i:i+1
                                 for n=j-1:j+1
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                            end
                end
            case u
                  switch j
                    case 1
                            for m=i-1:i
                                for n=j:j+1
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                end
                            end
                
                    case v
                        
                            for m=i-1:i
                                 for n=j-1:j
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                            end
                      otherwise
                            for m=i-1:i
                                 for n=j-1:j+1
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                            end
                  end
            otherwise
                switch j
                    case 1 
                        for m=i-1:i+1
                                 for n=j:j+1
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                        end
                    case v
                        for m=i-1:i+1
                                 for n=j-1:j
                                    if (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)~=2))
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                        end
                    otherwise
                        for m=i-1:i+1
                                 for n=j-1:j+1
                                    if ((Discovered_Map_New(m,n)<1) && Discovered_Map_New(m,n)>0)
                                    Discovered_Map_New(m,n)=Discovered_Map_New(m,n)+0.1;
                                    elseif (((Discovered_Map_New(m,n)~=1)&(Discovered_Map_New(m,n)~=0)) & (Discovered_Map_New(m,n)==2))
                                     Discovered_Map_New(m,n)=0.1;   
                                    end
                                 end
                        end
                end
        end
     end
  end
end

%DM=Discovered_Map_New;
       
    function d=Distance(i,j,t1,t2)
    if t2(1)-t1(1)==0;
        d=abs((j)-t1(1));
    else
        a=(t2(2)-t1(2))/(t2(1)-t1(1));
        d=abs(a*(j)-(i)-a*t1(1)+t1(2))/sqrt(a^2+1);
    end
    end
end