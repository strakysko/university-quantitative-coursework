import numpy as np
import matplotlib.pyplot as plt


def generate_W(NoOfPaths, NoOfSteps, T):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    t = 0.0
    for i in range(0, NoOfSteps):
        # making sure that samples from normal have mean 0 and variance 1
        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]
        t = t + dt
    return W


def get_var_X(t, T):
    return t - 2.0 * (t / T) * np.minimum(t, T - t) + (t ** 2.0) / (T ** 2.0) * (T - t)


def estimate_var_X():
    T = 10.0
    NoOfPaths = 1000
    NoOfSteps = 1000

    dt = T / float(NoOfSteps)
    W = generate_W(NoOfPaths, NoOfSteps, T)
    time = np.linspace(0, T, NoOfSteps + 1)
    X = np.zeros([NoOfPaths, NoOfSteps + 1])

    var_X = [0.0]
    t = 0.0
    dt = T / float(NoOfSteps)

    for i in range(0, NoOfSteps):
        X[:, i + 1] = W[:, i] - t / T * W[:, NoOfSteps - i]
        t = t + dt
        var_X.append(np.var(X[:, i + 1]))

    '''
    plt.figure(1)
    plt.plot(time, var_X)
    plt.plot(time, get_var_X(time, T), '--r')

    plt.grid()
    plt.xlabel('time $t$')
    plt.ylabel('$Var(X(t))$')
    plt.legend(['numerical', 'analytical'])

    plt.show()
    '''

    return var_X


def get_sensitivity(NoOfRuns):
    length = len(estimate_var_X())

    varX = estimate_var_X()

    for _ in range(NoOfRuns - 1):
        varX = np.vstack((varX, estimate_var_X()))

    return varX


NoOfRuns = 10
varX = get_sensitivity(NoOfRuns)
time = np.linspace(0, 10, 1000 + 1)

plt.xlabel('time $t$')
plt.ylabel('$Var(Var(X(t)))$')
plt.plot(time, np.var(varX, axis=0))

plt.show()
