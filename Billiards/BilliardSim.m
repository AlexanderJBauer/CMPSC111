function BilliardSim( timeStep, ballArray, numBalls, cueForce, ystrike, ...
                         zstrike, simLength, windowWidth, windowHeight )
%BilliardsSim Runs the simulation of billiards
    global FirstCollisionTime;
    %SET TIME VARIABLE TO 0. TO BE USED TO SIMULATE PROGRAM FOR DESIRED
    t = 0;                                                      %LENGTH OF TIME
    tm= 0;
    f = 1;
    %tableWidth AND tableLength FOR A STANDARD 8 FOOT POOL TABLE IN ACCORDANCE
    % WITH THE World Pool-Billiard Association(WPA) IN METERS. playWidth AND
    % playLength DEFINE THE PLAYABLE AREA ( INSIDE OF THE TABLES BUMPERS ) IN
    % ACCORDANCE WITH THE WPA IN METERS.
    tableWidth  = 1.2716;
    tableLength = 2.4416;
    playWidth   = 1.17;
    playLength  = 2.34;
    
    FirstCollisionTime = timeStep +1;

    ballArray = updateVectors(timeStep, ballArray(1:numBalls), numBalls, cueForce, ...
                                ystrike, zstrike, [.0508,.0508,0], ... 
                                [playLength + .0508,playWidth + .0508,0]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DRAWING FIRST FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure('position', [250, 50, windowWidth, windowHeight]);
    title('Aerial View of a Billiards Table');

    %CREATING AXES
    axis([0 tableLength 0 tableWidth]);
    axis('on');
    grid on;
    grid minor;
 
    xticks([0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8...
            1.9 2 2.1 2.2 2.3 2.4]);
    yticks([0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2]);
    
    rectangle('Position',[.0508,.0508,playLength,playWidth]);  
    
    while t < simLength
        
        %TIME COUNTER FOR LOOP ITERATION
        
        FirstCollisionTime = timeStep +1;
    	ballArray = updateVectors(timeStep, ballArray(1:numBalls), numBalls, 0, ...
                                ystrike, zstrike, [.0508,.0508,0], ... 
                                [playLength + .0508,playWidth + .0508,0]);

        clf;
        for i = 1: 1: numBalls
            x = ballArray(i).position * [1;0;0];
            y = ballArray(i).position * [0;1;0];
            n = 100;
            for q=1:n
                theta=q*(2*pi/n);
                X(q)=x+BilliardBall.RADIUS*cos(theta);
                Y(q)=y+BilliardBall.RADIUS*sin(theta);
            end
            fill(X,Y,ballArray(i).RGBTriplet);hold on;
        end

        title('Aerial View of a Billiards Table');
        
        %CREATING AXES
        axis([0 tableLength 0 tableWidth]);
        axis('on');
        grid on;
        grid minor;

        xticks([0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8...
            1.9 2 2.1 2.2 2.3 2.4]);
        yticks([0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2]);
    
        rectangle('Position',[.0508,.0508,playLength,playWidth]);

        pause(.02);
        if(FirstCollisionTime < timeStep)
            t = t + FirstCollisionTime;
            tm = tm + FirstCollisionTime;
        else
            t = t + timeStep;
            tm = tm + timeStep;
        end
        if (tm >= .03333)
            M(f) = getframe;
            f = f + 1;
            tm = 0;
        end

    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    v = VideoWriter('BilliardsMovie.avi');
    open(v);
    writeVideo(v,M(1:f-1))
    close(v);
end