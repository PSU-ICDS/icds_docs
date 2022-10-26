/**----------------------------------------------------------------------
 Simple code to illustrate neural network backpropagation learning.
 This doesn't use separate training and validation
 datasets. This version reads the input data from a file.

  Prof. Lyle N. Long, Aug., 2017
------------------------------------------------------------------------**/

#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vector>  // EE -- just using this for ReadMNIST function
using namespace std;


#include "ReadMNIST.cpp"  // EE


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

  cout << endl << "Printing 2D array called... " << name << endl;

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



int  main() {

  float rate = 0.9;   // learning rate

  int nmax = 1000;   // number of epochs to run
  //  int mmax = 60000;       // number of input datasets  (4 for XOR problem) -- Getting this size from file input now

  int numLayers, numRowsData;   // this would be 3 for one hiddenlayer (and one input and one output layer)

  time_t tm0, tm1;   // variables to time code
  clock_t ck0, ck1;

  cout << endl <<"Welcome to backprop neural code" << endl << endl;

  string inputStream;

  //cout << "Enter name of file with data to read."<<endl;
  //cin >> inputStream;
  inputStream = "mnist_net.txt";  // EE -- file is only providing network topology now
  cout << "You entered :   " << inputStream<< " as input filename " << endl;


  //   ----- read data from file------
    
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

  printArray( neuronPerLayer, numLayers, "NeuronPerLayer");

  // create array to hold all input data

  // EE -- using vectors initially to utilize _.size() call
  vector< vector<float> > inputs_vec, outputs_vec;   // EE
  vector<float> outputlabels;                        // EE

  // 60,000 image set
  // ReadMNIST( "train-images-idx3-ubyte", "train-labels-idx1-ubyte", inputs_vec, outputlabels, outputs_vec);  // EE
  // 10,000 image set
  ReadMNIST( "t10k-images-idx3-ubyte", "t10k-labels-idx1-ubyte", inputs_vec, outputlabels, outputs_vec);  // EE
  
  int mmax = inputs_vec.size();

  float ** outputs = new float*[ mmax ];   // EE
  float ** inputs  = new float*[ mmax ];    // EE
  

  for ( int i=0 ; i<numLayers-1; i++) {
    neuronPerLayer[i] = neuronPerLayer[i] + 1;    // add an extra one for bias neurons, except on output layer
  }

  
  for ( int i=0 ; i<mmax; i++) {
      inputs[i] = new float[ neuronPerLayer[0] ];  
  }

  for ( int i=0 ; i<mmax; i++) {   // EE -- output must be 2D for 1-hot representation
      outputs[i] = new float[ neuronPerLayer[numLayers-1] ];  
  }
  
  // EE -- convert input and output from vector to dynamic array
  //    -- convert input to -.95 to .95 from 0 to 255
  for ( int i = 0; i < inputs_vec.size(); i++) {
    for ( int j = 0; j < inputs_vec[1].size(); j++ ) {
      inputs[i][j] = ( inputs_vec[i][j] / 255.0 ) * (2.0*.95) - 0.95;
    }
  }

  for ( int i = 0; i < outputs_vec.size(); i++) {
    for ( int j = 0; j < outputs_vec[1].size(); j++ ) {
      outputs[i][j] = outputs_vec[i][j];
    }
  }


  /*  // EE -- no longer getting inputs and outputs from txt file
  for( int i=0; i<numRowsData; i++)  {             // read all data from file
    for ( int j=0; j<neuronPerLayer[0]-1;  j++) {
      myInputFile >> inputs[i][j];
      //cout << " i j = " << i << " " << j << ",  inputs[i][j] = " << inputs[i][j] << endl;
    }
    myInputFile >> outputs[i];
  }
  */



  for( int i=0; i<mmax; i++)  {             // add the bias input to input array
      inputs[i][ neuronPerLayer[0]-1 ] = 0.95;
  }

  myInputFile.close();
   
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

  // set up neuron arrays   (first index is layer, second index is neuron number in that layer)

  float ** u  = new float*[ numLayers ];
  float ** dd = new float*[ numLayers ];

  for ( int i=0 ; i<numLayers; i++) {
    u[i] = new float[ neuronPerLayer[i] ];
    dd[i] = new float[ neuronPerLayer[i] ];
  }



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
  



  // Initialize u, dd, w, dw, and wOrig arrays

  for ( int k=0 ; k<numLayers; k++) {
    for ( int i=0 ; i<neuronPerLayer[k]; i++) {
	u[k][i] = 0.0;
	dd[k][i] = 0.0;
    }
  }




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






  int nnn=0, n=0, m=0;
  float error=0.0, sqerror=0.0, sumDW=0.0, epochError=0.0;


  tm0 = time(0);   // Start to time code
  ck0 = clock(); 


 for (n = 0; n<nmax; n++) {   //   loop over nmax epochs 

    
     epochError =  0.0;

     for (int mmm = 0; mmm<mmax; mmm++)  {    // loop over number of inputs (eg 4)
        
        nnn=nnn+1;
        
        m = (int)(mmax * myRan());          // randomly choose an input
        //m = mmm;                       // use inputs in same order each time

        for ( int i=0; i<neuronPerLayer[0]; i++) {
            u[0][i] = inputs[m][i];                     // set input neurons to input data
        }

        error = 0;
        sqerror = 0;
      
        // ---forward propagation---
        
        
        for (int k = 1; k<numLayers; k++) {    // loop over layers, starting with 2nd one
            
            for (int j = 0; j<neuronPerLayer[k]; j++)  {  // loop over postsyn neurons
                
                u[k][j] = 0;
                
                for (int i = 0; i<neuronPerLayer[k-1]; i++) {   // loop over presyn neurons
                  
                    u[k][j] = u[k][j]  +  w[k-1][j][i] * u[k-1][i];   // sum all inputs times weights (ie forward prop)

                }
                
                //u(k,j) = 1 / ( 1 + exp( -slope * u(k,j) ));   // apply sigmoid with coefficient "slope"
                u[k][j] = tanh( u[k][j] );   // apply tanh activation
                
            }
            
            if ( k < (numLayers-1) ) {
                u[k][ neuronPerLayer[k] ] = 0.95;   // reset bias terms, in case they have changed
            }                                     // (there is no bias on output layer)
            
        }

	for ( int i = 0; i < neuronPerLayer[numLayers-1]; i++ ) { // EE -- multiple output neurons now
	  error = error + .5 * pow( outputs[m][i] - u[2][i] , 2) ;   // mean square error
	}
	
        epochError = epochError + error;
        /*
	if ( mmm%1000 == 0 ) {
          cout  << " Epoch Error = " << epochError << endl;
	  for ( int i = 0; i < neuronPerLayer[numLayers-1]; i++ ) {
      	    cout << "outputs[" << m << "][" << i << "] = " << outputs[m][i] << ", u[2][" << i << "] = " << u[2][i] << endl;
	  }
	 }*/

        
        // ---backpropagation using online processing---
        
        
        // ---find delta terms (called dd here) for each neuron:---

        
        for (int k = numLayers-1; k>=0; k--) {    // loop over neuron layers, in backward order
            
            for (int i = 0; i<neuronPerLayer[k]; i++)  {   // loop over neurons in layer k
                
                if ( k == (numLayers-1) ) {  // for output layer do this:
                    //dd(k,i) = ( outputs(m) - u(k,i) )  * slope *  u(k,i) * ( 1 - u(k,i) ); // eqtn 4.13 in Haykin book
		    //dd[k][i] = ( outputs[m] - u[k][i] )  * ( 1 - u[k][i] ) *  ( 1 + u[k][i] );  // eqtn 4.37 in Haykin book
                    dd[k][i] = ( outputs[m][i] - u[k][i] )  * ( 1 - u[k][i] ) *  ( 1 + u[k][i] );  // EE -- added 2nd index to output
                }
                else {   // for all other layers do this:
                    sumDW = 0;
                    for (int ii=0; ii<neuronPerLayer[k+1]; ii++ )  {
                        sumDW = sumDW + w[k][ii][i] * dd[k+1][ii];
                    }
                    //dd(k,i) = sumDW  *  slope * u(k,i) * ( 1 - u(k,i) );    // eqtn 4.24 in Haykin book
                    dd[k][i] = sumDW  * ( 1 - u[k][i] )  * ( 1 + u[k][i] );     // eqtn 4.38 in Haykin book
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
        	
      }  // end of loop over number of inputs

      if ( n%1 == 0 ) {
          cout << " Epoch = " << n << ", Error = " << epochError << endl;
      }

      if ( epochError/neuronPerLayer[0]  < 0.000001) {
          break;
      }
    

 }  // end of loop over epochs

 //  printWeights( wOrig, numLayers, neuronPerLayer, "w" );

  tm1 = time(0); // end of timing  code
  ck1 = clock();

  cout << "  Wall time = " << difftime(tm1, tm0) << " seconds" << endl;
  double cputime = double(ck1 - ck0) / CLOCKS_PER_SEC;
  cout << "  CPU time  = " << cputime << " seconds" << endl<<endl;



  cout << "Number of epochs run:  " <<  n << endl;
  cout << "Code finished properly."<<endl<<endl;

}  // end of main()



