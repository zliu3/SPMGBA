function [df, K] = kqardratic(x, y, h, choice)
%%distribution feature and quadratic kernel matrix.
% X is the input component and can be a low dimensional matrix
% y is the binary classification problem 1/0 or 1/-1
%df is the density feature and K is kernel
%writen by Zhenqiu liu
%Cedars-Sinai Medical Center
%09/15/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n, d] = size(x);
if d ~= 1,
    error('x has to be a vector\n');
end

if nargin < 4,
    choice =1;
end

if nargin < 3,
    sig = std(x);
    c = 2.7799*n^(-1/5);
    h = c*sig;
end

kd = kdist(x, x, h);

kd(kd>=1) = 0;
K = (1-kd);

if choice ~=1, % leave-one-out cross validation
    Kk = K - diag(diag(K));
else
   Kk = K;
end


 j1 = find(y==1);
 K1 = Kk(:, j1);
 j0 = find(y~=1);
 K0 = Kk(:, j0);
 df = log(sum(K1,2)./sum(K0,2));

end
