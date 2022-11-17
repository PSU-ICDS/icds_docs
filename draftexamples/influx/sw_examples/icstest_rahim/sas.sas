     Proc sort data=wines; 
          by vineyard;
     run;
     ***  The Sort prepares the data so it can be analyzed for each vineyard;
     proc corr data=wines;
          title "Correlation matrix for wine data";
          by vineyard;
          var vintage pct_alchohol aroma coloration price sales;
     run;
     proc reg data=wines;
          title "Regression model for sales for each vineyard";  
          by vineyard;
          model sales=vintage pct_alchohol aroma coloration price;
     run;
     quit;
     *** Now lets use both vineyard and label;    
     Proc sort data=wines; 
          by vineyard label;
     run;
     ***  Sort prepares the data so it can be analyzed for each combination of vineyard and label;
     proc corr data=wines;
          title "Correlation matrix for wine data";
          by vineyard label;
          var vintage pct_alchohol aroma coloration price sales;
     run;
     proc reg data=wines;
          title "Regression model for sales for each vineyard";  
          by vineyard label;
          model sales=vintage pct_alchohol aroma coloration price;
     run;
     quit;
