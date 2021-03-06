clc;
clear;

% Standardizing function
normalize = @(v) (v-mean(v))/std(v);
% ---------------------------- %

% Load data
raw = csvread('data3.csv', 1, 0);
x1 = raw(:, 1);
x2 = raw(:, 2);
x3 = raw(:, 3);
x4 = raw(:, 4);
y = raw(:, 5);
% Prepare data (60:40 hold-out)
data = [ones(100,1) normalize(x1) normalize(x2) normalize(x3) normalize(x4) y];
shuffled = data(randperm(size(data,1)),:);
x = shuffled(:,end-1);
y = shuffled(:,end);
x_train = x(1:60,:);
x_test = x(61:100,:);
y_train = y(1:60,:);
y_test = y(61:100,:);
[m, n] = size(x_train);
% Initialize variables
w = rand(1, n);
h = zeros(m, 1);
% Number of iterations
k = 100;
% Learning rate (alpha)
lr = 0.01;
% Start training
for iter = 1:k
    % Update hypothesis
    for i = 1:m
        h(i) = (1 + exp(-(x_train(i,:)*w')));
    end
    % Update cost
    for i = 1:m
        cost = (y_train(i)*log(h(i)) + (1-y_train(i))*log(1-h(i)));
    end
    % Update weights
    for j = 1:n
        gradient = 0;
        for i = 1:m
            gradient = gradient + (y_train(i)*(1-h(i))+(1-y_train(i))'*h(i))*x_train((i),j);
        end
        w(j) = w(j) - lr*gradient;
    end
end
% Make predictions
y_pred = zeros(size(y_test));
for i = 1:size(y_pred,1)
    y_pred(i) = 1/(1 + exp(-(x_test(i,:)*w')));
    if y_pred(i) > 0.5
        y_pred(i) = 2;
    else
        y_pred(i) = 1;
    end
end
% Create confusion matrix
result = [y_test y_pred];
tp = 0;
tn = 0;
fp = 0;
fn = 0;
for i = 1:40
    if y_pred(i)-y_test(i) == 0
        if y_test(i) == 1
            tp = tp + 1;
        else
            tn = tn + 1;
        end
    else
        if y_pred(i)-y_test(i) == 1
            fp = fp + 1;
        else
            fn = fn + 1;
        end
    end
end
% Calculate stats
se = tp/(tp+fn);
sp = tn/(tn+fp);
acc = (tp+tn)/(tp+tn+fp+fn);
disp([tp fn;fp tn]);
disp(['Sensitivity: ', num2str(se)]);
disp(['Specificity: ', num2str(sp)]);
disp(['Accuracy: ', num2str(acc)]);
