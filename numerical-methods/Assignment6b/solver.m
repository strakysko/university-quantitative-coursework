function [t,x,U] = solver(u0,L,T,S,N)

% Discretize the spatial variable X and time T
x = linspace(-L,L,N)';
t = linspace(0,T,S)';

% Determine the initial condition U0
U0 = u0(x);

% Find the spatial step h
h = 2*L/(N-1);

% Approximate the second derivative with centered differences
B = triu(ones(N),1) - triu(ones(N),2);
A = -2*eye(N) + B + B';
A(1,N) = 1;
A(N,1) = 1;
A = A*h^(-2);

% Approximate the first derivative with centered differences
C = triu(ones(N),1) - triu(ones(N),2);
D = - C + C';
D(1,N) = 1;
D(N,1) = -1;
D = D/(2*h);

% Define odefun
odefun = @(t,u) D*(A*u + 3*u);

[~,U] = ode45(odefun,t,U0);

surf(U)

end