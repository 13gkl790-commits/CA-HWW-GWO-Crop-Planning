function [Violation,Details] = ...
    evaluateConstraints(x,Crop,Constraints)

%% Convert Decision Vector

X = reshape(x,3,10);

%% =====================================================
% Total Area
%% =====================================================

AreaUsed = sum(X(:));

%% =====================================================
% Water Usage
%% =====================================================

WaterUsed = 0;

for j = 1:10

    for i = 1:3

        WaterUsed = ...
            WaterUsed + ...
            X(i,j)*Crop(i).water;

    end

end

%% =====================================================
% Fertilizer Usage
%% =====================================================

FertUsed = 0;

for j = 1:10

    for i = 1:3

        FertUsed = ...
            FertUsed + ...
            X(i,j)*Crop(i).fert;

    end

end

%% =====================================================
% Budget Usage
%% =====================================================

BudgetUsed = 0;

for j = 1:10

    for i = 1:3

        BudgetUsed = ...
            BudgetUsed + ...
            X(i,j)*Crop(i).cost;

    end

end

%% =====================================================
% Crop-wise Area
%% =====================================================

CropAreas = sum(X,2);

%% =====================================================
% Constraint Violations
%% =====================================================

AreaViolation = ...
    max(0,...
    AreaUsed - Constraints.AreaMax);

WaterViolation = ...
    max(0,...
    WaterUsed - Constraints.WaterMax);

FertViolation = ...
    max(0,...
    FertUsed - Constraints.FertMax);

BudgetViolation = ...
    max(0,...
    BudgetUsed - Constraints.BudgetMax);

%% No Crop > 70% of Total Area

CropLimitViolation = ...
    sum(max(0,...
    CropAreas - ...
    0.7*Constraints.AreaMax));

%% =====================================================
% Total Violation
%% =====================================================

Violation = ...
    AreaViolation + ...
    WaterViolation + ...
    FertViolation + ...
    BudgetViolation + ...
    CropLimitViolation;

%% =====================================================
% Details Structure
%% =====================================================

Details.AreaUsed = AreaUsed;
Details.WaterUsed = WaterUsed;
Details.FertUsed = FertUsed;
Details.BudgetUsed = BudgetUsed;

Details.WheatArea   = CropAreas(1);
Details.RiceArea    = CropAreas(2);
Details.MustardArea = CropAreas(3);

Details.CropLimitViolation = ...
    CropLimitViolation;

end