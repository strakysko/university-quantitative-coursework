function [zero,x,res,niter,M]=modified(f,df,x0,nmax,tol,varargin)
%MODIFIED Finds a zero a function.
% ZERO=MODIFIED(F,FD,X0,NMAX,TOL,P1,P2,...) approximates a zero
% of a continuous and differentiable function F such that an approximation
% ZERO is nearest to X0, which is an initial guess of the zero.
% Inputs F and DF accept function handles with real numbers and 
% an arbitrary number of optional parameters P1, P2, etc.
% A positive integer NMAX is the maximal number of iterations of the
% Modified Newton's Method. A tolerance TOL is the distance of two last 
% approximations of the zero. Other inputs are considered to be values
% of parameters P1,P2,...
%
% [ZERO,X,RES,NITER,M]=SECANT(F,FD,X0,...) returns the approximation ZERO,
% a column vector X consisting of a sequence of approximations of the zero 
% for each iteration of the Modified Newton's Method, the residual RES in ZERO,
% the number of iterations NITER, and a column vector M that consists a
% sequence of approximations of multiplicity of the zero.
%
% ZERO=SECANT(FUN,X1,X0) approximates a zero of a function F with default
% inputs TOL=1e-10 and NMAX = 100.

format long;

% default values for inputs
if nargin < 4
    nmax = 100;
    tol = 1e-10;
elseif nargin < 5
    tol = 1e-10;
end

% Error check on NMAX
if (nmax<0)
  error('Error in secant.m: NMAX should be a positive integer.');
end

% Error check on TOL
if tol<eps
  msg = sprintf('Error in secant.m: TOL should be a positive number greater than or equal to %e',eps);
  error(msg');
end

% determines the initial values 
niter = 0;      diff = tol+1;       x(niter+1) = x0;

% Repeats until the tolerance TOL or the number of iterations NITER is 
% reached.
while diff >= tol & niter < nmax
    niter = niter + 1;
    fx = feval(f,x0,varargin{:});
    dfx = feval(df,x0,varargin{:});
    
    if (dfx == 0)
        disp('Stopped due to vanishing derivative.');
        return; 
    end
    
    if niter < 3
        % Three approximations of a zero are needed for formula for
        % approximation of zero multiplicity. Until then, the zero is
        % assumed to be simple.
        M(niter) = 1;
    else
        % Approximates the multiplicity of a zero.
        M(niter) = (x(niter-1)-x(niter-2))/(2*x(niter-1)-x(niter)-x(niter-2));
        
        % We assume the multiplicity of a zero cannot be less than 1.
        if M(niter)<1
            M(niter) = 1;
        end
    end
    
    % Uses the approximation M to calculate a next approximation of ZERO
    diff = - M(niter)*fx/dfx;       x0 = x0 + diff;
    x(niter+1) = x0;                diff = abs(diff);
end

% The failor message that shows up when the tolerance TOL is not reached in
% NITER iterations.
if (niter==nmax & diff > tol)
    fprintf(['The Modified Newton''s Method stopped without achieving',...
    ' the desired tolerance because the maximum ',...
    'number of iterations was reached.\n']);
end

% Determines outputs
zero = x0; res = feval(f,x0,varargin{:}); x = x'; M = M';
return