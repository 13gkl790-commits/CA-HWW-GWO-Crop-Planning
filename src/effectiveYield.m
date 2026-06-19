function Yeff = effectiveYield(Crop,WSI)

Yeff = Crop.yield * (0.8 + 0.2*WSI);

end