clc;
clear;

[Crop,Constraints,Weather,Plot] = ...
    loadData_V2();

[BestSol,BestCost] = ...
    CA_HWW_GWO_v3( ...
    Crop,...
    Constraints,...
    Weather,...
    Plot);

X = reshape(BestSol,3,10);

CropArea = sum(X,2);

fprintf('\n========================\n');
fprintf('BEST ALLOCATION\n');
fprintf('========================\n');

fprintf('Wheat   = %.2f ha\n',CropArea(1));
fprintf('Rice    = %.2f ha\n',CropArea(2));
fprintf('Mustard = %.2f ha\n',CropArea(3));

fprintf('\nProfit = %.2f INR\n',BestCost);

figure

pie(CropArea)

legend('Wheat','Rice','Mustard')