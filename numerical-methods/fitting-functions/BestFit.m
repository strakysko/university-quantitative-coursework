function [exponents,constants,residue] = BestFit(data,guess)
% BESTFIT determines a best fit exponential function for a set of points.
%   [EXPONENTS, CONSTANTS, RESIDUE]=BestFit(DATA, GUESS) determines a best
%   fit exponential function of the form
%   f(x) = C_1*e^{\lambda_1*x} + ... + C_n*e^{\lambda_n*x} 
%   for a given set of points DATA using n guesses of lambdas given 
%   in the vector GUESS. The best fit function is determined using
%   the least square method. The function BESTFIT also plots both the data 
%   points and the determined function in one plot.
%   The input (m x 2) matrix DATA consists of a column of x values and 
%   a column of corresponding y values. The input vector GUESS of length n
%   consists of n real numbers which are guesses of corresponding 
%   n lambdas in the aforementioned function f(x).
%   The output vectors EXPONENTS and CONSTANTS both consist of n coefficients 
%   needed for construction of the best fit function f(x). The n real numbers
%   in the vector EXPONENTS correspond to n lambdas in the function f(x).
%   The n real numbers in the vector CONSTANTS correspond to n coefficients
%   C in the function f(x). The output RESIDUE is a sum of absolute 
%   differences between each data point and the best fit function f(x).

% calls functions to obtain EXPONENTS, CONSTANTS, and a RESIDUE
[exponents, residue] = fminsearch(@findConst,guess);
[~,constants] = findConst(exponents);
exponents = exponents';

% plots the data points DATA and the best fit function constructed
% from the found EXPONENTS, CONSTANTS, and a RESIDUE
x = min(data(:,1)):0.1:max(data(:,1));
plot(data(:,1),data(:,2),'.')
hold on
plot(x,bestFunc(x),'-','LineWidth',3)
title(["The best fit function of the form C_1e^{\lambda_1x}+...+C_ne^{\lambda_nx}",...
    "by the least square method"],'FontWeight','Normal');
xlabel('x-axis');     ylabel('y-axis');
legend('data','the best-fit function')
hold off

    function [residue, constants] = findConst(guess)
    % FINDCONST uses the least square method to find constants C_1,...,C_n
    %   for fixed exponents defined in GUESS. Also calculates the residue.
    
    m = length(data);
    n = length(guess);
    
    % constructs, for each data point in DATA, one row of a matrix 
    % corresponding to calculation of a residue of that data point and 
    % the best fit function, i.e. r_i = y_i - f(x_i,C).
    residue = zeros(m,n+1);
    for dataPoint = 1:m        
        for column = 1:n+1
            if column == 1
                residue(dataPoint,column) = data(dataPoint,2);
            else
                residue(dataPoint,column) = - exp(guess(column-1) ...
                    * data(dataPoint));
            end
        end
    end
    
    % notice that dS/dC_k = SUM(r_i^2) = 2*SUM(r_i * e^{lambda_k*x_i)
    %
    % Thus, for each constant, say constant k:
    % 1. muliplies each row i of residue by 2*e^{lambda_k*x_i}
    % 2. sums up the columns of the determined matrix in step 1 into a row
    %
    % the output is an (n x n+1) matrix LIN_EQUATIONS in which each row 
    % corresponds to one linear equation with coefficients C_1, ... ,C_n.
    lin_equations = zeros(n,n+1);
    for const = 1:n
        diff = residue;
        for row = 1:m
            diff(row,:) = -2*diff(row,:)*exp(guess(const)*data(row));
        end
        lin_equations(const,:) = sum(diff);
    end
    
    % equated the equations in LIN_EQUATIONS to zero and solves for C
    solutions = -1*lin_equations(:,1);
    lin_equations(:,1) = [];
    constants = linsolve(lin_equations,solutions);
    
    % calculates residue
    residue = 0;
    for data_row = 1:m
        func = 0;
        for const = 1:n
            func = func + constants(const)*exp(guess(const) ...
                * data(data_row,1));
        end
        residue = residue + abs(data(data_row,2) - func);
    end
    end

    function y = bestFunc(x)
    % BESTFUNC determines the value of the found best fit function for an x
        y = 0;
        for k = 1:length(constants)
            y = y + constants(k)*exp(exponents(k)*x);
        end
    end

end