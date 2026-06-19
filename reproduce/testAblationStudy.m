clc;
clear;

RepairOnly = 3472390.09;

WWO = 59336378.73;

GWO = 59599260.10;

Hybrid = 59946094.42;

fprintf('\n========================\n');
fprintf('ABLATION STUDY\n');
fprintf('========================\n');

fprintf('Repair Only     : %.2f\n',RepairOnly);
fprintf('WWO             : %.2f\n',WWO);
fprintf('GWO             : %.2f\n',GWO);
fprintf('CA-HWW-GWO      : %.2f\n',Hybrid);

figure

bar([RepairOnly WWO GWO Hybrid])

set(gca,...
    'XTickLabel',...
    {'Repair','WWO','GWO','Hybrid'})

ylabel('Mean Profit (INR)')

title('Ablation Study')

grid on