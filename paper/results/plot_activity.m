heur = csvread('activity_heur_fpga10_11_uns_rcr.csv');
spopt = csvread('activity_spopt_fpga10_11_uns_rcr.csv');

heurspace = linspace(0,100, length(heur));
spoptspace = linspace(0,100, length(spopt));

plot(heurspace, heur, spoptspace, spopt)
ylabel('Number of active symmetries')
xlabel('Solving progress (%)')
legend('heuristic', 'SP^{opt}')