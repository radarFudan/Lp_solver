function [mat, feasible, steps] = simplex_lp_with_basic_feasible_solution(A, b, c, phase, index)

feasible = 0;
    % feasible = 0 denotes the problme is solvable, the return value is finite.
    % For phase I, feasible = 1 means the feasible set is empty and the infimum will be inf
    % For phase II, feasible = -1 means there is a feasible direction with negative cost, then the infimum will be -\infty
steps = 0;
[m,n] = size(A);

mat = [-233, -233, 1:n; -233, -c(index)' * b, c'-c(index)' * A; index, b, A];

indicator = sum(mat(2,3:(n+2)) < 0);
while sum(mat(2,3:(n+2)) < 0) > 0
    mark = 0; min = 0;
    for i = 3:(n+2)
        if mat(2, i) < min % Find the direction with the negative reduced cost.
            mark = i-2;
            min = mat(2, i);
        end
    end
    new = mark; % The new column in.

    mark = 0;ratio = 100000; % Just make ratio really big.
    for i = 3:(m+2)
        if mat(i, new + 2) > 0 
            if mat(i,2)/mat(i,new+2) < ratio % Find the maximum distance possible for move. The maximum distrance to move is associated with the minimum of the ratio
                mark = i - 2;
                ratio = mat(i,2)/mat(i,new+2);
            end
        end
    end

    if mark == 0
        feasible = -1; % It means that, according to P90 3. the optimal cost is -infty. 
        break; 
    end
    old = mark; % The old column out.

    mat = mat_update(mat, old, new, m, n);
    steps = steps + 1;
    indicator = sum(mat(2,3:(n+2)) < 0);
end



% In phase I, we need to drive artificial variables out of the basis. 

if phase == 1
while (sum(mat(3:(m+2),1) > n-m) > 0) % index > n are all artifical variables
    mark = 0;
    for i = 3:(m+2)
        if mat(i,1) > n-m
            mark = i-2;
            break;
        end
    end
    old = mark; % The old column out.

    mark = 0;
    for i = 3:(n-m+2)
        if abs(mat(old+2, i)) >= 1e-14 % I'll take value greater than 1e-14 as not zero to deal with issues related to accuracy. 
            mark = i - 2;
            break;
        end
    end        
    if mark == 0
        % We use this part to handle those unnecessary constraint.
        mat(old+2,:) = [];
        m = m - 1; n = n - 1;
        continue; 
    end
    new = mark; % The new column in.

    mat = mat_update(mat, old, new, m, n);
    steps = steps + 1;
end
end





%% old column exits while new column enters.

function mat = mat_update(mat, old, new, m, n) 
    mat(old+2,2:(n+2)) = mat(old+2,2:(n+2)) / mat(old+2,new+2);

    for i = 2:(m+2)
        if ne(i, old + 2)
            mat(i,2:(n+2)) = mat(i,2:(n+2)) - mat(i,new+2) * mat(old+2,2:(n+2));
        end
    end

    mat(old+2,1) = new; % Update the B's column info
