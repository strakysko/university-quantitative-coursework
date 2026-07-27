%% Exercise 2 - Solving the Korteweg-de Vries equation

% Define initial condition with lambda = 1000
u0 = @(x) 1000/2 * (cosh(sqrt(1000)*x/2)).^(-2);

[t,x,U] = solver(u0,1,10,4,11)

% Define initial condition with lambda = 10000
u0 = @(x) 1000/2 * (cosh(sqrt(1000)*x/2)).^(-2);

[t,x,U] = solver(u0,10,100,40,110)