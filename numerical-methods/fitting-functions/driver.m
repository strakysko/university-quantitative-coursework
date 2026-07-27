%% Assignment III

%% Exercise 1 - Newton Fractal
% The function NewtonFractal plots the Newton fractal of a function 
% z^3 - 1 with three roots. The greater the entries of the second input,
% the more precise picture we get of the fractal assuming that those new
% points would reach one of the zeros of the function.

%%
% Newton fractal with a relatively low precision
NewtonFractal([-2+2i,2-2i],[100,100])

%%
% Newton fractal with a relatively high precision
NewtonFractal([-2+2i,2-2i],[300,300])

%%
% Newton fractal zoomed out
NewtonFractal([-20+20i,20-20i],[300,300])

%% Exercise 2 - Best Fit Function
% The function BestFit finds coefficients of an exponential best fit 
% function and plots the function against the data set. We call the
% function for three given data sets.

% loads the data sets
load expo-examples.mat

%%
% Data set 1
[exponents,constants,residue] = BestFit(data1,-0.1:0.05:0.1)

%%
% Data set 1
[exponents,constants,residue] = BestFit(data2,-0.1:0.05:0.1)

%%
% Data set 1
[exponents,constants,residue] = BestFit(data3,-0.1:0.05:0.1)
