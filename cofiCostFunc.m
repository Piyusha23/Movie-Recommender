function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

error = 0.5*(X*Theta'-Y).^2;
J = sum(error(R==1))+(lambda/2)*sum(sum(Theta.^2))+(lambda/2)*(sum(sum(X.^2)));

grad = X*Theta'-Y;
err = grad.*R;

X_grad = err*Theta + lambda*X;

Theta_grad = err'*X + lambda*Theta;








% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
