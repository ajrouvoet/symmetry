% Expects diff and speed matrices.
% Where diff is the average difference of activity
% And speed is the speedup.

sorted={}
for i=1:size(diff,2)
    sorted{i} = sortrows( [diff(:,i) speed(:,i)] );
end

Y= []
X =[]
for i=1:length(sorted)
    %semilogy(sorted{i}(:,1), sorted{i}(:,2))
    X = [ X sorted{i}(:,1)]
    Y = [ Y sorted{i}(:,2)]
end

% Calculate linear regression
sortedAll = sortrows([diff(:), speed(:)]);
% Remove NaNs
sortedAll2 = sortedAll(isfinite(sortedAll(:, 1)), :)
allDiff = sortedAll2(:,1);
allSpeed = sortedAll2(:,2);
p = polyfit(allDiff, allSpeed, 1)
f = polyval(p, allDiff);


plot(X, Y, '*', allDiff, f, '-')
hline(1)
legend('SP^{opt}', 'SA', 'SA-APPROX', 'Symmetry Count', 'Symmetry Usage', 'Location', 'southeast')
ylabel('Performance ratio')
xlabel('Average activity difference')
title('Performance ratio versus the relative symmetry activity')