% ASSIGNEMTN: Group Population Project
% NAME: Christopher Luecht
% GROUP: 15

% Setup for new run every time, kept crashing if ran without cleared vars
clearvars
clc

% Define what inital data files we want to use
sourcefile1 = "2010-2020Census.csv";
sourcefile2 = "2020-2025Census.csv";

% Use external function files to get our full, clean, predicted data
east_west_data = analyze_data(sourcefile1, sourcefile2);
growth_data = growth_simulation(east_west_data);

% What year our data starts from and how many we want to predict after the
% end of the data, used to number the graph
start_year = 2010;
num_predicted = 10;

% Seperate east_west array into many smaller, easier to manipulate arrays
eastPop = double(growth_data(1, 2:end));
westPop = double(growth_data(2, 2:end));

num_total = length(eastPop);
num_real = num_total - num_predicted;

east_real = eastPop(1:num_real);
west_real = westPop(1:num_real);

east_predicted = eastPop(num_real + 1:end);
west_predicted = westPop(num_real + 1:end);

% Our dataset doesent include year tags to we make them right here, also
% used for solid vs dashed line
real_years = start_year:(start_year + num_real - 1);
predicted_years = (start_year + num_real):(start_year + num_total - 1);


% Make the graph
figure;

plot(real_years, east_real, 'r-o', 'LineWidth', 2); % east_real years are solid red
hold on;

plot(real_years, west_real, 'b-o', 'LineWidth', 2); % west_real years are solid blue

plot(predicted_years, east_predicted, 'r--o', 'LineWidth', 2); % east_predicted years are dashed red

plot(predicted_years, west_predicted, 'b--o', 'LineWidth', 2); % west_predicted years are dashed blue

title("East vs West Population Growth"); 
xlabel("Year");
ylabel("Population");

legend("East Real", "West Real", ...
    "East Predicted", "West Predicted", ...
    "Location", "best");

grid on;
hold off;

