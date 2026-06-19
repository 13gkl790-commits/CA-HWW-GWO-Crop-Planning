function Pop = initializePopulation( ...
                    nPop,...
                    nVar,...
                    Crop,...
                    Constraints)

Pop = struct();

for i = 1:nPop

    %% -------------------------------------
    % Random Allocation
    %% -------------------------------------

    x = rand(1,nVar) * 150;

    %% -------------------------------------
    % Repair to Feasible Region
    %% -------------------------------------

    x = repairSolution( ...
            x,...
            Crop,...
            Constraints);

    %% -------------------------------------
    % Store
    %% -------------------------------------

    Pop(i).Position = x;

    Pop(i).Cost = [];

end

end