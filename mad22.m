all = csvread ('assets return.csv',3,1)
xx = [];rr=[];mad=[];
% get historical monthly data from 2000-2004
 for i = 1:60
    for j = 1:40
        monthly_R1(i,j) = all(i,j)
    end
 end
 % geometric mean of five-year monthly return
 month_mu = exp(mean(log(monthly_R1)))'
 % arithmetic mean of five-year monthly return
 month_mean_mu = mean(monthly_R1)'

 % set range of lamda values 
 lamda = [0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,...
     0.009,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.1,0.5,2,3,50]
 e = ones(40,1)
  
 for p=1:length(lamda)
   R = lamda(p);
  cvx_begin;
   variable x(length(month_mu))
   maximize (month_mu'*x - R*norm(monthly_R1*x-month_mean_mu'*x,1))
   subject to
     e'*x == 1;
     x>= 0;
   cvx_end

  xx = [xx x];
  rr = [rr month_mu'*x]
  mad = [mad norm(monthly_R1*x-month_mean_mu'*x,1)]
  end
