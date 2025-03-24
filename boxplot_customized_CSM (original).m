%Nicknames = {Table.Properties.VariableNames{:}};
%Palette = parula(length(Nicknames)./1);%after./ write the number of columns you want with same colour %should decide length and how many colours are you using
%Palette = kron(Palette,ones(1,1)); %(number of times you want same color to be repeated, 1) 
Title = 'Active Nuclei Proportion'

Nicknames = {'Hnt';'m7';'Hnt';'m7';'Hnt';'m7'};%change to no. of columns
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
MyColorMap = [darkorange;orange]%change to no. of columns!!
%hold on

% SelectedNames = {'St5 SuH', ' St5 H', 'St6 SuH', 'St6 H', 'St7 SuH', 'St7 H', 'St8 SuH', 'St8 H', 'St9 SuH', 'St9 H', 'St10 SuH', 'St10 H'}; %needs to be same length as number of coilumns
% SelectedNames = repmat(SelectedNames, [1, 3])
ExpLabels = {'Hnt';'m7';'Hnt';'m7';'Hnt';'m7'} % same as numebr of columns!!
%ExpLabels = repmat(ExpLabels, [1, 3]) %To group labels in categories o
%[1,Xcolumns]%
All = ResultMatrix;
% matrix always needs experiment as column, rows for individual values,
% empty rows filled with NaNs

            
Jitter = 0.2; %Jitter./2 cant be > BarW 
BarW = 0.3; % barwidth for boxplot
FaceAlpha = 0.3; %transparency of box in boxplot
DotSize =  10; 
CMAP = MyColorMap%Palette orMyColorMap if you want to introduce color manually
LineWidth = 2; 
FontSizeTitle = 16; 
FontSize = 12;
Ylim = ([0,81])
set(gca,'FontSize',FontSize)

Fig1 = figure('PaperSize',[40,50],'PaperUnits','inches','resize','on', 'visible','on');
set(0,'defaultAxesColorOrder',CMAP)
%set(0,'defaultLegendAutoUpdate','on')
Fig1.Position (3:4)= [300, 425];

plotBoxplotMATLABlike_v2(All,Nicknames,ExpLabels,Jitter,BarW,Title,FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,Ylim)
%hold on
%xline([2.5:2:8],'--')%draw a vertical line in the different values selected
%Xs = repmat([1:1:6],1,1)
%Ys = repmat([0,0.3],6,1)
%plot(Xs,Ys','--','Color',[0.3,0.3,0.3])
xlabel('Target Gene')
ylabel('Active Nuclei (%)')
%ylim([0,10]);
%xlim([0,12]);
%xticks([1:1:9])

%print(Fig1,'//Volumes/Carmina/Postdoc Science/Experiments/m7-MS2_hsp83MCPGFP_hisRFP/Active nuclei proportion ALL.pdf','-fillpage', '-dpdf');

