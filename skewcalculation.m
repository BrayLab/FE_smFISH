%omg javier be so proud!!

rootPath = '/Users/gulat/Documents/matlabsmFish';
%rootPath = uigetdir();
%listRoot = dir(rootPath)

%cell array can store any combo of data: strings, characters, numbers 
%matrix can only store numbers



directories = {'stage 6', 'stage 7', 'stage 9'};
allwrifolders = {};
allBrRNAifolders = {};

for z = 1:size(directories, 2)
    Stagexdirectory = append(rootPath, '/', directories{z});
    %disp (Stagexdirectory)
    Stagexsubfolders = dir(Stagexdirectory);
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
        csvFilesInFolder = dir([stageiwriPath ,'/*all count.csv']);
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
        csvFilesInFolderBr = dir([stageiBrRNAiPath ,'/*all count.csv']);
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


%if find the st6 name - a nice idea but idk how i'd execute
%to ask javier! is is better to overwrite a variable, relying on your
%programme going through the code sequentially or is it better to define
%lots of separate variables eg. in the case of Hnt and m7 below.

    Propst6 = nan([size(stage6wricsvfiles, 2), 2]);
    Propst6Br = nan([size(stage6BrRNAicsvfiles, 2), 2]);
        
        for s = 1:size(stage6wricsvfiles, 2)
            % Construct full file path
            % {} takes things out of the csvFiles
            TableAdd = readtable(stage6wricsvfiles{1, s});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst6(s, :) = [HntProp, m7Prop];
        
        end
        
        for c = 1:size(stage6BrRNAicsvfiles, 2)
            % Construct full file path
            % {} takes things out of the csvFiles
            TableAdd = readtable(stage6BrRNAicsvfiles{1, c});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst6Br(c, :) = [HntProp, m7Prop];
        
        end
        

    

  %elseif find the st7 name - again a nice thought but how 

    Propst7 = nan([size(stage7wricsvfiles, 2), 2]);
    Propst7Br = nan([size(stage7BrRNAicsvfiles, 2), 2])

        for d = 1:size(stage7wricsvfiles, 2)
            % Construct full file path
            % {} takes things out of the csvFiles
            TableAdd = readtable(stage7wricsvfiles{1, d});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst7(d, :) = [HntProp, m7Prop];
        
        end
        
        for e = 1:size(stage7BrRNAicsvfiles, 2)
            % Construct full file path:
            %filePath = fullfile(folderPath, stage7wricsvfiles(i).name);
            %then use this to extract filepath csv to table
            %TableAdd = readtable(filePath);
            TableAdd = readtable(stage7BrRNAicsvfiles{1, e});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst7Br(e, :) = [HntProp, m7Prop];
        
        end

AllProp = padconcatenation(Propst6, Propst7, 2);
AllPropBr = padconcatenation(Propst6Br, Propst7Br, 2);
% 2 at end bc this is horizontal concatenation so u are adding new columns horizontally

%concatenate st9 into AllProp
Propst9 = nan([size(stage9wricsvfiles, 2), 2]);
Propst9Br = nan([size(stage9BrRNAicsvfiles, 2), 2]);
        
        for g = 1:size(stage9wricsvfiles, 2)
            % Construct full file path:
            %filePath = fullfile(folderPath, stage7wricsvfiles(i).name);
            %then use this to extract filepath csv to table
            %TableAdd = readtable(filePath);
            TableAdd = readtable(stage9wricsvfiles{1, g});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst9(g, :) = [HntProp, m7Prop];
        
        end

        for m = 1:size(stage9BrRNAicsvfiles, 2)
            % Construct full file path
            % {} takes things out of the csvFiles
            TableAdd = readtable(stage9BrRNAicsvfiles{1, m});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst9Br(m, :) = [HntProp, m7Prop];
        
        end

AllProp = padconcatenation(AllProp, Propst9, 2);
disp(AllProp)%hntWrist6, m7Wrist6, hntWrist7, m7wrist7, hntWrist9, m7wrist9

AllPropBr = padconcatenation(AllPropBr, Propst9Br, 2);
disp(AllPropBr)%hntBrst6, m7Brst6, hntBrst7, m7Brst7, hntBrst9, m7Brst9


%i want to make a matrix that has hntWrist6, hntBrst6, hntwrist7,
%hntBrst7,hntWrist9, hntBrst9

