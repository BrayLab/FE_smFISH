%script to analyse cytoplasm intensities
%REMEMBER TO ADD FILTERED  MATRIX

%questions for javier
%to use same variable letter or different variables to prevent issues when
%running parts of code separately instead of whole thing?

rootPath = '/Users/gulat/Documents/matlabsmFish';
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


%javier how would i do this but avoid creating 2 tables (append to the second
%column of a matrix)?
allwriHntcsvs = {};
allwrim7csvs = {};
allBrRNAiHntcsvs = {}
allBrRNAim7csvs = {}
for i = 1:size(directories, 2)
    stagewriHntcsvs = {};
    stagewrim7csvs = {}
    stageBrRNAiHntcsvs = {}
    stageBrRNAim7csvs = {}

    for k = 1:size(allwrifolders{i}, 2)
      %i surely don't need to construct a path for each wri subfolder bc i
      %have it from Stage6wridirectories, but then how do i use for loop

      %loop for wri subfolders
        stageiwriPath = allwrifolders{i}{1,k}
        %obtain all csvs in each wri subfolders
        HntcsvFilesInFolder = dir([stageiwriPath ,'/*cytoplasm_Hntintensities.csv']);
        m7csvFilesInFolder = dir([stageiwriPath ,'/*cytoplasm_m7intensities.csv']);
        % If .csv files are found, store their full paths
        % ~negates expression!!
        if ~isempty(HntcsvFilesInFolder)
            for j = 1:size(HntcsvFilesInFolder, 1)
            % Construct the full path manually and append to the list
            stagewriHntcsvs{end + 1} = [HntcsvFilesInFolder(j).folder, '/', HntcsvFilesInFolder(j).name];
            end
        end
        if ~isempty(m7csvFilesInFolder)
            for j = 1:size(m7csvFilesInFolder, 1)
            % Construct the full path manually and append to the list
            stagewrim7csvs{end + 1} = [m7csvFilesInFolder(j).folder, '/', m7csvFilesInFolder(j).name];
            end
        else
        % Display message if no .csv files are found in this subfolder
        disp(['No intensities.csv files in: ', stageiwriPath]);
        end
    end

    for l = 1:size(allBrRNAifolders{i}, 2)
      %loop for all BrRNAi subfolders
        stageiBrRNAiPath = allBrRNAifolders{i}{1,l}
        %obtain all csvs in each wri subfolders
        HntcsvFilesInFolder = dir([stageiBrRNAiPath ,'/*cytoplasm_Hntintensities.csv']);
        m7csvFilesInFolder = dir([stageiBrRNAiPath ,'/*cytoplasm_m7intensities.csv']);
        % If .csv files are found, store their full paths
        % ~negates expression!!
        if ~isempty(HntcsvFilesInFolder)
            for j = 1:size(HntcsvFilesInFolder, 1)
            % Construct the full path manually and append to the list
            stageBrRNAiHntcsvs{end + 1} = [HntcsvFilesInFolder(j).folder, '/', HntcsvFilesInFolder(j).name];
            end
        end
        if ~isempty(m7csvFilesInFolder)
            for j = 1:size(m7csvFilesInFolder, 1)
            % Construct the full path manually and append to the list
            stageBrRNAim7csvs{end + 1} = [m7csvFilesInFolder(j).folder, '/', m7csvFilesInFolder(j).name];
            end
        else
        % Display message if no .csv files are found in this subfolder
        disp(['No intensities.csv files in: ', stageiBrRNAiPath]);
        end
    end
    %store stage results
    allwriHntcsvs{i} = stagewriHntcsvs
    allwrim7csvs{i} = stagewrim7csvs
    allBrRNAiHntcsvs{i} = stageBrRNAiHntcsvs
    allBrRNAim7csvs{i} = stageBrRNAim7csvs
end



%TOCHECKFORDUPLICATES (troubleshooting)
% % Find unique elements
% [uniqueData, ia, ic] = unique(stageBrRNAim7csvs);
% 
% % Find duplicates
% duplicateIndices = setdiff(1:numel(stageBrRNAim7csvs), ia);
% duplicates = stageBrRNAim7csvs(duplicateIndices);
% 
% disp('Duplicates:');
% disp(duplicates);

    % to test function works: celldisp(allwricsvs{1})
    %celldisp(allBrRNAicsvs{1})

