function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

add = find(y==1);   % encontra linhas que possuem elementos 1 
                    % retorna os indices verdadeiros
nadd = find(y==0);  % encontra linhas que possuem elementos 0 
                    % retorna os indices verdadeiros

plot(X(add,1), X(add,2), 'k+', 'LineWidth', 2, 'MarkerSize', 7);
plot(X(nadd,1), X(nadd,2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

% =========================================================================



hold off;

end
