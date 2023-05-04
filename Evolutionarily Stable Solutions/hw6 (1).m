
step = 0.01

p0 = [.2;.3;.5];
traj = zeros(1000,3);
Q = [0 -1*b a; a 0 -1*b; -1*b a 0];
p = p0;


RD = 0 %%%value 0 means BNN value 1 means RD
a = 1 
b = 2
if RD == 1
    for t = 1:10000
       traj(t,:) = p;
       qp = Q*p;
       dp = p.*(qp - transpose(p)*qp);
       p = p + 0.01*dp;
    end
    
else
    for t = 1:10000
       traj(t,:) = p;
       qp = Q*p;
       pqp = transpose(p)*qp;
       u = zeros(3,1);
       for j = 1:3;
          u(j) = max(qp(j) - pqp,0);
       end
       alpha = sum(u);
       dp = u - alpha*p;
       p = p + step*dp;;
    end
    
end

plot(traj)
ylim([-1 2])
