%% Assignment 3 - Nonlinear dynamical systems
% by David Straka on January 2023

%% Question 1
% Homogeneous steady states follow from the given parameter restrictions 
% and the system of equations
%
% $$0 = v(wv - \gamma),$$
%
% $$0 = \alpha - w - wv^2.$$
%
% The first equilibrium is
%
% $$E_1 = (0,\alpha)$$
%
% and always exists.
%
% The first equation gives that $wv = \gamma,$ which is bigger than zero
% by assumption. This implies that $w \neq 0$. Hence, $v=\frac{\gamma}{w}.$
% Plugging this into the second equation yields that $0=w^2 - \alpha w +
% \gamma^2$. Solving this quadratic equation gives two other equilibria
%
% $$E_2 = \left( \frac{2\gamma}{\alpha + \sqrt{\alpha^2 - 4\gamma^2}},
% \frac{\alpha}{2} + \frac{1}{2}\sqrt{\alpha^2 - 4\gamma^2}\right) \quad 
% \textit{and} \quad E_3 = \left(\frac{2\gamma}{\alpha - \sqrt{\alpha^2 - 4\gamma^2}},
% \frac{\alpha}{2} - \frac{1}{2}\sqrt{\alpha^2 - 4\gamma^2}\right).$$
%
% It follows from $0<4\gamma^2$ that $\frac{\alpha}{2} - 
% \frac{1}{2}\sqrt{\alpha^2 - 4\gamma^2} \geq 0$.
%
% The equilibria $E_2$ and $E_3$ exist iff $\alpha \geq 2\gamma$ because
% $v$ and $w$ must be real. This means that only if the rainfall rate
% $\alpha$ is at least twice as big as the death rate $\gamma$, then we
% have all three homogeneous equilibria. Otherwise, we have only the
% equilibrium $E_1$. This supports statements $S1$ and $S2$.

%% Question 2
% $$\mathcal{L}(v_*, w_*) = \pmatrix{\partial_x^2 - \gamma + 2w_*v_* &
% v_*^2 \cr -2w_*v_* & \beta\partial_x - 1 - v_*^2}$$

%% Question 3
% Plugging in the vegetative equilibrium gives
%
% $$\mathcal{L}(E_3) = \pmatrix{\partial_x^2 + \gamma & 
% \frac{2\gamma^2}{\alpha^2 - 2\gamma^2 -\alpha\sqrt{\alpha^2-4\gamma^2}} \cr
% -2\gamma & \beta \partial_x - 1 - \frac{2\gamma^2}{\alpha^2 - 2\gamma^2 
% -\alpha\sqrt{\alpha^2-4\gamma^2}}}.$$
%
% Notice that $v_* = \frac{2\gamma}{\alpha-\sqrt{\alpha^2-4\gamma^2}} = 
% \frac{2\gamma\left(\alpha+\sqrt{\alpha^2-4\gamma^2}\right)}
% {\left(\alpha-\sqrt{\alpha^2-4\gamma^2}\right)
% \left(\alpha+\sqrt{\alpha^2-4\gamma^2}\right)} = 
% \frac{\alpha+\sqrt{\alpha^2-4\gamma^2}}{2\gamma} = \mu(\alpha, \gamma)$.
%
% Hence, the ansatz $\varphi(x,t)=\exp(\lambda t+ikx)\psi$ gives
% $M\psi=\lambda\psi$ with $M$ as in Assignment 3.
% The matrix $M$ has the eigenvalues $\lambda_{1,2} = 
% \frac{\tau \pm \sqrt{\tau^2-4\delta}}{2},$ where $\tau = \gamma - k^2 - 1
% -\mu(\alpha,\gamma)^2 + i \beta k$ is the trace of $M$ and $\delta =
% \gamma\mu(\alpha,\gamma)^2 -\gamma +i\beta k\gamma +k^2 
% +k^2\mu(\alpha,\gamma)^2 - i\beta k^3$ is the determinant of $M$.

%% Question 4
% I expected the eigenvalues to be complex conjugates. It is not the case,
% as it can be seen in the plot below, because the characteristic
% polynomial of the matrix $M$ does not have real coefficients. This shows
% that a matrix with complex entries does not necessarily have complex
% conjugate pairs of eigenvalues.
%
% The plot below provides a numerical evidence that the real parts of both
% eigenvalues for the given parameters are negative. Hence, the vegetative
% equilibrium is linearly stable.

