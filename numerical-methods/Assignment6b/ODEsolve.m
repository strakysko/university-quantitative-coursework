function [T,U] = ODEsolve(fun,S,u0,theta,h)
%ODESOLVE solves initial value problem of nonlinear ODEs.
%
%   ODESOLVE attempts to solve initial value problem of ODEs of the form:
%             
%   U' = FUN(U)
%   U(0) = U0
%
%   where FUN may be a vector or a matrix, and U is a vector.   
%
%   ODESOLVE implements three different methods: forward Euler method,
%   backward Euler method, and Crank-Nicolson method. Choose parameter
%   THETA in [0,1]. Choose THETA = 0 for the forward Euler method, 
%   THETA = 1 for the backward Euler method, or THETA = 1/2 for the
%   Crank-Nicolson method.
%
%   [T,U] = ODESOLVE(FUN,S,U0,THETA,H) starts at the initial value U0 and 
%   tries to solve U' = FUN(U). If vector S contains two values, then these
%   two values define an interval of times at which U is evaluated. If
%   vector S contains more than two values, then U is evaluated for all the
%   values in S. The time step H discretizes the time axis. The vector T
%   consists of times at which U is evaluated. U may be a vector or a
%   Matrix such that every column corresponds to one variable and every row
%   corresponds to a time in T.

% discretizes S with step size h (including the greatest element of S)
T = min(S) : h : max(S) + h;

% Find U for all points in time in T
U(:,1) = u0;
for n = 2:length(T)
    
    % Solve for x = u_{n+1}
    f = @(x) x -  U(:,n-1) - h*((1-theta)*fun(T(n-1),U(:,n-1)) + theta*...
        fun(T(n-1),x));
    U(:,n) = fsolve(f,U(:,n-1),optimset('Display','off'));
end

% Find U for requested points in time in S
if length(S) > 2
    
    % Find U for each element in S, say t*
    for i = 1:length(S)
        
        % Check whether U was already calculated for the element t*
        if ismember(S(i),T)
            [~,locationInT] = ismember(S(i),T);
            T2(i) = T(locationInT);
            U2(:,i) = U(:,locationInT);
            
        % Interpolate U linearlly for the element t*
        % (I did not know whether I could use the built-in interpolation
        % function)
        else
            % Find a greatest element t in T such that the greatest element
            % is smaller than t*
            t = max(T(T < S(i)));
            
            % Determine U corresponding to t*
            U2(:,i) = U(:,T==t) + (U(:,T==t+h) - U(:,T==t))*(S(i) - t)/h;
            T2(i) = S(i);
        end
    end
    
    T = T2';
    U = U2';
    
% Check if U outside the interval S was found. Delete such U.
else
    if S(end) ~= T(end)
        U(end) = [];
        U = U';
        T(end) = [];
        T = T';
    end
end
end