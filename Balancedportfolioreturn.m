rr=[]
% build a balanced portfolio
for m = 1:40
    s1(1,m) = 0.025
end

% Calculate the realized return of using a balanced portfolio from 2005 to 2019
for t = 1:15
 for i = 1:12
     for j = 1:40
         monthly_R1(i,j) = all(60+i+12*(t-1),j)% get each yeas' monthly return
     end
 end
mu1 = exp(mean(log(monthly_R1)))' % Geometric mean of monthly return of 40 assets per year
rr = [rr mu1'*s1']
end
