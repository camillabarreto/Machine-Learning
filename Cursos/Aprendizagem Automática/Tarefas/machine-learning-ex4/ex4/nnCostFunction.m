function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% -------------------------------------------------------------
a1 = [ones(m,1),X];
z2 = a1*Theta1';
a2 = sigmoid(z2);
a2 = [ones(m,1),a2];
z3 = a2*Theta2';
h = sigmoid(z3);

for i = 1:m
  for k = 1:num_labels
    J = J + -(y(i)==k)*log(h(i,k))-(1-(y(i)==k))*log(1-h(i,k));
  end
end

t1 = Theta1(:,[2:size(Theta1,2)]).^2;
t2 = Theta2(:,[2:size(Theta2,2)]).^2;
s1 = sum(sum(t1));
s2 = sum(sum(t2));
reg = (lambda/(2*m))*(s1 + s2);
J = (J/m)+reg;
% =========================================================================

yk = 1:num_labels;
G1 = zeros(size(Theta1))';
G2 = zeros(size(Theta2))';
for t = 1:m
  %etapa 1 - já foi feita anteriormente para o calculo da funcao J
  %etapa 2
  ep3 = zeros(1,num_labels);
  for k = 1:num_labels
    ep3(k) = h(t,k)-(y(t)==yk)(k);
  end
  %etapa 3 
  ep2 = (ep3*Theta2);
  ep2 = ep2(:,2:end);
  ep2 = ep2.*sigmoidGradient(z2(t,:));
  %etapa 4
  G1 = G1 + a1(t,:)'*ep2;
  G2 = G2 + a2(t,:)'*ep3;

end
%etapa 5
G1 = ((1/m)*G1)';
G2 = ((1/m)*G2)';

%sG1 = size(G1)
%sTheta1 = size(Theta1)
%sG2 = size(G2)
%sTheta2 = size(Theta2)

REG1 = (lambda/m)*Theta1(:,2:end);
REG1 = [[zeros(size(REG1,1),1)],REG1];

REG2 = (lambda/m)*Theta2(:,2:end);
REG2 = [[zeros(size(REG2,1),1)],REG2];

%sREG1 = size(REG1)
%sREG2 = size(REG2)

Theta1_grad = G1 + REG1;
Theta2_grad = G2 + REG2;

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end