function solve_sys_linear_eqns

len = 2^14; % 16384

% A:   2 GB
% b: 128 KB

A = rand(len);
b = rand(len,1);
tic
x = A\b;
t = toc;
fprintf('Single run : %0.2f\n',t)

cpu = @()(A\b);
t = timeit(cpu);
fprintf('Average run: %0.2f\n',t)

gpuDevice
gA = gpuArray.rand(len);
gb = gpuArray.rand(len,1);
tic
gx = gA\gb;
t = toc;
fprintf('Single run : %0.2f\n',t)

gpu = @()(gA\gb);
t = gputimeit(gpu);
fprintf('Average run: %0.2f\n',t)
