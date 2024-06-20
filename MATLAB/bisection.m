function BisectionMethod()
    disp('BISECTION METHOD');
    
    % Define the function
    disp('Enter your equation in terms of x (use MATLAB syntax ex. x^3+x^2-4*x+1):')
    eq_str = input('f(x) = ', 's');

    % Replace 'e' or 'Euler' with the numerical value
    eq_str = strrep(eq_str, 'e', num2str(exp(1))); % 'e' to numerical value
    eq_str = strrep(eq_str, 'Euler', num2str(exp(1))); % 'Euler' to numerical value

    f = str2func(['@(x)' eq_str]);

    % Input range [a, b] and tolerance
    a = input('Enter the xL: ');
    b = input('Enter the xU: ');

    try
        % Increase resolution for better accuracy
        rangeEnd = round((b - a) * 10) + 1;
        functionValues = zeros(1, rangeEnd);
        xValues = linspace(a, b, rangeEnd);

        % Evaluate the function at each x-value and store the results in arrays
        for i = 1:rangeEnd
            functionValues(i) = f(xValues(i));
        end

        bracketing = [];
        for i = 1:(rangeEnd - 1)
            current = functionValues(i);
            next = functionValues(i + 1);
            currentX = xValues(i);
            nextX = xValues(i + 1);
            if sign(current) ~= sign(next)
                bounds = [currentX, nextX];
                bracketing = [bracketing; bounds];
            end
        end

        % Initialize variables
        iteration_info = [];
        roots = [];

        % Loop through each bracketing interval
        for k = 1:size(bracketing, 1)
            xL = bracketing(k, 1);
            xU = bracketing(k, 2);

            % Perform bisection for the current interval
            iteration = 0;
            prevXR = 0;

            while (xU - xL) > 0.001
                iteration = iteration + 1;
                xR = (xL + xU) / 2.0;
                fxL = f(xL);
                fxR = f(xR);
                fxU = f(xU);
                positive = fxL * fxU;

                if iteration == 1
                    currentError = " ";
                else
                    currentError = abs(xR - prevXR) / abs(xR) * 100;
                end

                % Store iteration information
                iteration_info(end+1, :) = [iteration, xL, xR, xU, fxL, fxU, currentError];

                if fxL * fxR < 0
                    xU = xR;
                else
                    xL = xR;
                end

                prevXR = xR;
                xR = (xL + xU) / 2.0;
            end

            % Final root
            roots(end+1) = (xL + xU) / 2.0;
        end

        % Print a separator line
        fprintf('----------------------------------------\n');

        % Display the iteration information in a table
        fprintf('Iteration information:\n');
        iteration_table = array2table(iteration_info, 'VariableNames', {'Iteration', 'xl', 'xr', 'xu', 'f(xl)', 'f(xu)', 'Error'});
        disp(iteration_table);

        % Print a separator line
        fprintf('----------------------------------------\n');

        % Display the roots
        fprintf('Roots:\n');
        disp(roots);

        % Plot the roots
        clf;
        fplot(f, [a-1, b+1]);
        hold on;
        plot(roots, arrayfun(f, roots), 'ro', 'MarkerSize', 8); % Using arrayfun to apply function to each root
        title('Bisection Method');
        xlabel('x');
        ylabel('f(x)');
        grid on;
        legend('Function', 'Roots');

    catch ex
        fprintf('Error: %s\n', ex.message);
    end
end
