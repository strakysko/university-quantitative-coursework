import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st
from scipy.integrate import quad


def GeneratePathsGBM(NoOfPaths, NoOfSteps, T, r, sigma, S_0):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    MilsteinS = np.zeros([NoOfPaths, NoOfSteps + 1])
    EulerS = np.zeros([NoOfPaths, NoOfSteps + 1])
    MilsteinS[:, 0] = S_0
    EulerS[:, 0] = S_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        MilsteinS[:, i + 1] = MilsteinS[:, i] + r(time[i]) * MilsteinS[:, i] * dt + sigma(time[i]) * MilsteinS[:, i] * (W[:, i + 1] - W[:, i]) \
                              + 0.5 * sigma(time[i]) * sigma(time[i]) * MilsteinS[:, i] * (np.power((W[:, i + 1] - W[:, i]), 2) - dt)
        EulerS[:, i + 1] = EulerS[:, i] + r(time[i]) * EulerS[:, i] * dt + sigma(time[i]) * EulerS[:, i] * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    return MilsteinS, EulerS


def GeneratePathsGBMMilstein(NoOfPaths, NoOfSteps, T, r, sigma, S_0):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    S1 = np.zeros([NoOfPaths, NoOfSteps + 1])
    S1[:, 0] = S_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        S1[:, i + 1] = S1[:, i] + r(time[i]) * S1[:, i] * dt + sigma(time[i]) * S1[:, i] * (W[:, i + 1] - W[:, i]) \
                       + 0.5 * sigma(time[i]) * sigma(time[i]) * 0 * S1[:, i] * (np.power((W[:, i + 1] - W[:, i]), 2) - dt)
        time[i + 1] = time[i] + dt

    return S1


def generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma, S_0):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])

    S = np.zeros([NoOfPaths, NoOfSteps + 1])

    S[:, 0] = S_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        S[:, i + 1] = S[:, i] + r(time[i]) * S[:, i] * dt + sigma(time[i]) * S[:, i] * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    return S


def discount_factor(T, r):
    integral, _ = quad(r, 0, T)
    return np.exp(-integral)


# Calculate the integral of the interest rate function over [0, T]
def average_interest_rate(T, r):
    integral, _ = quad(r, 0, T)
    return integral / T


# Black-Scholes call option price
def BS_Call_Put_Option_Price(S_0, K, sigma, t, T, r):
    d1 = (np.log(S_0 / K) + (average_interest_rate(T-t, r) + 0.5 * np.power(sigma, 2.0)) * (T - t)) / (sigma * np.sqrt(T - t))
    d2 = d1 - sigma * np.sqrt(T-t)

    value = st.norm.cdf(d1) * S_0 - st.norm.cdf(d2) * K * np.exp(-average_interest_rate(T-t, r) * (T-t))
    return value


def sigma_star(T):
    numerator = np.exp(-(9 * T) / 2) * ((27 * T * np.exp((3 * T) / 2) + 12) * np.exp(3 * T) - np.exp((3 * T) / 2))
    denominator = 75
    return np.sqrt(1 / T * (numerator / denominator - 11 / 75))


def priceUpAndOutBarrierOption(pathsEuler, B, K, T, r):
    paths = pathsEuler.copy()
    paths[np.any(paths > B, axis=1), -1] = 0
    return discount_factor(T, r) * np.mean(np.maximum(paths[:, -1] - K, 0))


def priceUpAndInBarrierOption(pathsEuler, B, K, T, r):
    paths = pathsEuler.copy()
    paths[~np.any(paths > B, axis=1), -1] = 0
    return discount_factor(T, r) * np.mean(np.maximum(paths[:, -1] - K, 0))


def mainCalculation():
    ConsideredNoOfSteps = [50, 100, 200, 400]
    ConsideredNoOfPaths = [1000, 10000, 100000]
    t = 0
    T = 4
    r = lambda t: 0.05 * (t < 2) + 0.08 * (t >= 2)
    sigma = lambda t: 0.6 - 0.2 * np.exp(-1.5 * t)
    S_0 = 1
    K = 1.6
    B = 1.5

    exactPrice = BS_Call_Put_Option_Price(S_0, K, sigma_star(T-t), t, T, r)
    print(f"Exact Black-Scholes Price: {exactPrice}")

    fig, axs = plt.subplots(2, 2, figsize=(7.5, 7.5))

    for i, NoOfSteps in enumerate(ConsideredNoOfSteps):
        errorsEuler = []
        errorsMilstein = []

        for NoOfPaths in ConsideredNoOfPaths:
            # pathsEuler = generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma, S_0)
            # pathsMilstein = GeneratePathsGBMMilstein(NoOfPaths, NoOfSteps, T, r, sigma, S_0)

            pathsMilstein, pathsEuler = GeneratePathsGBM(NoOfPaths, NoOfSteps, T, r, sigma, S_0)

            priceEuler = discount_factor(T, r) * np.mean(np.maximum(pathsEuler[:, -1] - K, 0))
            priceMilstein = discount_factor(T, r) * np.mean(np.maximum(pathsMilstein[:, -1] - K, 0))

            errorsEuler.append(abs(priceEuler - exactPrice))
            errorsMilstein.append(abs(priceMilstein - exactPrice))

        row, col = divmod(i, 2)

        axs[row, col].plot(ConsideredNoOfPaths, errorsEuler, label='Euler')
        axs[row, col].plot(ConsideredNoOfPaths, errorsMilstein, label='Milstein')
        axs[row, col].set_title(f'Convergence for {NoOfSteps} time steps')
        axs[row, col].legend()

    plt.show()

    # price the barrier options
    EulerPaths = generateEulerPaths(ConsideredNoOfPaths[-1], ConsideredNoOfSteps[1], T, r, sigma, S_0)
    print(f"Simulated up-and-out barrier option price: {priceUpAndOutBarrierOption(EulerPaths, B, K, T, r)}")
    print(f"Simulated up-and-in barrier option price: {priceUpAndInBarrierOption(EulerPaths, B, K, T, r)}")


mainCalculation()
