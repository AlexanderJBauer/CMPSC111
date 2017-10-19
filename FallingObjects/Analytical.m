function exact_solution = Analytical(time, gravity, dragCoefficient, mass)

%Analytical SOLVES THE EXACT SOLUTION OF A GIVEN OBJECTS VELOCITY AT A GIVEN
%TIME
%  THIS FUNCTION SOLVES THE REAL VELOCITY OF A MASS IN FREE FALL AFFECTED BY 
%   DRAG. THIS FUNCTION TAKES IN FOUR PARAMETERS: time WHICH DEFINES THE TIME
%   AT WHICH VELOCITY SHOULD BE SOLVED FOR AND gravity, dragCoefficient, mass 
%   WHICH ARE ALL PARAMETERS THAT CAN BE PLAYED WITH FOR OBJECTS OF
%   DIFFERENT MASS WITH DIFFERENT DRAG COEFFICIENTS UNDER THE FORCE OF DIFFERENT
%   GRAVITY

    g = gravity;            %
    c = dragCoefficient;    % VARIABLE DEFINITIONS THAT MAKE TYPING EASIER
    m = mass;               % 
    t = time;               %
    
    % CALCULATE THE VELOCITY OF THE OBJACT AT TIME time SECONDS WHEN THE INITIAL
    % VELOCITY IS ZERO
    exact_solution = sqrt((g * m) / c) * tanh(sqrt((g * c) / m) * t);
    % exact_solution NOW EQUALS THE REAL VELOCITY OF THE OBJECT AT end_time
end