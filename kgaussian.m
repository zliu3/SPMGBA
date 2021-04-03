function [df, K] = kgaussian(X, y, h, choice)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%distribution feature and gaussian kernel matrix.
% X is the input component and can be a low dimensional matrix
% y is the binary classification problem 1/0 or 1/-1
%df is the density feature and K is kernel
%writen by Zhenqiu liu
%Cedars-Sinai Medical Center
%09/15/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n, d] = size(X);

if nargin < 4,
    choice =1;
end

if nargin < 3,
    sig = std(X);
    c = (4/((2+d)*n))^(1/(d+4));
    h = c*sig;
end
K = ones(n, n);
for j =1:d,
    K = K.* K_gaussian(X(:,j), X(:,j), h(j));
end

if choice ~=1, % leave-one-out cross validation
    Kk = K - diag(diag(K));
else
   Kk = K;
end


 j1 = find(y==1);
 K1 = Kk(:, j1);
 j0 = find(y~=1);
 K0 = Kk(:, j0);
 df = log(sum(K1, 2)./sum(K0,2)) - ((n-1)/n)*log(length(j1)/length(j0));

end

