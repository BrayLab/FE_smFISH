clear all 
[file, path] = uigetfile ('*.csv');


Table = readtable(append(path, file));
% to see properties use Table.Properties.VariableNames
Table.TotalArea = [];   % Removes the column 'NewColumn' from the table
Table.AverageSize = [];   % Removes the column 'NewColumn' from the table
Table.x_Area = [];
Table.Slice = [];
Table.Mean = []; 
resultColumn = Table{2, :} ./ Table{1, :};
resultColumn1 = resultColumn * 100
resultColumn2 = Table{3, :} ./ Table{1, :};
resultColumn22 = resultColumn2 * 100
ResultMatrix = [resultColumn1, resultColumn22]

% New row to add
%newRow = [NaN, NaN];
% Add the new row to the matrix
%ResultMatrix = [ResultMatrix; newRow];  % Concatenating new row at the bottom
% Display the updated matrix
%disp(ResultMatrix);

% Folder path containing CSV files
folderPath = '/Users/gulat/Documents/stage 6';
if ~isfolder(folderPath)
    error('The specified folder does not exist.');
else disp('Good')
end

csvFiles = dir(fullfile(folderPath, '*.csv'));
if isempty(csvFiles)
    error('No CSV files found in the specified folder.');
else
    disp({csvFiles.name}); % Display list of CSV files
end

% Loop through each CSV file

Propst6 = nan([size(csvFiles, 1), 2]);

for i = 1:size(csvFiles, 1)
    % Construct full file path
    filePath = fullfile(folderPath, csvFiles(i).name);
    TableAdd = readtable(filePath);
    CountValues = TableAdd{:, 2};
    
    HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
    m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
   
    Propst6(i, :) = [HntProp, m7Prop];

    % TableAdd.TotalArea = [];   % Removes the column 'NewColumn' from the table
    % TableAdd.AverageSize = [];   % Removes the column 'NewColumn' from the table
    % TableAdd.x_Area = [];
    % TableAdd.Slice = [];
    % TableAdd.Mean = [];
    % newResult1 = TableAdd{2, :} ./ TableAdd{1, :};
    % newResult11 = newResult1 * 100
    % newResult2 = TableAdd{3, :} ./ TableAdd{1, :};
    % newResult22 = newResult2 * 100
    % newRow1 = [newResult11, newResult22];
    % ResultMatrix = [ResultMatrix; newRow1];
    % disp(ResultMatrix);
    % Display a message indicating progress
    % fprintf('Processed file: %s\n', csvFiles(i).name);
end

%find
%if, elseif, else, end












% Folder path containing CSV files
folderPath = '/Users/gulat/Documents/stage 6';
if ~isfolder(folderPath)
    error('The specified folder does not exist.');
else disp('Good')
end

csvFiles = dir(fullfile(folderPath, '*.csv'));
if isempty(csvFiles)
    error('No CSV files found in the specified folder.');
else
    disp({csvFiles.name}); % Display list of CSV files
end



% Loop through each CSV file
for i = 1:length(csvFiles)
    % Construct full file path
    filePath = fullfile(folderPath, csvFiles(i).name);
    TableAdd = readtable(filePath);
    TableAdd.TotalArea = [];   % Removes the column 'NewColumn' from the table
    TableAdd.AverageSize = [];   % Removes the column 'NewColumn' from the table
    TableAdd.x_Area = [];
    TableAdd.Slice = [];
    TableAdd.Mean = [];
    newResult1 = TableAdd{2, :} ./ TableAdd{1, :};
    newResult2 = TableAdd{3, :} ./ TableAdd{1, :};
    newRow1 = [newResult1, newResult2];
    ResultMatrix = [ResultMatrix; newRow1];
    disp(ResultMatrix);
    % Display a message indicating progress
    fprintf('Processed file: %s\n', csvFiles(i).name);
end






folderPath = '/Users/Shared/Files From c.localized/cammed/PART 2 PROJECT BRAY/stage 6';  % Update with your folder path

if ~isfolder(folderPath)
    error('The specified folder does not exist.');
