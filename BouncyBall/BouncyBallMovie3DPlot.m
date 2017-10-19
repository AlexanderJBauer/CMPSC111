function BouncyBallMovie3DPlot( cVelocity, cPosition, initPosition, ...
                         initVelocity, acceleration, timeStep, dampingMatrix,...
                         ballRadius, roomWidth, roomHeight, roomDepth, ...
                         simLength, windowWidth, windowHeight )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BouncyBallMovie3DPlot Pots the trajectory of a 3D ball bouncing in a walled 3D
%                        space.
%***** The arguments for this function are the same as they are for
%         BouncyBallMovie3D. This function exists because although the
%         simulation produced by BouncyBallMovie3D is accurate, it does not look
%         like it is, because the sphere does not shrink as it moves farther
%         back in the room and does not change shades from shadowing either. In
%         other words it is hard to tell exactly what direction the ball is
%         moving since depth cannot be seen. This plot shows the path the center
%         of the sphere in BouncyBallMovie3D took. Once the simulation has been
%         run for the desired simLength, the plot can be rotated in matlab to
%         visualize the path of the ball better.
%
%   Arguments:
%       cVelocity: Calculates velocity for the next step, can work anyway you
%       want as long as it takes a position vector, an initial velocity vector,
%       an acceleration vector, a time step, the lower and upper bounds of the
%       3D space, the ball radius, the normal damping force, and the tangential
%       damping force. This function needs so many arguments because it must 
%       also take care of the cases when the ball hits a wall.
%       
%       cPosition: Calculates postion for the next step, can work anyway you
%       want as long as it takes an initial position vector, a velocity vector,
%       a time step, the lower and upper bounds of the 3D space, and the ball 
%       radius. This function also take care of the cases when the ball hits a 
%       wall. 
%       ****cPosition and cVelocity should coordinate to take care of the case
%           when the ball hits the wall.
%
%       initPosition: Initial 3D position vector of the ball. The vector is a
%       1 x 3 vector as such - [x-position y-position z-position] where z is the 
%       vertical component, y is the depth component, and x is the horizontal 
%       component. Units of the vector are in meters.
%
%       initVelocity: Initial 3D velocity vector of the ball. The vector is a
%       1 x 3 vector as such - [x-velocity y-velocity z-velocity] where z is the 
%       vertical component, y is the depth component, and x is the horizontal 
%       component. Units of the vector are in meters per second.
%
%       acceleration: The acceleration vector for the system. The vector is a
%       1 x 3 vector as such - [x-acceleration y-acceleration z-acceleration] 
%       where z is the vertical component, y is the depth component, and x is 
%       the horizontal component. For this simulation, the acceleration is 
%       constant. Units of the vector are in meters per second^2.
%
%       timeStep: The time interval between successive position and velocity
%       calculations.
%
%       dampingMatrix: The collision damping maxtrix for the system. The matrix
%       is a 1 x 2 vector as such - [alpha beta] where alpha is the collision 
%       damping coefficient of the velocity component normal to the wall and
%       beta is the collision damping coefficient of the velocity component
%       tangential to the wall.
%
%       ballRadius: The radius of the ball in meters.
%
%       roomWidth, roomHeight, roomDepth: The width of the room in meters, the
%       height of the room in meters, and the depth of the room in meters
%       respectively.
%       ***** Note that the axes of the animation will always make a cube
%             so if the height, depth, and width are not the same, the ball will
%             look like an ellipse.
%
%       simLength: Time in seconds the system should be simulated for. 
%       ***** This is important for this function because the Zeno Phenomenon is
%       not accounted for here so without a duration for the simulation, it may 
%       run forever.
%
%       windowWidth,windowHeight: The width and height of the window the
%       animation is contained in respectively
%       ***** This will affect the size of the animation as well, but remember
%       the axes will always make a cube so having a longer width will not
%       make the animation wider if the width of the window exceeds the height.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    program_start=tic(); %STARTS THE CLOCK FOR THE RUN TIME OF THE PROGRAM

    %SET UP THE DAMPING COEFFICIENTS AS SEPERATE VARIABLES FOR EASIER
    normalDamp = dampingMatrix * [1;0];                    %CALCULATION LATER ON
    tangentialDamp = dampingMatrix * [0;1];
    
    %SET UP LOWER AND UPPER BOUNDS FOR FUTURE CALCULATIONS
    bounds0 = [0, 0, 0];
    boundsMax = [roomWidth, roomDepth, roomHeight];

    %SET TIME VARIABLE TO 0. TO BE USED TO SIMULATE PROGRAM FOR DESIRED
    t = 0;                                                      %LENGTH OF TIME
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DRAWING FIRST FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DRAW BALL IN INITAL POSITION
    figure('position', [250, 50, windowWidth, windowHeight])
    title('3D Trajectory Plot of the Center of a Simulated Bouncing Ball'); 
    plot3(initPosition*[1;0;0],initPosition*[0;1;0], ...
          initPosition*[0;0;1],'*');hold on;
    
    %CREATING AXES
    axis([0 roomWidth 0 roomDepth 0 roomHeight]);
    axis('square');
    axis('on');
    grid on;
    grid minor;
    xticks([0 .1*roomWidth .2*roomWidth .3*roomWidth .4*roomWidth ...
        .5*roomWidth .6*roomWidth .7*roomWidth .8*roomWidth .9*roomWidth ...
        roomWidth]);
    yticks([0 .1*roomDepth .2*roomDepth .3*roomDepth .4*roomDepth ...
        .5*roomDepth .6*roomDepth .7*roomDepth .8*roomDepth .9*roomDepth...
        roomDepth]);
    zticks([0 .1*roomHeight .2*roomHeight .3*roomHeight .4*roomHeight ...
        .5*roomHeight .6*roomHeight .7*roomHeight .8*roomHeight .9*roomHeight...
        roomHeight]);

    %LABELING AXES
    xlabel('WIDTH');
    ylabel('DEPTH');
    zlabel('HEIGHT');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %SETTING POSITION AND VELOCITY TO INITIAL CONDITIONS
    position = initPosition;
    velocity = initVelocity;
    
    %RUN SIMULATION
    while abs(t) < abs(simLength)
        
        %TIME COUNTER FOR LOOP ITERATION
        t_loopstart=tic();
        
        %CALCULATE NEXT POSITION
        position = cPosition(position, velocity, timeStep, bounds0, ...
                             boundsMax, ballRadius);
                         
        %CALCULATE NEXT VELOCITY
        velocity = cVelocity(position, velocity, acceleration, timeStep, ...
                             bounds0, boundsMax, ballRadius, ...
                             normalDamp, tangentialDamp);
        
        %%%%%%%%%%%%%%%%%%%%%%% DRAW NEXT FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %DRAW BALL IN UPDATED POSITION
        plot3(position*[1;0;0],position*[0;1;0],position*[0;0;1],'*');hold on;
        
        %PRESERVE AXES
        axis([0 roomWidth 0 roomDepth 0 roomHeight]);
        axis('square');
        axis('on');
        grid on;
        grid minor;
    	xticks([0 .1*roomWidth .2*roomWidth .3*roomWidth .4*roomWidth ...
            .5*roomWidth .6*roomWidth .7*roomWidth .8*roomWidth .9*roomWidth ...
            roomWidth]);
        yticks([0 .1*roomDepth .2*roomDepth .3*roomDepth .4*roomDepth ...
            .5*roomDepth .6*roomDepth .7*roomDepth .8*roomDepth .9*roomDepth...
            roomDepth]);
        zticks([0 .1*roomHeight .2*roomHeight .3*roomHeight .4*roomHeight ...
            .5*roomHeight .6*roomHeight .7*roomHeight .8*roomHeight ...
            .9*roomHeight roomHeight]);

        %PRESERVE LABELS
        title('3D Trajectory Plot of the Center of a Simulated Bouncing Ball');
        xlabel('WIDTH');
        ylabel('DEPTH');
        zlabel('HEIGHT');
        view(45,25);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %UPDATE TIME BALL HAS BEEN SIMULATED FOR        
        t = t + timeStep;
        
        %PAUSING ANIMATION TO MAKE IT VIEWABLE
        el_time=toc(t_loopstart);     %CALCULATE TIME IT TOOK FOR LOOP ITERATION
        if (el_time < timeStep)       %
            pause(timeStep-el_time);  %IF THE SYSTEM IS FAST ENOUGH TO
        else                          %ITERATE THROUGH THE LOOP FASTER THAN
            pause(.02);               %timeStep, MAKE ANIMATION VERY CLOSE TO
        end                           %REAL TIME, ELSE PAUSE TO MAKE VIEWABLE
    %END OF ANIMATION    
    end
    
    %OUTPUT TIME COMPUTER TOOK TO ANIMATE THE SYSTEM SO IT CAN BE COMPARED TO
    %THE TIME IT SIMULATED FOR TO SEE IF ANIMATION WAS IN REAL TIME OR NOT
    %IF program_run_time_3DPlot IS ABOUT EQUAL TO simLength THEN ANIMATION WAS
    %CLOSE TO REAL TIME, ELSE ANIMATION WAS NOT REAL TIME, BUT STILL SPANNED THE
    %LENGTH OF TIME IN THE REAL WORLD SPECIFIED BY simLength
    program_run_time_3DPlot=toc(program_start)
  
end

