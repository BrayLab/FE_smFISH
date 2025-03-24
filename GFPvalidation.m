%rootPath = '/Users/gulat/Documents/matlabsmFishAM';
rootPath = uigetdir()
filePath = fullfile(rootPath, 'All_Intensities123 .csv');
T = readtable(filePath);
dataMatrix = table2array(T)

% fullCSVname = {}
% for j = 1:size(csvFiles, 1)
%     % Construct the full path manually and append to the list
%     fullCSVname{end + 1} = [csvFiles(j).folder, '/', csvFiles(j).name];
% end

% TableAdd = readtable(fullCSVname);
% TableAdd = TableAdd{:,:}

sum_data = sum(dataMatrix, 1)
average_data = sum_data / size(dataMatrix, 1)
percentage_diff_st6 = ((average_data(1) - average_data(2)) / average_data(1)) * 100;
percentage_diff_st7 = ((average_data(3) - average_data(4)) / average_data(3)) * 100;
percentage_diff_st9 = ((average_data(5) - average_data(6)) / average_data(5)) * 100;
disp('Percentage differences between control and BrRNAi for each stage:');
disp(['Stage 6: ', num2str(percentage_diff_st6), '%']);
disp(['Stage 7: ', num2str(percentage_diff_st7), '%']);
disp(['Stage 9: ', num2str(percentage_diff_st9), '%']);
%% 



%for FIGURE:
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
CMAP = [0 0 0];
lightgray = [.4 .4 .4]
gray = [0.6 0.6 0.6]
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
CMAP = [lightgray;gray;lightgray;gray;lightgray;gray]%change to no. of columns!!
CMAPBr = [darkgreen;lightgreen;darkgreen;lightgreen;darkgreen;lightgreen]
%hold on
%CMAP = repmat(CMAP, 6, 1)

Nicknames = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
ExpLabels = {'wRNAist6','BrRNAist6','wRNAist7','BrRNAist7','wRNAist9', 'BrRNAist9'}
Xlabel = 'Stage and condition of egg chamber'
Ylabel = 'GFP intensity'

%to create figures sorted by hnt or m7
boxplot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
% nexttile
plotBoxplotMATLABlike_v2(dataMatrix, Nicknames, Nicknames, 0.5, 0.2, 'BrZ1-GFP intensity', 15, 15, CMAP, 0.3, 2,20, [0, 2500], Xlabel, Ylabel) %include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
% nexttile
% %include the second boxplot here
% plotBoxplotMATLABlike_v2(AllPropm7, Nicknames,Nicknames, 0.5, 0.2, 'Proportion of ATS at m7 target', 15, 20, CMAPBr, 0.5, 2,20, [0, 25], Xlabel, Ylabel)

