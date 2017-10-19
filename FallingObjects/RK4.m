function velocity = RK4(time_step, end_time, gravity,... 
                        dragCoefficient, mass)
                    
%RK4 NUMERICALLY SOLVES THE VELOCITY OF AN OBJECT AFTER end_time
%SECONDS IN FREE FALL
%   THIS FUNCTION NUMERICALLY SOLVES THE VELOCITY OF A MASS IN FREE FALL 
%   AFFECTED BY DRAG USING A FOURTH ORDER RUNGE-KUTTA APPROXIMATION (RK4). THIS
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
    % GIVEN TIME (endt_time) USING RK4 METHOD FOR ALL ITERATIONS OF 
    % RK4. THE NUMBER OF ITERATIONS IS GIVEN BY end_time / time_step
    for time = time_step: time_step: end_time
        k1 = time_step * acceleration(g,c,m,velocity);
        k2 = time_step * acceleration(g,c,m,velocity + k1 / 2);
        k3 = time_step * acceleration(g,c,m,velocity + k2 / 2);
        k4 = time_step * acceleration(g,c,m,velocity + k3);
        velocity = velocity + (k1 + 2*k2 + 2*k3 + k4) / 6;
    end
    % velocity NOW EQUALS THE NUMERICAL SOLUTION USING THE FOURTH ORDER
    % RUNGE-KUTTA METHOD
end
