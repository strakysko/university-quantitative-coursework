function [result] = DFFT(input,inverse)
%DFFT applies the fast Fourier transform or its inverse to the input.
%   [RESULT]=DFFT(INPUT, INVERSE) either finds the Fourier transform 
%   RESULT of an L-periodic function INPUT when INVERSE = 0 or determines 
%   a function RESULT from the Fourier transform INPUT when INVERSE = 1.
%   
%   The length of the input vector INPUT needs to be 2^N, where N is
%   a positive integer.
%   The input INVERSE is optional with the default value 0.

% default inputs
if nargin < 2
    inverse = 0;
end

M = length(input);

% if INVERSE = 1, IFFT is applied. Otherwise, FFT is applied.
if inverse == 1
    % In this case, the input is a FT that is scaled by M to get F suitable
    % for IFFT. The output of IFFT needs is then scaled by 1/M to get 
    % a correct function as a result.
    F = input .* M;
    Mfunc = IFFT(F);
    result = Mfunc ./ M;
else
    % In this case, the input is a function. The result of FFT is scaled 
    % by 1/M to change F into a FT.
    F = FFT(input);
    result = F ./ M;
end
    
    function [F] = FFT(func)
    %FFT obtains a scaled FT, vector F, of a function.
    %   [F]=FFT(FUNC) finds F, which is a scaled FT, corresponding to FUNC.
    
    N = length(func);
    
    
    if N == 1
        % in case length of F is 1, formula for F yields that F = func.
        F = func;
    else
        % uses the FFT recursive algorithm to reduce computation time
        Fodd = FFT(func(1:2:end));
        Feven = FFT(func(2:2:end));
        
        % uses decomposition formulas for the Cooley-Tuckey algorithm
        w = exp(-2*pi*1i/N) .^ (0:N/2 - 1);
        F = [Fodd + w .* Feven, Fodd - w .* Feven];
    end
    end

    function [func] = IFFT(F)
    %IFFT obtains a scaled function from a scaled FT.
    %   [FUNC]=IFFT(F) finds FUNC, which is a scaled correct function, 
    %   corresponding to F, which is a scaled FT. There are only minor
    %   changes in the IFFT compared to FFT.
    N = length(F);

    if N == 1
        func = F;
    else
        % Uses the IFFT recursive algorithm.
        func_odd = IFFT(F(1:2:end));
        func_even = IFFT(F(2:2:end));
        
        % Notice the exponents in W lack the minus sign compared to FFT.
        w = exp(2*pi*1i/N) .^ (0:N/2 - 1);
        % uses the composition formulas
        func = [func_odd + w .* func_even, func_odd - w .* func_even];
    end
    end

end