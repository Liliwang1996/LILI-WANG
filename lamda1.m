all = csvread ('assets return.csv',3,1) % read data
xx = [];rr=[];stdv=[];
% get historical data from 2000-2004 
  for i = 1:60
     for j = 1:40
         monthly_R1(i,j) = all(i,j)
     end
  end
  mu1 = exp(mean(log(monthly_R1)))' % mu1 is expected return of 40 assets 
  cov1 = cov(monthly_R1) % cov1 is the covariance matrix of 40 assets

  % set range of values of lamda
  lamda = [0.01,0.5,0.75,1.5,3,5,7,12,15,20,25,30,35,40,45,50]
  e = ones(40,1)
  for p=1:length(lamda)
    R = lamda(p);
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
