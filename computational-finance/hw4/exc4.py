import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st
from scipy.integrate import quad


def GeneratePathsCorrelatedBM(NoOfPaths, NoOfSteps, T, rho):
    Z1 = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    Z2 = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W1 = np.zeros([NoOfPaths, NoOfSteps + 1])
    W2 = np.zeros([NoOfPaths, NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    time = np.zeros([NoOfSteps + 1])
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z1[:, i] = (Z1[:, i] - np.mean(Z1[:, i])) / np.std(Z1[:, i])
            Z2[:, i] = (Z2[:, i] - np.mean(Z2[:, i])) / np.std(Z2[:, i])

        # Correlate noise

        Z2[:, i] = rho * Z1[:, i] + np.sqrt(1.0 - rho ** 2) * Z2[:, i]

        W1[:, i + 1] = W1[:, i] + np.power(dt, 0.5) * Z1[:, i]
        W2[:, i + 1] = W2[:, i] + np.power(dt, 0.5) * Z2[:, i]

        time[i + 1] = time[i] + dt

    return W1, W2


def generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, W1, W2):
    S1 = np.zeros([NoOfPaths, NoOfSteps + 1])
    S2 = np.zeros([NoOfPaths, NoOfSteps + 1])

    S1[:, 0] = S1_0
    S2[:, 0] = S2_0

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        S1[:, i + 1] = S1[:, i] + r * S1[:, i] * dt + sigma1 * S1[:, i] * (W1[:, i + 1] - W1[:, i])
        S2[:, i + 1] = S2[:, i] + r * S2[:, i] * dt + sigma2 * S2[:, i] * (W2[:, i + 1] - W2[:, i])

    return S1, S2


def obtainCI(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, rho):
    W1, W2 = GeneratePathsCorrelatedBM(NoOfPaths, NoOfSteps, T, rho)
    S1, S2 = generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, W1, W2)

    V = np.exp(-r * T) * np.maximum(S1[:, -1], S2[:, -1])

    meanV = np.mean(V)
    stdV = np.std(V)
    CI = [meanV - 1.96 * stdV / np.sqrt(NoOfPaths), meanV + 1.96 * stdV / np.sqrt(NoOfPaths)]
    return meanV, CI


def obtainCI2(NoOfSim, NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, rho):
    # not used in the end
    V = np.zeros(NoOfSim)

    for i in range(NoOfSim):
        W1, W2 = GeneratePathsCorrelatedBM(NoOfPaths, NoOfSteps, T, rho)
        S1, S2 = generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, W1, W2)

        V[i] = np.exp(-r * T) * np.mean(np.maximum(S1[:, -1], S2[:, -1]))

    meanV = np.mean(V)
    stdV = np.std(V)
    CI = [meanV - 1.96 * stdV / np.sqrt(NoOfSim), meanV + 1.96 * stdV / np.sqrt(NoOfSim)]
    return meanV, CI


def mainCalculation():
    NoOfSteps = 400
    NoOfPaths = 100000
    T = 4
    r = 0.01
    sigma1, sigma2 = 0.4, 0.15
    S1_0, S2_0 = 1, 1
    rho1, rho2 = -0.9, 0.9

    print(obtainCI(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, rho1))
    print(obtainCI(NoOfPaths, NoOfSteps, T, r, sigma1, sigma2, S1_0, S2_0, rho2))

mainCalculation()
