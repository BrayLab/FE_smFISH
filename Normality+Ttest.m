%for normality test

%
%then create loop for all csvs
%loop should have:
% 1) table add (put csv into table form)
% 2) extract 1st column of table
% 3) strcomp for n55 or yw -> sort into 2 different matrices
% 4) strcomp for third part of string 6 or 7 or 8 -> 

clear all
%omg javier be so proud!!

rootPath = '/Users/gulat/Documents/matlabsmFishAM';
%rootPath = uigetdir();
listRoot = dir(rootPath)

%cell array can store any combo of data: strings, characters, numbers 
%matrix can only store numbers



directories = {'stage 6', 'stage 7', 'stage 9'};
allwrifolders = {};
allBrRNAifolders = {};

for z = 1:size(directories, 2)
    Stagexdirectory = dir(append(listRoot(1).folder, '/*', directories{1, z}, '*'));
    %disp (Stagexdirectory)
    Stagexsubfolders = dir(append(Stagexdirectory(1).folder, '/', Stagexdirectory(1).name));
    %disp (Stagexsubfolders)
%how did it know to do it to run this for all the folders within stage6 directory, i thought you'd need a loop to do this?
%basically, dir gets a list of all the things within any given folder eg.
%all the subfolders or all the files
        
    stagewrifolders = {};
    stageBrRNAifolders = {};

%WORK ON THIS OVER XMAS
% for u = 1:size(Stagexsubfolders, 1)
%         Stagexsubfolders = dir(append(listRoot(1).folder, '/*', directories{1, z}, '*'));
%         %disp (Stagexdirectory)
%         Stagexsubfolders = dir(append(Stagexdirectory(1).folder, '/', Stagexdirectory(1).name));
%         %disp (Stagexsubfolders)
% %how did it know to do it to run this for all the folders within stage6 directory, i thought you'd need a loop to do this?
% %basically, dir gets a list of all the things within any given folder eg.
% %all the subfolders or all the files
       

    for y = 1:size(Stagexsubfolders, 1)
    %input conditions to assign to different variables
        try
        % receive wRi+anything files from subfolder
        tempwRi = dir(append(Stagexsubfolders(y).folder, '/',Stagexsubfolders(y).name, '/', 'wRi', '*'));
        tempBrRNAi = dir(append(Stagexsubfolders(y).folder, '/',Stagexsubfolders(y).name, '/', 'BrRNAi', '*'));
        end
  
        if isempty(tempwRi)
           disp ('is empty')
        else
            for r = 1:size(tempwRi, 1)
                %to append to empty array set up previously use end+1
                %you don't have to use append for strcat, you can use
                %square brackets and just commas?
                disp (tempwRi(r).name)
                stagewrifolders{end+1} = [tempwRi(r).folder, '/', tempwRi(r).name];
            end
        end

         if isempty(tempBrRNAi)
           disp ('is empty')
        else
            for r = 1:size(tempBrRNAi, 1)
                %to append to empty array set up previously use end+1
                %you don't have to use append for strcat, you can use
                %square brackets and just commas?
                disp (tempBrRNAi(r).name)
                stageBrRNAifolders{end+1} = [tempBrRNAi(r).folder, '/', tempBrRNAi(r).name];
            end
        end
    end
    allwrifolders{z} = stagewrifolders
    allBrRNAifolders{z} = stageBrRNAifolders
end

% stage6wrifolders = allwrifolders{1}
% stage7wrifolders = allwrifolders{2}
% stage9wrifolders = allwrifolders{3}


allwricsvs = {};
allBrRNAicsvs = {}
for i = 1:size(directories, 2)
    stagewricsvs = {};
    stageBrRNAicsvs = {}

    for k = 1:size(allwrifolders{i}, 2)
      %i surely don't need to construct a path for each wri subfolder bc i
      %have it from Stage6wridirectories, but then how do i use for loop

      %loop for wri subfolders
        stageiwriPath = allwrifolders{i}{1,k}
        %obtain all csvs in each wri subfolders
        csvFilesInFolder = dir([stageiwriPath ,'/*count.csv']);
        % If .csv files are found, store their full paths
        % ~negates expression!!
        if ~isempty(csvFilesInFolder)
            for j = 1:size(csvFilesInFolder, 1)
            % Construct the full path manually and append to the list
            stagewricsvs{end + 1} = [csvFilesInFolder(j).folder, '/', csvFilesInFolder(j).name];
            end
        else
        % Display message if no .csv files are found in this subfolder
        disp(['No .csv files in: ', stageiwriPath]);
        end
    end 

    for l = 1:size(allBrRNAifolders{i}, 2)
      %loop for all BrRNAi subfolders
        stageiBrRNAiPath = allBrRNAifolders{i}{1,l}
        %obtain all csvs in each wri subfolders
        csvFilesInFolderBr = dir([stageiBrRNAiPath ,'/*count.csv']);
        % If .csv files are found, store their full paths
        % ~negates expression!!
        if ~isempty(csvFilesInFolderBr)
            for j = 1:size(csvFilesInFolderBr, 1)
            % Construct the full path manually and append to the list
            stageBrRNAicsvs{end + 1} = [csvFilesInFolderBr(j).folder, '/', csvFilesInFolderBr(j).name];
            end
        else
        % Display message if no .csv files are found in this subfolder
        disp(['No .csv files in: ', stageiBrRNAiPath]);
        end
    end
    %store stage results
    allwricsvs{i} = stagewricsvs
    allBrRNAicsvs{i} = stageBrRNAicsvs
