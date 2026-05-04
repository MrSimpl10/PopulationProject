% Analyze Data
% Christopher Luecht
% GROUP: 15

% This file takes 2 file inputs, cleans the data into only usefule
% information, concades the 2 lists and seperates them into east vs west
% populations. 

% I did this to clean up the main matlab file and seperate the 2 tasks
% requird.

function east_west_data = analyze_data(file_name_1, file_name_2)

    % Parse both Census files
    data1 = parsedata(file_name_1);
    data2 = parsedata(file_name_2);

    % Combine both datasets
    final_data = concadedata(data1, data2);

    % Convert final state data into East vs West totals
    east_west_data = eastwestdata(final_data);

end


function dataset = parsedata(filename)

    % Read the CSV file
    data = readcell(filename);

    % Get the column headers
    headers = string(data(1, :));

    % Find needed colums to search later
    nameCol = find(headers == "NAME");
    sumlevCol = find(headers == "SUMLEV");

    % Find all POPESTIMATE columns, these contain the important popoulation
    % data
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
    dataset = [stateNames string(popData)];

end


function dataset = concadedata(array1, array2)

    % Grab every column from array2 except the first column
    array2Data = array2(:, 2:end);

    % Add those columns to the end of array1
    dataset = [array1 array2Data];

end


function regionData = eastwestdata(final_data)

    % Common East vs West split
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

    % Get state names from first column
    stateNames = final_data(:, 1);

    % Get population data from all other columns
    popData = double(final_data(:, 2:end));

    % Find which rows are East and West
    eastRows = ismember(stateNames, eastStates);
    westRows = ismember(stateNames, westStates);

    % Add up all East states for each year
    eastTotals = sum(popData(eastRows, :), 1);

    % Add up all West states for each year
    westTotals = sum(popData(westRows, :), 1);

    % Combine into one final array
    regionData = [
        "East" string(eastTotals)
        "West" string(westTotals)
    ];

end