% ASSIGNEMTN: Group Population Project
% NAME: Christopher Luecht
% GROUP: Population Pros

% Setup for new run every time, kept crashing if ran without cleared vars
clearvars
clc

% Define initial info for program
sourcefile1 = "2010-2020Census.csv";
sourcefile2 = "2020-2025Census.csv";
start_year = 2010;
years_to_predict = 10;

% Analyze the data and get it into usable format
[east_data, west_data] = analyze_data(sourcefile1, sourcefile2, start_year);

% Create prediction data
east_predictions = growth_simulation(east_data, years_to_predict);
west_predictions = growth_simulation(west_data, years_to_predict);

% Separate real data for graphing
real_years = east_data(1, :);
east_real = east_data(2, :);
west_real = west_data(2, :);

% Separate predicted data for graphing
predicted_years = east_predictions(1, :);
east_predicted = east_predictions(2, :);
west_predicted = west_predictions(2, :);

% Make the graph
figure;

% Plot all data using different line styles and colors to differentiate them
plot(real_years, east_real, 'r-o', 'LineWidth', 2); % east_real years are solid red
hold on; % Hold on to plot everything on one graph
plot(real_years, west_real, 'b-o', 'LineWidth', 2); % west_real years are solid blue
plot(predicted_years, east_predicted, 'r--o', 'LineWidth', 2); % east_predicted years are dashed red
plot(predicted_years, west_predicted, 'b--o', 'LineWidth', 2); % west_predicted years are dashed blue

% Setup axis and title
title("East vs West Population Growth"); 
xlabel("Year");
ylabel("Population");

% Format y axis to prevent scientific notation and add commas for readability, did research and this is the best way I could find to do it in matlab, not super readable but it works
ax = gca;
ax.YAxis.Exponent = 0;
ytickformat('%,.0f')

% Create Legend to understand graph
legend("East Real", "West Real", ...
    "East Predicted", "West Predicted", ...
    "Location", "best");

% finish graph formatting
grid on;
hold off;