function denoise( v , k, timeStep, simLength, pic )

    I=imread(pic);% Load image file and store it as variable I.
    
    I=rgb2gray(I); % Convert to gray scale
    I=im2double(I); % Convert the variable into double. 

    m=size(I,1);
    n=size(I,2);
    
    %Center pixel distances
    dy = 1;
    dx = 1;

    % Add some noise to the image
    I_noisy=I;
    for i=1:m
        for j=1:n
            I_noisy(i,j)=I(i,j)+((rand(1))-.5)/5;
        end
    end

    % Process the noisy image ...
    
    t=0;%Time variable to keep track of iterations
    orig = I;%Keep a copy of the original image for boundary conditions
    I = I_noisy;%Make the Image the noisy image
    
    %PPERFORM DENOISING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while t< simLength
        
        %%%%%%BOUNDARY CONDITIOS = ORIGINAL IMAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for y=1:m
            I(y,1) = orig(y,1);
            I(y,2) = orig(y,2);
        end
        for y=1:m
            I(y,n) = orig(y,n);
            I(y,n-1) = orig(y,n-1);
        end
        for x=1:n
            I(1,x) = orig(1,x);
            I(2,x) = orig(2,x);
            %I(3,x) = orig(3,x);
            %I(4,x) = orig(4,x);
        	%I(5,x) = orig(5,x);
            %I(6,x) = orig(6,x);
        end
        for x=1:n
            I(m,x) = orig(m,x);
            I(m-1,x) = orig(m-1,x);
            %I(m-2,x) = orig(m-2,x);
            %I(m-3,x) = orig(m-3,x);
            %I(m-4,x) = orig(m-4,x);
            %I(m-5,x) = orig(m-5,x);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %First derivative approximations of the iamge brightness with respect to
        %   x and y
        dI_dx = (circshift(I,-1,2) - circshift(I,1,2))/2*dx;
        dI_dy = (circshift(I,1,1) - circshift(I,-1,1))/2*dy;

        %Matrix of conduction coefficients updated at every iteration as a
        %   function of the brightness gradient
        g = v./(1+(dI_dx.^2+dI_dy.^2)/k);
        g = g*timeStep;
        
        
        temp=I;%Holds I of previous time step
        temp2=I;%Holds I of previous time step
        temp = g.*temp;%Now contains values of the previous time step times 
        %their respective conduction coeeficients to make calculations simpler
        
        %Updates I at every grid point
        for x=3:n-2
            for y=3:m-2
                I(y,x) = temp2(y,x) + (-temp(y,x-2) + 16*temp(y,x-1)...
                        - 30*temp(y,x) + 16*temp(y,x+1) - temp(y,x+2)...
                        - temp(y-2,x) + 16*temp(y-1,x) - 30*temp(y,x)...
                        + 16*temp(y+1,x) - temp(y+2,x))/12;
            end
        end
        
        t=t+timeStep;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Display original image
    figure;
    imshow(orig);
    title('Original Image');

    %Display noisy image
    figure;
    imshow(I_noisy);
    title('Noisy Image');
    
    %Display Denoised Image
    figure;
    imshow(I);
    title('Denoised Image');

end