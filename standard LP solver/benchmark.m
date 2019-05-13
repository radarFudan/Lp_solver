load('test_student.mat');

options = optimoptions(@linprog,'Algorithm','dual-simplex','Display','iter');

%[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq,lb,[],options);
[x,fval,exitflag,output] = linprog(c, -eye(100) ,zeros(100, 1), A, b, -inf(100,1), inf(100,1), options)

% [x,fval,exitflag,output] = linprog(c, -eye(n) ,zeros(n, 1), A, b, -inf(n,1), inf(n,1), options)
