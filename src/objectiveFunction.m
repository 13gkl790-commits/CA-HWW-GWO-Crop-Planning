function Profit = objectiveFunction(x,Crop,Constraints,Weather,Plot)
X = reshape(x,3,10);
lambda = 50000;

Profit = 0;

for j = 1:10

    EffectiveRain = ...
        Weather.R * Plot(j).WaterFactor;

    for i = 1:3

        Area = X(i,j);

        WSI = weatherSuitability( ...
            Crop(i), ...
            Weather.T, ...
            EffectiveRain);

        Yeff = effectiveYield( ...
            Crop(i), ...
            WSI);

        Revenue = ...
            Area * ...
            Yeff * ...
            Crop(i).price * ...
            (1 - 0.0002*Area);

        Cost = ...
            Area * Crop(i).cost;

        Profit = ...
            Profit + ...
            (Revenue - Cost);

    end

end
Penalty = 0;

for j = 1:10

    for i = 1:3

        Penalty = Penalty + ...
            (X(i,j)*Crop(i).water / ...
            Constraints.WaterMax)^2;

    end

end
Profit = Profit - lambda*Penalty;

end