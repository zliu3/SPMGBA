function [df, K] = k2gaussian(X,Xt, y, h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%distribution feature and gaussian kernel matrix.
% X is the input component and can be a low dimensional matrix
% y is the binary classification problem 1/0 or 1/-1, it is the training
% label.
%df is the density feature and K is kernel
%writen by Zhenqiu liu
%Cedars-Sinai Medical Center
%09/15/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n, d] = size(X);
[nt, dt] = size(Xt);

if d ~= dt,
    error('The dimension of training and test data are not the same');
end


if nargin < 4,
    sig = std(X);
    c = (4/((2+d)*n))^(1/(d+4));
    h = c*sig;
end
K = ones(n, nt);
for j =1:d,
    K = K.* K_gaussian(X(:,j), Xt(:,j), h(j));
end
j1 = find(y==1);
K1 = K(j1, :);
j0 = find(y~=1);
K0 = K(j0,:);
df = log(sum(K1)./sum(K0))-((n-1)/n)*log(length(j1)/length(j0));
df = df(:);
end

