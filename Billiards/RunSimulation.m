function RunSimulation( sim, timeStep, simLength )

    if(sim==1)
        %CREATE THE TWO BILLIARD BALLS
        r = BilliardBall([.3,.5,0],[5,0,0],[0,0,0],[0,0,0],[0,0,0], true, [1 0 0]); %RED BALL
        b = BilliardBall([1,.5,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0], false,[0 0 1]); %BLUE BALL
        %CREATE BALL ARRAY FOR SIM
        ballArray = [r b];
        numBalls  = 2;
        
        BilliardSim(timeStep,ballArray(1:numBalls),numBalls,0,0,0,simLength,1200,600);
    end
    if(sim==2)
        %CREATE THE TWO BILLIARD BALLS
        r = BilliardBall([.3,.49,0],[5,0,0],[0,0,0],[0,0,0],[0,0,0], true, [1 0 0]); %RED BALL
        b = BilliardBall([1,.5,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0], false,[0 0 1]); %BLUE BALL
        %CREATE BALL ARRAY FOR SIM
        ballArray = [r b];
        numBalls  = 2;
        
        BilliardSim(timeStep,ballArray(1:numBalls),numBalls,0,0,0,simLength,1200,600);
    end
    if(sim==3)
        %CREATE 20 BILLIARD BALLS
        for i=1:1:20
            ballArray(i) = BilliardBall([rand * 2.20,rand * 1.17,0],...
                                        [rand * 7, rand * 7, 0],[0,0,0],...
                                        [0,0,0],[0,0,0], false,[rand rand rand]);
        end
        numBalls = 20;
        BilliardSim(timeStep,ballArray(1:numBalls),numBalls,0,0,0,simLength,1200,600);
    end

end

