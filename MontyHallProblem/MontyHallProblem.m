% FUNCTION THAT RUNS MY THREE SIMULATIONS OF THE MONTY HALL PROBLEM USING
% 1,000, 10,000, AND 100,000 SIMULATIONS RESPECTIVELY AND GIVES RESULTS AS
% A STRING

function results = MontyHallProblem()

    % INITIALIZE VARIABLES THAT WILL BE USED IN STATISTICAL ANALYSIS
    numRealizationsMin = 1000;
    numRealizationsMid = 10000;
    numRealizationsMax = 100000;
    
    % FORMAT OUTPUT
    results = 'Running statistics for 1,000, 10,000, and 100,000';
    results = strcat(results,' realizations.',sprintf('\n\n\n\10'));
    
    % CALULATE RESULTS BY USING probabilitiesAfter(n)"trials" FUNCTION
    results = strcat(results,probabilitiesAfter(numRealizationsMin));
    results = strcat(results,probabilitiesAfter(numRealizationsMid));
    results = strcat(results,probabilitiesAfter(numRealizationsMax));
end