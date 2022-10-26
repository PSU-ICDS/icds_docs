% -----------------------------------------------------------------
% This is a code to test the Simulated Annealing method
%
% We are trying to minimize some function L( theta ), where theta is a
% vector we are trying to find.   
% Here we are just trying to solve a system of linear equations:
%      A x = B
% or we are trying to minimize:
%       A x - B
% our x here is like theta above.   And L = A x - B
%
% My ultimate goal is to apply this to neural networks, this is just
% a code to illustrate the approach.
%
% This is an attractive approach since it only involves two parameters
% (alpha and temp), but you also need to decide at what rate to reduce
% temp.
%
% While Gauss-Seidel works very well for a system of equations,
% and the final error is very small, we do not need this sort of 
% accuracy for neural networks!  This is just a simple code to illustrate
% SA.
%
%         L.N.Long, Nov. 3, 2016
%----------------------------------------------------------------
clear all    % variables
close all    % figure windows

format long;

iMax = 5;      % size of matrix is iMax x iMax
nMax = 10000;   % number of iterations

% These are the two parameters ued by Simulated Annealing, and
% two parameters for reducing TEMP:

alpha = 0.01;           % magnitude of perturbation of solution
temp = 10000;           % "temperature" term
tempReduceRate = 0.3;   % when TEMP is reduced, use this factor
tempReducePeriod = 50;  % this is how often TEMP will be reduced


error = zeros(nMax,1);

doPrint=1;   % if this is 1, then you will see more plots

min_num=1000000;
min_err= 1;


% create system of equations to solve

A = 2*rand(iMax,iMax) - 1;   % off-diagonal terms range from randomly -1 to 1

diagTerm = 100.0 * iMax;   % diagonal terms are 100*iMax

for i=1:iMax
    A(i,i) = diagTerm  +  4 * A(i,i);   % Make A diagonally dominant
end

B = diagTerm * ones(iMax,1)  +  (4*rand(iMax,1) -2)   ;

xExact = A\B;    % find exact solution


if iMax<6
    A
    B
    xExact
end







tic

%xNum = inv( diag(diag(A) )) * B;    % initial guess, this is a really good
                                     % guess for a diag. dominat A
xNum = 2*rand(iMax,1) - 1;    % random initial guess

maxError = 10.0 * max( abs( xNum - xExact));


error(1) = sqrt( sum( ( A * xNum - B ).^2 ) / iMax );


for   n=2:nMax      %  iterations
    
    perturb = alpha * ( 2*rand(iMax,1) - 1);  % perturb soln using ALPHA as coefficient (-alpha to alpha)
    
    xNumNew = xNum + perturb;  % create a pertured soln vector
    
    error(n) = sqrt( sum( ( A * xNumNew - B ).^2 ) / iMax );

    if  error(n) < error(n-1)             
        xNum = xNumNew;              % if error was reduced, use the new value of X
    else
        myRan = rand(1,1);
        test  = exp( -(error(n)-error(n-1)) /  temp ); % apply simulated annealing here using TEMPerature
        if myRan < test
           xNum = xNumNew;    % if myRan < test, use the new value of X
        else
            error(n) = error(n-1);  % if myRan > test, DO NOT use the new value of X, and use previous error
        end
    end
    
    if ( mod(n,100) == 0 &  doPrint==1)
        figure(1)
        plot(1:iMax, (xExact - xNum))
        axis([ 0 iMax+1  -maxError maxError])
        xlabel('Index Number of Vector')
        ylabel('Error')
        title('Error')
        pause(0.01)
        
        figure(2)
        plot(1:iMax, xExact, '-', 1:iMax, xNum, 'o')
        axis([ 0 iMax  0.8 1.2])
        xlabel('Index Number of Vector')
        ylabel('xExact or xNumerical ')
        title('Exact and Numerical Solutions')
        legend( 'Exact Soln', 'Numerical Soln')
        pause(0.01)
    end
    
    if mod(n, tempReducePeriod) == 0 
       temp = tempReduceRate * temp ;    % This is an important part of SA. Temp must be reduced occasionally.
    end
    
    if error(n) < 10^(-8)
        break;
    end
end

toc

Num_SA_iterations=n

disp ( 'error=' )
disp ( error(n) )

if iMax<6
    xNum
end

%finalNormError = error(n) / sqrt( sum( ( A * xExact - B ).^2 ) / iMax )


figure(3)
semilogy( error(1:n) / error(1) )
xlabel('Iteration Number')
ylabel('Error')
title('Error')



%-----------------------------------------
%  now do gauss-seidel method to compare to
%-----------------------------------------

disp('-------Now doing Gauss-Seidel-------')

tic

D = diag( diag(A) );
ND = A - D;

xNum2 = inv( diag( diag(A))) * B;    % this is a really good guess for diag. dominant A
InitialError = sqrt( sum( ( A * xNum2 - B ).^2 ) / iMax );

for n=1:1000

  xNum2old = xNum2;
  xNum2 = inv(D) * ( B - ND * xNum2 );    
  error = sum( abs(xNum2-xNum2old) )/iMax;
    
  if error < 1.0e-8
     break 
  end
  
end

Num_GS_iterations = n

if iMax<6
   xNum2
end

GS_RMS_error=sqrt( sum( ( A * xNum2 - B ).^2 ) / iMax )  /  InitialError

toc



if iMax<6
    SAsoln_minus_GSsoln = xNum-xNum2
end





