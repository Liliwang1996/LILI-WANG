re = []
all = csvread ('assets return.csv',3,1)
for w = 1:15
 for m = 1:12
     for n = 1:40
         R1(m,n) = all(60+12*(w-1)+m,n)
     end
 end
 mu = exp(mean(log(R1)))'
 
 % xx is the optimal portfolio from the model
 ret = mu'*xx(:,w)
 re = [re ret]
end