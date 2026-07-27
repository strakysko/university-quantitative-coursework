function [approx] = sine(x, num_terms)
% SINE computes Taylor approximation of sine around x = 0
% 
% [APPROX]=SINE(X,NUM_TERMS) computes Taylor approximation of sine
% of each element in a vector X. Each element in a vector NUM_TERMS
% determines the number of terms of a Taylor sequence used for
% approximation of sine of a corresponding element in the vector X.
% 
% If X is scalar, X is repetedly approximated using each element
% of NUM_TERMS. If NUM_TERMS is scalar, then each element of X is 
% approximated using NUM_TERMS.
%
% The output is a vector in which the k-th element corresponds
% to an approximation of sine of the k-th element of X.
%
% [APPROX]=SINE(X) uses a default value NUM_TERMS=3.

% default value for num_terms 
if ~exist('num_terms')
    num_terms = ones(1,length(x)) * 3;
elseif length(num_terms) == 1
    num_terms = ones(1,length(x)) * num_terms;
end

% default value for x
if length(x) == 1
    x = ones(1,length(num_terms)) * x;
end

% for every element in x, generates and sums Taylor terms
approx = zeros(1,length(x));

for i = 1:length(x)
    for j = 1:num_terms(i)
        next_term = (-1)^(j+1) * x(i)^(2*j-1);
        approx(i) = approx(i) + next_term;
    end
end

return