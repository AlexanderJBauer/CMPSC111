function position = EulersPosition( initPosition, velocity, timeStep, ...
                                    bounds0, boundsMax, ballRadius )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EulersPosition Calculate subsequent position of the ball using Euler's Method
%   Arguments:
%       initPosition: 2D or 3D position vector of the ball. The vector is a
%       1 x 2 vector as such - [x-position y-position] where y is the vertical
%       component and x is the horizontal component or a 1 x 3 vector as such -
%       [x-position y-position z-position] where z is the vertical component,
%       y is the depth component, and x is the horizontal component. Units of 
%       the vector are in meters.
%
%       velocity: 2D or 3D velocity vector of the ball. The vector is a
%       1 x 2 vector as such - [x-velocity y-velocity] where y is the vertical
%       component and x is the horizontal component or a 1 x 3 vector as such -
%       [x-velocity y-velocity z-velocity] where z is the vertical component,
%       y is the depth component, and x is the horizontal component. Units of 
%       the vector are in meters per second.
%
%       timeStep: The time interval between successive position and velocity
%       calculations.
%
%       bounds0: The lower bounds of the system to be used in collision
%       calculations
%
%       boundsMax: The upper bounds of the system to be used in collision
%       calculations
%
%       ballRadius: The radius of the ball to be used in collision calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %CALCULATE THE NEXT POSITION OF THE BALL
    position = initPosition + velocity * timeStep;

    %CHECK AND ADJUST FOR COLLISIONS. THIS IS A VERY SIMPLE COLLISION HANDLER
    %THAT SIMPLY RESETS THE POSITION IN BOUNDS IF IT IS OUT OF BOUNDS
    
    %2 DIMENSIONAL CHECK MADE FOR A CURVED RECTANGLE CREATED BY RECTANGLE()
    if (length(position) == 2)
        
        %DETERMINE IF PART OF THE BALL IS OUTSIDE OF THE LOWER BOUNDS OF ROOM
        out1 = position > bounds0;
        
        %DETERMINE IF PART OF THE BALL IS BEYOND THE UPPER BOUNDS OF THE ROOM
        out2 = (position + 2*ballRadius) < boundsMax;
        
        %ADJUST FOR PARTS OF THE BALL OUTSIDE OF THE LOWER BOUNDS OF THE ROOM
        position = position * [out1*[1;0],0;0,out1*[0;1]];
        
        %ADJUST FOR PARTS OF THE BALL BEYOND THE UPPER BOUNDS OF THE ROOM
        position = position * [out2*[1;0],0;0,out2*[0;1]] + ...
             [(boundsMax*[1;0] - 2*ballRadius)*(~out2*[1;0]),...
              (boundsMax*[0;1] - 2*ballRadius)*(~out2*[0;1])];
          
    %3 DIMENSIONAL CHECK FOR A SPHERE MADE WITH Draw_Sphere()
    else
        
        %DETERMINE IF PART OF THE BALL IS OUTSIDE OF THE LOWER BOUNDS OF ROOM
        out1 = position - ballRadius > bounds0;
        
        %DETERMINE IF PART OF THE BALL IS BEYOND THE UPPER BOUNDS OF THE ROOM
        out2 = (position + ballRadius) < boundsMax;
        
        %ADJUST FOR PARTS OF THE BALL OUTSIDE OF THE LOWER BOUNDS OF THE ROOM
        position=position*[out1*[1;0;0],0,0;0,out1*[0;1;0],0;0,0,out1*[0;0;1]]...
                            + ballRadius*(~out1);
                        
        %ADJUST FOR PARTS OF THE BALL BEYOND THE UPPER BOUNDS OF THE ROOM
        position=position*[out2*[1;0;0],0,0;0,out2*[0;1;0],0;0,0,out2*[0;0;1]]+...
            [(boundsMax*[1;0;0] - ballRadius)*(~out2*[1;0;0]),...
             (boundsMax*[0;1;0] - ballRadius)*(~out2*[0;1;0]),...
             (boundsMax*[0;0;1] - ballRadius)*(~out2*[0;0;1])];
        
    end
end

