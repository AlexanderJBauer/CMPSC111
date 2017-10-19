close all;
clear all;

N = 100; % in each spacial direction
u(N+1,N+1) = 0;
v(N+1,N+1) = 0;
p(N+1,N+1) = 0;
p1(N+1,N+1) = 0;

%Bounds
xmin = -pi / 2;
xmax = pi / 2;
ymin = -pi / 2;
ymax = pi / 2;

%discretise x and y
dx = (xmax - xmin)/N;
x = xmin : dx : xmax;
dy = (ymax - ymin)/N;
y = xmin : dx : xmax;

%Time
timeStep = .2 * dx;
simLength = pi;
t = 0;

%%%%%%%%%%%%%%%%%% Initial conditions and initial frame %%%%%%%%%%%%%%%%%%%%%%%%
for ix = 1:N+1
    for iy = 1:N+1
        if (sqrt((x(ix)-1)^2+(y(iy)-0)^2) <= .25)
            p(iy,ix) = 1;
        end
    end
end

for ix = 1:N+1
    for iy = 1:N+1
        u(iy,ix) = -cos(x(ix))*sin(y(iy))*cos(t);
    end
end
for ix = 1:N+1
    for iy = 1:N+1
        v(iy,ix) = sin(x(ix))*cos(y(iy))*cos(t);
    end
end

mesh(x,y,p); hold on;
%quiver(x,y,u,v);
axis([-pi/2 pi/2 -pi/2 pi/2]);
xlabel('X-Dimension');
ylabel('Y-Dimension');
zlabel('Value of P');
title('Advection Simulation No Source');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% Loop through until simLength %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t = timeStep: timeStep: simLength
    
    % Establish u and v for time t %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for ix = 1:N+1
        for iy = 1:N+1
            u(iy,ix) = -cos(x(ix))*sin(y(iy))*cos(t);
        end
    end
    for ix = 1:N+1
        for iy = 1:N+1
            v(iy,ix) = sin(x(ix))*cos(y(iy))*cos(t);
        end
    end
    U = u*timeStep/dx; %Variable to make calculations easier to type
    V = v*timeStep/dy; %Variable to make calculations easier to type
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %BOUNDARY CONDITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for iy = 1:N+1
        p(iy,1) = 0;
        p1(iy,1) = 0;
    end
    for iy = 1:N+1
        p(iy,N+1) = 0;
        p1(iy,N+1) = 0;
    end
    for ix = 1:N+1
        p(1,ix) = 0;
        p1(1,ix) = 0;
    end
    for ix = 1:N+1
        p(N+1,ix) = 0;
        p1(N+1,ix) = 0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for ix = 2:N
        for iy = 2:N
            if U(iy,ix) >= 0 && V(iy,ix) >= 0
                p1(iy,ix) = p(iy,ix) - U(iy,ix)*(p(iy,ix)-p(iy,ix-1)) ...
                           - V(iy,ix)*(p(iy,ix)-p(iy-1,ix));
            end
            if U(iy,ix) >= 0 && V(iy,ix) < 0
                p1(iy,ix) = p(iy,ix) - U(iy,ix)*(p(iy,ix)-p(iy,ix-1)) ...
                           - V(iy,ix)*(p(iy+1,ix)-p(iy,ix));
            end
            if U(iy,ix) < 0 && V(iy,ix) >= 0
                p1(iy,ix) = p(iy,ix) - U(iy,ix)*(p(iy,ix+1)-p(iy,ix)) ...
                           - V(iy,ix)*(p(iy,ix)-p(iy-1,ix));
            end
            if U(iy,ix) < 0 && V(iy,ix) < 0
                p1(iy,ix) = p(iy,ix) - U(iy,ix)*(p(iy,ix+1)-p(iy,ix)) ...
                           - V(iy,ix)*(p(iy+1,ix)-p(iy,ix));
            end
        end
    end
    
    p = p1;
    
    %%%%%%%%%%%% Plot the current state of the simulation
    clf;
    mesh(x,y,p); hold on;
%    quiver(x,y,u,v);
    axis([-pi/2 pi/2 -pi/2 pi/2 0 1]);
    xlabel('X-Dimension');
    ylabel('Y-Dimension');
    zlabel('Value of P');
    title('Advection Simulation No Source');
%    view(0,90);
    pause(.02);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
