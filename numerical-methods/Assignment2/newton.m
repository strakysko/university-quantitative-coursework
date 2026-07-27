function [x,res,xvec,resvec,iter] = newton(f,df,x0,maxiter,tol)
% This is not an assignment function. This is a function I downloaded from
% canvas and did not change it further. It just serves for calculation of
% the XVEC for the driver file.

  % Error check on maxiter
  if (maxiter<0)
    error('Error in newton.m: maxiter should be a positive integer');
  end

  % Error check on tol
  if tol<eps
    msg = sprintf('Error in newton.m: tol should be a positive number greater than or equal to %e',eps);
    error(msg');
  end

  % Initial guess 
  x = x0;

  % This variable will contain x_(k+1) - x_k and it is used
  % to test convergence
  dx = tol + 1; 

  % Initial residual
  res = abs(f(x));

  % Main iterator
  k = 0;

  % Allocate and initialise approximation history 
  xvec = zeros(maxiter+1,1); 
  xvec(1) = x;

  % Allocate and initialise residual history 
  resvec = zeros(maxiter+1,1); 
  resvec(1) = res;

  % Main loop
  while (k < maxiter) && (abs(dx) > tol)

    % Update dx
    dx = -f(x)/df(x);

    % Update x
    x = x + dx;

    % Update residual
    res = abs(f(x));

    % Update iterator
    k = k+1;

    % Update histories
    xvec(k+1) = x;
    resvec(k+1) = res;

  end

  % Trim histories
  xvec = xvec(1:k+1);
  resvec = resvec(1:k+1);
  iter = k;


end
