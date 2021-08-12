# SPMGBA
Semiparametric methods for gene-based analysis with MATLAB
Main functions:

kgaussopt.m is the main function to calculate the distribution feature vector with an Input matrix X and class label Y.

opt_h.m to calculate the optimal bandwidth h  with maximum likelihood estimate and leave-one-out cross validation. Opt_h.m is called by kgaussian.m function.

K_gaussian.m: Gaussian kernel computation

demodriv1,m: An example  to run this script with the demo data  
