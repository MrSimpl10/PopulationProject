% Simulate Growth
% Christopher Luecht
% GROUP: 15

function growth_data = growth_simulation(east_west_data)

    % Number of years to predict
    futureYears = 10;

    % Get region names: East and West
    regions = east_west_data(:, 1);

    % Get population data only
    popData = double(east_west_data(:, 2:end));

    % Count how many years of data are already in the array
    numYears = size(popData, 2);

    % Create array to store predicted values
    predictedData = strings(size(popData, 1), futureYears);

    % Loop through East and West separately
    for i = 1:size(popData, 1)

        % Population values for this region
        P = popData(i, :);

        % First population value
        P0 = P(1);

        % Estimate carrying capacity
        K = max(P) * 1.5;

        % Use only the past 5 years to calculate growth/loss rate
        recentYears = 5;

        % Population from 5 years ago
        P_start = P(end - recentYears);

        % Most recent population
        P_end = P(end);

        % Calculate r using only the past 5 years
        r = -(1 / recentYears) * log((K / P_end - 1) / (K / P_start - 1));

        % Future time values
        futureT = numYears:(numYears + futureYears - 1);

        % Logistic growth formula
        futureP = K ./ (1 + ((K - P0) / P0) .* exp(-r .* futureT));

        % Store rounded predictions
        predictedData(i, :) = string(round(futureP));

    end

    % Append predicted values to the end of the original input array
    growth_data = [east_west_data predictedData];

end