AllPropFINAL = padconcatenation(AllProp, AllPropBr, 2)
AllPropHnt = [AllPropFINAL(:,1), AllPropFINAL(:,7) AllPropFINAL(:,3), AllPropFINAL(:,9) AllPropFINAL(:,5), AllPropFINAL(:,11)]
AllPropm7 = [AllPropFINAL(:,2), AllPropFINAL(:,8) AllPropFINAL(:,4), AllPropFINAL(:,10) AllPropFINAL(:,6), AllPropFINAL(:,12)]

%TO ANALYSE SKEWNESS!

myMatrix = []
myColumn = []
for i = 1:size(AllPropHnt, 2)
    disp(i);
    data = AllPropHnt(:, i); % Extract the column

    % Remove NaN values
    data = data(~isnan(data));
    
    % Check for sufficient data points and reshape as needed
    if numel(data) < 2 
        warning('Skipping column %d: insufficient or invalid data.', i);
        continue;
    end
    
    % Reshape data to ensure it's a 2D array with one column
    data = reshape(data, [], 1);
    
    % Fit the Gaussian Mixture Model
    %GMModel = fitgmdist(data, 2);
    try
        GMModel = fitgmdist(data, 2, 'RegularizationValue', 1e-6);
    catch ME
        warning('Skipping column %d: GMM fitting failed. Error: %s', i, ME.message);
        continue;
    end

    disp(GMModel.ComponentProportion(1))
    ComponentProportion = reshape(GMModel.ComponentProportion, [], 1)
    Mean = reshape(GMModel.mu, [], 1)
    Sigma = reshape(GMModel.Sigma(:,:,:), [], 1)
    myColumn = [ComponentProportion; Mean; Sigma]
    myMatrix = [myMatrix,myColumn]
end

% Define column headers
columnHeaders = {'St6Wri', 'St6BrRNAi', 'St7Wri', 'St7BrRNAi', 'St9Wri', 'St9BrRNAi'};

% Define row headers
rowHeaders = {'Component Proportion 1', 'Component Proportion 2', 'Mean 1', 'Mean 2', 'Sd 1', 'Sd 2'};

% Create the table
myTable = array2table(myMatrix, 'VariableNames', columnHeaders, 'RowNames', rowHeaders);

% Display the table
disp(myTable);

folderName = uigetdir();

% Construct the full file path for the CSV
filePath = append(folderName, '/', 'HntSkewness.csv');

%writetable(myTable, filePath)
writetable(myTable, filePath, 'WriteRowNames', true);



%writetable(myTable, 'HntSkewness.csv')




%for FIGURE:
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
CMAP = [0 0 0];
blue = [0 0.5 1];
red = [1 0.2 0.2];
green = [0.11 0.7 0.32];
orange = [1 0.58 0.01];
darkorange = [1 0.3 0.01];
pink = [1 0.4 0.5];
purple = [0.74 0.01 1];
purple2 = [0.85 0.04 0.8560]
cyan = [0 1 1];
lightblue = [0.3010 0.7450 0.9330];
darkgreen = [0.4660 0.6740 0.1880];
lightgreen = [0.44 0.9 0.5];
darkblue =[0 0 1];
greenCSL =[0.48 0.76 0.22];
magentaMam =[0.77 0.08 0.34];
pinkHairless =[0.74 0.49 0.72];
CMAP = [darkorange;orange;darkorange;orange;darkorange;orange]%change to no. of columns!!
CMAPBr = [darkgreen;lightgreen;darkgreen;lightgreen;darkgreen;lightgreen]
%hold on
%CMAP = repmat(CMAP, 6, 1)

Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
ExpLabels = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
Xlabel = 'Stage and condition of egg chamber'
Ylabel = 'Proportion of active transcription sites (ATS( as a proportion of all nuclei (%)'

%to create figures sorted by hnt or m7
boxplot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
nexttile
plotBoxplotMATLABlike_v2(AllPropHnt, Nicknames, Nicknames, 0.5, 0.2, 'Proportion of ATS at Hnt target', 15, 20, CMAP, 0.3, 2,20, [0, 100], Xlabel, Ylabel) %include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
nexttile
%include the second boxplot here
plotBoxplotMATLABlike_v2(AllPropm7, Nicknames,Nicknames, 5, 0.2, 'Proportion of ATS at m7 target', 15, 10, CMAPBr, 0.8, 2,20, [0, 100], Xlabel, Ylabel)




