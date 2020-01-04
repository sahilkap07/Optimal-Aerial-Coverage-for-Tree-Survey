function coordinates=path_planning(Discovered_Map,origin,R)
[u,v]=size(Discovered_Map);
x_origin=origin(1);
y_origin=origin(2);
angle=[];
probable_weight=[];
step=10;
for i=1:u
    for j=1:v
        if (Discovered_Map(i,j)>0 & Discovered_Map(i,j)<1)
            angle=[angle;atand((j-y_origin)/(i-x_origin))];
            probable_weight=[probable_weight;Discovered_Map(i,j)];
        end
    end
end
teta=90+sum(angle.*probable_weight)/sum(probable_weight);
d=0;
teta_ub=teta+step;
teta_lb=teta-step;
point_interest=[x_origin,y_origin];
while (d<=R & (teta_ub<(teta+180)))
teta_lb=teta_lb-step;
teta_ub=teta_ub+step;
for i=1:u
    for j=1:v
        if ((Discovered_Map(i,j)>0)&(Discovered_Map(i,j)<1)&(90+atand((j-y_origin)/(i-x_origin))<teta_ub) & (90+atand((j-y_origin)/(i-x_origin))>teta_lb))
            point_interest=[point_interest;i,j];
        end
    end
end
step=step+10;
x=point_interest(:,1);
y=point_interest(:,2);
n=length(x);
if n==1
    continue
end
    index=nchoosek(1:n,2);
    dist=hypot(x(index(:,1))-x(index(:,2)),y(index(:,1))-y(index(:,2)));
    ldist=length(dist);
    Aeq=spones(1:length(index));
    beq=n;
    Aeq=[Aeq;spalloc(n,length(index),n*(n-1))];
    opts = optimoptions('intlinprog','Display','off');
        for i=1:n
            w=(index==i);
            w=sparse(sum(w,2));
            Aeq(i+1,:)=w';
        end
    beq = [beq; 2*ones(n,1)];
    intcon=1:ldist;
    lb=zeros(ldist,1);
    ub=ones(ldist,1);
    [x_opt,cost]=intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);
    A = spalloc(0,ldist,0); % Allocate a sparse linear inequality constraint matrix
    b = [];
    tours = detectSubtours(x_opt,index);
    numtours = length(tours); % number of subtours
    A = spalloc(0,ldist,0); % Allocate a sparse linear inequality constraint matrix
    b = [];
    if numtours==1
        d=cost;
    else
        while numtours > 1 % repeat until there is just one subtour
        % Add the subtour constraints
        b = [b;zeros(numtours,1)]; % allocate b
        A = [A;spalloc(numtours,ldist,n)]; % a guess at how many nonzeros to allocate
            for ii = 1:numtours
                rowIdx = size(A,1)+1; % Counter for indexing
                subTourIdx = tours{ii}; % Extract the current subtour
%         The next lines find all of the variables associated with the
%         particular subtour, then add an inequality constraint to prohibit
%         that subtour and all subtours that use those stops.
                variations = nchoosek(1:length(subTourIdx),2);
                    for jj = 1:length(variations)
                        whichVar = (sum(index==subTourIdx(variations(jj,1)),2)) & ...
                       (sum(index==subTourIdx(variations(jj,2)),2));
                        A(rowIdx,whichVar) = 1;
                    end
                b(rowIdx) = length(subTourIdx)-1; % One less trip than subtour stops
            end
           [x_opt,cost]=intlinprog(dist,intcon,A,b,Aeq,beq,lb,ub,opts);
    for q=1:length(x_opt)
        if x_opt(q)>0.5
            x_opt(q)=1;
        else
            x_opt(q)=0;
        end
    end
    tours = detectSubtours(x_opt,index);
    numtours = length(tours); 
    fprintf('Number of subtours: %d\n',numtours);
    d=cost;
        end
        end
% Tour_No=(1:n)';
% Start_point=[1;u(1:end-1)];
% End_point=u;
% table(Tour_No,Start_point,End_point)
% fprintf('Total Travel Distance: %d\n',cost);
end
[e,i]=size(point_interest);    
if e~=1
    order=(tours{1,1})';
    coordinates=[x_origin,y_origin];
    coordinates=[coordinates;point_interest(order,:)];
else
    coordinates=[];
end
end
            