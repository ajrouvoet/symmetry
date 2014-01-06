heur = csvread('activity_heur_fpga10_11_uns_rcr.csv');
spopt = csvread('activity_spopt_fpga10_11_uns_rcr.csv');


avgheur = average_samples(heur, 5);
avgspopt = average_samples(spopt, 5);

% heurspace = linspace(0,100, length(heur));
% spoptspace = linspace(0,100, length(spopt));

plot([1:length(avgheur)], avgheur, [1:length(avgspopt)], avgspopt)

ylabel('Average number of active symmetries')
xlabel('Number of decisions, grouped per 5 samples')
legend('SA-APPROX', 'SP^{opt}')
title('Comparison of active symmetries')
xlim([0 length(avgheur)])