stage6wriHntcsvfiles = allwriHntcsvs{1}
stage7wriHntcsvfiles = allwriHntcsvs{2}
stage9wriHntcsvfiles = allwriHntcsvs{3}

stage6wrim7csvfiles = allwrim7csvs{1}
stage7wrim7csvfiles = allwrim7csvs{2}
stage9wrim7csvfiles = allwrim7csvs{3}

stage6BrRNAiHntcsvfiles = allBrRNAiHntcsvs{1}
stage7BrRNAiHntcsvfiles = allBrRNAiHntcsvs{2}
stage9BrRNAiHntcsvfiles = allBrRNAiHntcsvs{3}

stage6BrRNAim7csvfiles = allBrRNAim7csvs{1}
stage7BrRNAim7csvfiles = allBrRNAim7csvs{2}
stage9BrRNAim7csvfiles = allBrRNAim7csvs{3}



masterCellArray = {'stage 6', 'wRi', 'Hnt', allwriHntcsvs{1}; 'stage 6', 'BrRNAi', 'Hnt', allBrRNAiHntcsvs{1}; 'stage 7', 'wRi', 'Hnt', allwriHntcsvs{2};'stage 7', 'BrRNAi', 'Hnt', allBrRNAiHntcsvs{2};'stage 9', 'wRi', 'Hnt', allwriHntcsvs{3}; 'stage 9', 'BrRNAi', 'Hnt', allBrRNAiHntcsvs{3}; 'stage 6', 'wRi', 'm7', allwrim7csvs{1}; 'stage 6', 'BrRNAi', 'm7', allBrRNAim7csvs{1};'stage 7', 'wRi', 'm7', allwrim7csvs{2};'stage 7', 'BrRNAi', 'm7', allBrRNAim7csvs{2}; 'stage 9', 'BrRNAi', 'm7', allBrRNAim7csvs{3}; 'stage 9', 'wRi', 'm7', allwrim7csvs{3}}

% %bc my fiji pipeline was messed up COMMENT OUT IF U GET FIJI TO WORK
% for z = 1:size(masterCellArray, 1)
%     disp(masterCellArray {z,1})
%     if strcmp(masterCellArray{z, 3}, 'm7')
%         disp(['Condition met for row ', num2str(z)])
%         col4new = masterCellArray{z,4}
%         for y = 1:size(col4new, 2)
%             TableAdd = readtable(col4new{1, y});
%                 if size(TableAdd, 2) >= 9
%                 % Find the rows where column 9 is NaN
%                     rowsToRemove = ~isnan(TableAdd{:, 9});  % Logical array where true means not NaN
%                     TableAdd(rowsToRemove, :) = [];  % Remove rows where column 9 is not NaN
%                 end
%                 % for x = 1:size(TableAdd, 2)
%                 %     if ~isnan(TableAdd{x, 9})
%                 %         TableAdd(x, 9) = []
%                 %     end
%                 % end
%             [originalDir, ~, ~] = fileparts(col4new{1, y})
%             writetable(TableAdd, col4new{1, y});
%         end
%     end
% end

          



% %oh my god i've gone un poco loco...ayudame por favor
% IntensityHntst6 = [nan]
% Intensitym7st6 = [nan]
% IntensityHntst6Br = [nan]
% Intensitym7st6Br = [nan]
% IntensityHntst7 = [nan]
% Intensitym7st7 = [nan]
% IntensityHntst7Br = [nan]
% Intensitym7st7Br = [nan]
% IntensityHntst9 = [nan]
% Intensitym7st9 = [nan]
% IntensityHntst9Br = [nan]
% Intensitym7st9Br = [nan]

