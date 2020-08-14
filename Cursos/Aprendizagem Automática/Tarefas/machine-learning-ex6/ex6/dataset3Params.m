function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 30;
sigma = 30;
values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

x1 = X(:,1);
x2 = X(:,2);
prediction = zeros(size(y,1),64);
choice = zeros(64,2);
i = 1;
for C = values
  for sigma = values
    model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions(:,i) = svmPredict(model, Xval);
    choice(i,1) = C;
    choice(i,2) = sigma;
    i = i + 1;
  end
end

m = mean(double(predictions ~= yval));
[mm,mi] = min(m);

C = choice(mi,1)
sigma = choice(mi,2)

% =========================================================================

end