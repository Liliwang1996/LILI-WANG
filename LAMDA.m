all = csvread ('assets return.csv',3,1)
xx = [];rr=[];stdv=[];
for t = 1:15
  for i = 1:60
     for j = 1:40
         monthly_R1(i,j) = all((t-1)*12+i,j)
     end
  end
  mu1 = exp(mean(log(monthly_R1)))'
  cov1 = cov(monthly_R1)

  % R is the value of lamda we choose
  R = 50
  e = ones(40,1)

  cvx_begin;
   variable x(length(mu1))
    maximize (mu1'*x- R*x'*cov1*x)
    subject to
     e'*x == 1;
     x>= 0;
  cvx_end

xx = [xx x]
rr = [rr mu1'*x]
stdv = [stdv sqrt(x'*cov1*x)]
 
end
