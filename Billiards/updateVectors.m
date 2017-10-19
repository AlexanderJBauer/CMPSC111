function newBallArray = updateVectors( timeStep, ballArray, numBalls, ...
                                        cueForce, ystrike, zstrike, ...
                                        bounds0, boundsMax )
%updateVectors UPDATES THE POSITION VELOCITY AND ACCELERATION VECTORS OF THE
%BILLIARDS BALLS ON THE TABLE
%   ARGUMENTS:
%       ballArray: IS AN ARRAY OF BILLIARD BALL OBJECTS
%   OUTPUT:
%       newBallArray: IS AN ARRAY OF BILLIARD BALLS WITH UPDATED VECTORS

    global FirstCollisionTime;
    
    ball1 = 0;
    ball2 = 0;
    CollisionType = 0;
    beyondLowerBounds = [0,0,0];
    beyondUpperBounds = [0,0,0];
    FirstBeyondLowerBounds = [0,0,0];
    FirstBeyondUpperBounds = [0,0,0];
    gravity = 9.81;

    if(dot(cueForce,cueForce))
        %IF ITS THE FIRST SHOT, FIND CUEBALL
        for i = 1: 1: numBalls
            if ballArray(i).isCueBall
                cueBall = i;
                break;
            end
        end
        %UPDATE CUEBALL VECTORS
        ballArray(cueBall).velocity = (cueForce / BilliardBall.MASS) * .01;
        ballArray(cueBall).position = ballArray(cueBall).position + ...
                                       .5 * (cueForce / BilliardBall.MASS) * ...
                                       .01^2;


        Rvector = [sqrt(BilliardBall.RADIUS^2-ystrike^2-zstrike^2), ystrike, ...
                                                                    zstrike];                                                        
        ballArray(cueBall).angularAcceleration = cross(Rvector,cueForce) ...
                                                / BilliardBall.MOMENT_INERTIA;
        ballArray(cueBall).angularVelocity = ...
                               ballArray(cueBall).angularAcceleration * .01;
        ballArray(cueBall);
    end
    
    for i = 1: 1: numBalls
        tempArray(i) = ballArray(i);
    end
    
    %CREATE POSSIBLE RETURN VALUE
    for i = 1: 1: numBalls
        R = [0,0,-BilliardBall.RADIUS];
        vp = cross(tempArray(i).angularVelocity,R) + tempArray(i).velocity;
        mew = BilliardBall.KINETIC_FRICTION;
        if (magnitude1x3(vp) - BilliardBall.RADIUS * ...
                magnitude1x3(tempArray(i).angularVelocity)<.01)
            mew = BilliardBall.ROLLING_FRICTION;
        end
        if magnitude1x3(vp)
            friction = (-mew * BilliardBall.MASS * gravity / magnitude1x3(vp)) * vp;
        else
            friction = [0,0,0];
        end
        tempArray(i).acceleration = friction / BilliardBall.MASS;
        tempArray(i).position = tempArray(i).position ...
                               + tempArray(i).velocity * timeStep...
                               + .5 * tempArray(i).acceleration * timeStep^2;
        tempArray(i).velocity = tempArray(i).velocity ...
                               + tempArray(i).acceleration * timeStep;
        tempArray(i).angularAcceleration = cross(R,friction) ...
                                          / BilliardBall.MOMENT_INERTIA;
        tempArray(i).angularVelocity = tempArray(i).angularVelocity ...
                                  + tempArray(i).angularAcceleration * timeStep;

    end

    %CHECK FOR FIRST COLLISION
    for i = 1: 1: numBalls
        for j = i: 1: numBalls
            if j~=i
                if (dot((tempArray(i).position-tempArray(j).position), ...
                       (tempArray(i).position-tempArray(j).position)) ...
                       <= 4 * BilliardBall.RADIUS^2)
                   
                   a = dot((ballArray(i).velocity-ballArray(j).velocity), ...
                           (ballArray(i).velocity-ballArray(j).velocity));
                   b = dot((ballArray(i).position-ballArray(j).position), ...
                           (ballArray(i).velocity-ballArray(j).velocity)) * 2;
                   c = dot((ballArray(i).position-ballArray(j).position), ...
                           (ballArray(i).position-ballArray(j).position)) ...
                         - 4 * BilliardBall.RADIUS^2;
                   CollisionTime1 = (-b + sqrt(b^2 - 4*a*c)) / (2 * a);
                   CollisionTime2 = (-b - sqrt(b^2 - 4*a*c)) / (2 * a);
                   
                   if CollisionTime1 < 0
                       CollisionTime1 = 100;
                   end
                   if CollisionTime2 < 0
                       CollisionTime2 = 100;
                   end
                   if CollisionTime1 < CollisionTime2
                       CollisionTime = CollisionTime1;
                   else
                       CollisionTime = CollisionTime2;
                   end
                   if CollisionTime < FirstCollisionTime && CollisionTime > 0
                       FirstCollisionTime = CollisionTime;
                       CollisionType = 1;
                       ball1 = i;
                       ball2 = j;
                   end
                end
            end
        end
        
        beyondLowerBounds = ((tempArray(i).position - BilliardBall.RADIUS)...
                            <= bounds0);
        beyondUpperBounds = ((tempArray(i).position + BilliardBall.RADIUS)...
                            >= boundsMax);
        CollisionTime1    = 100;
        CollisionTime2    = 100;
        if (beyondLowerBounds * [1;1;0] > 0)
            if (beyondLowerBounds * [1;0;0]) == 1
                CollisionTime1 = (bounds0 * [1;0;0] + BilliardBall.RADIUS ...
                                - ballArray(i).position * [1;0;0]) ...
                                /(ballArray(i).velocity * [1;0;0]);
            end
            if (beyondLowerBounds * [0;1;0]) == 1
                CollisionTime2 = (bounds0 * [0;1;0] + BilliardBall.RADIUS ...
                                - ballArray(i).position * [0;1;0]) ...
                                /(ballArray(i).velocity * [0;1;0]);
            end
            if CollisionTime1 < CollisionTime2
                CollisionTime = CollisionTime1;
            else
                CollisionTime = CollisionTime2;
            end
            if CollisionTime < FirstCollisionTime
                FirstCollisionTime = CollisionTime;
                if CollisionTime1 < CollisionTime2
                    FirstBeyondLowerBounds = [1,0,0];
                else
                    FirstBeyondLowerBounds = [0,1,0];
                end
                CollisionType = 2;
                ball1 = i;
                ball2 = 0;
            end
        end
        
        if (beyondUpperBounds * [1;1;0] > 0)
            if (beyondUpperBounds * [1;0;0]) == 1
                CollisionTime1 = (boundsMax * [1;0;0] - BilliardBall.RADIUS ...
                                - ballArray(i).position * [1;0;0]) ...
                                /(ballArray(i).velocity * [1;0;0]);
            end
            if (beyondUpperBounds * [0;1;0]) == 1
                CollisionTime2 = (boundsMax * [0;1;0] - BilliardBall.RADIUS ...
                                - ballArray(i).position * [0;1;0]) ...
                                /(ballArray(i).velocity * [0;1;0]);
            end
            if CollisionTime1 < CollisionTime2
                CollisionTime = CollisionTime1;
            else
                CollisionTime = CollisionTime2;
            end
            if CollisionTime < FirstCollisionTime
                FirstCollisionTime = CollisionTime;
                if CollisionTime1 < CollisionTime2
                    FirstBeyondUpperBounds = [1,0,0];
                else
                    FirstBeyondUpperBounds = [0,1,0];
                end
                CollisionType = 3;
                ball1 = i;
                ball2 = 0;
            end
        end
    end
    
    % IF COLLISION, DEAL WITH COLLISION
    if (FirstCollisionTime <= timeStep)
        for i = 1: 1: numBalls
            tempArray(i) = ballArray(i);
        end
        %REDO tempArray WITH NEW TIMESTEP
        for i = 1: 1: numBalls
            R = [0,0,BilliardBall.RADIUS];
            vp = cross(tempArray(i).angularVelocity,R) + tempArray(i).velocity;
            mew = BilliardBall.KINETIC_FRICTION;
            if (magnitude1x3(tempArray(i).velocity) <= BilliardBall.RADIUS * ...
                              magnitude1x3(tempArray(i).angularVelocity))
                mew = BilliardBall.ROLLING_FRICTION;
            end
            if magnitude1x3(vp)
            friction = (-mew * BilliardBall.MASS * gravity / magnitude1x3(vp)) * vp;
            else
            friction = [0,0,0];
            end
            tempArray(i).acceleration = friction / BilliardBall.MASS;
            tempArray(i).position = tempArray(i).position ...
                                   + tempArray(i).velocity...
                                   * FirstCollisionTime...
                                   + .5 * tempArray(i).acceleration ...
                                   * FirstCollisionTime^2;
            tempArray(i).velocity = tempArray(i).velocity ...
                                   + tempArray(i).acceleration ...
                                   * FirstCollisionTime;
            tempArray(i).angularAcceleration = cross(R,friction) ...
                                              / BilliardBall.MOMENT_INERTIA;
            tempArray(i).angularVelocity = tempArray(i).angularVelocity ...
                                         + tempArray(i).angularAcceleration ...
                                         * FirstCollisionTime;
        end
        
        %HANDLE COLLISIONS
        if CollisionType == 1
            
            n = (tempArray(ball1).position - tempArray(ball2).position)...
              / (magnitude1x3((tempArray(ball1).position ...
                            - tempArray(ball2).position)));
            v_n1 = dot(tempArray(ball1).velocity,(-n)) * (-n);
            v_n2 = dot(tempArray(ball2).velocity,n) * n;
            v_t1 = tempArray(ball1).velocity - v_n1;
            v_t2 = tempArray(ball2).velocity-v_n2;
            
            tempArray(ball1).velocity = v_t1 + v_n2;
            tempArray(ball2).velocity = v_t2 + v_n1;
        end
        
        if CollisionType == 2
            if (FirstBeyondLowerBounds * [1;0;0]) == 1
                tempArray(ball1).velocity = tempArray(ball1).velocity * ...
                             [-BilliardBall.BUMPER_RESTITUTION,0,0;0,1,0;0,0,1];
            end
            if (FirstBeyondLowerBounds * [0;1;0]) == 1
                tempArray(ball1).velocity = tempArray(ball1).velocity * ...
                             [1,0,0;0,-BilliardBall.BUMPER_RESTITUTION,0;0,0,1];
            end
        end
        
        if CollisionType == 3
            if (FirstBeyondUpperBounds * [1;0;0]) == 1
                tempArray(ball1).velocity = tempArray(ball1).velocity * ...
                             [-BilliardBall.BUMPER_RESTITUTION,0,0;0,1,0;0,0,1];
            end
            if (FirstBeyondUpperBounds * [0;1;0]) == 1
                tempArray(ball1).velocity = tempArray(ball1).velocity * ...
                             [1,0,0;0,-BilliardBall.BUMPER_RESTITUTION,0;0,0,1];
            end
        end     
    end
    
        for i = 1: 1: numBalls
            newBallArray(i) = tempArray(i);
        end

end

