function [] = NewtonFractal(vertices,steps,iter,tol)
%NEWTONFRACTAL plots the Newton fractal for z^3 - 1.
%   []=NewtonFractal(VERTICES, STEPS, ITER, TOL) plots a part of the Newton 
%   fractal in the complex plain for the function z^3 - 1 such that
%   the Newton fractal is colored by root reached. The plotted part 
%   of the Newton fractal is bounded by a rectangle given by two vertices
%   in the vector VERTICES. The rectangle is discretized into complex
%   points such that there are STEPS(1) horizontally evenly-spaced points
%   for every point from STEPS(2) vertically evenly-spaced points. Each
%   of the complex points is used as a starting point in the Newton's
%   method for the function z^3 - 1. The Newton's method is iterated ITER
%   times for each starting point. If the absolute difference between a zero 
%   approximated by the Newton's method and one of the actual zeros is less 
%   than TOL, then let us say that such a starting point reaches that
%   actual zero. In the output, all the starting points reaching the same 
%   zero are colored with the same color.
%
%   The inputs ITER and TOL are optional with default values 30 and 1e-15,
%   respectively.

% default inputs
if nargin < 4
    tol = 1e-15;
end
if nargin < 3
    iter = 30;
end

% states zeros of the function z^3 - 1
zeros(1) = 1;    
zeros(2) = -0.5 + 3^(1/2)/2i;    
zeros(3) = -0.5 - 3^(1/2)/2i;

% discretizes two sides of the rectangle
realSide = linspace(real(vertices(1)),real(vertices(2)),steps(1));
imaginarySide = linspace(imag(vertices(1)),imag(vertices(2)),steps(2)).*1i;

% discretizes the entire rectangle into a matrix consisting of starting 
% points for the Newton's Method
for j = 1:steps(1)
    for k = 1:steps(2)
        startPoints(k,j) = realSide(j) + imaginarySide(k);
    end
end

% applies the Newton's Method to the matrix consisting of starting points,
% gives a matrix with approximations of zeros of the function z^3 - 1
zeroApprox = startPoints;
for l = 1:iter
    zeroApprox = zeroApprox - (zeroApprox.^3 - 1) ./ (3*zeroApprox.^2);
end

% plots and colors starting points with the same color if the starting
% points reach the same zero
for m = 1:3
    diff = abs(zeroApprox - zeros(m));
    plot(startPoints(diff < tol),'.');
    hold on
end
title({"The Newton fractal","colored by root reached"},'FontWeight','Normal');
xlabel('Real number line');     ylabel('Imaginary number line');
hold off

end