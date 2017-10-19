function error = HeatDiffusionPlot( timeStep, spacialResolution, ...
                                           diffusionConstant, domain, simLength)
%%%%%%%%%% Creat transformation matrix A for the system and inverse it %%%%%%%%%
    left = -diffusionConstant * timeStep / spacialResolution^2;
    center = 1 + 2*(diffusionConstant * timeStep / spacialResolution^2);
    right = -diffusionConstant * timeStep / spacialResolution^2;

    i = 1;
    while i <= ((domain(2)-domain(1)) / spacialResolution) + 1
        transformation(i, i) = center;
        if i > 1 && i < ((domain(2)-domain(1)) / spacialResolution) + 1
            transformation(i, i - 1) = left;
        end
        if i < ((domain(2)-domain(1)) / spacialResolution) + 1 && i > 1
            transformation(i, i + 1) = right;
        end
        if i == 1 || i == ((domain(2)-domain(1)) / spacialResolution) + 1
            transformation(i, i) = 1;
        end
        i = i + 1;
    end

    transformation = inv(transformation);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Create the grid nodes
    Xaxis = [];
    for x = domain(1): spacialResolution: domain(2)
        Xaxis = [Xaxis; x];
    end

    %Set up  initial conditions
    exactTemp = [];
    for x = domain(1): spacialResolution: domain(2)
        exactTemp = [exactTemp; cos(x)];
    end
    
    finalTempurature = exactTemp;

%%%%%%%%%%%%%ITERATE THROUGH UNTIL SIMLENGTH IS REACHED%%%%%%%%%%%%%%%%%%%%%%%%%
    for t = timeStep: timeStep: simLength
        %Assign boundary values
        finalTempurature(1,1) = exp(-diffusionConstant*t)*cos(domain(1));
        finalTempurature(((domain(2)-domain(1)) / spacialResolution) + 1) ...
                        = exp(-diffusionConstant*t)*cos(domain(2));
        %Multily by inverse matrix to get next step
        finalTempurature = transformation * finalTempurature;
        
        %Update exact solution
        exactTemp = [];
        for x = domain(1): spacialResolution: domain(2)
            exactTemp = [exactTemp; exp(-diffusionConstant*t) * cos(x)];
        end
    
        %Plot both the exact solution (red) and numerical solution (blue) at
        %time t
        clf;
        plot(Xaxis,finalTempurature,'Marker','o','Color','blue');hold on;
        plot(Xaxis,exactTemp,'Color','red');
        axis([-1 1 .3 1]);
        axis('on');
        grid on;
        title('Tempurature vs Position On X-Dimension');
        xlabel('Position On X-Dimension')
        ylabel('Tempurature');
        pause(.04);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %Calculate error
    error = [];
    i = 1;
    while i <= ((domain(2)-domain(1)) / spacialResolution) + 1
        error = [error; i - 1];
        i = i + 1;
    end
    error = [error, (finalTempurature - exactTemp)];
    error = [error, ((finalTempurature - exactTemp) ./ exactTemp) * 100];
    %RETURNS a matrix with three columns, numbered grid nodes, absolute error,
    %and percent error in that order.
end

