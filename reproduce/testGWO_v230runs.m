clc;
clear;

[Crop,Constraints,Weather,Plot] = loadData_V2();

Runs = 30;

Results = zeros(Runs,1);

for r = 1:Runs

    rng(r);

    [~,BestCost,~] = ...
        GWO( ...
        Crop,...
        Constraints,...
        Weather,...
        Plot);

    Results(r) = BestCost;

    fprintf('Run %2d : %.2f\n', ...
            r,BestCost);

end

fprintf('\n========================\n');
fprintf('Mean Profit : %.2f\n',mean(Results));
fprintf('Std Profit  : %.2f\n',std(Results));
fprintf('Min Profit  : %.2f\n',min(Results));
fprintf('Max Profit  : %.2f\n',max(Results));