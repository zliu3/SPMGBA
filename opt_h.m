function opth = opt_h(x, y)
% x: nxd matrix
% y: nx1 0/1 vector

% opth is any optimal scalor

y = (y==1);
opth = fminbnd(@(h) nloglik(x, y, h),0.01, 1000);

function  O1 = nloglik(x, y, h)
%Maximal likelihood with leave-one-out cross validation
K = Ksgauss(x,x, h);
n = size(K,1);
Kk = K - diag(diag(K));

j1 = find(y==1);
K1 = Kk(:, j1);
j0 = find(y~=1);
K0 = Kk(:, j0);

Ks = sum(Kk, 2);
K1s = sum(K1,2);
K0s = sum(K0, 2);

O1 = sum(log(Ks)) - sum(y.*log(K1s) + (1-y).*(log(K0s)));


function kval = Ksgauss(u,v,param)
nu = size(u,1);
nv = size(v,1);

norm_u = sqrt(sum(u.^2,2));
norm_v = sqrt(sum(v.^2,2));

k1 = u*v';

kval = exp(-0.5*(repmat(norm_u.^2,1,nv)-2*k1+repmat(norm_v'.^2,nu,1))/(param^2));

