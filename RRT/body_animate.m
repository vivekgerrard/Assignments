function body_animate(t,x,par,xy_eef, enable_obstacle)

%% Settings
colors = [1 0 0];

%% Create link shape
shape1 = linkshape(par.a1);
shape2 = linkshape(par.a2);
shape3 = linkshape(par.a3);
shape4 = linkshape(par.a4);

%% Objects
clf
animationfig = figure(1);
AxesHandle = axes('Parent',animationfig,  'Position',[0 0 1 1]);
link1 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
link2 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
link3 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
link4 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
table = line('Parent',AxesHandle, 'Color',[0 0 0], 'LineWidth',2);
if(~isempty(xy_eef))
    eef = line('Parent',AxesHandle,'Color',[0 0 1],'LineWidth',1);
end;
if(enable_obstacle)
    bin1 = line('Parent',AxesHandle,'Color',[1 0 0],'LineWidth',2);
    bin2 = line('Parent',AxesHandle,'Color',[1 0 0],'LineWidth',2);
    ball = line('Parent',AxesHandle, 'MarkerFaceColor',[1 0 0],'Marker','o','MarkerSize',32);
end;

%% Animation


p1=0;
p2=0;
p3=0;
p4=0;

n=0;
while n<length(t)
n=n+1;    
    
    % state vector
    p1 = x(n,1);
    p2 = x(n,2);
    p3 = x(n,3);
    p4 = x(n,4);

    
    % leg positions
    pos1 = move(R(p1)*shape1,[0;0]);
    pos2 = move(R(p2)*shape2,coor(p1, par.a1)-coor(p2, par.a2));
    pos3 = move(R(p3)*shape3,coor(p1, par.a1));
    pos4 = move(R(p4)*shape4,coor(p1, par.a1)+coor(p3, par.a3)-coor(p4, par.a4));

    set(link1,'Xdata',pos1(1,:),'Ydata',pos1(2,:));
    set(link2,'Xdata',pos2(1,:),'Ydata',pos2(2,:));
    set(link3,'Xdata',pos3(1,:),'Ydata',pos3(2,:));
    set(link4,'Xdata',pos4(1,:),'Ydata',pos4(2,:));
    
    % table
    table_pos = [-1, 4; -0.051 -0.051];
    bin1_pos   = [0.5 0.5; -0.051 0.9];
    bin2_pos   = [1.1 1.1; -0.051 0.9];
    ball_pos   = [0.8 0.8;0.14 0.14];
    set(table,'Xdata',table_pos(1,:),'Ydata',table_pos(2,:));
    if(enable_obstacle)
        set(bin1,'Xdata',bin1_pos(1,:),'Ydata',bin1_pos(2,:));
        set(bin2,'Xdata',bin2_pos(1,:),'Ydata',bin2_pos(2,:));
        set(ball,'Xdata',ball_pos(1,:),'Ydata',ball_pos(2,:));
    end;
    if(~isempty(xy_eef))
        set(eef,'Xdata',xy_eef(:,1)','Ydata',xy_eef(:,2)');
    end;
    drawnow
    axis equal
    pause(0.05);
end

function d = coor(p, a) %calculates local coordinates using angles
d = [-a*sin(p),a*cos(p)];


function shape = linkshape(l)
link_width = 0.1;
n   = linspace(pi/2,-pi/2,20);
top_arc    = (link_width/2)*[sin(n);cos(n)];
bottom_arc = (link_width/2)*[-sin(n);-cos(n)];
if l<0
    bottom_arc(2,:) = bottom_arc(2,:)+l;
else
    top_arc(2,:) = top_arc(2,:)+l;
end
shape = [top_arc, bottom_arc];


function rot = R(phi)
rot = [cos(phi)  -sin(phi);
       sin(phi)   cos(phi)];
   
function c = move(a, b)
c(1,:) = a(1,:) + b(1);
c(2,:) = a(2,:) + b(2);

        
