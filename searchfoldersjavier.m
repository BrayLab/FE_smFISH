%%% plotting puncta

nameofmolofinterest = 'MamHalo';
nameofloctag = "loctag ";
ChannelofInterest = 2;


path = uigetdir() %select folder with all the stages inside it


blue = [0 0.5 1];
red = [1 0.2 0.2];
green = [0.11 0.7 0.32];
orange = [1 0.58 0.01];
purple = [0.74 0.01 1];

listConditions = {'St 6'}; %include here the number for the stage 
listColor = cat(1, red, green, blue, orange); %include here the number for the stage 



for a = 1:(length(listConditions))

    namestage = listConditions{a};
    notchstatus = listConditions{a}

parentdirectory = dir(append(path, '/*', namestage, '*'));


PunctaROIMatrix = [];
BGROIMatrix = []; 
PixelSize = [];

disp(parentdirectory.name);

 MATDirectory = dir(append(parentdirectory.folder, "/", parentdirectory.name, '/*.mat'));
       
    MATDirectoryfullpath = []
    
    for u = 1:length(MATDirectory);
        
        MATDirectoryfullpath = [MATDirectoryfullpath, append(MATDirectory(u).folder, "/", MATDirectory(u).name)];
    
    end

    
    
    
    for n = 1:length(MATDirectoryfullpath);
       
        if isequal("PunctaROIMatrix", regexp(MATDirectoryfullpath{n},'PunctaROIMatrix', 'match'));  
            
            PunctaROI  = load(MATDirectoryfullpath{n});
            
            PunctaROIMatrix = [PunctaROIMatrix, PunctaROI];
            
            
        elseif  isequal("BGROIMatrix", regexp(MATDirectoryfullpath{n},'BGROIMatrix', 'match'));
            
            BGROI  = load(MATDirectoryfullpath{n});
            
            BGROIMatrix = [BGROIMatrix, BGROI];
            
    
        elseif  isequal("PhysicalSizePixel", regexp(MATDirectoryfullpath{n},'PhysicalSizePixel', 'match'));
            
            PixelSi  = load(MATDirectoryfullpath{n});
            
            PixelSize = [PixelSize, PixelSi]  ;
          
           
              
        else
        end
    end
         
      
end


PunctaROIforplot = [];

for y = 1:length(PunctaROIMatrix)
    
if isempty(PunctaROIforplot);
    
    PunctaROIforplot = PunctaROIMatrix(y).IntensityROI;
else
 
 PunctaROIforplot  = cat(4, PunctaROIforplot, PunctaROIMatrix(y).IntensityROI);
     
 end    
        
end

size(PunctaROIforplot)
    


BGROIforplot = [];

for q = 1:length(BGROIMatrix)
    
if isempty(BGROIforplot);
    
    BGROIforplot = BGROIMatrix(q).BGROI;
else
 
 BGROIforplot  = cat(4, BGROIforplot, BGROIMatrix(q).BGROI);
     
 end    
        
end

size(BGROIforplot)
    
  
PhysicalSizePixel = PixelSi.PhysicalSizePixel%%check that all of the values are the same
if ChannelofInterest == 1;
    OtherChannel = 2;
else 
    OtherChannel = 1;
    
end
    
