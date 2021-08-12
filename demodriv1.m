load demodata;
X = snpv;  %genotype matrix

ugid = unique(gids);

for i =1:length(ugid)
    J = find(strcmp(gids, ugid{i}));
    %Nonlinear feature with leave-one-out for kernel bandwidth h
    Z = X(:, J); df =kgaussopt(Z, Y, 2);  
    % estimating the coefficients with logistic regression without
    % constant
    [b, dummy, stats] = glmfit(df, Y, 'binomial', 'constant', 'off');
    geneid = ugid{i}
    estimatedBeta = b
    Pvalue = stats.p
end
    

