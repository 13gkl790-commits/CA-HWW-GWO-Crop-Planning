function Plot = loadPlots()

for j = 1:10

    Plot(j).Area = 100;

end

WaterFactor = ...
    [1.20 1.15 1.10 1.00 1.00 ...
     0.90 0.90 0.85 0.80 0.75];

for j = 1:10

    Plot(j).WaterFactor = ...
        WaterFactor(j);

end

end