function [BestSol,BestCost,Convergence] = ...
    CA_HWW_GWO(Crop,Constraints,Weather,Plot)

%% Parameters

nPop  = 30;
MaxIt = 200;
nVar  = 30;

lambdaMax = 0.5;
lambdaMin = 0.01;

%% Initialize Population

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

    Pop(i).Lambda = lambdaMax;

end

%% Initial Sorting

[~,Order] = sort([Pop.Cost],'descend');

Pop = Pop(Order);

Alpha = Pop(1);
Beta  = Pop(2);
Delta = Pop(3);

BestSol  = Alpha.Position;
BestCost = Alpha.Cost;

Convergence = zeros(MaxIt,1);

%% Initial Diversity

D0 = populationDiversity(Pop);

Dmax = D0;

%% Main Loop

for it = 1:MaxIt

    %% ---------------------------------
    % Adaptive Coefficient
    %% ---------------------------------

    D = populationDiversity(Pop);

    Dmax = max(Dmax,D);

    CA = D / (Dmax + eps);

    %% ---------------------------------
    % Update Alpha Beta Delta
    %% ---------------------------------

    [~,Order] = sort([Pop.Cost],'descend');

    Pop = Pop(Order);

    Alpha = Pop(1);
    Beta  = Pop(2);
    Delta = Pop(3);

    a = 2 - 2*(it/MaxIt);

    %% ---------------------------------
    % Population Update
    %% ---------------------------------

    for i = 1:nPop

        X = Pop(i).Position;

        %% ====================================
        % Adaptive Operator Selection
        %% ====================================

        if rand < CA

            %% --------------------------------
            % WWO Exploration
            %% --------------------------------

            Xnew = X + ...
                Pop(i).Lambda .* ...
                randn(1,nVar).*X;

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

            %% Lambda Update

            if CostNew > Pop(i).Cost

                Pop(i).Lambda = ...
                    max(lambdaMin,...
                    0.95*Pop(i).Lambda);

            else

                Pop(i).Lambda = ...
                    min(lambdaMax,...
                    1.05*Pop(i).Lambda);

            end

        else

            %% --------------------------------
            % GWO Exploitation
            %% --------------------------------

            r1 = rand(1,nVar);
            r2 = rand(1,nVar);

            A1 = 2*a*r1 - a;
            C1 = 2*r2;

            Dalpha = ...
                abs(C1.*Alpha.Position - X);

            X1 = ...
                Alpha.Position - A1.*Dalpha;

            r1 = rand(1,nVar);
            r2 = rand(1,nVar);

            A2 = 2*a*r1 - a;
            C2 = 2*r2;

            Dbeta = ...
                abs(C2.*Beta.Position - X);

            X2 = ...
                Beta.Position - A2.*Dbeta;

            r1 = rand(1,nVar);
            r2 = rand(1,nVar);

            A3 = 2*a*r1 - a;
            C3 = 2*r2;

            Ddelta = ...
                abs(C3.*Delta.Position - X);

            X3 = ...
                Delta.Position - A3.*Ddelta;

            Xnew = ...
                (X1 + X2 + X3)/3;

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

        end

        %% ---------------------------------
        % Greedy Selection
        %% ---------------------------------

        if CostNew > Pop(i).Cost

            Pop(i).Position = Xnew;
            Pop(i).Cost     = CostNew;

        end

    end

    %% ---------------------------------
    % Global Best
    %% ---------------------------------

    [~,Order] = sort([Pop.Cost],'descend');

    Pop = Pop(Order);

    if Pop(1).Cost > BestCost

        BestCost = Pop(1).Cost;
        BestSol  = Pop(1).Position;

    end

    Convergence(it) = BestCost;

    if mod(it,20)==0 || it==1

        fprintf( ...
        'Iter %3d  Profit = %.2f  CA = %.4f\n',...
        it,...
        BestCost,...
        CA);

    end

end

end