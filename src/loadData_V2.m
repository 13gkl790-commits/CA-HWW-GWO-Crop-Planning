function [Crop,Constraints,Weather,Plot] = loadData_V2()

%% =========================================================
% Crop Data
%% =========================================================

Crop(1).name  = 'Wheat';
Crop(1).yield = 4.77;
Crop(1).price = 25850;
Crop(1).cost  = 55000;
Crop(1).water = 4500;
Crop(1).fert  = 247;

Crop(1).Topt = 22;
Crop(1).Tmin = 10;
Crop(1).Tmax = 30;

Crop(1).Ropt = 625;
Crop(1).Rmin = 500;
Crop(1).Rmax = 750;

% ----------------------------------------------------------

Crop(2).name  = 'Rice';
Crop(2).yield = 3.39;
Crop(2).price = 23200;
Crop(2).cost  = 65000;
Crop(2).water = 12000;
Crop(2).fert  = 267;

Crop(2).Topt = 30;
Crop(2).Tmin = 10;
Crop(2).Tmax = 38;

Crop(2).Ropt = 1200;
Crop(2).Rmin = 1000;
Crop(2).Rmax = 1500;

% ----------------------------------------------------------

Crop(3).name  = 'Mustard';
Crop(3).yield = 2.00;
Crop(3).price = 62000;
Crop(3).cost  = 45000;
Crop(3).water = 2500;
Crop(3).fert  = 138;

Crop(3).Topt = 22;
Crop(3).Tmin = 10;
Crop(3).Tmax = 30;

Crop(3).Ropt = 350;
Crop(3).Rmin = 250;
Crop(3).Rmax = 450;

%% =========================================================
% Constraints
%% =========================================================

Constraints.AreaMax   = 1000;      % ha
Constraints.WaterMax  = 6.5e6;     % m3
Constraints.FertMax   = 180000;    % kg
Constraints.BudgetMax = 5e7;       % INR

%% =========================================================
% Weather Data
%% =========================================================

Weather.T = 24;

Weather.Rainfall = 700;

Weather.Irrigation = 500;

Weather.R = ...
    Weather.Rainfall + ...
    Weather.Irrigation;

Plot = loadPlots();
end