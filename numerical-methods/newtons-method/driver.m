%% Assignment 2


%% THE SECANT METHOD
clear all, close all, clc, format long;

%% Approximates a zero of a function
% Secant approximates a zero of a function with the Secant Method until 
% either the maximal number of iterations is reached or the tolerance is 
% met. Let tolerance be the maximal difference of the last two iterates.

% I choose F and inputs, such that the zero of F is obvious (-2) and 
% the Secant Method converges to the actual zero.
f = @(x) x^3+x^2+4; 
zero = secant(f,3,5,100,1e-5)

%% Makes use of optional inputs
% The default optional inputs are the maximal number of iterations 100 
% and the minimal tolerance 1e-5.

% The optional arguments are left blank.
f = @(x) x^3+x^2+4;
zero = secant(f,3,5)

%% Gives additional outputs

f = @(x) x^3+x^2+4;

% gives a vector X, which contains root approximations obtained
% in the iterations
[~,x] = secant(f,3,5)

% gives a real number RES, which is an evaluation of a function F 
% at the approximated ZERO (This should be almost zero in a good approx.)
[~,~,res] = secant(f,3,5)

% gives a natural number NITER, which is either the maximal number
% of iterations, in case a tolerance has not been met, or the number
% of iterations needed to meet the tolerance.
[~,~,~,niter] = secant(f,3,5)

%% Accepts functions with parameters
% An arbitrary number of parameters can be plugged into the function.
% For example, when P1 = 5 and P2 = 2, then a zero is approximated 
% for a function with such parameters.

f = @(x,p1,p2) p1*x^3+x^2/p2+4;
zero = secant(f,3,5,100,1e-5,5,2)

%% Condition(s) for the Secant Method to converge
% For the Secant Method to converge, certain conditions need to be sufficed.
% The following sequence of zero approximations seems not to be converging. 

% Only first 15 terms are shown for better readability.
f = @(x) (x-1)^2*(x-2)^2; 
[~,x] = secant(f,0.8,1.2,15,1e-5)

%% Determination of orders of convergence between the Newton's Method and the Secant Method
% Under some conditions, there are typical orders of convergence
% for the Secant Method and for the Newton's Method. We are going 
% to approximate and compare these orders of convergence. We can approximate 
% an order of convergence with a formula $[1]$. For each of the methods,
% the corresponding formula converges to the order of convergence as the 
% number of iterates in that method increases. 

% Calculates iterates of both, the Secant Method and the Newton's Method, 
% for a given a function F.
f = @(x) x^3+x^2+4; 
[~,x] = secant(f,3,5,20,1e-10);
[~,~,y] = newton(f,@(x) 3*x^2+2*x,-100,16,1e-10);

% This is the formula$[1]$.
formula = @(x1,x2,x3,x4) log(abs((x4 - x3) / (x3 - x2))) ...
        / log(abs((x3 - x2) / (x2 - x1)));

% As i increases, the approximation of the order approaches the actual
% order of convergence. We know this from the formula explanation$[1]$.
for i = 4:length(x)
    orderSecant(i-3) = formula(x(i-3),x(i-2),x(i-1),x(i));
end

for i = 4:length(y)
    orderNewton(i-3) = formula(y(i-3),y(i-2),y(i-1),y(i));
end

% Makes a plot of the iterates approaching the order of convergence for
% each method.
figure(1);
x_axis = 1:length(x)-3;
y_axis = 1:length(y)-3;
plot(x_axis,orderSecant,'-.',y_axis,orderNewton,'-*');
xlabel('Number of iterations of the formula.');
ylabel('Approximated order of convergence.');
title('Plot of sequences converging to corresponding order of convergence.');
xticks(0:14);
yticks([-8:1, 1.6, 2:6]);
legend({'Secant Method','Newton''s Method'},'Location','southwest')
width=700;
height=700;
set(figure(1),'position',[0,0,width,height])
grid on;

% According to the plot, the approximated orders of convergence are
% 2 and 1.6 for the Newton's and Secant Method, respectively. 
% Actually, we know more exact values from previous calculations.
orderOfConvergenceSecant = orderSecant(length(x)-3)
orderOfConvergenceNewton = orderNewton(length(y)-3)


%% Comparison of efficiency of the Secant and Newton's Method
% The previous observation is in agreement with the theoretical values for the
% orders of convergence of the Secant and Newton's Method. Under certain 
% conditions, the Newton's Method should converge quadratically. The
% Secant Method should converge sublinearly with the order of convergence
% equal to the golden ratio (~1.618). Therefore, assuminng those certain
% conditions are met and the derivative of a function is known, it is more 
% efficient to use the Newton's Method than the Secant Method because of
% faster convergence. Otherwise, when the derivative of a function is
% unknown or we observe higher order of convergence for the Secant than for
% the Newton's Method, we should opt for using the Secant Method.


%% THE MODIFIED NEWTON'S METHOD
clear all; close all; clc; 

%% Determines zero of a function
% For a given function F and its derivative DF, modified approximates a
% zero closest to the guess GUESS of the zero.
f = @(x) (x^2-1)^2*log(x);
df = @(x) 4*x*(x^2-1)*log(x)+(x^2-1)^2/x;
guess = 2.8;

% The actual zero is 1.
zero = modified(f,df,guess)

%% Approximates order of a zero in each iteration
% The function modified approximates order of a zero in each iteration. The
% resulting output is a vector M consisting of the approximations in each
% iteration. If it is approximated in an iteration that the order of a zero
% is less than one, we assume the order of the zero to be one. The
% approximation of the order of the zero converges to the actual order 
% of a zero as the number of iterations increases.

% The actual order of the zero is 3.
[~,~,~,~,M] = modified(f,df,guess)

%% Comparison of the Classical and Modified Newton's Method
% We can check how many iterations it takes for each method to achieve the
% demanded tolerance. We can observe that the number of iterates needed for
% the Modified Method to achieve the tolerance is much less than the number
% of iterates needed for the Classical Method to achieve the tolerance.

% Gets iterates converging to zero from both methods
[~,x] = modified(f,df,guess)
[~,~,y] = newton(f,df,guess,100,1e-10)


% To achieve the tolerance 1e-10, we need the following number of iterates
% of each method.
neededIteratesModified = length(x) - 1
neededIteratesClassical = length(y) - 1


%% Plots comparison of the Newton's Classical and Modified Method
% We get a graph that shows iterates of both methods in one plot to see
% which of the methods converges to the zero faster. The method that
% converges faster has a bigger order of convergence than the other method.
% In this cae, when f has a zero with multiplicity 3, the Modified Newton's
% Method converges faster than the Newton's Method. Thus, the Modified
% Newton's Method has a higher order of convergence than the Newton's
% Method.

% We plot the calculated values from above
x_axis = 1:length(x);       y_axis = 1:length(y);
plot(x_axis,x,'-.',y_axis,y,'-*');
xlabel('Number of iterations of a method.');
ylabel('Approximations of a zero.');
title('Plot of generated sequences converging to a zero of a function.');
legend({'Modified Method','Classica Method'},'Location','northeast')
width=700;      height=700;     grid on;


%% REFERENCES
% $[1]$ Senning, Jonathan R. "Computing and Estimating the Rate
% of Convergence" (PDF). gordon.edu. Retrieved 2020-08-07