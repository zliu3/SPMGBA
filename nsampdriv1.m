load fisheriris
X = meas(51:end,:); % versicolor and virginica
X = X(:, [3,4]);

y = strcmp('versicolor',species(51:end));
mdl = fitglm(X,y,'linear','distr','binomial');
Xn =[];
Xn2 =[];
for i=1:size(X,2);
    [df,K] = kgaussian(X(:,i), y);
    Xn = [Xn, df];
    [df2, K2] = kqardratic(X(:, i),y);
    Xn2 =[Xn2, df2];
end

%Xn = Xn(:,[3:4]);
mdn = fitglm(Xn,y,'linear', 'distr', 'binomial','Intercept', false);
mdn2 = fitglm(Xn2,y,'linear', 'distr', 'binomial','Intercept', false);