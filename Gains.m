function Gain_Means_perPhase = Gains(fitties)
% Gains

Gain_Means_perPhase = zeros(2,numel(fitties{1,1}));
for j = 1:numel(fitties{1,1})
    if isempty(fitties{1,1}{1,j})
        Gain_Means_perPhase(:,j) = 0;
    else
        Gain_Means_perPhase(:,j) = mean(fitties{1,1}{1,j},1)';
    end
    
end
end