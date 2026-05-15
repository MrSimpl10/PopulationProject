% Analyze Data
% Christopher Luecht
% GROUP: 15

% This file is responsible for taking in the raw csv data and creating usable arrays for the rest of the program.
% I chose to seperate this as it is a very different task than the growth simulation and graphing.
% It is also a lot of code that would make the main file look very cluttered.

function [east, west] = analyze_data(file_name_1, file_name_2, initial_year)

    % Parse data into usable format
    data1 = parsedata(file_name_1);
    data2 = parsedata(file_name_2);

    % Concate Data
    total_data = [data1, data2(:, 3:end)]; % 3:end Remove region name and year from second dataset to avoid duplicates as both datasets include 2020
    
    % Seperate into East vs West
    [east, west] = eastwestdata(total_data);

    % Add year values to array
    num_years = size(east, 2) - 1; % Subtract 1 for the region name
    years = initial_year:(initial_year + num_years - 1); % Use initial year and len of data to create year array
    east = [years; east(2:end)];
    west = [years; west(2:end)];

end

% Uses search functions to find the right columns to grab the correct data and make something usable
function dataset = parsedata(filename)

    % Read the CSV file
    data = readcell(filename);

    % Define where the header is, important for finding the right columns later
    headers = string(data(1, :));

    % Find needed colums to search later
    nameCol = find(headers == "NAME");
    sumlevCol = find(headers == "SUMLEV");

    % Find all POPESTIMATE columns, these contain the important popoulation data
    popCols = startsWith(headers, "POPESTIMATE");

    % Grab names and SUMLEV values to determine what are states later on
    names = string(data(2:end, nameCol));
    sumlev = cell2mat(data(2:end, sumlevCol));

    % Keep only state-level rows, csv already defined them with sumlev = 40
    stateRows = sumlev == 40;

    % Grab state names
    stateNames = names(stateRows);

    % Grab population data
    popData = data(2:end, popCols);
    popData = popData(stateRows, :);
    popData = cell2mat(popData);

    % Combine state names and population data into one giant array
    dataset = [stateNames, popData];

end


function [east, west] = eastwestdata(final_data)

    % The most common form of dividing the US into East and West is to use the Mississippi river as the dividing line. This is what I did.
    eastStates = ["Alabama","Connecticut","Delaware","Florida","Georgia", ...
                  "Illinois","Indiana","Kentucky","Maine","Maryland", ...
                  "Massachusetts","Michigan","Mississippi","New Hampshire","New Jersey", ...
                  "New York","North Carolina","Ohio","Pennsylvania","Rhode Island", ...
                  "South Carolina","Tennessee","Vermont","Virginia","West Virginia", ...
                  "Wisconsin"];

    westStates = ["Alaska","Arizona","Arkansas","California","Colorado", ...
                  "Hawaii","Idaho","Iowa","Kansas","Louisiana", ...
                  "Minnesota","Missouri","Montana","Nebraska","Nevada", ...
                  "New Mexico","North Dakota","Oklahoma","Oregon","South Dakota", ...
                  "Texas","Utah","Washington","Wyoming"];

    % Seperate info
    stateNames = final_data(:, 1);
    popData = double(final_data(:, 2:end));

    % Find which rows are East and West
    eastRows = ismember(stateNames, eastStates);
    westRows = ismember(stateNames, westStates);

    % Sum total population for each year for East and West
    east = sum(popData(eastRows, :), 1);
    west = sum(popData(westRows, :), 1);

end