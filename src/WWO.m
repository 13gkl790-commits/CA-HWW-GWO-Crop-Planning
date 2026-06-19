function [BestSol,BestCost,Convergence] = ...
    WWO(Crop,Constraints,Weather,Plot)

%% Parameters

nPop  = 30;
MaxIt = 200;

nVar = 30;

%% Initialize

Pop = initializePopulation( ...
        nPop,...
        nVar,...
        Crop,...
        Constraints);

for i = 1:nPop

    Pop(i).Cost = ...
        objectiveFunction( ...
        Pop(i).Position,...
        Crop,...
        Constraints,...
        Weather,...
        Plot);

    Pop(i).Height = 5;

end

%% Best

[~,idx] = max([Pop.Cost]);

BestSol  = Pop(idx).Position;
BestCost = Pop(idx).Cost;

%% Convergence

Convergence = zeros(MaxIt,1);

%% Main Loop

for it = 1:MaxIt

    for i = 1:nPop

        %% ----------------------------
        % PROPAGATION
        %% ----------------------------

        X = Pop(i).Position;

        Step = ...
            randn(1,nVar).* ...
            (BestSol - X);

        Xnew = X + rand*Step;

        Xnew = max(Xnew,0);

        Xnew = repairSolution( ...
                Xnew,...
                Crop,...
                Constraints);

        CostNew = ...
            objectiveFunction( ...
            Xnew,...
            Crop,...
            Constraints,...
            Weather,...
            Plot);

        %% Improvement

        if CostNew > Pop(i).Cost

            Pop(i).Position = Xnew;
            Pop(i).Cost     = CostNew;

            Pop(i).Height = 5;

        else

            Pop(i).Height = ...
                Pop(i).Height - 1;

        end

        %% ----------------------------
        % REFRACTION
        %% ----------------------------

        if Pop(i).Height <= 0

            Xnew = ...
                (Pop(i).Position + ...
                 BestSol)/2;

            Xnew = repairSolution( ...
                    Xnew,...
                    Crop,...
                    Constraints);

            CostNew = ...
                objectiveFunction( ...
                Xnew,...
                Crop,...
                Constraints,...
                Weather,...
                Plot);

            Pop(i).Position = Xnew;
            Pop(i).Cost     = CostNew;

            Pop(i).Height = 5;

        end

    end

    %% Update Global Best

    [~,idx] = max([Pop.Cost]);

    if Pop(idx).Cost > BestCost

        BestCost = Pop(idx).Cost;
        BestSol  = Pop(idx).Position;

    end

    Convergence(it) = BestCost;

    fprintf( ...
      'Iteration %3d : %.2f\n',...
      it,BestCost);

end

end