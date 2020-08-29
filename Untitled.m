all = csvread ('assets return.csv',3,1) % read data
% choose monthly return data from 2000-2004
for i = 1:60
    for j = 1:40
         monthly_R1(i,j) = all(i,j)
    end
end
mu1 = exp(mean(log(monthly_R1)))' % Geometric mean of monthly returns of 40 assets
cov1 = cov(monthly_R1) % Covariance matrix of 40 assets

% set range of values to use for target return R
RR = [1.01:0.002:1.05]
e = ones(40,1)
xx = [];rr=[];stdv=[];

for p=1:length(RR)
R = RR(p);
cvx_begin;
  variable x(length(mu1))
  minimize (x' * cov1 * x)
  subject to
    mu1'*x >= R;
    e'*x == 1;
    x>= 0;
cvx_end
% record results
xx = [xx x]
rr = [rr mu1'*x]
stdv = [stdv sqrt(x'*cov1*x)]
end

figure(1);
plot(stdv, rr);
title('Efficient Frontier')
xlabel('Standard deviation')
ylabel('Return')




figure(2);
area(RR,xx');
title('Composition of effcient portfolios')
xlabel('R')
ylabel('Percent invested in different asset classes')
legend("F",	"JPM",	"INTC",	"HPQ",	"COP",	"PEP",	"DIS",	"NKE",	"WMT",	"FDX",	"0011.HK",	"0026.HK",	"0027.HK",	"0003.HK",	"0069.HK",	"600006.SS",	"600007.SS",	"600055.SS",	"000002.SZ",	"000063.SZ",	"000155.KS",	"005389.KS",	"6758.T",	"9984.T",	"RSA.L",	"IMB.L",	"ULVR.L",	"ADS.DE",	"BAYN.DE",	"C6L.SI",	"C76.SI",	"BKL.AX",	"COH.AX",	"CA.PA",	"RMS.PA",	"^GSPC",	"^HSI",	"RR=F",	"FSAIX",	"FREAX")

