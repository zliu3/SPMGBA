load fisheriris
X = meas(51:end,:); % versicolor and virginica
%X = X(:, [3,4]);

y = strcmp('versicolor',species(51:end));
mdl = fitglm(X,y,'linear','distr','binomial');
Xn =[];

F1 =[];
F0 =[];
X1 =X(y==1,:);
X0 = X(y==0, :);

%Xn2 =[];
for i=1:size(X,2);
    h = opt_h(X(:,i), y)
    K  = Ksgauss(X(:,i), X(:, i), h);
    j1 = find(y==1);
    K1 = K(:, j1);
    j0 = find(y~=1);
    K0 = K(:, j0);
    df= log(sum(K1,2)./sum(K0,2));
    Xn = [Xn, df];
    fn = sum(K1, 2)./sum(K, 2);
    fn1 = fn(j1);
    fn0 = 1-fn(j0);
    F1 =[F1, fn1];
    F0 =[F0, fn0];
 %   [df2, K2] = kqardratic(X(:, i),y);
 %   Xn2 =[Xn2, df2];
end

for i=1:4,
    subplot(2,2,i),
    plot(X1(:,i), F1(:,i), 'r.');
    hold on;
    plot(X0(:,i), F0(:,i), 'b.');
    hold off;
end


%Xn = Xn(:,[3:4]);
mdn = fitglm(Xn,y,'linear', 'distr', 'binomial','Intercept', false);
%mdn2 = fitglm(Xn2,y,'linear', 'distr', 'binomial','Intercept', false);
