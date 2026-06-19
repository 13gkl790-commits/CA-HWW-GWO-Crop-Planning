clc;
clear;

GWO = readtable('GWOResults.xlsx');
HYB = readtable('HybridResults.xlsx');

GWOResults = GWO.Profit;
HybridResults = HYB.Profit;

[h,p] = ttest2(GWOResults,HybridResults);

fprintf('\n=====================\n');
fprintf('t-test p-value = %.10f\n',p);

[pw,~,stats] = ranksum(...
    GWOResults,...
    HybridResults);

fprintf('Wilcoxon p-value = %.10f\n',pw);