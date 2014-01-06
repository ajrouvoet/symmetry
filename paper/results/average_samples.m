function  [y, y_std] = average_samples( x, samples )
%AVERAGE_SAMPLES Summary of this function goes here
%   Detailed explanation goes here
    
    xtrim = x(1:end-(mod(length(x), samples))); % trim surplus samples
    xx = reshape(xtrim,samples,[]);
    yy = sum(xx,1)./size(xx,1);
    y = reshape(repmat( yy, size(yy,1),1),1,[]);
    y_std = std(xx);

end

