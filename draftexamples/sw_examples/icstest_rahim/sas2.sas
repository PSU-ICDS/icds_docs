proc sort data=preTest;
     by student_ID;
run;
proc sort data=postTest;
     by student_ID;
run;
data testGroup;
     merge preTest(in=a rename=(score=pre)) 
           postTest(in=b rename=(score=post));
     by student_ID;
     if a and b;
     difference=post-pre;
run;
Title "Student's T test of difference"; 
proc means data=testGroup n mean stddev stderr t prt;
     by student_ID;
     var difference;
run;

