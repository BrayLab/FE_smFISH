function processIntensityData(files, intensityArray)
    for s = 1:size(files, 2)
        % Read the table
        TableAdd = readtable(files{1, s});
        
        % Extract the 7th column (intensity data)
        IntDen = TableAdd{:, 7};
        
        % Debugging step: Display the intensity data for each iteration
        disp(IntDen);
        
        % Append the new data
        intensityArray = [intensityArray; IntDen];
    end
end