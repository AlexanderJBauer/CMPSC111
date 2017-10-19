classdef BilliardBall
    %BilliardBall creates an object that represents a biliard ball
    %   The radius and weight of the ball are in accordance with the 
    %   World Pool-Billiard Association(WPA) regulations and are constants since
    %   all balls should have the same weight and radius.
    
    properties
        position
        velocity
        acceleration
        angularVelocity
        angularAcceleration
        isCueBall
        RGBTriplet
    end
    
    properties(Constant)
        MASS               = .160
        RADIUS             = .028575
        KINETIC_FRICTION   = .2
        ROLLING_FRICTION   = .01
        BUMPER_RESTITUTION = .7
        MOMENT_INERTIA     = .4 * BilliardBall.MASS * BilliardBall.RADIUS^2
    end
    
    methods
        %CONSTRUCTOR SETS INITIAL POSITION, VELOCITY, AND ACCELERATION OF BALL
        function obj = BilliardBall(p,v,a, omega, alpha, C, color)
            obj.position            = p;
            obj.velocity            = v;
            obj.acceleration        = a;
            obj.angularVelocity     = omega;
            obj.angularAcceleration = alpha;
            obj.isCueBall           = C;
            obj.RGBTriplet          = color;
        end
    end
    
end

