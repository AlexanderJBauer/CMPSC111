function exact_solution = AnalyticalPlot(time_step, end_time, gravity,...
                                         dragCoefficient, mass)
                                     
%AnalyticalPlot PLOTS THE EXACT SOLUTION OF A GIVEN OBJECTS VELOCITY AT A GIVEN
%TIME
%  THIS FUNCTION PLOTS THE REAL VELOCITY OF A MASS IN FREE FALL AFFECTED BY DRAG
%   THIS FUNCTION TAKES IN FIVE PARAMETERS: time_step WHICH DEFINES THE TIME
%   STEP BETWEEN EACH PLOT OF VELOCITY, end_time WHICH DEFINES HOW
%   LONG THE FREE FALL MOTION SHHOULD BE OBSERVED FOR, gravity, dragCoefficient,
%   and mass WHICH ARE ALL PARAMETERS THAT CAN BE PLAYED WITH FOR OBJECTS OF
%   DIFFERENT MASS WITH DIFFERENT DRAG COEFFICIENTS UNDER THE FORCE OF DIFFERENT
%   GRAVITY

    g = gravity;            %
    c = dragCoefficient;    % VARIABLE DEFINITIONS THAT MAKE TYPING EASIER
    m = mass;               % 
 
    % CALCULATE AND PLOT THE EXACT SOLUTION OF VELOCITY AT A 
    % GIVEN TIME FROM 0->end_time SECONDS
    t = (0:time_step:end_time);
    y = sqrt((g * m) / c) * tanh(sqrt((g * c) / m) * t);
    plot(t,y);
    
    exact_solution = sqrt((g * m) / c) * tanh(sqrt((g * c) / m) * end_time);
    % exact_solution NOW EQUALS THE REAL VELOCITY OF THE OBJECT AT end_time
end