end
    % to test function works: celldisp(allwricsvs{1})
    %celldisp(allBrRNAicsvs{1})

stage6wricsvfiles = allwricsvs{1}
stage7wricsvfiles = allwricsvs{2}
stage9wricsvfiles = allwricsvs{3}

stage6BrRNAicsvfiles = allBrRNAicsvs{1}
stage7BrRNAicsvfiles = allBrRNAicsvs{2}
stage9BrRNAicsvfiles = allBrRNAicsvs{3}

HntSt6wri = []
HntSt7wri = []
HntSt9wri = []
m7St6wri = []
m7St7wri = []
m7St9wri = []

HntSt6BrRNAi = []
HntSt7BrRNAi = []
HntSt9BrRNAi = []
m7St6BrRNAi = []
m7St7BrRNAi = []
m7St9BrRNAi = []


for i = 1:size(allwricsvs, 2)
% for i = 1:1
    for j = 1:size(allwricsvs{i}, 2)
        TableAdd = readtable(allwricsvs{i}{1, j});

        for s = 1:size(TableAdd, 1)
            Name = TableAdd{s, 1};
            Count = TableAdd{s, 2};
            parts = split(string(Name), ',');
            parts{end} = erase(parts{end}, '.tif');
            disp(parts);

            switch i
                case 1
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt6wri = [HntSt6wri ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St6wri = [m7St6wri ; (Count / CellCount) * 100]
                    end
               
                case 2
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt7wri = [HntSt7wri ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St7wri = [m7St7wri ; (Count / CellCount) * 100]
                    end
    
                case 3
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt9wri = [HntSt9wri ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St9wri = [m7St9wri ; (Count / CellCount) * 100]
                    end
            end
        end
    end
end  

for i = 1:size(allBrRNAicsvs, 2)
% for i = 1:1
    for j = 1:size(allBrRNAicsvs{i}, 2)
        TableAdd = readtable(allBrRNAicsvs{i}{1, j});

        for s = 1:size(TableAdd, 1)
            Name = TableAdd{s, 1};
            Count = TableAdd{s, 2};
            parts = split(string(Name), ',');
            parts{end} = erase(parts{end}, '.tif');
            disp(parts);

            switch i
                case 1
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt6BrRNAi = [HntSt6BrRNAi ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St6BrRNAi = [m7St6BrRNAi ; (Count / CellCount) * 100]
                    end
               
                case 2
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt7BrRNAi = [HntSt7BrRNAi ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St7BrRNAi = [m7St7BrRNAi ; (Count / CellCount) * 100]
                    end
    
                case 3
                    if strcmp(parts{4}, 'cells')
                        CellCount = Count
                    end
                    if strcmp(parts{4}, 'hnt')
                         HntSt9BrRNAi = [HntSt9BrRNAi ; (Count / CellCount) * 100]
                    end
                    if strcmp(parts{4}, 'm7')
                        m7St9BrRNAi = [m7St9BrRNAi ; (Count / CellCount) * 100]
                    end
            end
        end
    end
end 

% To find out if data is normal: Kolmogorov-Smirnov Test

alldata = {HntSt6wri, HntSt6BrRNAi, HntSt7BrRNAi, HntSt7wri, HntSt9BrRNAi, HntSt9wri }
alldatavars = {'HntSt6wri', 'HntSt6BrRNAi', 'HntSt7BrRNAi','HntSt7wri', 'HntSt9BrRNAi', 'HntSt9wri'}

for a = 1:size(alldata, 2)

    % Perform Kolmogorov-Smirnov test
    [h, p] = kstest((alldata{a} - mean(alldata{a})) / std(alldata{a}));
    
    % Display results
    if h == 0
        disp( [char(alldatavars{a}), 'Data follows a normal distribution (fail to reject null hypothesis).']);
    else
        disp( [char(alldatavars{a}), 'Data does not follow a normal distribution (reject null hypothesis).']);
    end
end

%to do unpaired t-test
wrigroup = {HntSt6wri, HntSt7wri, HntSt9wri}
wrigroupname = {'HntSt6wri', 'HntSt7wri', 'HntSt9wri'}
BrRNAigroup = {HntSt6BrRNAi, HntSt7BrRNAi, HntSt9BrRNAi}
BrRNAigroupname = {'HntSt6BrRNAi', 'HntSt7BrRNAi', 'HntSt9BrRNAi'}

for y = 1:size(wrigroup, 2)
    [h, p, ci, stats] = ttest2(wrigroup{y}, BrRNAigroup{y});
    % Display results
    if h == 0
        disp([ wrigroupname{y}, 'Fail to reject null hypothesis: Means are not significantly different.']);
        disp(['p-value: ', num2str(p)]);
        disp(['Confidence Interval: ', num2str(ci')]);
    else
        disp([ wrigroupname{y}, 'Reject null hypothesis: Means are significantly different.']);
        disp(['p-value: ', num2str(p)]);
        disp(['Confidence Interval: ', num2str(ci')]);
    end
end

group1 = randn(30, 1) + 1; % Group 1 mean ~1
group2 = randn(30, 1);     % Group 2 mean ~0

% Perform two-sample t-test
[h, p, ci, stats] = ttest2(group1, group2);

% Display results
if h == 0
    disp('Fail to reject null hypothesis: Means are not significantly different.');
else
    disp('Reject null hypothesis: Means are significantly different.');
end

% Show test statistics
disp(['p-value: ', num2str(p)]);
disp(['t-statistic: ', num2str(stats.tstat)]);
disp(['Confidence Interval: ', num2str(ci')]);