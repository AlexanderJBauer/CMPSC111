function velocity = EulersMethodPlot(time_step, end_time, gravity,... 
                                 dragCoefficient, mass)
                             
%EulersMethodPlot PLOTS ITERATIONS OF EULERS METHOD WTIH THE GIVEN STEP SIZE
%UNTIL THE END TIME
%   THIS FUNCTION PLOTS THE VELOCITY OF A MASS IN FREE FALL AFFECTED BY DRAG.
%   THE PLOT USING EULERS METHOD TO NUMERICALLY SOLVE FOR VELOCITY IS SHOWN IN
%   RED CIRCLES WHILE THE EXACT SOLUTION IS SHOWN AS A BLUE LINE ON THE PLOT.
%   THIS FUNCTION TAKES IN FIVE PARAMETERS: time_step WHICH DEFINES THE TIME
%   STEP BETWEEN EACH ITERATION OF EULERS METHOD, end_time WHICH DEFINES HOW
%   LONG THE FREE FALL MOTION SHHOULD BE OBSERVED FOR, gravity, dragCoefficient,
%   and mass WHICH ARE ALL PARAMETERS THAT CAN BE PLAYED WITH FOR OBJECTS OF
%   DIFFERENT MASS WITH DIFFERENT DRAG COEFFICIENTS UNDER THE FORCE OF DIFFERENT
%   GRAVITY

    g = gravity;            %
    c = dragCoefficient;    % VARIABLE DEFINITIONS THAT MAKE TYPING EASIER
    m = mass;               % THE INITIAL TIME IS ALWAYS ZERO
    time = 0.0;             % THE INITIAL VELOCITY IS ALWAYS ZERO
    velocity = 0;           %

    % PLOT THE FIRST POINT OF EULERS METHOD AND CONFIGURE THE PLOT             %    
    figure
    plot(time, velocity,'or'); hold on;

    title('Plot of Velocity Over Time Using Eulers Method'); % PLOT TITLE
    xlabel('Time in Seconds Mass Has Been in Free Fall (s)');% AXIS LABELS    
    ylabel('Velcoity in Meters per Second of Mass in Free Fall (m/s)');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    str = {strjoin({'Gravity__________=',num2str(g),'m/s^2'}),strjoin(...      %
                   {'Drag Coefficient_=',num2str(c),'kg/m'}),strjoin(...       %
                   {'Mass of Object___=',num2str(m),'kg'}),strjoin(...         %
                   {'Initial Velocity_=',num2str(velocity),'m/s'}),strjoin(... %
                   {'Time Step________=',num2str(time_step),'s'})};            %
        % CONFIGURE INFORMATION DISPLAY THAT WILL GO ON THE PLOT %%%%%%%%%%%%%%%
    
    % CALCULATE AND PLOT THE NUMERICAL APPROXIMATION OF VELOCITY AT A 
    % GIVEN TIME USING EULERS METHOD FOR ALL ITERATIONS OF EULERS METHOD. 
    % THE NUMBER OF ITERATIONS IS GIVEN BY end_time / time_step
    for time = time_step: time_step: end_time
        velocity = velocity + acceleration(g,c,m,velocity) * time_step;
        plot(time, velocity,'or');hold on;
    end
    % velocity NOW EQUALS THE NUMERICAL SOLUTION USING EULERS METHOD
    
    % PLOT THE ACTUAL VELOCITY OF THE OBJECT OVER THE TIME INTERVAL 0->end_time
    AnalyticalPlot(.01, end_time, g, c, m);
    
    % THE REST OF THE CODE IS DEDICATED TO FORMATTING THE GRAPH    
    h = zeros(2, 1);                          %
    h(1) = plot(0,0,'or', 'visible', 'on');   % FORMAT LEGEND
    h(2) = plot(0,0,'-b', 'visible', 'on');   %
    legend(h, 'Eulers Method','Exact Solution','location','southeast');%
    
    t = text(end_time - (9.8*end_time)/10,velocity,str,'interpreter','none');
    t.FontName = 'FixedWidth'; % FORMAT ADDITIONAL INFORMATION TEXT

end