ViolinPlot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
% nexttile
plotwoBoxplot(AllPropHnt, Nicknames, Nicknames, 0.5, 0.2, 'Proportion of ATS at Hnt target', 15, 20, CMAP, 0.3, 2,20, [0, 100])%include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)


ylim([0,  100])

try
delete(violinplotobj);
end

Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
 ViolinPlot = violin(AllPropHnt, 'xlabel', Nicknames, 'ylabel', Ylabel, 'facecolor',CMAP, 'edgecolor','none', ...
'mc','',... 
'medc','', ...
'bw', 5) %change this parameter for the appearance of the violins








All = AllPropHnt
Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
ExpLabels = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
BinWidthHist = 0.4
Jitter = 0.2; %Jitter./2 cant be > BarW 
BarW = 0.3; % barwidth for boxplot
FaceAlpha = 1; %transparency of box in boxplot
DotSize =  10; 
%CMAP = MyColorMap%Palette orMyColorMap if you want to introduce color manually
LineWidth = 2; 
FontSizeTitle = 16; 
FontSize = 12;
Ymin = 0;
Ylim = ([0,inf])
Log = false

figure('Position',[600 100 1500 1000]);
plotViolin(All,Nicknames,ExpLabels,BinWidthHist,BarW,Title,FontSize,FaceAlpha,LineWidth,FontSizeTitle,Ymin, Log)

%plotViolin(AllPropm7, {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}, {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}, 0.5, 0.3, 'Violin Plot example', 10, 0.5, 1.5, 12, 0, true)

% %either to create 2 separate figures
% fig1 = figure;
% fig2 = figure
% figure(fig1)
% plotBoxplotMATLABlike_v2(AllProp, {'hntst6','m7st6','hntst7','m7st7','hntst9', 'm7st9'}, {'hntst6','m7st6','hntst7','m7st7', 'hntst9', 'm7st9'}, 0.9, 0.2, 'Active Proportion in CTR wRNAi', 9, 5, CMAP, 0.8, 2,8, [0, 100])
% figure(fig2)
% plotBoxplotMATLABlike_v2(All, {'hntst6','m7st6','hntst7','m7st7','hntst9', 'm7st9'}, {'hntst6','m7st6','hntst7','m7st7', 'hntst9', 'm7st9'}, 0.9, 0.2, 'Active Proportion in BroadRNAi', 9, 5, CMAPBr, 0.8, 2,8, [0, 100])
% 
% 
%or to create a tiled figure
figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
nexttile
plotBoxplotMATLABlike_v2(AllProp, {'hntst6','m7st6','hntst7','m7st7','hntst9', 'm7st9'}, {'hntst6','m7st6','hntst7','m7st7', 'hntst9', 'm7st9'}, 1.5, 0.2, 'Active Proportion in CTR wRNAi', 9, 5, CMAP, 0.8, 2,8, [0, 100])%include the first boxplot here
nexttile
%include the second boxplot here
plotBoxplotMATLABlike_v2(AllPropBr, {'hntst6','m7st6','hntst7','m7st7','hntst9', 'm7st9'}, {'hntst6','m7st6','hntst7','m7st7', 'hntst9', 'm7st9'}, 1.5, 0.2, 'Active Proportion in BroadRNAi', 9, 5, CMAPBr, 0.8, 2,8, [0, 100])



%Angelette'snotes
% rows,columns [rows,columns]
% : means all eg. all rows or all columns
% [x ; y] concatenates things vertically ie. adds new columns
% [x , y] concatenates things horizontally ie. adds new rows
%CMAP = repmat(CMAP, 6, 1) - to construct a repeating matrix
%to check if something is true
% if isequal(ans{12}, ans{1})
%     disp('Arrays are equal');
% end

%to analyse intensity
Propst6 = nan([size(stage6wricsvfiles, 2), 2]);
        
        for i = 1:size(stage6wricsvfiles, 2)
            % Construct full file path
            % {} takes things out of the csvFiles
            TableAdd = readtable(stage6wricsvfiles{1, i});
            CountValues = TableAdd{:, 2};
            
            HntProp = (CountValues(2, 1) ./ CountValues(1, 1)) * 100;
            m7Prop = (CountValues(3, 1) ./ CountValues(1, 1)) * 100;
           
            Propst6(i, :) = [HntProp, m7Prop];
        
        end




intensity
counting cytoplasmic 
CALIBRRATE

%to check if something is true
if isequal(ans{12}, ans{1})
    disp('Arrays are equal');
end