molscale = 250;
loctagscale = 800;

    PunctaMeanChannel1 = mean(PunctaROIforplot(:,:,1,:), 4); %the second argument is for making average of the columns, the end is one vector (row)
    PunctaMeanChannel2 = mean(PunctaROIforplot(:,:,2,:), 4); %the second argument is for making average of the columns, the end is one vector (row)


    BGMeanChannel1 = mean(BGROIforplot(:,:,1,:), 4); %the second argument is for making average of the columns, the end is one vector (row)
    BGMeanChannel2 = mean(BGROIforplot(:,:,2,:), 4); %the second argument is for making average of the columns, the end is one vector (row)
            


     figure('Name', append(nameofmolofinterest, 'recruitment to the locustag'), 'Renderer', 'painters', 'Position', [10 10 900 500])           
     tl = tiledlayout(2, 3,'TileSpacing','Compact');

     nexttile
    hold on
    ylabel('Distance (um)');
    xlabel('Distance (um)');

        imagesc([PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel1, 1))],  [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel2, 2))], PunctaMeanChannel2);
        caxis([1, molscale]);
        colorbar;


     title(append(nameofmolofinterest, ' at locustag'));
         xlim([0, (PhysicalSizePixel * size(PunctaMeanChannel2, 1))])
         ylim([0, (PhysicalSizePixel * size(PunctaMeanChannel2, 2))])

     nexttile
     hold on
    ylabel('Distance (um)');
    xlabel('Distance (um)');

        imagesc([PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel2, 1))],  [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel1, 2))], PunctaMeanChannel1);
        caxis([1, loctagscale]);
        colorbar;

         xlim([0, (PhysicalSizePixel * size(PunctaMeanChannel1, 1))])
         ylim([0, (PhysicalSizePixel * size(PunctaMeanChannel1, 2))])

     title('Locustag signal');

      nexttile

      hold on
     ylabel('fluorescence (A.U.)');
    xlabel('Distance (um)');

     yprojpunctaChannel1 = permute(mean(PunctaROIforplot(:,:,1,:), 2), [1, 4, 2, 3]);
     SEMpunctaChannel1 = std(yprojpunctaChannel1, 0, 2, 'omitnan') ./ sqrt(size(yprojpunctaChannel1, 2));

    topcurve = (mean(yprojpunctaChannel1, 2, 'omitnan') + SEMpunctaChannel1).';
    lowercurve = (mean(yprojpunctaChannel1, 2, 'omitnan') - SEMpunctaChannel1).';
    spatialscale = [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel1, 1))];
    pline1 = plot(spatialscale,...
         mean(yprojpunctaChannel1, 2, 'omitnan'), '-','color',[0.74 0.01 1]);

    pfill1 = fill([spatialscale fliplr(spatialscale)], [topcurve fliplr(lowercurve)], ...
                  [0.74 0.01 1], 'linestyle', 'none', 'FaceAlpha', .3, 'DisplayName', 'SEMmol');
    xlim([0, (PhysicalSizePixel * size(PunctaMeanChannel2, 1))])         
    ylim([50,500])%max([molscale, loctagscale])])


     yprojpunctaChannel2 = permute(mean(PunctaROIforplot(:,:,2,:), 2), [1, 4, 2, 3]);
     SEMpunctaChannel2 = std(yprojpunctaChannel2, 0, 2, 'omitnan') ./ sqrt(size(yprojpunctaChannel2, 2));

    topcurve2 = (mean(yprojpunctaChannel2, 2, 'omitnan') + SEMpunctaChannel2).';
    lowercurve2 = (mean(yprojpunctaChannel2, 2, 'omitnan') - SEMpunctaChannel2).';
    spatialscale = [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(PunctaMeanChannel2, 1))];
    pline2 = plot(spatialscale,...
         mean(yprojpunctaChannel2, 2, 'omitnan'), '-','color',[0.11 0.7 0.32]);

    pfill2 = fill([spatialscale fliplr(spatialscale)], [topcurve2 fliplr(lowercurve2)], ...
                  [0.11 0.7 0.32], 'linestyle', 'none', 'FaceAlpha', .3, 'DisplayName', 'SEMmol');
     title('Profiles at the locustag');

     nexttile
     hold on
    ylabel('Distance (um)');
    xlabel('Distance (um)');

        imagesc([PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel2, 1))],  [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel1, 2))], BGMeanChannel2);
        caxis([1, molscale]);
        colorbar;
        
        xlim([0, (PhysicalSizePixel * size(BGMeanChannel2, 1))])
        ylim([0, (PhysicalSizePixel * size(BGMeanChannel2, 2))])

     title(append(nameofmolofinterest, ' at random nuclear location'));

     nexttile
     hold on
    ylabel('Distance (um)');
    xlabel('Distance (um)');

        imagesc([PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel2, 1))],  [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel1, 2))], BGMeanChannel1);
        caxis([1, loctagscale]);
        colorbar;
     title('Locustag signal at random nuclear location');
     
      xlim([0, (PhysicalSizePixel * size(BGMeanChannel1, 1))]);
      ylim([0, (PhysicalSizePixel * size(BGMeanChannel1, 2))]);


     nexttile

    hold on

    ylabel('Fluorescence (A.U.)');
    xlabel('Distance (um)');

     yprojBGChannel1 = permute(mean(BGROIforplot(:,:,1,:), 2), [1, 4, 2, 3]);
     SEMBGChannel1 = std(yprojBGChannel1, 0, 2, 'omitnan') ./ sqrt(size(yprojBGChannel1, 2));

    topcurve = (mean(yprojBGChannel1, 2, 'omitnan') + SEMBGChannel1).';
    lowercurve = (mean(yprojBGChannel1, 2, 'omitnan') - SEMBGChannel1).';
    spatialscale = [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel1, 1))];
    pline1 = plot(spatialscale,...
         mean(yprojBGChannel1, 2, 'omitnan'), '-','color',[0.74 0.01 1]);

    pfill1 = fill([spatialscale fliplr(spatialscale)], [topcurve fliplr(lowercurve)], ...
                  [0.74 0.01 1], 'linestyle', 'none', 'FaceAlpha', .3, 'DisplayName', 'SEMmol');


     yprojBGChannel2 = permute(mean(BGROIforplot(:,:,2,:), 2), [1, 4, 2, 3]);
     SEMBGChannel2 = std(yprojBGChannel2, 0, 2, 'omitnan') ./ sqrt(size(yprojBGChannel2, 2));

    topcurve2 = (mean(yprojBGChannel2, 2, 'omitnan') + SEMBGChannel2).';
    lowercurve2 = (mean(yprojBGChannel2, 2, 'omitnan') - SEMBGChannel2).';
    spatialscale = [PhysicalSizePixel:PhysicalSizePixel:(PhysicalSizePixel * size(BGMeanChannel2, 1))];
    pline2 = plot(spatialscale,...
         mean(yprojBGChannel2, 2, 'omitnan'), '-','color',[0.11 0.7 0.32]);

    pfill2 = fill([spatialscale fliplr(spatialscale)], [topcurve2 fliplr(lowercurve2)], ...
                  [0.11 0.7 0.32], 'linestyle', 'none', 'FaceAlpha', .3, 'DisplayName', 'SEMmol');
    
     title('Profiles at random nuclear location');
    
    xlim([0, (PhysicalSizePixel * size(BGMeanChannel1, 1))])
    ylim([50, 500])%max([molscale, loctagscale])])


