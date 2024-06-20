disp('REGULA FALSI METHOD');
% Define the function
disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
eq_str = input('f(x) = ', 's');

% Replace 'e' or 'Euler' with the numerical value
eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

f = str2func(['@(x)' eq_str]);

% Input range [xL, xU] and tolerance
xL = input('Enter the xL (lower bound): ');
xU = input('Enter the xU (upper bound): ');
tol = 0.001; % Set tolerance to 0.001

% Initialize variables
iterations = 0;
prevXU = 0;
Error = inf;

% Store iteration information
iteration_info = [];

while Error > tol
    iterations = iterations + 1;
    
    % Evaluate the function at xL and xU
    fxL = f(xL);
    fxU = f(xU);

    % Regula Falsi formula for finding next approximation
    xR = (fxU * xL - fxL * xU) / (fxU - fxL);
    fxR = f(xR);

    % Calculate error
    if iterations == 1
        currentError = NaN;
    else
        currentError = abs(xR - prevXU) / abs(xR) * 100;
    end
    
    % Store iteration information
    iteration_info(end+1, :) = [iterations, xL, xU, xR, fxR, currentError];
    
    % Update bounds based on Regula Falsi criteria
    if fxL * fxR < 0
        xU = xR;
    else
        xL = xR;
    end

    % Update previous xU and error
    prevXU = xR;
    Error = abs(fxR); % Error is based on the value of f(xR)
end

% Print a separator line
fprintf('----------------------------------------\n');

% Display the iteration information in a table
fprintf('Iteration information:\n');
iteration_table = array2table(iteration_info, 'VariableNames', {'Iteration', 'xL', 'xU', 'xR', 'f(xR)', 'Error'});
disp(iteration_table);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the root
fprintf('Root found at:\n');
disp(xR);

% Plot the function and the root
clf;
fplot(f, [xL-1, xU+1]);
hold on;
plot(xR, f(xR), 'ro', 'MarkerSize', 8); % Plot the root
title('Regula Falsi Method for Root Finding');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');

 % Plot the function and the root
clf;
fplot(f, [xL-1, xU+1]);
hold on;
plot(xR, f(xR), 'ro', 'MarkerSize', 8); % Plot the root
title('Regula Falsi Method');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');