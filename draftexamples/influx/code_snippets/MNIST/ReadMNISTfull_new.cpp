/*
 
 This code reads in the MNIST hand-written character dataset into image and label arrays.
 
 Created by Emery Etter, Dec 2017
 
 */

#include <iostream>
#include <fstream>
//#include <vector>
#include <string>
using namespace std;


int ReverseInt (int i) {
    /* This is needed for low/high endian dilemma. I'm not really sure how it works, but it does.
     
        The header values have to be reversed on Intel processors.
    */
    
    unsigned char ch1, ch2, ch3, ch4;
    ch1=i&255;
    ch2=(i>>8)&255;
    ch3=(i>>16)&255;
    ch4=(i>>24)&255;
    return((int)ch1<<24)+((int)ch2<<16)+((int)ch3<<8)+ch4;
}  // end ReverseInt


void ReadMNIST( string imageFile, string labelFile, float**& imarr, float*& labarr, float**& lab_1hot) {
    /* This function takes in the filenames for the MNIST image and label files and returns image and label arrays.
     
     File source:   http://yann.lecun.com/exdb/mnist/
     
     Train files:   train-images-idx3-ubyte train-labels-idx1-ubyte
                    60,000 images and labels
     
     Test files:    t10k-images-idx3-ubyte  t10k-labels-idx1-ubyte
                    10,000 images and labels
     
     */
    
    
    // Open image file for processing
    ifstream imfile ( imageFile, ios::binary );
    if ( imfile.is_open() ) {
       
        int magic_number = 0;
        int number_of_images = 0;
        int n_rows = 0;
        int n_cols = 0;
        
        // Read in file header information
        imfile.read( (char*) &magic_number, sizeof(magic_number) );
        magic_number = ReverseInt( magic_number );
        
        imfile.read( (char*) &number_of_images, sizeof(number_of_images) );
        number_of_images = ReverseInt( number_of_images );
        
        imfile.read( (char*) &n_rows, sizeof(n_rows) );
        n_rows = ReverseInt( n_rows );
        
        imfile.read( (char*) &n_cols, sizeof(n_cols) );
        n_cols = ReverseInt( n_cols );
        
        // Resize image array based on header info
	imarr = new float*[ number_of_images ];
	for ( int i = 0; i < number_of_images; i++ ) {
	  imarr[i] = new float [ (n_rows*n_cols) ];
	}

        // Read pixel values into image-by-pixel 2D array
        for ( int i = 0; i < number_of_images; i++ ) {
            for ( int r = 0; r < n_rows; r++ ) {
                for ( int c = 0; c < n_cols; c++ ) {
                    unsigned char temp = 0;
                    imfile.read( (char*) &temp, sizeof(temp) );
                    imarr[i][(n_rows*r)+c] = (double) temp;
                }
            }
        }
    }
    
    imfile.close();  // close image file
    
    // Open label file for processing
    ifstream labfile ( labelFile, ios::binary );
    if ( labfile.is_open() ) {
        
        int magic_number_lab = 0;
        int number_of_labels = 0;
        
        // Read in file header info
        labfile.read( (char*) &magic_number_lab, sizeof(magic_number_lab) );
        magic_number_lab = ReverseInt( magic_number_lab );
        
        labfile.read( (char*) &number_of_labels, sizeof(number_of_labels) );
        number_of_labels = ReverseInt( number_of_labels );
        
        // Resize image array based on header info
	labarr = new float [ number_of_labels ];
        
        // Read into array
        for ( int i = 0; i < number_of_labels; i++ ) {

            unsigned char temp = 0;
            labfile.read( (char*) &temp, sizeof(temp) );
            labarr[i] = (double) temp;
            
        }

    // Convert to 1-hot representation
    lab_1hot = new float* [ number_of_labels ];
    for ( int i = 0; i < number_of_labels; i++ ) {
      lab_1hot[i] = new float [ 10 ];
    }
    
    for ( int i = 0; i < number_of_labels; i++ ) {
        for ( int j = 0; j < 10; j++ ) {
            
            if ( labarr[i] == j ) {
                lab_1hot[i][j] = 1.0;
            } else {
                lab_1hot[i][j] = 0.0;
            }
            
        }
    }


    }
    
    labfile.close();  // close label file
    
    
}  // end ReadMNIST



int main() {
    
  float** train_imar;
  float** test_imar;
  float* train_labar;
  float* test_labar;
  float** train_lab1hot;
  float** test_lab1hot;
    	

    // Read in training data
    ReadMNIST("train-images-idx3-ubyte", "train-labels-idx1-ubyte", train_imar, train_labar, train_lab1hot);
    
    // Read in test data
    ReadMNIST("t10k-images-idx3-ubyte", "t10k-labels-idx1-ubyte", test_imar, test_labar, test_lab1hot);
    
    // initialize random seed and generate random number
    srand (time(NULL));
    int randindex = rand() % ( 60000 - 1 );

    // Print random image label and pixel values for sanity check
    cout << "\nLabel of training image #" << randindex << ": " << train_labar[randindex] << endl;
    cout << "Training image pixel values for image #" << randindex << ": \n";
    for ( int r = 0; r < 28; r++ ) {
        for ( int c = 0; c < 28; c++) {
            cout << train_imar[randindex][(28*r)+c] << " ";
        }
        cout << endl;
    }
    /*    
    // Check sizes for sanity check
    cout << endl << "train label array size: " << train_labar.size() << endl;
    cout << "train image array size: " << train_imar.size() << " x " << train_imar[1].size() << endl;
    cout << "test label array size: " << test_labar.size() << endl;
    cout << "test image array size: " << test_imar.size() << " x " << test_imar[1].size() << endl << endl;
    */
    // 1-hot representation
    cout << "1-hot representation of label: ";
    for ( int i = 0; i < 10; i++ ) {
        cout << train_lab1hot[randindex][i] << ", ";
    }
    cout << endl << endl;
    
    return 0;
    
}  // end main

