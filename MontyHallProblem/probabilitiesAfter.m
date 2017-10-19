% FUNCTION THAT CALCULATES THE PROBABILITIES OF WINNING A CAR DEPENDING ON
% WHETHER OR NOT YOU CHOOSE TO SWITCH OR NOT TO SWITCH DOORS USING n
% REALIZATIONS. RESULTS ARE GIVEN AS A STRING.

function statistics = probabilitiesAfter(n)%trials

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % WILL BE USED TO HOLD THE TOTAL NUMBER OF PEOPLE WHO WIN CARS OUT OF
    % n PLAYERS FOR A GIVEN RUN THROUGH OF REALIZATIONS
    numWinners         = 0;
% RUN A PROBABILITY ANALYSIS ON THE ODDS OF WINNING A CAR DEPENDING ON
% WHETHER OR NOT YOU CHOOSE TO SWITCH DOORS BASED ON n TRIALS

    % FORMATTING OUTPUT
    statistics = num2str(n);
    statistics = strcat(statistics,sprintf(' Realizations:'));
    statistics = strcat(statistics,sprintf('\nProbability of winning'));
    statistics = strcat(statistics,sprintf(' a car if you choose to:'));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for iterator = 1:n                  %                                 %
        if (DoesSwitch())               % COUNT NUMBER OF WINNERS OUT OF  %
            numWinners = numWinners + 1;% n PEOPLE WHO MAKE THE CHOICE    %
        end                             % TO SWITCH DOORS                 %
    end                                 %                                 %
                                                                          %
    % TURN THE NUMBER OF WINNERS INTO A PROBABILITY REPRESENTED AS A      %
    probability = (numWinners/n) * 100;                      % PERCENTAGE %
    numWinners  = 0; % SET numWinners BACK TO ZERO FOR FUTURE USE         %
                                                                          %
    % FORMATTING OUTPUT                                                   %
    statistics  = strcat(statistics,sprintf('\npick the other door'));    %
    statistics  = strcat(statistics,sprintf(':      \10'));               %
    statistics  = strcat(statistics,num2str(probability),'%');            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for iterator = 1:n                  %                                 %
        if (DontSwitch())               % COUNT NUMBER OF WINNERS OUT OF  %
            numWinners = numWinners + 1;% n PEOPLE WHO MAKE THE CHOICE    %
        end                             % NOT TO SWITCH DOORS             %
    end                                 %                                 %
                                                                          %
    % TURN THE NUMBER OF WINNERS INTO A PROBABILITY REPRESENTED AS A      %
    probability = (numWinners/n) * 100;                      % PERCENTAGE %
                                                                          %
    % FORMATTING OUTPUT                                                   %
    statistics  = strcat(statistics,sprintf('\nstay with the same door'));%
    statistics  = strcat(statistics,sprintf(':  \10'));                   %
    statistics  = strcat(statistics,num2str(probability),'%');            %
    statistics  = strcat(statistics,sprintf('\n\n\n\10'));                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end