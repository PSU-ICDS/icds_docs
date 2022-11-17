#include <iostream>
#include <vector>
#include <math.h>
#include <time.h>


using std::vector;
using std::cout;
using std::endl;

vector<float> X {
5.1,3.5,1.4,0.2, 
4.9,3,1.4,0.2, 
4.7,3.2,1.3,0.2, 
4.6,3.1,1.5,0.2, 
5,3.6,1.4,0.2, 
5.4,3.9,1.7,0.4, 
4.6,3.4,1.4,0.3, 
5,3.4,1.5,0.2, 
4.4,2.9,1.4,0.2, 
4.9,3.1,1.5,0.1, 
5.4,3.7,1.5,0.2, 
4.8,3.4,1.6,0.2, 
4.8,3,1.4,0.1, 
4.3,3,1.1,0.1, 
5.8,4,1.2,0.2, 
5.7,4.4,1.5,0.4, 
5.4,3.9,1.3,0.4, 
5.1,3.5,1.4,0.3, 
5.7,3.8,1.7,0.3, 
5.1,3.8,1.5,0.3, 
5.4,3.4,1.7,0.2, 
5.1,3.7,1.5,0.4, 
4.6,3.6,1,0.2, 
5.1,3.3,1.7,0.5, 
4.8,3.4,1.9,0.2, 
5,3,1.6,0.2, 
5,3.4,1.6,0.4, 
5.2,3.5,1.5,0.2, 
5.2,3.4,1.4,0.2, 
4.7,3.2,1.6,0.2, 
4.8,3.1,1.6,0.2, 
5.4,3.4,1.5,0.4, 
5.2,4.1,1.5,0.1, 
5.5,4.2,1.4,0.2, 
4.9,3.1,1.5,0.1, 
5,3.2,1.2,0.2, 
5.5,3.5,1.3,0.2, 
4.9,3.1,1.5,0.1, 
4.4,3,1.3,0.2, 
5.1,3.4,1.5,0.2, 
5,3.5,1.3,0.3, 
4.5,2.3,1.3,0.3, 
4.4,3.2,1.3,0.2, 
5,3.5,1.6,0.6, 
5.1,3.8,1.9,0.4, 
4.8,3,1.4,0.3, 
5.1,3.8,1.6,0.2, 
4.6,3.2,1.4,0.2, 
5.3,3.7,1.5,0.2, 
5,3.3,1.4,0.2, 
7,3.2,4.7,1.4, 
6.4,3.2,4.5,1.5, 
6.9,3.1,4.9,1.5, 
5.5,2.3,4,1.3, 
6.5,2.8,4.6,1.5, 
5.7,2.8,4.5,1.3, 
6.3,3.3,4.7,1.6, 
4.9,2.4,3.3,1, 
6.6,2.9,4.6,1.3, 
5.2,2.7,3.9,1.4, 
5,2,3.5,1, 
5.9,3,4.2,1.5, 
6,2.2,4,1, 
6.1,2.9,4.7,1.4, 
5.6,2.9,3.6,1.3, 
6.7,3.1,4.4,1.4, 
5.6,3,4.5,1.5, 
5.8,2.7,4.1,1, 
6.2,2.2,4.5,1.5, 
5.6,2.5,3.9,1.1, 
5.9,3.2,4.8,1.8, 
6.1,2.8,4,1.3, 
6.3,2.5,4.9,1.5, 
6.1,2.8,4.7,1.2, 
6.4,2.9,4.3,1.3, 
6.6,3,4.4,1.4, 
6.8,2.8,4.8,1.4, 
6.7,3,5,1.7, 
6,2.9,4.5,1.5, 
5.7,2.6,3.5,1, 
5.5,2.4,3.8,1.1, 
5.5,2.4,3.7,1, 
5.8,2.7,3.9,1.2, 
6,2.7,5.1,1.6, 
5.4,3,4.5,1.5, 
6,3.4,4.5,1.6, 
6.7,3.1,4.7,1.5, 
6.3,2.3,4.4,1.3, 
5.6,3,4.1,1.3, 
5.5,2.5,4,1.3, 
5.5,2.6,4.4,1.2, 
6.1,3,4.6,1.4, 
5.8,2.6,4,1.2, 
5,2.3,3.3,1, 
5.6,2.7,4.2,1.3, 
5.7,3,4.2,1.2, 
5.7,2.9,4.2,1.3, 
6.2,2.9,4.3,1.3, 
5.1,2.5,3,1.1, 
5.7,2.8,4.1,1.3, 
6.3,3.3,6,2.5, 
5.8,2.7,5.1,1.9, 
7.1,3,5.9,2.1, 
6.3,2.9,5.6,1.8, 
6.5,3,5.8,2.2, 
7.6,3,6.6,2.1, 
4.9,2.5,4.5,1.7, 
7.3,2.9,6.3,1.8, 
6.7,2.5,5.8,1.8, 
7.2,3.6,6.1,2.5, 
6.5,3.2,5.1,2, 
6.4,2.7,5.3,1.9, 
6.8,3,5.5,2.1, 
5.7,2.5,5,2, 
5.8,2.8,5.1,2.4, 
6.4,3.2,5.3,2.3, 
6.5,3,5.5,1.8, 
7.7,3.8,6.7,2.2, 
7.7,2.6,6.9,2.3, 
6,2.2,5,1.5, 
6.9,3.2,5.7,2.3, 
5.6,2.8,4.9,2, 
7.7,2.8,6.7,2, 
6.3,2.7,4.9,1.8, 
6.7,3.3,5.7,2.1, 
7.2,3.2,6,1.8, 
6.2,2.8,4.8,1.8, 
6.1,3,4.9,1.8, 
6.4,2.8,5.6,2.1, 
7.2,3,5.8,1.6, 
7.4,2.8,6.1,1.9, 
7.9,3.8,6.4,2, 
6.4,2.8,5.6,2.2, 
6.3,2.8,5.1,1.5, 
6.1,2.6,5.6,1.4, 
7.7,3,6.1,2.3, 
6.3,3.4,5.6,2.4, 
6.4,3.1,5.5,1.8, 
6,3,4.8,1.8, 
6.9,3.1,5.4,2.1, 
6.7,3.1,5.6,2.4, 
6.9,3.1,5.1,2.3, 
5.8,2.7,5.1,1.9, 
6.8,3.2,5.9,2.3, 
6.7,3.3,5.7,2.5, 
6.7,3,5.2,2.3, 
6.3,2.5,5,1.9, 
6.5,3,5.2,2, 
6.2,3.4,5.4,2.3, 
5.9,3,5.1,1.8


};

