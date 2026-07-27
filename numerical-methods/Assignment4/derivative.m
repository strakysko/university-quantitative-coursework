function [df] = derivative(func,L)
%DERIVATIVE finds a derivative of a function.
%   [DF]=derivative(FUNC, L, N) finds a derivative DF of an L-periodic 
%   function FUNC.

N = length(func);

% find the Fourier transform of the function FUNC
C = DFFT(func);

% defines a vector of indeces of the Fourier transform C
K = [0:N/2-1,-N/2:-1];

% finds FT of a DF using the formula {iK * 2pi/L * C_K}
dC = C.*K.*(1i*2*pi/L);

% applies the ifft to get DF from the FT of DF
df = DFFT(dC,1);
end