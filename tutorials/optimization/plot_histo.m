function [N,Nplot,centers] = plot_histo(hdat,edges,itype)
%PLOT_HISTO plot a histogram with cyan bars and black boundaries

if nargin==2, itype=2; end

dbin = edges(2) - edges(1);
Ntotal = length(hdat);
[N,bin] = histc(hdat,edges);
switch itype
    case 1, Nplot = N; xlab = 'Count';
    case 2, Nplot = N/Ntotal; xlab = 'Fraction';
    case 3, Nplot = N/Ntotal/dbin; xlab = 'PDF';
end
bar(edges,Nplot,'histc');
xlim([min(edges) max(edges)]);
ylabel(sprintf('%s (N=%i)',xlab,Ntotal));

h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 1 1],'EdgeColor','k');

if length(hdat) ~= sum(N)
   disp(sprintf('NOTE (plot_histo.m): You may want to extend the edges --'));
   disp(sprintf(' there are %i/%i input that are outside the specified range',...
       length(hdat)-sum(N),length(hdat)));
   %disp(sprintf(' the number of input (%i) does not equal the sum of bin counts (%i).',length(hdat),sum(N)));
end

centers = edges + dbin/2;
centers(end) = [];
% the last bin of N (and Nplot) will count any values that match EDGES(end)
% (see histc), so we cut them
N(end) = [];
Nplot(end) = [];
