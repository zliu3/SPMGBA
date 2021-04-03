load MSdataup;
Y = Yfg;
%Y = (Y==0);
age = (agegg > 60);
gender = strcmp('M', gendergg);
race = strcmp('Caucasian', racesg);
x1 = gcvg;
[n, m] = size(x1);
x1 = x1 - repmat(mean(x1), n,1);
%x1 = (x1- repmat(mean(x1), n,1))./repmat(std(x1), n, 1);
gn1 = gcidg';
x2 = snpnvg >1;  % different genetic model
j = find(var(x2) >0);
x2 = x2(:,j);
xs = sum(x2, 2);
gn2 = snpidg(j);
%x2 = (x2- repmat(mean(x2), n,1))./repmat(std(x2), n, 1);
x3=[age, race, gender];
gn3 ={'Age'; 'Race'; 'Gender'};
X1 =x1;
X2 =[x2, x3]
gn =[gn1; gn2; gn3];

B1 = L0qtl(X1, X2, Y, 1e-6, 1000, 1);
B2 = L0qtl(X1, X2, Y, 1e-6, 1000, 2);
B3 = L0qtl(X1, X2, Y, 1e-6, 1000, 3);


%save  sg2  X gn sgv sgn;


save gcqtlout B1 B2 B3 gn;
