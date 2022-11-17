
clc, clear

diary on

for i = 1 : 10
    fprintf('Count = %d\n', i);
    pause(1);
end

diary diaryoutput

diary off