else
    disp('Folder exists. Checking for CSV files...');
end




% Display the names of any files found
if isempty(csvFiles)
    disp('No CSV files found in the specified folder.');
else
    disp('CSV files found:');
    disp({csvFiles.name});
end

allFiles = dir(folderPath);  % Lists all files
disp({allFiles.name});

folderPath = '/Users/Shared/Files From c.localized/cammed/PART 2 PROJECT BRAY/stage 6';  % Update with your folder path
allFiles = dir(folderPath);             % List all files in the folder

% Display file details
for k = 1:length(allFiles)
    disp(['File name: ', allFiles(k).name]);
end

folderPath = '/Users/gulat/Documents/stage 6';  % Update with your actual folder path

% List all files in the folder with only .csv extension
allFiles = dir(fullfile(folderPath, '*.csv'));

% Filter out directories or hidden files
csvFiles = allFiles(~[allFiles.isdir]);  % Exclude directories

% Display filtered file names
for k = 1:length(csvFiles)
    disp(['File name: ', csvFiles(k).name]);
end

for k = 1:length(csvFiles)
    fullFilePath = fullfile(csvFiles(k).folder, csvFiles(k).name);
    disp(['Full file path: ', fullFilePath]);
end

% List all CSV files in the folder
csvFiles = dir(fullfile(folderPath, '*.csv'));

folderPath = '/Users/gulat/Documents';  % Replace with your actual path
csvFiles = dir(fullfile(folderPath, '*.csv'));

folderPath = '/Users/Shared/Files From c.localized/cammed/PART 2 PROJECT BRAY/stage 6';  % Or another accessible directory
specificFile = dir(fullfile(folderPath, 'abc.csv'));
if isempty(specificFile)
    disp('abc.csv is still not detected.');
else
    disp('abc.csv was found in the new folder.');
end



% Verify if MATLAB detects any files
if isempty(csvFiles)
    disp('No CSV files found in the specified folder.');
else
    disp('CSV files found:');
    disp({csvFiles.name});
end

fullFilePath = fullfile(folderPath, 'abc.csv');  % Full path to abc.csv
if exist(fullFilePath, 'file')
    disp('File abc.csv is accessible.');
else
    disp('File abc.csv is NOT accessible.');
end

specificFile = dir(fullfile(folderPath, 'abc.csv'));
if isempty(specificFile)
    disp('abc.csv is still not detected.');
else
    disp('abc.csv was found:');
    disp(specificFile.name);
end

isFolder = isfolder(folderPath); % Check if folder exists and is accessible
disp(['Folder exists: ', num2str(isFolder)]);

% Loop through each CSV file
for i = 1:length(csvFiles)
    % Construct full file path
    filePath = fullfile(folderPath, csvFiles(i).name);
    TableAdd = readtable(append(path, file));
    TableAdd.TotalArea = [];   % Removes the column 'NewColumn' from the table
    TableAdd.AverageSize = [];   % Removes the column 'NewColumn' from the table
    TableAdd.x_Area = [];
    TableAdd.Slice = [];
    TableAdd.Mean = [];
    newResult1 = TableAdd{2, :} ./ TableAdd{1, :};
    newResult2 = TableAdd{3, :} ./ TableAdd{1, :};
    newRow1 = [newResult1, newResult2];
    ResultMatrix = [ResultMatrix; newRow1];
    disp(ResultMatrix);
    % Display a message indicating progress
    fprintf('Processed file: %s\n', csvFiles(i).name);
end








%resultColumnrepeat = Table{4, :} ./ Table{1, :};
%ResultMatrix(2,1) = resultColumnrepeat;
%disp(ResultMatrix);


%to add to new table
%ResultTable.m7 = resultColumn2
%ResultTable = table(resultColumn, 'VariableNames', {'Hnt'});

% Add `resultRow` as a new row to the table
%Table.NewResultColumn = resultColumn
%Table{:, end+1} = resulColumn;
%resultRow2 = Table{3, :} ./ Table{1, :};
%Table{end+1, :} = resultRow2;