% Trace, determinant, and eigenvalues function handles
mu = @(a,g) (a + sqrt(a^2 - 4*g^2))/(2*g);
tau  = @(a,b,g,k) g - k.^2 - 1 - mu(a,g)^2 + 1i*b*k;
delta = @(a,b,g,k) g*mu(a,g)^2 - g + 1i*b*g*k + k.^2 + mu(a,g)^2*k.^2 - 1i*b*k.^3;
lambda1 = @(a,b,g,k) (tau(a,b,g,k)-sqrt(tau(a,b,g,k).^2 - 4*delta(a,b,g,k)))/2;
lambda2 = @(a,b,g,k) (tau(a,b,g,k)+sqrt(tau(a,b,g,k).^2 - 4*delta(a,b,g,k)))/2;

rel1 = @(a,b,g,k) real(lambda1(a,b,g,k));
rel2 = @(a,b,g,k) real(lambda2(a,b,g,k));
imag1 = @(a,b,g,k) imag(lambda1(a,b,g,k));
imag2 = @(a,b,g,k) imag(lambda2(a,b,g,k));

% Set parameters
a = 8; b = 20; g = 2;

% Continuous variable k
k = linspace(-2,2,1000);

% Plot dispersion relation (with inset around k=0)
figure, hold on;
plot(k,rel1(a,b,g,k),'DisplayName','Re \lambda_1');             plot(k,rel2(a,b,g,k),'DisplayName','Re \lambda_2');
plot(k,imag1(a,b,g,k),'DisplayName','Im \lambda_1');            plot(k,imag2(a,b,g,k),'DisplayName','Im \lambda_2');
hold off; grid on; ylim([-15 5]); xlabel('k'); 
lgd = legend; lgd.Location = 'northoutside'; lgd.NumColumns = 3;
drawnow;

%% Question 5
% We can see in the plot below that for $\alpha = 7$, there exist perturbations for $k$ such
% that the real part of one of the corresponding eigenvalues is positive.
% Such system is unstable and will exhibit patterns. The plot
% for $\alpha = 8$ contains only eigenvalues with negative real parts. Then
% the system is stable and does not exhibit patterns for any perturbation. 
% The plot provides numerical evidence that there is a critical $\alpha_c$
% between 7 and 8 changing the stability of the vegetative equilibrium and
% causing bifurcation.
%
% This plot provides numerical evidence that the bifurcation is neither
% Turing (there is no k s.t. both real and imaginary parts of the 
% eigenvalues are zero) nor Hopf (at k=0, the eigenvalues are not purely
% imaginary). However, we can predict from Lecture notes 3 Case 4, that the pattern
% is a travelling wave because of the similarity of plots. This coincides
% with the expected pattern of a wave from the Turing bifurcation.

b = 20; g = 2;

figure, hold on;
for a = 7: 0.2: 8 
    plot(k,rel1(a,b,g,k));             plot(k,rel2(a,b,g,k));
    plot(k,imag1(a,b,g,k));            plot(k,imag2(a,b,g,k));
end
hold off; grid on; ylim([-15 5]); xlabel('k'); 
drawnow;

%% Question 6
% The plot shows that the concentration of vegetation $v$ forms a (travelling)
% wave pattern over time for the given parameters. This coincides with the
% suggested wave in Question 5. This wave pattern means that
% the vegetation concentration at a certain position is expected 
% to oscillate as the time passes.


% Set parameters
p = [7 20 2];
L = 15.7;

% Instantiating periodic differentiation matrix
nx = 1500; [x,Dx,Dxx] = PeriodicDiffMat([-L,L],nx); 

% Initial condition (steady state + perburbation)
e = ones(size(x)); 
v0 = 4/(7 - sqrt(33)); w0 = 7/2 - sqrt(33)/2; z0 = [v0*e; w0*e]; 
z0 = z0 + [cos(4*pi/L*x); e];

% Time step
rhs = @(t,z) Schnakenberg(z,p,Dx,Dxx);
jac = @(t,z) SchnakenbergJacobian(z,p,Dx,Dxx);
opts = odeset('Jacobian',jac);
tSpan = 0:0.1:300;
% tSpan = [0:0.1:50];
[t,ZHist] = ode15s(rhs,tSpan,z0,opts);

% Space-time plot
PlotHistory(x,t,ZHist,p,[]);