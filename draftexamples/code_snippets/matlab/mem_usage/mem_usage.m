
% Occupy memory until job crashes or until max memory size is reached...

clc, clear, close all;

% some size parameters
gb = 1024^3;
bpelement = 8;
elementpgb = gb / bpelement;

% prepare output file
fid = fopen('mem_usage.txt', 'w');

% increment array by 1 GB each iteration
maxsize = 5;  % max size in GB
for i = 1 : maxsize
    
    X(:,i) = ones(elementpgb,1);
    
    w_X = whos('X');
    size_bytes = w_X.bytes;
    size_gb = size_bytes / gb;
    fprintf('Memory used (GB) = %.2f\n', size_gb)
    fprintf(fid, 'Memory used (GB) = %.2f\n', size_gb);

end

fclose(fid);
