clc;
clear;

x = [0 0 1 1; 0 1 0 1];
y = [0 1 1 1];
w = [0 0];
b = 0;
alpha = 0.1;
theta = 0.5;
iter = 50;
for k = 1:iter
    for i=1:size(x,2)
        a(i) = b + x(1,i)*w(1) + x(2,i)*w(2);
        h(i) = (a(i) >= theta);
        if (h(i) ~= y(i))
            for j=1:2
                w(j) = w(j) + (alpha*y(i)*x(j,i));
            end
            b = b + (alpha*y(i));
        end
    end
    e(k) = sum((y-h).^2);
end
plot(e)
xlabel('Iterations')
ylabel('Cost')