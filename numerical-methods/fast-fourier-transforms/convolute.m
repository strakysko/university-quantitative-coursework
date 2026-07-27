function [conv] = convolute(func1,func2, L)
%CONVOLUTION finds circular convolution of two periodic functions.
%   [CONV]=convolute(FUNC1, FUNC2, L) finds convolution CONV of two
%   L-periodic functions FUNC1 and FUNC2.

% finds Fourier transforms of FUNC1 and FUNC2
C1 = DFFT(func1);
C2 = DFFT(func2);

% find the Fourier transform of the convolution of FUNC1 and FUNC2
C = C1 .* C2 * L;

% determines the convolution of Fourier transform C as the inverse Fourier
% transform of C
conv = DFFT(C,1);
end