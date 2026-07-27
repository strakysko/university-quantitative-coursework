function [] = attractor(min, max, N, K, L, x0)
%   ATTRACTOR plots limit points of a sequence for various lambda values.
%
%   []=ATTRACTOR(MIN, MAX, N, K, L, X0) plots L approximations
%   of limit points of a sequence x_{n+1}=lambda*x_n*(1-x_n) for each 
%   lambda, such that there are N equally-distant lambdas from the interval
%   [MIN, MAX].
%   For every lambda, the sequence is iterated K times using an initial
%   value X0.
%   
%   The compulsory inputs are MIN and MAX, which determine an interval
%   [MIN, MAX] that is used for generation of lambdas. The restrictions for
%   values of MIN and MAX are 0 <= MIN <= MAX <= 4.
%   
%   The optional inputs are N, K, L and X0.
%   N is the number of lambdas that is generated from an interval
%   [MIN,MAX].
%   K is the number of iterations of a sequence, the bigger K, the
%   closer are the approximations of limit points to the actual limit
%   points.
%   L is the number of approximations of limit points of a 
%   sequence for every generated lambda.
%   X0 is the initial term in a sequence, with a restriction that 
%   0 <= X0 <= 1.
%
%   The output is a graph of an attractor, where the independent variable
%   is lambda, and the dependent variables are the approximations of limit
%   points of a sequence for each lambda.
%
%   The defaul values are:
%   N = 30000
%   K = 5000
%   L = 30
%   X0 = 0.5

% default values
if ~exist('N')
    N = 30000;
end

if ~exist('K')
    K = 5000;
end

if ~exist('L')
    L = 30;
end

if ~exist('x0')
    x0 = 0.5;
end

% generates N equally-distant lambdas from an interval [min, max]
lambdas = linspace(min, max, N);

% defines a sequence
seq = @(x,i) lambdas(i) * x * (1-x); 

% iterates for all lambdas
for i = 1:N
    x = x0;
    
    % iterates the sequence for a fixed lambda
    for k = 1:K
        x_n(k) = seq(x,i);
        x = x_n(k);
    end
    
    % assigns the last approximations of limiting points to a solution set
    % for a fixed lambda
    x_axis(1 + L * (i-1) :  L * i) = ...
        ones(1, L) * lambdas(i);
    y_axis(1 + L * (i-1) :  L * i) = ...
        ones(1,L) .* x_n(K - L + 1 : K);
end

% makes a plot
plot(x_axis, y_axis, '.');
xlabel('\lambda');
ylabel('Approximations of limit points of x_n');
title('Attractor of a sequence x_{n+1}=\lambdax_n(1-x_n)');
dim = [0.2 0.5 0.3 0.3];
str = {sprintf('N = %d', N), sprintf('iterations = %d', K), ...
    sprintf('buffer points = %d', L), sprintf('x_0 = %.2f', x0)};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

end