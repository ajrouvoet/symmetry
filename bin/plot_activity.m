function = plot_activity( heur, spopt )
	[avgheur, stdheur] = average_samples(heur, 400);
	[avgspopt, stdspopt] = average_samples(spopt, 400);

	% heurspace = linspace(0,100, length(heur));
	% spoptspace = linspace(0,100, length(spopt));
	hold all;
	errorbar([1:length(avgheur)], avgheur, stdheur);
	errorbar([1:length(avgspopt)], avgspopt, stdspopt);
	% plot([1:length(avgheur)], avgheur, [1:length(avgspopt)], avgspopt)

	ylabel('Average number of active symmetries')
	xlabel('Number of decisions, grouped per 400 samples')
	legend('SA-APPROX', 'SP^{opt}')
	title('Comparison of active symmetries')
	xlim([0 length(avgheur)])
end
