disp('NEWTON RAPHSON METHOD');
% Define the function
disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
eq_str = input('f(x) = ', 's');

% Replace 'e' or 'Euler' with the numerical value
eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

f = str2func(['@(x)' eq_str]);

% Define the function to differentiate
differentiateFunction = @(xValue) (f(xValue + 0.000001) - f(xValue)) / 0.000001;

% Input initial guess and tolerance
x0 = input('Enter the initial guess x0: ');
tol = 0.001; % Set tolerance to 0.001

% Initialize array to store iteration data
iteration_info = [];

% Initialize variables for the Newton-Raphson method
iterations = 0;
error = Inf;

while error > tol
    iterations = iterations + 1;
    fx0 = f(x0);
    fDashX0 = differentiateFunction(x0);
    
    % Newton-Raphson formula for finding next approximation
    x1 = x0 - (fx0 / fDashX0);
    fx1 = f(x1);
    
    % Calculate error
    if iterations == 1
        prevX0 = NaN;
    else
        prevX0 = iteration_info(end, 4);
    end
    error = abs(x1 - prevX0) / abs(x1) * 100;
    
    % Format numbers for display (not strictly necessary for calculations)
    decimalnumX0 = x0;
    decimalnumX1 = x1;
    decimalnumFX0 = fx0;
    decimalnumFX1 = fx1;
    decimalnumError = error;
    
    % Store iteration information
    iteration_info(end+1, :) = [iterations, decimalnumX0, decimalnumFX0, decimalnumX1, decimalnumFX1, decimalnumError];
    
    x0 = x1;
end

% Print a separator line
fprintf('----------------------------------------\n');

% Display the iteration information in a table
fprintf('Iteration information:\n');
iteration_table = array2table(iteration_info, 'VariableNames', {'Iteration', 'x0', 'f(x0)', 'x1', 'f(x1)', 'Error'});
disp(iteration_table);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the root
fprintf('Root:\n');
fprintf('x = %f\n', x1);

 % Plot the function and the root
clf;
fplot(f, [xL-1, xU+1]);
hold on;
plot(xR, f(xR), 'ro', 'MarkerSize', 8); % Plot the root
title('Newton Raphson Method');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');
