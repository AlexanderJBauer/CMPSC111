function BouncingBall( timeStep, simLength1, simLength2, simLength3, ...
                       windowWidth, windowHeight )
                   
%** FOR PURPOSE OF THE HOMEWORK CALL: BouncingBall(.03, 50, 42, 42, 700, 700)***
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
%BouncingBall Runs different simulations of a bouncing ball
%   Arguments:
%       timeStep: The time step for which the simulations should be run at. The
%       smaller the value here, the more accurate the simulation will be. The
%       smaller the value gets however the longer the run time of the simulation
%       will be.
%
%       simLength1,simLength2,simLength3: The run time for various simulations.
%       The first is for the run time of the 2D simulation, the second is for
%       the run time of the 3D trajectory simulation, and the third one is for
%       the 3D simulation. If set to 0 or anything less the corresponding
%       simulation will not play.
%
%       windowWidth,windowHeight: The width and height of the window the
%       animation is contained in respectively
%       ***** This will affect the size of the animation as well, but 
%       the axes will always be equal length so having a longer width will not
%       make the animation wider if the width of the window exceeds the height.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Setting up variables to be consistent with the assignment
    roomWidth = 1.0;
    roomHeight = 1.0;
    roomDepth = 0;
    initVelocity = [0.3, 0];
    ballRadius = .05;
    initPosition = [.5, 1-ballRadius];
    dampingMatrix = [.8, .99];
    gravity = [0, -.0981];

    %Run 2D simulation
    if ( simLength1 > 0 )
        BouncyBallMovie(@EulersVelocity, @EulersPosition, initPosition, ...
                         initVelocity, gravity, timeStep, dampingMatrix, ...
                         ballRadius, roomWidth, roomHeight, roomDepth, ...
                         simLength1, windowWidth, windowHeight);
    end

    %Setting up variables to be consistent with the assignment
    roomWidth = 1.0;
    roomHeight = 1.0;
    roomDepth = 1.0;
    initVelocity = [0.3,0.1,0.2];
    ballRadius = .05;
    initPosition = [.5,1-ballRadius,.5];
	dampingMatrix = [.8, .99];
    gravity = [0,0, -.0981];

    %Run 3D trajectory simulation
    if ( simLength2 > 0 )
        BouncyBallMovie3DPlot(@EulersVelocity, @EulersPosition, initPosition,...
                         initVelocity, gravity, timeStep, dampingMatrix, ...
                         ballRadius, roomWidth, roomHeight, roomDepth, ...
                         simLength2, windowWidth, windowHeight);
    end

    %Run 3D simulation
    if ( simLength3 > 0 )
        BouncyBallMovie3D(@EulersVelocity, @EulersPosition, initPosition, ...
                         initVelocity, gravity, timeStep, dampingMatrix, ...
                         ballRadius, roomWidth, roomHeight, roomDepth, ...
                         simLength3, windowWidth, windowHeight);
    end
end