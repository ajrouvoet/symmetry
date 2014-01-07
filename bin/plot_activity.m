function [ heur, spopt ] = plot_activity( heur, spopt )
    heur = csvread( heur );
    spopt = csvread( spopt );
	[avgheur, stdheur] = average_samples(heur, 50);
	[avgspopt, stdspopt] = average_samples(spopt, 50);

	% heurspace = linspace(0,100, length(heur));
	% spoptspace = linspace(0,100, length(spopt));
	hold all;
	errorbar([1:length(avgheur)], avgheur, stdheur);
	errorbar([1:length(avgspopt)], avgspopt, stdspopt);
    plot([1:length(avgheur)], avgheur, 'b', 'LineWidth', 2);
	plot([1:length(avgspopt)], avgspopt, 'g', 'LineWidth', 2);

	ylabel('Average number of active symmetries')
	xlabel('Number of decisions, grouped per 400 samples')
	legend('SA-APPROX', 'SP^{opt}')
	title('Comparison of active symmetries')
	xlim([0 length(avgheur)])
end