vector<float> y {
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1,
1, 
1, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2, 
2    };

vector<float> W {
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5, 
0.5     


};

vector <float> sigmoid_d (const vector <float>& m1) {
    
    /*  Returns the value of the sigmoid function derivative f'(x) = f(x)(1 - f(x)), 
        where f(x) is sigmoid function.
        Input: m1, a vector.
        Output: x(1 - x) for every element of the input matrix m1.
    */
    
    const unsigned long VECTOR_SIZE = m1.size();
    vector <float> output (VECTOR_SIZE);
    
    
    for( unsigned i = 0; i != VECTOR_SIZE; ++i ) {
        output[ i ] = m1[ i ] * (1 - m1[ i ]);
    }
    
    return output;
}

vector <float> sigmoid (const vector <float>& m1) {
    
    /*  Returns the value of the sigmoid function f(x) = 1/(1 + e^-x).
        Input: m1, a vector.
        Output: 1/(1 + e^-x) for every element of the input matrix m1.
    */
    
    const unsigned long VECTOR_SIZE = m1.size();
    vector <float> output (VECTOR_SIZE);
    
    
    for( unsigned i = 0; i != VECTOR_SIZE; ++i ) {
        output[ i ] = 1 / (1 + exp(-m1[ i ]));
    }
    
    return output;
}

vector <float> operator+(const vector <float>& m1, const vector <float>& m2){
    
    /*  Returns the elementwise sum of two vectors.
        Inputs: 
            m1: a vector
            m2: a vector
        Output: a vector, sum of the vectors m1 and m2.
    */
    
    const unsigned long VECTOR_SIZE = m1.size();
    vector <float> sum (VECTOR_SIZE);
    
    for (unsigned i = 0; i != VECTOR_SIZE; ++i){
        sum[i] = m1[i] + m2[i];
    };
    
    return sum;
}

