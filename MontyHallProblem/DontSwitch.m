% FUNCTION THAT RETURNS A BOOLEAN TRUE OR FALSE VALUE DEPENDING ON WHETHER
% OR NOT THE CAR WAS WON WHEN THE PLAYER DECIDED NOT TO SWITCH DOORS. IF
% true IS RETURNED, THE CAR WAS WON. IF false WAS RETURNED, A GOAT WAS WON.

function gotCar = DontSwitch()

% INITIALIZE VARIABLES AND DECIDE WHICH DOOR HOLDS THE CAR
%   AND WHICH DOOR THE PLAYER CHOSE
    door1 = false;
    door2 = false;
    door3 = false;
    carDoor = randi(3);
    OriginalDoorPick = randi(3);
    SecondDoorPick = 0;
    
% SET THE VALUE OF WHICHEVER DOOR HOLDS THE CAR TO TRUE
    if (carDoor == 1)
        door1 = true;
    elseif (carDoor == 2)
        door2 = true;
    else
        door3 = true;
    end
    
% REVEAL ONE OF THE DOORS THAT CONTAINS A GOAT
% THEN CHOOSE WHETHER OR NOT TO SWITCH DOORS
%   IN THIS CASE THE PLAYER CHOOSES NOT TO SWITCH DOORS
% FINALLY RETURN WETHER OR NOT THE PLAYER CHOSE THE DOOR WITH THE CAR

% REVEAL DOOR 1 TO BE A GOAT (PLAYER ORIGINALLY CHOSE DOOR 2 OR 3)
    if (door1 == false && OriginalDoorPick ~= 1)
        
        SecondDoorPick = OriginalDoorPick;%CHOOSE NOT TO SWITCH DOORS
        
        %CHECK TO SEE IF PLAYER CHOSE DOOR WITH CAR
        if (SecondDoorPick == 2)
            gotCar = door2;
        else
            gotCar = door3;
        end
    end
    
% REVEAL DOOR 2 TO BE A GOAT (PLAYER ORIGINALLY CHOSE DOOR 1 OR 3)
    if (door2 == false && OriginalDoorPick ~= 2)
        
        SecondDoorPick = OriginalDoorPick;%CHOOSE NOT TO SWITCH DOORS
        
        %CHECK TO SEE IF PLAYER CHOSE DOOR WITH CAR
        if (SecondDoorPick == 1)
            gotCar = door1;
        else
            gotCar = door3;
        end
    end
    
% REVEAL DOOR 3 TO BE A GOAT (PLAYER ORIGINALLY CHOSE DOOR 1 OR 2)
    if (door3 == false && OriginalDoorPick ~= 3)
        
        SecondDoorPick = OriginalDoorPick;%CHOOSE NOT TO SWITCH DOORS
        
        %CHECK TO SEE IF PLAYER CHOSE DOOR WITH CAR
        if (SecondDoorPick == 1)
            gotCar = door1;
        else
            gotCar = door2;
        end
    end

end