/**----------------------------------------------------------------------
 Simple code to illustrate neural network backpropagation learning.
 This doesn't use separate training and validation
 datasets. This version reads the input data from a file.

  Prof. Lyle N. Long, Aug., 2017
  edited by Emery Etter
------------------------------------------------------------------------**/

#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
//#include <vector> 
using namespace std;


#include "ReadMNIST.cpp"


double myRan(void) {
  //#include <iomanip.h>
  //return  rand() / (double)RAND_MAX;               //  0 <= num <= 1 
  return  rand() / ((double)RAND_MAX + 1.0);         //  0 <= num <  1
  //return (rand()+1.0) / ((double)RAND_MAX + 2);      //  0 <  num <  1
}


void printArray( float* x, int iNum, string name ) {

  cout << endl << "Printing 1D array called... " << name << endl;

  for ( int i=0; i<iNum; i++) {
      cout << x[i]  << endl;
  }
}

void printArray( int* x, int iNum , string name) {

  cout << endl << "Printing 1D array called... " << name << endl;

  for ( int i=0; i<iNum; i++) {
      cout << x[i]  << endl;
  }
}


void printArray( float** x, int iNum, int jNum, string name) {

  cout << endl << "Printing 2D array called... " << name << endl;

  for ( int i=0; i<iNum; i++) {
    for ( int j=0; j<jNum; j++) {
      cout << x[i][j] << " " ;  
    }
    cout << endl;
  }
}


void printArray( float*** x, int iNum, int jNum, int kNum, string name) {

  cout << endl << "Printing 3D array called... " << name << endl;

  for ( int i=0; i<iNum; i++) {
    cout << endl << " Layer i = " << i << endl;
    for ( int j=0; j<jNum; j++) {
      for ( int k=0; k<kNum; k++) {
	cout << x[i][j][k] << " " ;  
      }
      cout << endl;
    }
  }
}



void printWeights( float*** x, int numLayers, int neurPerLayer[], string name) {

  cout << endl << "Printing weight array ... " << name << endl;

  for ( int i=0; i<numLayers-1; i++) {
    cout << endl << "  Layer i = " << i << endl;
    for ( int k=0; k<neurPerLayer[i]; k++) {
      cout  << "    Presyn Neuron = " << k << endl;
      for ( int j=0; j<neurPerLayer[i+1]; j++) {
	cout << "       " << x[i][j][k] << " " ;  
      }
      cout << endl;
    }
  }
  cout << endl << endl;

}


void weights2file( float*** x, int numLayers, int neurPerLayer[], string filename) {

  ofstream outfile;
  outfile.open( filename.c_str(), std::ios_base::app );

  for ( int i=0; i<numLayers-1; i++) {
    for ( int k=0; k<neurPerLayer[i]; k++) {
      for ( int j=0; j<neurPerLayer[i+1]; j++) {
	outfile << x[i][j][k] << " " ;  
      }
    }
  }
  outfile << endl;

  outfile.close();

}




// - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - MAIN- - - - - - - - - - - 
// - - - - - - - - - - - - - - - - - - - - - - -

