load fisheriris
X = meas(51:end,:); % versicolor and virginica
X = X(:, [3,4]);

y = strcmp('versicolor',species(51:end));
mdl = fitglm(X,y,'linear','distr','binomial');
[w, s2] = logisticregp(X, y, 0.1);