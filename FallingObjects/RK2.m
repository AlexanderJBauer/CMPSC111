function velocity = RK2(time_step, end_time, gravity,... 
                        dragCoefficient, mass)
                    
%RK2 NUMERICALLY SOLVES THE VELOCITY OF AN OBJECT AFTER end_time
%SECONDS IN FREE FALL
%   THIS FUNCTION NUMERICALLY SOLVES THE VELOCITY OF A MASS IN FREE FALL 
%   AFFECTED BY DRAG USING A SECOND ORDER RUNGE-KUTTA APPROXIMATION (RK2). THIS
%   FUNCTION TAKES IN FIVE PARAMETERS: time_step WHICH DEFINES THE TIME STEP 
%   BETWEEN EACH ITERATION OF EULERS METHOD, end_time WHICH DEFINES HOW LONG THE
%   FREE FALL MOTION SHHOULD BE OBSERVED FOR, AND gravity, dragCoefficient, 
%   and mass WHICH ARE ALL PARAMETERS THAT CAN BE PLAYED WITH FOR OBJECTS OF 
%   DIFFERENT MASS WITH DIFFERENT DRAG COEFFICIENTS UNDER THE FORCE OF DIFFERENT
%   GRAVITY

    g = gravity;            %
    c = dragCoefficient;    % VARIABLE DEFINITIONS THAT MAKE TYPING EASIER
    m = mass;               % THE INITIAL TIME IS ALWAYS ZERO
    time = 0.0;             % THE INITIAL VELOCITY IS ALWAYS ZERO
    velocity = 0;           %
    
    % CALCULATE THE NUMERICAL APPROXIMATION OF VELOCITY AT A 
    % GIVEN TIME (endt_time) USING RK2 METHOD FOR ALL ITERATIONS OF 
    % RK2. THE NUMBER OF ITERATIONS IS GIVEN BY end_time / time_step
    for time = time_step: time_step: end_time
        k1 = time_step * acceleration(g,c,m,velocity);
        k2 = time_step * acceleration(g,c,m,velocity + k1 / 2);
        velocity = velocity + k2;
    end
    % velocity NOW EQUALS THE NUMERICAL SOLUTION USING THE SECOND ORDER
    % RUNGE-KUTTA METHOD
end