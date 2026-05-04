% Simulate Growth
% Christopher Luecht
% GROUP: 15

% Another function file to feduce clutter in main and to seperate major
% parts of the project

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

        % Time values for existing data
        t = 0:(numYears - 1);

        % First and last population values
        P0 = P(1);
        Pend = P(end);

        % Estimate carrying capacity, tbh i had to guess, couldnt find a
        % reasonable estimate online
        K = max(P) * 1.25;

        % Calculate growth/loss rate from current data
        r = -(1 / t(end)) * log((K / Pend - 1) / (K / P0 - 1));

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