orient(gcf,'landscape');
saveas(gcf, append(path,'/Puncta fluorescence st 5.2.pdf'));

%% Surface plot
figure('Position', [100, 100, 500, 1200])

s = surf(mean(PunctaMeanChannel2(:,:, :, :), 4));
title ('Mam intensity ');
ylabel('Distance (um)');
    xlabel('Distance (um)');
    colorbar;
    caxis([0, 650]);
    %colormap(flipud(gray));
     s.EdgeColor = 'none';

%%surface plot substracted BG     
     MEANBG= mean(BGMeanChannel2, [1,2]);
NormPunctaMeanChannel2 = (PunctaMeanChannel2 - MEANBG);
ZeroPunctaMeanChannel2 = [];

for t = 1:size(NormPunctaMeanChannel2,1);%or length()give the biggest dimmension
    for y = 1:size(NormPunctaMeanChannel2,2);
        if NormPunctaMeanChannel2(t,y) < 0;
         ZeroPunctaMeanChannel2(t,y) = 0;
        elseif NormPunctaMeanChannel2(t,y)>= 0;
        ZeroPunctaMeanChannel2(t,y) = NormPunctaMeanChannel2(t,y);
        else

        end
    end
end

 s = surf(mean(ZeroPunctaMeanChannel2(:,:, :, :), 4));
title ('Mam intensity ');
ylabel('Distance (um)');
    xlabel('Distance (um)');
    colorbar;
    caxis([-50, 250]);
    %colormap(flipud(gray));
     s.EdgeColor = 'none';
% 
%     s = surf(mean(NormPunctaMeanChannel2(:,:, :, :), 4));
% title ('Mam intensity ');
% ylabel('Distance (um)');
%     xlabel('Distance (um)');
%     colorbar;
%     caxis([0, 250]);
%     %colormap(flipud(gray));
%      s.EdgeColor = 'none';
