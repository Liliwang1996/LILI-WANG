all = csvread ('assets return.csv',3,1) % read data
xx = [];rr=[];mad=[];
for t = 1:15
  for i = 1:60
     for j = 1:40
         monthly_R1(i,j) = all((t-1)*12+i,j)
     end
  end
  
  month_mu = exp(mean(log(monthly_R1)))'
  month_mean_mu = mean(monthly_R1)'

  % R is the lamda value we choose
  R= 2
  e = ones(40,1)
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
