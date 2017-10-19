function error = HeatDiffusion( timeStep, spacialResolution, ...
                                           diffusionConstant, domain, simLength)

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
    
    Xaxis = [];
    for x = domain(1): spacialResolution: domain(2)
        Xaxis = [Xaxis; x];
    end

    exactTemp = [];
    for x = domain(1): spacialResolution: domain(2)
        exactTemp = [exactTemp; cos(x)];
    end
    
    finalTempurature = exactTemp;

    for t = timeStep: timeStep: simLength
        finalTempurature(1,1) = exp(-diffusionConstant*t)*cos(domain(1));
        finalTempurature(((domain(2)-domain(1)) / spacialResolution) + 1) ...
                        = exp(-diffusionConstant*t)*cos(domain(2));
        finalTempurature = transformation * finalTempurature;
        
        exactTemp = [];
        for x = domain(1): spacialResolution: domain(2)
            exactTemp = [exactTemp; exp(-diffusionConstant*t) * cos(x)];
        end

    end
    
    error = [];
    i = 1;
    while i <= ((domain(2)-domain(1)) / spacialResolution) + 1
        error = [error; i - 1];
        i = i + 1;
    end
    error = [error, (finalTempurature - exactTemp)];
    error = [error, ((finalTempurature - exactTemp) ./ exactTemp) * 100];

end

