function [df, K, H] = kgaussmopt(X, y, choice)
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

if nargin < 3,
    choice =1;
end

K = ones(n, n);
H = zeros(d,1);
for j =1:d,
    h = opt_h(X(:,j), y);
    K = K.* K_gaussian(X(:,j), X(:,j), h);
    H(j) = h;
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

