function x = repairSolution(x,Crop,Constraints)

maxIter = 500;

for iter = 1:maxIter

    [Violation,Details] = ...
        evaluateConstraints( ...
        x,...
        Crop,...
        Constraints);

    %% Already Feasible

    if Violation <= 1e-6
        break;
    end

    %% =========================================
    % Area Constraint
    %% =========================================

    if Details.AreaUsed > Constraints.AreaMax

        Scale = ...
            Constraints.AreaMax / ...
            Details.AreaUsed;

        x = x * Scale;

    end

    %% =========================================
    % Water Constraint
    %% =========================================

    if Details.WaterUsed > Constraints.WaterMax

        Scale = ...
            Constraints.WaterMax / ...
            Details.WaterUsed;

        x = x * Scale;

    end

    %% =========================================
    % Fertilizer Constraint
    %% =========================================

    if Details.FertUsed > Constraints.FertMax

        Scale = ...
            Constraints.FertMax / ...
            Details.FertUsed;

        x = x * Scale;

    end

    %% =========================================
    % Budget Constraint
    %% =========================================

    if Details.BudgetUsed > Constraints.BudgetMax

        Scale = ...
            Constraints.BudgetMax / ...
            Details.BudgetUsed;

        x = x * Scale;

    end

    %% =========================================
    % Crop Area Limit
    %% =========================================

    X = reshape(x,3,10);

    CropAreas = sum(X,2);

    MaxCropArea = ...
        0.7 * Constraints.AreaMax;

    for i = 1:3

        if CropAreas(i) > MaxCropArea

            Scale = ...
                MaxCropArea / ...
                CropAreas(i);

            X(i,:) = ...
                X(i,:) * Scale;

        end

    end

    x = X(:)';

end

end