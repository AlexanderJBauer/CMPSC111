function velocity = EulersVelocity ( position, initVelocity, acceleration, ...
                                     timeStep, bounds0, boundsMax, ...
                                     ballRadius, normalDamp, tangentialDamp )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EulersVelocity Calculate subsequent velocity of the ball using Euler's Method
%   Arguments:
%       position: 2D or 3D position vector of the ball. The vector is a
%       1 x 2 vector as such - [x-position y-position] where y is the vertical
%       component and x is the horizontal component or a 1 x 3 vector as such -
%       [x-position y-position z-position] where z is the vertical component,
%       y is the depth component, and x is the horizontal component. Units of 
%       the vector are in meters. Used for collision calculations
%
%       initVelocity: 2D or 3D velocity vector of the ball. The vector is a
%       1 x 2 vector as such - [x-velocity y-velocity] where y is the vertical
%       component and x is the horizontal component or a 1 x 3 vector as such -
%       [x-velocity y-velocity z-velocity] where z is the vertical component,
%       y is the depth component, and x is the horizontal component. Units of 
%       the vector are in meters per second.
%
%       acceleration: 2D or 3D acceleration vector of the ball. The vector is a
%       1 x 2 vector as such - [x-acceleration y-acceleration] where y is the 
%       vertical component and x is the horizontal component or a 1 x 3 vector 
%       as such - [x-acceleration y-acceleration z-acceleration] where z is the 
%       vertical component, y is the depth component, and x is the horizontal 
%       component. For this simulation, the acceleration is constant. Units of 
%       the vector are in meters per second^2.
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
%
%       normalDamp: The damping coefficient of the velocity component normal to 
%       the wall during a collision. Used in collision calculations
%
%       tangentialDamp: The damping coefficient of the velocity component 
%       tangential to the wall during a collision. Used in collsion calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %CALCULATE THE NEXT VELOCITY OF THE BALL
    velocity = initVelocity + acceleration * timeStep;
    
    %CHECK AND ADJUST FOR COLLISIONS. THIS IS A VERY SIMPLE COLLISION HANDLER.
    %IF THERE IS A COLLISION DETERMINE WHICH VELOCITY COMPONENTS ARE NORMAL TO
    %THE WALL AND MULTIPLY THEM BY -normalDamp AND DETERMINE WHICH VELOCITY
    %COMPONENTS ARE TANGENTIAL TO THE WALL AND MULTIPLY THEM BY tangentialDamp.
    
    %2 DIMENSIONAL CHECK
    if (length(position) == 2)
        
        %DETERMINE IF PART OF THE BALL IS OUTSIDE OF THE LOWER BOUNDS OF ROOM
        out1 = position > bounds0;
        
        %DETERMINE IF PART OF THE BALL IS BEYOND THE UPPER BOUNDS OF THE ROOM
        out2 = position + 2*ballRadius < boundsMax;

      %IF THERE IS A COLLISION DETERMINE WHICH VELOCITY COMPONENTS ARE NORMAL TO
      %THE WALL AND MULTIPLY THEM BY -normalDamp AND DETERMINE WHICH VELOCITY
      %COMPONENTS ARE TANGENTIAL TO THE WALL AND MULTIPLY THEM BY tangentialDamp

        if (out1*[1;1]<2)
            out1 = (out1 * (normalDamp+tangentialDamp)) - normalDamp;
            out1 = [out1*[1;0],0;0,out1*[0;1]];
        
            velocity = velocity * out1;
        end
        
        if (out2*[1;1]<2)
            out2 = (out2 * (normalDamp+tangentialDamp)) - normalDamp;
            out2 = [out2*[1;0],0;0,out2*[0;1]];
        
            velocity = velocity * out2;
        end
        
    %3 DIMENSIONAL CHECK    
    else
        %DETERMINE IF PART OF THE BALL IS OUTSIDE OF THE LOWER BOUNDS OF ROOM
        out1 = position - ballRadius > bounds0;
        
        %DETERMINE IF PART OF THE BALL IS BEYOND THE UPPER BOUNDS OF THE ROOM
        out2 = position + ballRadius < boundsMax;
        
      %IF THERE IS A COLLISION DETERMINE WHICH VELOCITY COMPONENTS ARE NORMAL TO
      %THE WALL AND MULTIPLY THEM BY -normalDamp AND DETERMINE WHICH VELOCITY
      %COMPONENTS ARE TANGENTIAL TO THE WALL AND MULTIPLY THEM BY tangentialDamp
        if (out1*[1;1;1]<3)
            out1 = (out1 * (normalDamp+tangentialDamp)) - normalDamp;
            out1 = [out1*[1;0;0],0,0;0,out1*[0;1;0],0;0,0,out1*[0;0;1]];
        
            velocity = velocity * out1;
        end
        
        if (out2*[1;1;1]<3)
            out2 = (out2 * (normalDamp+tangentialDamp)) - normalDamp;
            out2 = [out2*[1;0;0],0,0;0,out2*[0;1;0],0;0,0,out2*[0;0;1]];
        
            velocity = velocity * out2;
        end
    end

end