function WSI = weatherSuitability(Crop,T,R)

%% Temperature spread

sigmaT = (Crop.Tmax - Crop.Tmin)/4;

%% Rainfall spread

sigmaR = (Crop.Rmax - Crop.Rmin)/4;

%% Temperature suitability

ST = max(0,...
    1 - abs(T-Crop.Topt)/(Crop.Tmax-Crop.Tmin));
%% Rainfall suitability

SR = max(0,...
    1 - abs(R-Crop.Ropt)/(Crop.Rmax-Crop.Rmin));
%% Combined Weather Suitability

WSI = 0.5*(ST+SR);
end