int  main() {

  // - - - - - SET UP HYPERPARAMETERS - - - - -

  float rate = 0.5;    // learning rate
  float slope = 0.3;   // logistic hyperparameter
  float beta = 0.1;    // tanh hyperparameter
  int nmax = 1000;      // number of epochs to run  
  int sw = 20;
  bool test = false;       // do trained weights already exist?
  string weightfile = "weights.txt";
  bool printweights = false;

  cout << endl <<"Welcome to backprop neural code" << endl;

  cout << endl << "Learning Rate = " << rate << "\nSlope = " << slope << "\nBeta = " << beta << endl;
  cout << "Logistic" << endl << endl;


  // - - - - - READ TOPO DATA FROM FILE - - - - -

  string inputStream;

  //cout << "Enter name of file with data to read."<<endl;
  //cin >> inputStream;
  inputStream = "mnist_net.txt";
  cout << "You entered :   " << inputStream<< " as input filename " << endl;

 
  int numLayers, numRowsData;   // this would be 3 for one hiddenlayer (and one input and one output layer)

  std::fstream myInputFile;
  myInputFile.open( inputStream.c_str(), std::ios::in);
  
  myInputFile >> numLayers ;
  cout << "  numLayers = " << numLayers << endl;

  int* neuronPerLayer = new int[ numLayers ];

  for( int i=0; i<numLayers; i++)  {
      myInputFile >> neuronPerLayer[i];
      cout << "  Layer = " << i << "," << " neuronPerLayer = " << neuronPerLayer[i] << endl;
  }
  myInputFile >> numRowsData;
  cout << "  numRows of input data =  " << numRowsData << endl;

  myInputFile.close();

  printArray( neuronPerLayer, numLayers, "NeuronPerLayer");


  // - - - - - READ INPUT AND OUTPUT FROM MNIST FILES - - - - -

  //  vector< vector<float> > inputs_vec, outputs_vec, testin_vec, testout_vec;
  //  vector<float> outputlabels, testoutlabels;                     
  float** inputs; float** outputs; float** testin; float** testout;
  float* outputlabels; float* testoutlabels;

  // Training Set -- 60,000 image set
  ReadMNIST( "train-images-idx3-ubyte", "train-labels-idx1-ubyte", inputs, outputlabels, outputs);
  // Test Set -- 10,000 image set
  ReadMNIST( "t10k-images-idx3-ubyte", "t10k-labels-idx1-ubyte", testin, testoutlabels, testout);
  
  int mmax = 60000;
  int test_mmax = 10000;

  // - - - - - SET UP INPUTS AND OUTPUTS FOR NETWORK - - - - - 
  /*
  float ** outputs = new float*[ mmax ];
  float ** inputs  = new float*[ mmax ];
  float ** testin = new float*[ test_mmax ];
  float ** testout = new float*[ test_mmax ];
  */
  for ( int i=0 ; i<numLayers-1; i++) {
    neuronPerLayer[i] = neuronPerLayer[i] + 1;    // add an extra one for bias neurons, except on output layer
  }
  /*
  for ( int i=0 ; i<mmax; i++) {
      inputs[i] = new float[ neuronPerLayer[0] ];  
  }

  for ( int i=0 ; i<test_mmax; i++) {
     testin[i] = new float[ neuronPerLayer[0] ];  
  }

  for ( int i=0 ; i<mmax; i++) {   // output must be 2D for 1-hot representation
      outputs[i] = new float[ neuronPerLayer[numLayers-1] ];  
  }

  for ( int i=0 ; i<test_mmax; i++) {   // output must be 2D for 1-hot representation
      testout[i] = new float[ neuronPerLayer[numLayers-1] ];  
  }
  */
  
  // convert input and output from vector to dynamic array
  // convert input to -.95 to .95 from 0 to 255
  for ( int i = 0; i < mmax; i++) {
    for ( int j = 0; j < 28*28; j++ ) {
      inputs[i][j] = ( inputs[i][j] / 255.0 ) * (2.0*.95) - 0.95;
    }
  }

  for ( int i = 0; i < test_mmax; i++) {
    for ( int j = 0; j < 28*28; j++ ) {
      testin[i][j] = ( testin[i][j] / 255.0 ) * (2.0*.95) - 0.95;
    }
  }

  for ( int i = 0; i < mmax; i++) {
    for ( int j = 0; j < 10; j++ ) {
      outputs[i][j] = outputs[i][j];
    }
  }

  for ( int i = 0; i < test_mmax; i++) {
    for ( int j = 0; j < 10; j++ ) {
      testout[i][j] = testout[i][j];
    }
  }
  
  for( int i=0; i<mmax; i++)  {             // add the bias input to input array
      inputs[i][ neuronPerLayer[0]-1 ] = 0.95;
  }


  // - - - - - CHECK SOME INPUTS/OUTPUTS - - - - -

  //  printArray( inputs, numRowsData, neuronPerLayer[0], "Inputs");
  /*  // print input pixels for input and 1hot output index 1
  for ( int i = 0; i < 28; i++ ) {
    for ( int j = 0; j < 28; j++ ) {
      cout << inputs[1][28*i+j] << " ";
    }
    cout << endl;
  }
  cout << "Output label: " << outputlabels[1] << endl;
  cout << "1-hot representation: ";
  for ( int i = 0; i < 10; i++ ) {
    cout << outputs[1][i] << " ";
  }
  cout << endl;
  */


  // - - - - - SET UP NEURON ARRAYS - - - -
  // ---> first index is layer, second index is neuron number in that layer

  float ** u  = new float*[ numLayers ];
  float ** dd = new float*[ numLayers ];

  for ( int i=0 ; i<numLayers; i++) {
    u[i] = new float[ neuronPerLayer[i] ];
    dd[i] = new float[ neuronPerLayer[i] ];
  }

  // Initialize u, dd arrays
  for ( int k=0 ; k<numLayers; k++) {
    for ( int i=0 ; i<neuronPerLayer[k]; i++) {
	u[k][i] = 0.0;
	dd[k][i] = 0.0;
    }
  }


  // - - - - - SET UP WEIGHT ARRAYS - - - - - 

  // create dynamic memory arrays for weights, wOrig, & dw
  // for weights: first index is layer number, second index is postsyn neuron,
  // and third index is presyn neuron.

  float *** w      = new float**[ numLayers-1 ];   // synapse weights
  float *** dw     = new float**[ numLayers-1 ];   // used for backpropagation
  float *** wOrig  = new float**[ numLayers-1 ];   // just used to store initial weights (not used yet)


  for ( int i=0 ; i<(numLayers-1) ; i++) {
    w[i]     = new float*[ neuronPerLayer[i+1] ];
    dw[i]    = new float*[ neuronPerLayer[i+1] ];
    wOrig[i] = new float*[ neuronPerLayer[i+1] ];
    for ( int j=0 ; j<neuronPerLayer[i+1]; j++) {
      w[i][j]     = new float[ neuronPerLayer[i] ];
      dw[i][j]    = new float[ neuronPerLayer[i] ];
      wOrig[i][j] = new float[ neuronPerLayer[i] ];
    }
  }

  // Initialize w, dw, wOrig arrays  
  for ( int k=0 ; k<numLayers-1; k++) {
    for ( int i=0 ; i<neuronPerLayer[k+1]; i++) {
      for ( int j=0 ; j<neuronPerLayer[k]; j++) {
        w[k][i][j] = 2.0*myRan() - 1.0;   // weights range form -1 to 1 initially
        dw[k][i][j] = 0.0;
        wOrig[k][i][j] = w[k][i][j] ;   // this is just used for plotting
      }
    }
  }

  //  printWeights( wOrig, numLayers, neuronPerLayer, "wOrig" );
  if ( printweights ) {
    weights2file( wOrig, numLayers, neuronPerLayer, weightfile );
  }


  // - - - - - SET UP SOME LOOP VARIABLES - - - - - 

  int nnn = 0, n = 0, m = 0, epochs = 0;
  float error = 0.0, sqerror = 0.0, sumDW = 0.0;
  int correct = 0, wrong = 0;
  double avg1 = 0.0, avg2 = 0.0;
  
  float * epochError = new float[nmax];

  for ( int i = 0; i < nmax; i++ ) {
    epochError[i] = 0.0;
  }

  ofstream errorfile;
  errorfile.open( "errors.txt" );

  // - - - - - SET UP TIMING VALUES - - - - -

  time_t tm0, tm1;   // variables to time code
  clock_t ck0, ck1;

  tm0 = time(0);   // Start to time code
  ck0 = clock(); 


  // - - - - - MAIN TRAINING EPOCH LOOP - - - - -
  loopstart:
  for (n = 0; n<nmax; n++) {   //   loop over nmax epochs 

     epochError[n] =  0.0;

     // - - - - - INPUT LOOP - - - - - 

     for (int mmm = 0; mmm<mmax; mmm++)  {    // loop over number of inputs
        
        nnn=nnn+1;
        
	m = (int)(mmax * myRan());          // randomly choose an input
	//      m = mmm;                       // use inputs in same order each time

	// - - - - - INJECT CURRENT - - - - -

        for ( int i=0; i<neuronPerLayer[0]; i++) {
            u[0][i] = inputs[m][i];                     // set input neurons to input data
        }

        error = 0;
        sqerror = 0;
      
        
	// - - - - - FORWARD PROPAGATION - - - - -
                
        for (int k = 1; k<numLayers; k++) {    // loop over layers, starting with 2nd one
            
            for (int j = 0; j<neuronPerLayer[k]; j++)  {  // loop over postsyn neurons
                
                u[k][j] = 0;
                
                for (int i = 0; i<neuronPerLayer[k-1]; i++) {   // loop over presyn neurons
                  
                    u[k][j] = u[k][j]  +  w[k-1][j][i] * u[k-1][i];   // sum all inputs times weights (ie forward prop)
                 
                }
                
                u[k][j] = 1 / ( 1 + exp( -slope * u[k][j] ));   // apply logistic with coefficient "slope"
                //u[k][j] = tanh( beta * u[k][j] );   // apply tanh activation
                
            }
            
            if ( k < (numLayers-1) ) {
                u[k][ neuronPerLayer[k] ] = 0.95;   // reset bias terms, in case they have changed
            }                                     // (there is no bias on output layer)
            
        }

	if ( test == true ){
	  // ----------------------------------
	  // ---------- TESTING CASE ----------
	  // ----------------------------------


	  // - - - - - FIND WINNER - - - - -
	  
	  double maxval = 0.0;
	  int maxind = 0;
	  
	  for ( int i = 0; i < neuronPerLayer[numLayers-1]; i++ ) {
	    if ( u[numLayers-1][i] > maxval ) {
	      maxind = i;
	      maxval = u[numLayers-1][i];
	    }
	  }
	  
	  // - - - - - CHECK CORRECTNESS - - - - -

	  if ( maxind == testoutlabels[m] ) {
	    correct = correct + 1;
	  } else {
	    wrong = wrong + 1;
	  }


	} else if ( test == false ) {
	  // -----------------------------------
	  // ---------- TRAINING CASE ----------
	  // -----------------------------------

	  // - - - - - CALCULATE ERROR - - - - - 

	  for ( int i = 0; i < neuronPerLayer[numLayers-1]; i++ ) { 
	    sqerror = sqerror + pow( outputs[m][i] - u[numLayers-1][i] , 2) ;   // mean square error
	  }
	
	  epochError[n] = epochError[n] + sqerror / neuronPerLayer[numLayers-1];
        
        

	  // - - - - - BACKPROPAGATION USING ONLINE PROCESSING - - - - -
	  
	  
	  // ---find delta terms (called dd here) for each neuron:---
	  
	  
	  for (int k = numLayers-1; k>=0; k--) {    // loop over neuron layers, in backward order
	    
            for (int i = 0; i<neuronPerLayer[k]; i++)  {   // loop over neurons in layer k
                
                if ( k == (numLayers-1) ) {  // for output layer do this:
		    dd[k][i] = ( outputs[m][i] - u[k][i] )  * slope *  u[k][i] * ( 1 - u[k][i] ); // eqtn 4.13 in Haykin book
		    //dd[k][i] = ( outputs[m] - u[k][i] )  * ( 1 - u[k][i] ) *  ( 1 + u[k][i] );  // eqtn 4.37 in Haykin book
                    //dd[k][i] = beta * ( outputs[m][i] - u[k][i] )  * ( 1 - u[k][i] ) *  ( 1 + u[k][i] );
                }
                else {   // for all other layers do this:
                    sumDW = 0;
                    for (int ii=0; ii<neuronPerLayer[k+1]; ii++ )  {
                        sumDW = sumDW + w[k][ii][i] * dd[k+1][ii];
                    }
                    dd[k][i] = sumDW  *  slope * u[k][i] * ( 1 - u[k][i] );    // eqtn 4.24 in Haykin book
                    //dd[k][i] = beta * sumDW  * ( 1 - u[k][i] )  * ( 1 + u[k][i] );     // eqtn 4.38 in Haykin book
                }
            }
            
	  }
        
	  // ---update weights:---
        
	  for (int k = 0; k<numLayers-1; k++) {    // loop over layers of weights            
            for (int j = 0;  j<neuronPerLayer[k+1]; j++) {   // loop over postsyn neurons
                for (int i = 0;  i<neuronPerLayer[k] ; i++) {   // loop over presyn neurons
                    
                    dw[k][j][i] = rate * u[k][i] * dd[k+1][j];   // eqtn 4.13 in Haykin book
		    w[k][j][i]  = w[k][j][i] + dw[k][j][i];
                    
                }
            }
	  }        	 

	} // end train/test if structure

     }  // end of loop over number of inputs

     if ( test == false ) {

       // save weights to file
       if ( n%50 == 0 && printweights ) {
	   weights2file( w, numLayers, neuronPerLayer, weightfile );
       }

       // output epoch error
       if ( n%1 == 0 ) {
	 cout << " Epoch = " << n << ", Error = " << epochError[n] << endl;
       }

       errorfile << n << ", " << epochError[n] << endl;

       // check for convergence
       if ( n > 2*sw ) {

	 avg1 = 0.0;
	 avg2 = 0.0;

	 for ( int i = n; i > n-sw ; i-- ) {
	   avg1 = avg1 + epochError[i];
	 }

	 for ( int i = n-sw; i > n-2*sw; i-- ) {
	   avg2 = avg2 + epochError[i];
	 }

	 if ( avg1 > avg2 ) {
	   break;
	 }
       }

     }
     
    

 }  // end of loop over epochs


  // - - - - - RUN TESTING IF NOT YET RUN - - - - -

  if ( test == false ) {
    
    epochs = n;
    nmax = 1;
    test = true;
    mmax = test_mmax;
    inputs = testin;
    goto loopstart;
  
  } else if ( test == true ) {
    
    error = (double) wrong / ( (double) correct + (double) wrong );

  }

  if ( printweights ) {
    weights2file( w, numLayers, neuronPerLayer, weightfile );
  }


 // - - - - - END TIMING OF CODE - - - - -

  tm1 = time(0); // end of timing  code
  ck1 = clock();

  cout << "  Wall time = " << difftime(tm1, tm0) << " seconds" << endl;
  double cputime = double(ck1 - ck0) / CLOCKS_PER_SEC;
  cout << "  CPU time  = " << cputime << " seconds" << endl<<endl;


  // - - - - - PRINT FINAL INFO - - - - -

  cout << "Number of epochs run:  " <<  epochs << endl;
  cout << "Test Error = " << error*100.0 << " % " << endl;
  cout << "Code finished properly."<<endl<<endl;

  errorfile.close();

}  // end of main()



