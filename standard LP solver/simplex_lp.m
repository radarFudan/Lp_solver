function [mat, feasible, opt_x, opt_value, x_0,steps_1, steps_2] = simplex_lp(A, b, c)

[m,n] = size(A);


%% Phase I
phase = 1;

c_0 = [zeros(n,1);ones(m,1)]; % objective function coefficient for phase I
% z_0 = [zeros(n,1);b]; % initial value for phase I(z_0 = [x_0; + y_0], y_0 equals to b while x_0 = 0.)
index = [(n+1):(n+m)].'; % index is the column index for the basis B.

[mat, feasible, steps_1] = simplex_lp_with_basic_feasible_solution([A,eye(m)], b, c_0, phase, index);

m = size(mat, 1) - 2; % Update the number of constraints because I eliminate the unnecessary ones. 
x_0 = zeros(n, 1); % x_0 is the intial basic feasible solution we get from Phase I.
for i = 1:m
    x_0(mat(i+2,1)) = mat(i+2,2);
end
% I don't use x_0 in the following program. But the x_0 stores the basic feasible solution we get from phase I. 

if abs(mat(2, 2)) >= 1e-12
    feasible = 1;
    opt_x = nan(n, 1);
    opt_value = Inf;
    steps_2 = 0;
    return;
end


%% Phase II
phase = 2;

new_A = mat(3:(m+2),3:(n+2)); % Inherit the data from Phase I to reduce complexity.
new_b = mat(3:(m+2),2); 
index = mat(3:(m+2),1)

[mat, feasible_opt, steps_2] = simplex_lp_with_basic_feasible_solution(new_A, new_b, c, phase, index);

opt_x = zeros(n, 1);
for i = 3:(m+2)
    opt_x(mat(i,1)) = mat(i,2);
end
opt_value = c' * opt_x;
