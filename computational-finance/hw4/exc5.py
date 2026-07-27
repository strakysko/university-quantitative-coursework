import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st


# part a
def generateEulerPaths(NoOfPaths, NoOfSteps, T, kappa, v_mean, gamma, v_0):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    v = np.zeros([NoOfPaths, NoOfSteps + 1])

    v[:, 0] = v_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        v[:, i + 1] = v[:, i] + kappa * (v_mean - v[:, i]) * dt + gamma * np.sqrt(v[:, i]) * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

        if np.any(v[:, i + 1] < 0):
            v = v[:, :i + 1]
            t = time[i + 1]
            break

    return t, v


# part b
def GeneratePathsCIR_AES(NoOfPaths, NoOfSteps, T, kappa, v0, vbar, gamma):
    V = np.zeros([NoOfPaths, NoOfSteps + 1])
    V[:, 0] = v0
    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):
        V[:, i + 1] = CIR_Sample(NoOfPaths, kappa, gamma, vbar, 0, dt, V[:, i])
        time[i + 1] = time[i] + dt
    # Outputs
    paths = {"time": time, "V": V}
    return paths


def CIR_Sample(NoOfPaths,kappa,gamma,vbar,s,t,v_s):
    delta = 4.0 *kappa*vbar/gamma/gamma
    c= 1.0/(4.0*kappa)*gamma*gamma*(1.0-np.exp(-kappa*(t-s)))
    kappaBar = 4.0*kappa*v_s*np.exp(-kappa*(t-s))/(gamma*gamma*(1.0-np.exp(-kappa*(t-s))))
    sample = c* np.random.noncentral_chisquare(delta,kappaBar,NoOfPaths)
    return  sample


# part c
def GeneratePathsCIREuler(NoOfPaths, NoOfSteps, T, kappa, v0, vbar, gamma):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])
    V = np.zeros([NoOfPaths, NoOfSteps + 1])
    V[:, 0] = v0
    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]
        V[:, i + 1] = V[:, i] + kappa * (vbar - V[:, i]) * dt + gamma * np.sqrt(V[:, i]) * (W[:, i + 1] - W[:, i])

        # We apply here the truncated scheme for negative values

        V[:, i + 1] = np.maximum(V[:, i + 1], 0.0)
        time[i + 1] = time[i] + dt

    # Outputs

    paths = {"time": time, "V": V}
    return paths


# part d


def mainCalculation():
    NoOfSteps = 100
    NoOfPaths = 10
    T = 4
    v_0 = 1
    kappa = 1
    v_mean = 0.1
    gamma = 0.5

    # part a
    t, v = generateEulerPaths(NoOfPaths, NoOfSteps, T, kappa, v_mean, gamma, v_0)

    plt.figure(1)
    plt.plot(np.linspace(0, t, v.shape[1]), np.transpose(v))
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("$v(t)$")
    plt.show()


    # part b
    PathsAES = GeneratePathsCIR_AES(NoOfPaths,NoOfSteps,T,kappa,v_0,v_mean,gamma)
    timeGrid = PathsAES["time"]
    V_AES = PathsAES["V"]

    plt.figure(2)
    plt.plot(timeGrid, np.transpose(V_AES), 'b')
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("v(t)")
    plt.show()


    # part c
    Paths = GeneratePathsCIREuler(NoOfPaths, NoOfSteps, T, kappa, v_0, v_mean, gamma)

    timeGrid = Paths["time"]
    V = Paths["V"]

    plt.figure(3)
    plt.plot(timeGrid, np.transpose(V), 'b')
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("V(t)")
    plt.show()

    # Here we compare expectations and variances for Euler and AES discretization schemes
    EX_Euler = np.mean(V, axis=0)
    EX_AES = np.mean(V_AES, axis=0)
    Var_Euler = np.var(V, axis=0)
    Var_AES = np.var(V_AES, axis=0)

    plt.figure(4)
    plt.plot(timeGrid, EX_Euler, '-k')
    plt.plot(timeGrid, EX_AES, '--r')
    plt.grid()
    plt.xlabel('time')
    plt.ylabel('E(v(t))')
    plt.legend(['Euler', 'AES'])
    plt.title('NoOfSteps = {0}'.format(NoOfSteps))
    plt.show()

    plt.figure(5)
    plt.plot(timeGrid, Var_Euler, '-k')
    plt.plot(timeGrid, Var_AES, '--r')
    plt.grid()
    plt.xlabel('time')
    plt.ylabel('Var(v(t))')
    plt.legend(['Euler', 'AES'])
    plt.title('NoOfSteps = {0}'.format(NoOfSteps))
    plt.show()

mainCalculation()
