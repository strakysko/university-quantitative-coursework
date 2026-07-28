import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st


def generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma_X, sigma_Y, X_0, Y_0):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    X = np.zeros([NoOfPaths, NoOfSteps + 1])
    Y = np.zeros([NoOfPaths, NoOfSteps + 1])

    X[:, 0] = X_0
    Y[:, 0] = Y_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        X[:, i + 1] = X[:, i] + r * X[:, i] * dt + sigma_X * X[:, i] * (W[:, i + 1] - W[:, i])
        Y[:, i + 1] = Y[:, i] + r * Y[:, i] * dt + sigma_Y * Y[:, i] * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    paths = {"time": time, "X": X, "Y": Y}
    return paths


def mainCalculation():
    NoOfPaths = 1000
    NoOfSteps = 1000
    T = 7
    r = 0.06
    K = np.arange(0, 10.05, 0.05)
    sigma_X = 0.15
    sigma_Y = 0.38
    X_0 = 4
    Y_0 = 1

    # Simulated paths

    Paths = generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma_X, sigma_Y, X_0, Y_0)
    timeGrid = Paths["time"]
    X = Paths["X"]
    Y = Paths["Y"]

    M_T = np.exp(r * T)

    H = np.zeros((len(K), NoOfPaths))

    for i, k in enumerate(K):
        H_k = np.maximum(0.5 * X[:, -1] - 0.5 * Y[:, -1], k) / M_T
        H[i, :] = H_k

    expectation_est = np.mean(H, axis=1)

    V_0 = expectation_est * np.exp(-r*T)

    plt.figure(1)
    plt.plot(K, V_0)
    plt.xlabel('$K$')
    plt.ylabel('$V(t_0)$')
    plt.title(r"$K$ vs. $V(t_0)$")
    plt.grid(True)

    plt.figure(2)
    plt.plot(timeGrid, np.transpose(X))
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("$X(t)$")

    plt.figure(3)
    plt.plot(timeGrid, np.transpose(Y))
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("$Y(t)$")

    plt.show()

mainCalculation()
