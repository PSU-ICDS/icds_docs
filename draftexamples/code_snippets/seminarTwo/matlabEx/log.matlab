exec taskset -c 0-3 matlab-bin -nodisplay -nosplash -singleCompThread

                            < M A T L A B (R) >
                  Copyright 1984-2016 The MathWorks, Inc.
                   R2016a (9.0.0.341360) 64-bit (glnxa64)
                             February 11, 2016

 
To get started, type one of these: helpwin, helpdesk, or demo.
For product information, visit www.mathworks.com.
 
    ----------------------------------------------------
	Your MATLAB license will expire in 49 days.
	Please contact your system administrator or
	MathWorks to renew this license.
    ----------------------------------------------------

	Academic License

>> Optimization terminated: change in best function value less than options.FunctionTolerance.

x =

   -0.0896    0.7130


fval =

   -1.0316


exitFlag =

     1


output = 

     iterations: 2948
      funccount: 2971
        message: 'Optimization terminated: change in best function value l...'
       rngstate: [1x1 struct]
    problemtype: 'unconstrained'
    temperature: [2x1 double]
      totaltime: 4.3200

Optimization terminated: change in best function value less than options.FunctionTolerance.
The number of iterations was : 2428
The number of function evaluations was : 2447
The best function value found was : -1.03163
Optimization terminated: change in best function value less than options.FunctionTolerance.

x =

    0.0898   -0.7127


fval =

   -1.0316

>> 