disp('GRAPHING METHOD');
% Define the function
disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
eq_str = input('f(x) = ', 's');

% Replace 'e' or 'Euler' with the numerical value
eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

f = str2func(['@(x)' eq_str]);

% Input initial value for x and step size
valX = input('Enter the initial x value: ');
step = 0.2; % Step size for graphing method

% Initialize variables
currX = valX + step;
currY = f(currX);
prevY = f(valX);
signChange = false;

% Store iteration information
iteration_info = [];
iterations = 0;

while ~signChange
    iterations = iterations + 1;
    
    % Store current X and Y values
    iteration_info(end+1, :) = [currX, currY];
    
    if prevY * currY < 0
        % Root finding using false position method
        tolerance = 0.001;
        lowerBound = currX - step;
        upperBound = currX;
        root = 0;

        while abs(upperBound - lowerBound) > tolerance
            root = (lowerBound * f(upperBound) - upperBound * f(lowerBound)) / (f(upperBound) - f(lowerBound));
            fA = f(lowerBound);
            fC = f(root);

            if fC == 0.0
                break;
            elseif fA * fC < 0
                upperBound = root;
            else
                lowerBound = root;
            end
        end

        rootVal = root;
        signChange = true; % Exit the loop as root is found
    else
        prevY = currY;
        currX = currX + step;
        currY = f(currX);
    end
end

% Print a separator line
fprintf('----------------------------------------\n');

% Display the iteration information in a table
fprintf('Iteration information:\n');
iteration_table = array2table(iteration_info, 'VariableNames', {'X', 'Y'});
disp(iteration_table);

% Print a separator line
fprintf('----------------------------------------\n');

% Display the root
fprintf('Root found at:\n');
disp(rootVal);

% Define bounds for plotting
xL = valX;
xU = currX;
xR = rootVal;

% Plot the function and the root
clf;
fplot(f, [xL-1, xU+1]);
hold on;
plot(xR, f(xR), 'ro', 'MarkerSize', 8); % Plot the root
title('Graphing Method');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Function', 'Root');
