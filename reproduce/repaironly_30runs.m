clc;
clear;

[Crop,Constraints,Weather,Plot] = ...
    loadData_V2();

Profit = zeros(30,1);

for r = 1:30

    [~,Profit(r)] = ...
        RepairOnly( ...
        Crop,...
        Constraints,...
        Weather,...
        Plot);

    fprintf('Run %d : %.2f\n',r,Profit(r));

end

fprintf('\n');
fprintf('Mean Profit = %.2f\n',mean(Profit));
fprintf('Std Profit  = %.2f\n',std(Profit));