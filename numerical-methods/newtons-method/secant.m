function [zero,x,res,niter]=secant(fun,x1,x0,nmax,tol,varargin)
%SECANT Finds function zeros.
% ZERO=SECANT(FUN,X1,X0,NMAX,TOL,P1,P2,...) tries to find the
% zero ZERO of the continuous and differentiable
% function FUN nearest to a real number X1 using the Secant Method.
% FUN accepts a function handle with real numbers and parameters P1, P2,...
% The real number X0 is another x in the domain of FUN, such that X0 is
% close to the zero to be found. Inputs X1 and X0 need to be sufficiently
% close to the zero, which we want to approximate, for Secant to converge.
% The positive integer NMAX determines the maximal number of iterations of the Secant
% Method. The tolerance TOL is defined as the distance of two last iterates
% in the sequence produced by the Secant Method. The Secant Method iterates
% until the tolerance TOL or the maximal number of iterations NMAX is reached.
% If NMAX is reached, without TOL being met, then a failor message shows up.
%
% [ZERO,X,RES,NMAX]=SECANT(FUN,...) returns an approximation ZERO of a zero,
% a column vector X consisting of approximations of zero for each iteration
% of the Secant Method, the residual RES in ZERO and the iteration number 
% NITER at which ZERO was computed. Assuming the toleration was met.
%
% ZERO=SECANT(FUN,X1,X0) approximates a zero of a function FUN with
% default arguments TOL=1e-5 and NMAX = 100.

format long;

% default values
if nargin < 4
    nmax = 100;
    tol = 1e-5;
elseif nargin < 5
    tol = 1e-5;
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
niter = 0;      diff = tol+1;       x(niter+1) = x1;

% Iterator repeating until the tolerance TOL or number of iterations NITER
% is reached.
while diff >= tol & niter < nmax
    niter = niter + 1;
    fx0 = feval(fun,x0,varargin{:});
    fx1 = feval(fun,x1,varargin{:});
    dfx = (fx1 - fx0)/(x1 - x0);
    
    if (dfx == 0)
        disp('Stopped due to vanishing derivative.');
        return; 
    end
    
    diff = - fx1/dfx;       x0 = x1;
    x1 = x1 + diff;         x(niter+1) = x1; 
    diff = abs(diff);
end

% The failor message that shows up when the tolerance TOL is not reached in
% NITER iterations.
if (niter==nmax & diff > tol)
    fprintf(['The Secant Method stopped without achieving',...
    ' the desired tolerance because the maximum ',...
    'number of iterations was reached.\n']);
end

% Defines outputs
zero = x1; res = feval(fun,x1,varargin{:}); x = x';
return