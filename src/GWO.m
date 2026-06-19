function [BestSol,BestCost,Convergence] = ...
    GWO(Crop,Constraints,Weather,Plot)
%% Parameters

nPop = 30;
MaxIt = 200;
nVar = 30;
%% Initialize Population

Pop = initializePopulation( ...
        nPop,...
        nVar,...
        Crop,...
        Constraints);

%% Evaluate Population

for i = 1:nPop

    Pop(i).Cost = ...
    objectiveFunction( ...
    Pop(i).Position,...
    Crop,...
    Constraints,...
    Weather,...
    Plot);

end

%% Sort

[~,Order] = sort([Pop.Cost],'descend');

Pop = Pop(Order);

Alpha = Pop(1);
Beta  = Pop(2);
Delta = Pop(3);

%% Convergence

Convergence = zeros(MaxIt,1);

%% Main Loop

for it = 1:MaxIt

    a = 2 - 2*(it/MaxIt);

    for i = 1:nPop

        X = Pop(i).Position;

        %% Alpha

        r1 = rand(1,nVar);
        r2 = rand(1,nVar);

        A1 = 2*a*r1 - a;
        C1 = 2*r2;

        D_alpha = abs(C1.*Alpha.Position - X);

        X1 = Alpha.Position - A1.*D_alpha;

        %% Beta

        r1 = rand(1,nVar);
        r2 = rand(1,nVar);

        A2 = 2*a*r1 - a;
        C2 = 2*r2;

        D_beta = abs(C2.*Beta.Position - X);

        X2 = Beta.Position - A2.*D_beta;

        %% Delta

        r1 = rand(1,nVar);
        r2 = rand(1,nVar);

        A3 = 2*a*r1 - a;
        C3 = 2*r2;

        D_delta = abs(C3.*Delta.Position - X);

        X3 = Delta.Position - A3.*D_delta;

        %% Update

        Xnew = (X1 + X2 + X3)/3;

        %% Remove Negatives

        Xnew = max(Xnew,0);

        %% Repair

        Xnew = repairSolution( ...
                Xnew,...
                Crop,...
                Constraints);

        %% Evaluate

        CostNew = ...
    objectiveFunction( ...
    Xnew,...
    Crop,...
    Constraints,...
    Weather,...
    Plot);

        %% Greedy Selection

        if CostNew > Pop(i).Cost

            Pop(i).Position = Xnew;
            Pop(i).Cost = CostNew;

        end

    end

    %% Sort Again

    [~,Order] = sort([Pop.Cost],'descend');

    Pop = Pop(Order);

    Alpha = Pop(1);
    Beta  = Pop(2);
    Delta = Pop(3);

    BestCost = Alpha.Cost;

    Convergence(it) = BestCost;

    fprintf('Iteration %3d : %.2f\n', ...
            it,BestCost);

end

BestSol = Alpha.Position;

end