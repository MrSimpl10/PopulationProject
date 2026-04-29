%==========================%
%      Group Project       %
%      Name: Group 15      %
%==========================%

% Our groups project is looking at US state populations over the last 5 years. 
% Our dataset is from the data.census.gov website and has provided an estimate 
% for the population of every individual state from 2020 to 2025. Our goal is to 
% analyze the data to see if there's over arching trends over the years.


% Import File raw data
data = readcell('US Population.csv');

% Get state names 
states = string(data(10:61,1));
states = erase(states,"."); % Remove the extra puncuation

% Gather the population data for each state into seperate years
pop2020 = str2double(string(data(10:61,3)));
pop2021 = str2double(string(data(10:61,4)));
pop2022 = str2double(string(data(10:61,5)));
pop2023 = str2double(string(data(10:61,6)));
pop2024 = str2double(string(data(10:61,7)));
pop2025 = str2double(string(data(10:61,8)));

% Gather all information into one array
usPopulation = [states, pop2020, pop2021, pop2022, pop2023, pop2024, pop2025];

% Look at the data
disp(usPopulation)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Logistic growth estimate and graph

% Choose a state to graph
stateIndex = input("What State Would You Like to Graph? (1-50): ");   % change this number to choose a different state

% Real population data for that state
% Grabs state population data from 2020-2025
realPop = [pop2020(stateIndex), pop2021(stateIndex), pop2022(stateIndex), pop2023(stateIndex), pop2024(stateIndex), pop2025(stateIndex)];

% Time values
tReal = 0:5;       % 0 = 2020, 5 = 2025
tSmooth = 0:0.1:5; % Many Incrimants to smooth graph

% Logistic model values
P0 = pop2020(stateIndex);    % initial population in 2020 based off state

% Growth rate based on inital real data
r = (pop2021(stateIndex) - pop2020(stateIndex)) / pop2020(stateIndex);

% Carrying capacity guess (Have to figure out later when tuning the model)
K = 1000000000;

% Logistic growth function
estimatedPop = K ./ (1 + ((K - P0) / P0) .* exp(-r .* tSmooth));

% Estimated population in 2025
estimated2025 = K ./ (1 + ((K - P0) / P0) .* exp(-r * 5));

% Display Result Information
fprintf('State: %s\n', states(stateIndex))
fprintf('Growth rate r: %.6f\n', r)
fprintf('Estimated population in 2025: %.0f\n', estimated2025)
fprintf('Real population in 2025: %.0f\n', pop2025(stateIndex))

% Graph Real Population Data vs Estimated Data
plot(2020 + tSmooth, estimatedPop, 'b-', 'LineWidth', 2)
hold on
plot(2020 + tReal, realPop, 'ro-', 'LineWidth', 2)
hold off

xlabel('Year')
ylabel('Population')
title("Estimated vs Real Population for " + states(stateIndex))
legend('Estimated Population', 'Real Population', 'Location', 'best')
grid on

% Bigger dataset
% Find trends in broader regions
% Plot all on large graph
% Make total net change in all regions equal the net change in the US population
