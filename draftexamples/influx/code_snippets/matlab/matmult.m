
% Matrix multiply the old-school way vs. Matlab's way

clc, clear, close all

% set matrix sizes
m1 = 1000;
n1 = 1200;
m2 = n1;    % middle dimensions must agree
n2 = 1000;

% create random matrices and result matrix
M1 = rand(m1,n1);
M2 = rand(m2,n2);
R = zeros(m1,n2);

% perform strict old-school matrix multiplication
tic
for i = 1 : m1
    for j = 1 : n2
        for k = 1 : n1
            
            R(i,j) = R(i,j) + M1(i,k) * M2(k,j);

        end
    end
end
t = toc;


% perform Matlab matrix multiplication
tic
Rm = M1 * M2;
tm = toc;

% check if results agree
checksum = ( sum(R(:)) - sum(Rm(:)) ) / numel(R);
if ( checksum < 10e-10 )
    fprintf('Results agree.\n');
else
    fprintf('Results do not agree!\n')
end

% print times
fprintf('Old-school multiply: %f sec\n', t )
fprintf('Matlab multiply:     %f sec\n', tm )