vector <float> operator-(const vector <float>& m1, const vector <float>& m2){
    
    /*  Returns the difference between two vectors.
        Inputs:
            m1: vector
            m2: vector
        Output: vector, m1 - m2, difference between two vectors m1 and m2.
    */
    
    const unsigned long VECTOR_SIZE = m1.size();
    vector <float> difference (VECTOR_SIZE);
    
    for (unsigned i = 0; i != VECTOR_SIZE; ++i){
        difference[i] = m1[i] - m2[i];
    };
    
    return difference;
}

vector <float> operator*(const vector <float>& m1, const vector <float>& m2){
    
    /*  Returns the product of two vectors (elementwise multiplication).
        Inputs:
            m1: vector
            m2: vector
        Output: vector, m1 * m2, product of two vectors m1 and m2
    */
    
    const unsigned long VECTOR_SIZE = m1.size();
    vector <float> product (VECTOR_SIZE);
    
    for (unsigned i = 0; i != VECTOR_SIZE; ++i){
        product[i] = m1[i] * m2[i];
    };
    
    return product;
}

vector <float> transpose (float *m, const int C, const int R) {
    
    /*  Returns a transpose matrix of input matrix.
        Inputs:
            m: vector, input matrix
            C: int, number of columns in the input matrix
            R: int, number of rows in the input matrix
        Output: vector, transpose matrix mT of input matrix m
    */
    
    vector <float> mT (C*R);
    
    for(unsigned n = 0; n != C*R; n++) {
        unsigned i = n/C;
        unsigned j = n%C;
        mT[n] = m[R*j + i];
    }
    
    return mT;
}

vector <float> dot (const vector <float>& m1, const vector <float>& m2, const int m1_rows, const int m1_columns, const int m2_columns) {
    
    /*  Returns the product of two matrices: m1 x m2.
        Inputs:
            m1: vector, left matrix of size m1_rows x m1_columns
            m2: vector, right matrix of size m1_columns x m2_columns (the number of rows in the right matrix 
                must be equal to the number of the columns in the left one)
            m1_rows: int, number of rows in the left matrix m1
            m1_columns: int, number of columns in the left matrix m1
            m2_columns: int, number of columns in the right matrix m2
        Output: vector, m1 * m2, product of two vectors m1 and m2, a matrix of size m1_rows x m2_columns
    */
    
    vector <float> output (m1_rows*m2_columns);
    
    for( int row = 0; row != m1_rows; ++row ) {
        for( int col = 0; col != m2_columns; ++col ) {
            output[ row * m2_columns + col ] = 0.f;
            for( int k = 0; k != m1_columns; ++k ) {
                output[ row * m2_columns + col ] += m1[ row * m1_columns + k ] * m2[ k * m2_columns + col ];
            }
        }
    }
    
    return output;
}

void print ( const vector <float>& m, int n_rows, int n_columns ) {
    
    
    for( int i = 0; i != n_rows; ++i ) {
        for( int j = 0; j != n_columns; ++j ) {
            cout << m[ i * n_columns + j ] << " ";
        }
        cout << '\n';
    }
    cout << endl;
}

int main(int argc, const char * argv[]) {
   
clock_t t;
  int f;
  t = clock();


///actual core code 
    for (unsigned i = 0; i != 50; ++i) {
        
        vector<float> pred = sigmoid(dot(X, W, 4, 4, 1 ) );
        vector<float> pred_error = y - pred;        
        vector<float> pred_delta = pred_error * sigmoid_d(pred);        
        vector<float> W_delta = dot(transpose( &X[0], 4, 4 ), pred_delta, 4, 4, 1);        
        W = W + W_delta;
        
        if (i == 49){
            print ( pred, 50, 1 );
        };
    };
t = clock() - t;
printf ("It took me %d clicks (%f seconds).\n",t,((float)t)/CLOCKS_PER_SEC);
    return 0;
}
