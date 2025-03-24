clear all 

%we extract the smFISH data here
[file, path] = uigetfile('*cytoplasm_Hntintensities.csv');

Table = readtable(append(path, file));
Vectorsmfish = table2array(Table);
 histogram(Vectorsmfish);
Median= median (Vectorsmfish);



filtered_data = AllCytoplasmicFoci(AllCytoplasmicFoci ~= 0); % Remove zero values
histogram(filtered_data, 'BinWidth',25); % Increase bins for more frequent bars

% Median = median (data_sorted);
% Mean = mean(data_sorted)
axis([0 300 0 100]); % Sets X-axis from 0 to 100 and Y-axis from 0 to 50


%we extract the MS2 data here and combine one movie in a vector
[file, path] = uigetfile ('*.mat');
%make sure that is called T2
load(append(path, file));

T2mat = T2{:,:};

T2vector = T2mat(:);
cleanedT2vector = T2vector(~isnan(T2vector));
cleanedT2vector = cleanedT2vector(find(cleanedT2vector));

%generate a plot
% 
% x1 = min(VectorTASsmfish):1:max(VectorTASsmfish);
% y1 = 0:1:100000;
% x2 = min(cleanedT2vector):1:max(cleanedT2vector);
% y2 = x2.^2./x2.^3;

% 
% figure()
% t = tiledlayout(1,1);
% ax1 = axes(t);
% histogram(ax1,VectorTASsmfish)
% 
% figure()
% t = tiledlayout(1,1);
% ax2 = axes(t);
% histogram(ax2,cleanedT2vector)
% 
% ax1.XColor = 'r';
% ax1.YColor = 'r';
% hold on
% histogram(VectorTASsmfish)

% Define bin edges for smFISH and MS2 histograms
binEdges1 = linspace(min(VectorTASsmfish), max(VectorTASsmfish), 20);
binEdges2 = linspace(min(cleanedT2vector), max(cleanedT2vector), 20);

% Calculate histograms
[counts1, binCenters1] = hist(VectorTASsmfish, binEdges1);
[counts2, binCenters2] = hist(cleanedT2vector, binEdges2);

% Create a figure and axes
% Create a figure and axes


% Create a figure and axes
figure;
axes1 = axes;

% Plot the histograms
bar(axes1, binCenters1, counts1);
yyaxis right
bar(axes1, binCenters2, counts2);

% Set x-axis limits
set(axes1,'XLim',[min(binEdges1) max(binEdges1)]);

% Set y-axis limits for each axes separately
set(axes1,'YLim',[0 max(counts2)]);


set(axes2,'YLim',[0 max(counts1)]);

% Label the axes
xlabel(axes1,'Data 1');
ylabel(axes1,'Count (Data 1)');
ylabel(axes2,'Count (Data 2)');
