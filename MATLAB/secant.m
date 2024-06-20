disp('SECANT METHOD');
% Define the function
disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
eq_str = input('f(x) = ', 's');
    
% Replace 'e' or 'Euler' with the numerical value
eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

f = str2func(['@(x)' eq_str]);

% Input initial guesses and tolerance
x0 = input('Enter the initial guess x0: ');
x1 = input('Enter the initial guess x1: ');
tol = 0.001; % Set tolerance to 0.001

% Initialize array to store iteration data
iteration_info = [];

% Initialize variables for the secant method
iterations = 0;
error = abs(x1 - x0);

while error > tol
    iterations = iterations + 1;
    fx0 = f(x0);
    fx1 = f(x1);
    denominator = fx0 - fx1;
    
    if denominator == 0
        disp('Division by zero encountered. Exiting.');
        break;
    end
    
    numerator = fx1 * (x0 - x1);
    x2 = x1 - numerator / denominator;
    fx2 = f(x2);

    % Store iteration information
    iteration_info(end+1, :) = [iterations, x0, x1, x2, fx0, fx1, fx2, error];

    % Update variables for next iteration
    error = abs(x2 - x1);
    x0 = x1;
    x1 = x2;
end

% Print a separator line
fprintf('----------------------------------------\n');

% Display the iteration information in a table
fprintf('Iteration information:\n');
iteration_table = array2table(iteration_info, 'VariableNames', {'Iteration', 'x0', 'x1', 'x2', 'f(x0)', 'f(x1)', 'f(x2)', 'Error'});
disp(iteration_table);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the root
fprintf('Root:\n');
fprintf('x = %f\n', x2);

% Plot the function and the root
clf;
fplot(f, [x0-1, x1+1]);
hold on;
plot(x2, f(x2), 'ro', 'MarkerSize', 8); % Plot the root
title('Secant Method');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');
