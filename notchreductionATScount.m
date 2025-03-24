%
%then create loop for all csvs
%loop should have:
% 1) table add (put csv into table form)
% 2) extract 1st column of table
% 3) strcomp for n55 or yw -> sort into 2 different matrices
% 4) strcomp for third part of string 6 or 7 or 8 -> 

clear all
rootPath = '/Users/gulat/Documents/Notch dose reduction data';
%rootPath = uigetdir();
csvFiles = dir(fullfile(rootPath, '**', '*.csv'));

fullCSVname = {}
for j = 1:size(csvFiles, 1)
    % Construct the full path manually and append to the list
    fullCSVname{end + 1} = [csvFiles(j).folder, '/', csvFiles(j).name];
end

HntOverall = []
m7Overall = []

HntSt6n55 = []
m7St6n55 = []
HntSt6yw = []
m7St6yw = []

HntSt7n55 = []
m7St7n55 = []
HntSt7yw = []
m7St7yw = []

HntSt8n55 = []
m7St8n55 = []
HntSt8yw = []
m7St8yw = []

for i = 1:size(fullCSVname, 2)
% for i = 1:1
    TableAdd = readtable(fullCSVname{1, i});
    for s = 1:size(TableAdd, 1)
        Name = TableAdd{s, 1};
        Count = TableAdd{s, 2};
        parts = split(string(Name), ',');
        parts{end} = erase(parts{end}, '.tif');
        disp(parts);

        %for st6 n55
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'cells')
            CellCount = Count
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt6n55 = [HntSt6n55 ; HntProp]
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'm7')
            m7St6n55 = [m7St6n55 ; (Count / CellCount) * 100]
        end

        %for st6 yw
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'cells')
            disp(fullCSVname{1, i})
            CellCount = Count
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt6yw = [HntSt6yw ; HntProp]
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '6') && strcmp(parts{4}, 'm7')
            m7St6yw = [m7St6yw ; (Count / CellCount) * 100]
        end

        %for st7 n55
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'cells')
            CellCount = Count
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt7n55 = [HntSt7n55 ; HntProp]
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'm7')
            m7St7n55 = [m7St7n55 ; (Count / CellCount) * 100]
        end

        %for st7 yw
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'cells')
            CellCount = Count
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt7yw = [HntSt7yw ; HntProp]
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '7') && strcmp(parts{4}, 'm7')
            m7St7yw = [m7St7yw ; (Count / CellCount) * 100]
        end

        %for st8 n55
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'cells')
            CellCount = Count
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt8n55 = [HntSt8n55 ; HntProp]
        end
        if strcmp(parts{1}, 'n55') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'm7')
            m7St8n55 = [m7St8n55 ; (Count / CellCount) * 100]
        end

        %for st8 yw
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'cells')
            CellCount = Count
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'hnt')
            HntProp = (Count / CellCount) * 100
            HntSt8yw = [HntSt8yw ; HntProp]
        end
        if strcmp(parts{1}, 'yw') && strcmp(parts{3}, '8') && strcmp(parts{4}, 'm7')
            m7St8yw = [m7St8yw ; (Count / CellCount) * 100]
        end

    end

end

HntOverall = padconcatenation(HntSt6yw, HntSt6n55, 2)
HntOverall = padconcatenation(HntOverall, HntSt7yw, 2)
HntOverall = padconcatenation(HntOverall, HntSt7n55, 2)
HntOverall = padconcatenation(HntOverall, HntSt8yw, 2)
HntOverall = padconcatenation(HntOverall, HntSt8n55, 2)

m7Overall = padconcatenation(m7St6yw, m7St6n55, 2)
m7Overall = padconcatenation(m7Overall, m7St7yw, 2)
m7Overall = padconcatenation(m7Overall, m7St7n55, 2)
m7Overall = padconcatenation(m7Overall, m7St8yw, 2)
m7Overall = padconcatenation(m7Overall, m7St8n55, 2)
    
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
CMAP = [darkblue;lightblue;darkblue;lightblue;darkblue;lightblue]%change to no. of columns!!
CMAPBr = [purple;purple2;purple;purple2;purple;purple2]
%hold on
%CMAP = repmat(CMAP, 6, 1)

Nicknames = {'yw st6','n55 st6','yw st7','n55 st7','yw st8', 'n55 st8'}
ExpLabels = {'yw st6','n55 st6','yw st7','n55 st7','yw st8', 'n55 st8'}
Xlabel = 'Stage and condition of egg chamber'
Ylabel = 'Proportion of active transcription sites (ATS) as a proportion of all nuclei (%)'

%to create figures sorted by hnt or m7
boxplot = figure('Position',[600 100 1500 1000]); %you can also define the size of the figure here so you dont have to adjust it every time
% tiledlayout(1, 2) %the dimensions of your tiled layout, indicating columns and rows
nexttile
plotBoxplotMATLABlike_v2(HntOverall, Nicknames, Nicknames, 0.5, 0.2, 'Proportion of ATS at Hnt target', 15, 20, CMAP, 0.3, 2,20, [0, 70], Xlabel, Ylabel) %include the first boxplot here
% plotBoxplot(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
nexttile
%include the second boxplot here
plotBoxplotMATLABlike_v2(m7Overall, Nicknames,Nicknames, 0.5, 0.2, 'Proportion of ATS at m7 target', 15, 16, CMAPBr, 0.3, 2,20, [0, 15], Xlabel, Ylabel)

%% Ttest

X = AllPropFINAL(:,5) ;  % Group 1
Y = AllPropFINAL(:,11);      % Group 2

% Perform the unpaired t-test
[h, p, ci, stats] = ttest2(X, Y);

% Display the results
fprintf('p-value: %.4f\n', p);
if h == 1
    fprintf('The null hypothesis is rejected, there is a significant difference.\n');
else
    fprintf('Fail to reject the null hypothesis, no significant difference.\n');
end





           

%to look into: csvFilesInFolder = dir([rootPath,'/*.csv']);
