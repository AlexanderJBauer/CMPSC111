function BouncyBallMovie(cVelocity, cPosition, initPosition, ...
                         initVelocity, acceleration, timeStep, dampingMatrix,...
                         ballRadius, roomWidth, roomHeight, roomDepth, ...
                         simLength, windowWidth, windowHeight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BouncyBallMovie Plays a movie of a 2D ball bouncing in a walled 2D space
%   Arguments:
%       cVelocity: Calculates velocity for the next step, can work anyway you
%       want as long as it takes a position vector, an initial velocity vector,
%       an acceleration vector, a time step, the lower and upper bounds of the
%       2D space, the ball radius, the normal damping force, and the tangential
%       damping force. This function needs so many arguments because it must 
%       also take care of the cases when the ball hits a wall.
%       
%       cPosition: Calculates postion for the next step, can work anyway you
%       want as long as it takes an initial position vector, a velocity vector,
%       a time step, the lower and upper bounds of the 2D space, and the ball 
%       radius. This function also take care of the cases when the ball hits a 
%       wall. 
%       ****cPosition and cVelocity should coordinate to take care of the case
%           when the ball hits the wall.
%
%       initPosition: Initial 2D position vector of the ball. The vector is a
%       1 x 2 vector as such - [x-position y-position] where y is the vertical
%       component and x is the horizontal component. Units of the vector are in
%       meters.
%
%       initVelocity: Initial 2D velocity vector of the ball. The vector is a
%       1 x 2 vector as such - [x-velocity y-velocity] where y is the vertical
%       component and x is the horizontal component. Units of the vector are in
%       meters per second.
%
%       acceleration: The acceleration vector for the system. The vector is a
%       1 x 2 vector as such - [x-acceleration y-acceleration] where y is the
%       vertical component and x is the horizontal component. For this
%       simulation, the acceleration is constant. Units of the vector are in
%       meters per second^2.
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
%       ***** Note that for a 2D space the depth should always be zero.
%             Also note that the axes of the animation will always make a square
%             so if the height and width are not the same, the ball will look
%             like an ellipse.
%
%       simLength: Time in seconds the system should be simulated for. 
%       ***** This is important for this function because the Zeno Phenomenon is
%       not accounted for here so without a duration for the simulation, it may 
%       run forever.
%
%       windowWidth,windowHeight: The width and height of the window the
%       animation is contained in respectively
%       ***** This will affect the size of the animation as well, but remember
%       the axes will always make a square so having a longer width will not
%       make the animation wider if the width of the window exceeds the height.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    program_start=tic(); %STARTS THE CLOCK FOR THE RUN TIME OF THE PROGRAM

    %ADJUST INITIAL POSITION FOR RECTANGLE() SO BALL APPEARS IN CORRECT PLACE
    initPosition = initPosition - ballRadius;
    
    %SET UP THE DAMPING COEFFICIENTS AS SEPERATE VARIABLES FOR EASIER
    normalDamp = dampingMatrix * [1;0];                    %CALCULATION LATER ON
    tangentialDamp = dampingMatrix * [0;1];
    
    %SET UP LOWER AND UPPER BOUNDS FOR FUTURE CALCULATIONS
    bounds0 = [0, 0];
    boundsMax = [roomWidth, roomHeight];
    
    %SET TIME VARIABLE TO 0. TO BE USED TO SIMULATE PROGRAM FOR DESIRED
    t = 0;                                                      %LENGTH OF TIME
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DRAWING FIRST FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DRAW BALL IN INITAL POSITION
    figure('position', [250, 50, windowWidth, windowHeight])
    title('A 2D Simulation of a Bouncing Ball');
    rectangle('Position',[initPosition 2*ballRadius 2*ballRadius],...
              'Curvature',[1,1],...
              'FaceColor','r');

    %CREATING AXES
    axis([0 roomWidth 0 roomHeight]);
    axis('square');
    axis('on');
    grid on;
    grid minor;
    xticks([0 .1*roomWidth .2*roomWidth .3*roomWidth .4*roomWidth ...
        .5*roomWidth .6*roomWidth .7*roomWidth .8*roomWidth .9*roomWidth ...
        roomWidth]);
    yticks([0 .1*roomHeight .2*roomHeight .3*roomHeight .4*roomHeight ...
        .5*roomHeight .6*roomHeight .7*roomHeight .8*roomHeight .9*roomHeight...
        roomHeight]);
    
    %LABELING AXES
    xlabel('WIDTH');
    ylabel('HEIGHT');
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
             
        %CLEAR FIGURE
        clf;
        
        %%%%%%%%%%%%%%%%%%%%%%% DRAW NEXT FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %DRAW CIRCLE IN UPDATED POSITION
        rectangle('Position',[position 2*ballRadius 2*ballRadius],...
            'Curvature',[1,1],...
            'FaceColor','r');
        
        %PRESERVE AXES
        axis([0 roomWidth 0 roomHeight]);
        axis('square');
        axis('on');
        grid on;
        grid minor;
        xticks([0 .1*roomWidth .2*roomWidth .3*roomWidth .4*roomWidth ...
            .5*roomWidth .6*roomWidth .7*roomWidth .8*roomWidth .9*roomWidth ...
            roomWidth]);
        yticks([0 .1*roomHeight .2*roomHeight .3*roomHeight .4*roomHeight ...
            .5*roomHeight .6*roomHeight .7*roomHeight .8*roomHeight ...
            .9*roomHeight roomHeight]);

        %PRESERVE LABELS
        title('A 2D Simulation of a Bouncing Ball');
        xlabel('WIDTH');
        ylabel('HEIGHT');

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
    %IF program_run_time_2D IS ABOUT EQUAL TO simLength THEN ANIMATION WAS VERY
    %CLOSE TO REAL TIME, ELSE ANIMATION WAS NOT REAL TIME, BUT STILL SPANNED THE
    %LENGTH OF TIME IN THE REAL WORLD SPECIFIED BY simLength
    program_run_time_2D=toc(program_start)
  
end