while true
    % Prompt the user to choose a method
    disp('Choose a root-finding method:');
    disp('1. Graphing Method');
    disp('2. Incremental Method');
    disp('3. Bisection Method');
    disp('4. Regula Falsi Method');
    disp('5. Fixed Point Method');
    disp('6. Newton Raphson Method');
    disp('7. Secant Method');
    method = input('Enter the number corresponding to your choice: ');

    switch method
        case 1
            graphing;
        case 2
            incremental;
        case 3
            bisection;
        case 4
            regula;
        case 5
            fixed;
        case 6
            newton;
        case 7
            secant;
        otherwise
            disp('Invalid choice. Please enter a number between 1 and 7.');
    end

    % Ask if the user wants to calculate again
    choice = input('Do you want to calculate again? [y]es/[n]o: ', 's');
    if ~strcmpi(choice, 'y') && ~strcmpi(choice, 'yes')
        disp('EXIT.....');
        break; % Exit the loop if the user does not want to calculate again
    end
end
