clc;
clear;

% Define normalizing function
normalize = @(v) (v-mean(v))/std(v);
% --------------------------------- %

% Num of iterations
k = 500;
% Load data
data = csvread('data.csv', 1, 0);
x1 = data(:, 1);
x2 = data(:, 2);
y = data(:, 3);
% Initialize variables
x = [ones(349,1) normalize(x1) normalize(x2)];
[m, n] = size(x);
w = [randn(1, n); zeros(k-1, n)];
h = zeros(m, 1);
cost = zeros(k, 1);
% Learning rate (alpha)
lr = 0.01;
% Start learning
for iter = 1:k
    % Update hypothesis
     h = x*w(iter,:)';
    % Update cost
    cost(iter) =(1/2*m)*((h-y)'*(h-y));
    % Update weights (Batch GD)
    gradient = zeros(1, n);
    for i = 1:m
        for j = 1:n
            gradient(j) = gradient(j) + lr*(1/m)*(h(i)-y(i))*x(i,j);
        end
    end
    for j = 1:n
        w(iter, j) = w(iter, j) - gradient(j);
    end
    w(iter+1,:) = w(iter,:);
end
% J vs k
figure(1)
plot(cost);
