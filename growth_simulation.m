% Simulate Growth
% Christopher Luecht
% GROUP: 15

% This file is responsible for predicting future population data given previous data.
% I chose to seperate this as it is a very different task than the data cleaning and graphing.
% It is also a lot of code that would make the main file look very cluttered.

function growth_data = growth_simulation(realdata, years_to_predict)

    % Separate years and population data
    years = realdata(1, :);
    popData = double(realdata(2:end, :));

    % Setup vars for growth sim formula
    startPop = popData(1);
    endPop = popData(end);
    numYears = years(end) - years(1);
    avgGrowthRate = (endPop / startPop)^(1 / numYears) - 1;

    % Logistic growth variables
    N0 = endPop; % Starts predicting from most recent real data point
    r = avgGrowthRate; 
    K = endPop * 1.5; % Carrying capacity estimate
    t = 1:years_to_predict; % Time array for prediction years

    % Logistic growth formula
    futurePop = K ./ (1 + ((K - N0) / N0) .* exp(-r .* t));

    % Setup to output
    futurePop = round(futurePop); % Round to whole people
    futureYears = (years(end) + 1):(years(end) + years_to_predict); % Future years array

    % Output real data plus predicted data in full format
    format long g % Use long format to avoid scientific notation
    growth_data = [futureYears; futurePop];

end