all = csvread ('assets return.csv',3,1) % read data
xx = [];rr=[];va=[];sp=[]
for t = 1:15
  for i = 1:60
     for j = 1:40
         monthly_R1(i,j) = all((t-1)*12+i,j)
     end
  end
  mu1 = exp(mean(log(monthly_R1)))'
  cov1 = cov(monthly_R1)

  R0 = 1.01 % risk-free return
  e = ones(40,1)
  s = mu1-R0*e

  cvx_begin;
   variable z(length(mu1))
   variable k
    minimize (z' * cov1 * z )
    subject to
     s'*z == 1
     e'*z == k
     k>0
     z>0
  cvx_end
  
  x=z/k
  xx = [xx x]
end
