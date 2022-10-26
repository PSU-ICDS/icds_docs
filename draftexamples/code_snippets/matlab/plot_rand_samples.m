
% Plots user-specified number of random samples

init_prompt = 'How many random samples?  ';
n = input(init_prompt);

x = [1:n];
y = rand(1,n);

plot(x,y);
title([num2str(n), ' Random Samples'])
xlabel('Samples')
ylabel('Random Sample Value')