% for z = 1:size(directories, 2)
%     if z == 1
%         a = stage6wriHntcsvfiles
%         b = stage6wrim7csvfiles
%         c = stage6BrRNAiHntcsvfiles
%         d = stage6BrRNAim7csvfiles
%         e = IntensityHntst6
%         f = Intensitym7st6
%         g = IntensityHntst6Br
%         h = Intensitym7st6Br
%     elseif z == 2
%         a = stage7wriHntcsvfiles
%         b = stage7wrim7csvfiles
%         c = stage7BrRNAiHntcsvfiles
%         d = stage7BrRNAim7csvfiles
%         e = IntensityHntst7
%         f = Intensitym7st7
%         g = IntensityHntst7Br
%         h = Intensitym7st7Br
%     else z == 3
%         a = stage9wriHntcsvfiles
%         b = stage9wrim7csvfiles
%         c = stage9BrRNAiHntcsvfiles
%         d = stage9BrRNAim7csvfiles
%         e = IntensityHntst9
%         f = Intensitym7st9
%         g = IntensityHntst9Br
%         h = Intensitym7st9Br
%     end
%     % Function to process and append intensities for each stage
%     processIntensityData(a, e);
%     processIntensityData(b, f);
%     processIntensityData(c, g);
%     processIntensityData(d, h);
% end

%initialise the matrices for Hnt and m7 based on stage
%wRi, BrRNAi
IntensityHnt6 = [nan,nan] 
IntensityM76 = [nan,nan]
IntensityHnt7 = [nan, nan]
IntensityM77 = [nan, nan]
IntensityHnt9 = [nan, nan]
IntensityM79 = [nan, nan]

%for the boxplot
 Nicknames = {}

for i = 1:size(masterCellArray, 1)
%for i = 1:1
% to test for i = 1:7
    %for boxplot
    Nicknames {end + 1} = [masterCellArray{i,1} ,' ' , masterCellArray{i,2}]
    col4 = masterCellArray{i,4}
