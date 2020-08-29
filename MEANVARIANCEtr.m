all = csvread ('assets return.csv',3,1) % read data

% set target return for 15 years
TR=[1.024,1.02,1.022,1.024,1.016,1.018,1.02,1.01,1.024,1.02,1.022,1.022,1.02,1.022,1.024]
xx = [];rr=[];stdv=[];var=[];

for t = 1:15
 for i = 1:60
     for j = 1:40
         monthly_R1(i,j) = all((t-1)*12+i,j)
     end
 end

mu1 = exp(mean(log(monthly_R1)))' 
cov1 = cov(monthly_R1)



e = ones(40,1)
 R = TR(t);
 cvx_begin;
  variable x(length(mu1))
  minimize (x' * cov1 * x)
  subject to
    mu1'*x >= R;
    e'*x == 1;
    x>= 0;
 cvx_end

xx = [xx x]
rr = [rr mu1'*x]
stdv = [stdv sqrt(x'*cov1*x)]
end





