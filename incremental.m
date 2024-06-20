disp('INCREMENTAL METHOD');
% Define the function
disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
eq_str = input('f(x) = ', 's');
    
% Replace 'e' or 'Euler' with the numerical value
eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

f = str2func(['@(x)' eq_str]);

% Input range start [a], deltaX and tolerance
a = input('Enter the xL: ');
deltaX = input('Enter the deltaX: ');
tol = 0.001; % Set tolerance to 0.001

% Initialize array to store roots
roots = zeros(1, 1000); % Preallocate for a maximum of 1000 roots

% Counter for the number of roots found
root_count = 0;

% Store iteration information
iteration_info = [];

% Initialize variables for the incremental search method
xL = a;
xU = xL + deltaX;
iterations = 0;
prevXU = 0;
Error = abs(xU - prevXU) / abs(xU) * 100;

while Error > tol
    iterations = iterations + 1;
    fxL = f(xL);
    fxU = f(xU);
    positive = fxL * fxU;
    
    % Calculate error
    if iterations == 1
        currentError = NaN;
    else
        currentError = abs(xU - prevXU) / abs(xU) * 100;
    end
    
    % Store iteration information
    iteration_info(end+1, :) = [iterations, xL, deltaX, xU, fxL, fxU, currentError];
    
    if Error < tol && fxL * fxU == 0
        root_count = root_count + 1;
        roots(root_count) = xU;
        break;
    end
    
    if fxL * fxU < 0
        xL = xL;
        deltaX = deltaX / 10.0;
    else
        xL = xU;
    end
    
    prevXU = xU;
    xU = xL + deltaX;
    Error = abs(xU - prevXU) / abs(xU) * 100;
end

% Final root
root_count = root_count + 1;
roots(root_count) = xU;

% Trim the excess preallocated space
roots = roots(1:root_count);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the iteration information in a table
fprintf('Iteration information:\n');
iteration_table = array2table(iteration_info, 'VariableNames', {'Iteration', 'xl', 'deltaX', 'xu', 'f(xl)', 'f(xu)', 'Error'});
disp(iteration_table);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the roots
fprintf('Roots:\n');
disp(roots);

% Plot the function and the root
clf;
fplot(f, [xL-1, xU+1]);
hold on;
plot(xR, f(xR), 'ro', 'MarkerSize', 8); % Plot the root
title('Incremental Method');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');