% intensities: WriHnt, WriM7, BrHnt, BrM7
    for s = 1:size(col4, 2)
    %for s = 1:1
    % to test for s = 1
        % Construct full file path
        % {} takes things out of the csvFiles
        TableAdd = readtable(col4{1, s});
        disp(col4{1,s})
        IntDen = TableAdd{:, 7};
        disp(IntDen)

        %for stage 6
        if strcmp(masterCellArray{i, 1}, 'stage 6')
            if strcmp(masterCellArray{i,3} , 'Hnt')
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    %would be nice to add a file name
                    %IntDen = padconcatenation(IntDen, col4{1,s}, 2)
                    IntensityHnt6 = [IntensityHnt6 ; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityHnt6 = [IntensityHnt6 ; IntDen]
                end
            end
            if strcmp(masterCellArray{i,3} , 'm7') 
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    IntensityM76 = [IntensityM76; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityM76 = [IntensityM76; IntDen ]
                end
            end
        end

        %for stage 7
        if strcmp(masterCellArray{i, 1}, 'stage 7')
            if strcmp(masterCellArray{i,3} , 'Hnt')
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    IntensityHnt7 = [IntensityHnt7 ; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityHnt7 = [IntensityHnt7 ; IntDen]
                end
            end
            if strcmp(masterCellArray{i,3} , 'm7')
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    IntensityM77 = [IntensityM77; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityM77 = [IntensityM77; IntDen ]
                end
            end
        end


        %for stage 9
         if strcmp(masterCellArray{i, 1}, 'stage 9')
            if strcmp(masterCellArray{i,3} , 'Hnt')
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    IntensityHnt9 = [IntensityHnt9 ; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityHnt9 = [IntensityHnt9 ; IntDen]
                end
            end
            if strcmp(masterCellArray{i,3} , 'm7')
                if strcmp(masterCellArray{i,2} , 'wRi')
                    IntDen = padconcatenation(IntDen, nan, 2)
                    IntensityM79 = [IntensityM79; IntDen]
                end
                if strcmp(masterCellArray{i,2} , 'BrRNAi')
                    IntDen = padconcatenation(nan, IntDen, 2)
                    IntensityM79 = [IntensityM79; IntDen ]
                end
            end
        end
    end
end

%unique function removes duplicates but usually alphabetises array aswell.
%if you don't want to alphabetise but rather keep order, then add stable
Nicknames = unique(Nicknames, 'stable')
disp(Nicknames)


%For loop if I'm using average intensity data
    % for s = 1:size(stage7BrRNAicsvfiles, 2)
    %     % Construct full file path
    %     % {} takes things out of the csvFiles
    %     TableAdd = readtable(stage7BrRNAicsvfiles{1, s});
    %     IntDen = TableAdd{:, 8};
    % 
    %     HntIntensity = IntDen(1,1)
    %     m7Intensity = IntDen(2,1)
    % 
    %     Intensityst7Br(s, :) = [HntIntensity, m7Intensity];
    % 
    % end

% javier how to pad concatenate three way?

AllIntensityHnt = padconcatenation(IntensityHnt6, IntensityHnt7, 2);
AllIntensityHnt = padconcatenation(AllIntensityHnt, IntensityHnt9, 2);
disp(AllIntensityHnt)

AllCytoplasmicFoci = AllIntensityHnt(:)
AllCytoplasmicFoci = AllCytoplasmicFoci(~isnan(AllCytoplasmicFoci));

filtered_data = AllCytoplasmicFoci(AllCytoplasmicFoci ~= 0); % Remove zero values

filtered_data = data_sorted
histogram(filtered_data, 'BinWidth',15); % Increase bins for more frequent bars

% Median = median (data_sorted);
% Mean = mean(data_sorted)
axis([0 300, 0 100]); % Sets X-axis from 0 to 100 and Y-axis from 0 to 50

%% m7 calib
%AllIntensityHnt = st6Wri, st6BrRNai, st7Wri, st7BrRNAi, st9wRi, st9BrRNAi
AllIntensitym7 = padconcatenation(IntensityM76, IntensityM77, 2);
AllIntensitym7 = padconcatenation(AllIntensitym7, IntensityM79, 2);

AllCytoplasmicFociM7 = AllIntensitym7(:)
AllCytoplasmicFociM7 = AllCytoplasmicFociM7(~isnan(AllCytoplasmicFociM7));

filtered_dataM7 = AllCytoplasmicFociM7(AllCytoplasmicFociM7 ~= 0); % Remove zero values
histogram(filtered_dataM7, 'BinWidth',10); % Increase bins for more frequent bars

% MedianM7 = median (filtered_dataM7);
% MeanM7 = mean(filtered_dataM7)
% axis([0 200 0 150]); % Sets X-axis from 0 to 100 and Y-axis from 0 to 50


%% 
AllIntensityHnt1 = AllIntensityHnt./ Median
AllIntensitym71 = AllIntensitym7 ./ MedianM7

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

% Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
% ExpLabels = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
Xlabel = 'Stage and condition of egg chamber'
Ylabel = 'Intensities of cytoplasmic foci (A.U.)'

%to create figures sorted by hnt or m7
boxplot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
nexttile
plotBoxplotMATLABlike_v2(AllIntensityHnt1, Nicknames, Nicknames, 0.5, 0.2, 'Cytoplasmic Hnt intensity', 15, 13, CMAP, 0.3, 2,20, [0, 12], Xlabel, Ylabel) %include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
nexttile
%include the second boxplot here
plotBoxplotMATLABlike_v2(AllIntensitym71, Nicknames, Nicknames, 0.5, 0.2, 'Cytoplasmic m7 intensity', 15, 15, CMAPBr, 0.8, 2,20, [0, 10], Xlabel, Ylabel)

ViolinPlot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
% nexttile
plotwoBoxplot(AllIntensityHnt, Nicknames, Nicknames, 0.5, 0.2, 'Intensity of ATS at Hnt target', 15, 20, CMAP, 0.3, 2,20, [0, 100])%include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)


ylim([0,  100])

try
delete(violinplotobj);
end

Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
 ViolinPlot = violin(AllIntensityHnt, 'xlabel', Nicknames, 'ylabel', Ylabel, 'facecolor',CMAP, 'edgecolor','none', ...
'mc','',... 
'medc','', ...
'bw', 200) %change this parameter for the appearance of the violins

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
% ExpLabels = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
Xlabel = 'Stage and condition of egg chamber'
Ylabel = 'Intensities of cytoplasmic foci (A.U.)'

%to create figures sorted by hnt or m7
boxplot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
nexttile
plotBoxplotMATLABlike_v2(AllIntensityHnt, Nicknames, Nicknames, 0.5, 0.2, 'Cytoplasmic Hnt mRNA intensity', 15, 15, CMAP, 0.3, 2,20, [0, 45], Xlabel, Ylabel) %include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
nexttile
%include the second boxplot here
plotBoxplotMATLABlike_v2(AllIntensityM7, Nicknames, Nicknames, 0.5, 0.2, 'Cytoplasmic m7 mRNA intensity', 15, 15, CMAPBr, 0.6, 2,20, [0, 10], Xlabel, Ylabel)

