function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

h = X*theta;
error = (h-y);

j = sum(error.^2);
reg1 = lambda*sum(theta(2:end,:).^2);
J = (j + reg1)/(2*m);

reg2 = [zeros(1,size(theta,2));lambda*theta(2:end,:)];
for j = 1:size(theta,1)
  grad(j) = sum(error.*X(:,j)) + reg2(j,:);
end
grad = grad/m;

% =========================================================================

grad = grad(:);

end
