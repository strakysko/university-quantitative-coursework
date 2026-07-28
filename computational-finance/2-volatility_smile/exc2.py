import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st
import pandas as pd
from scipy.stats import norm


def generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma, X_0, standardization=True):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])
    X = np.zeros([NoOfPaths, NoOfSteps + 1])

    X[:, 0] = X_0

    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1 and standardization:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]

        X[:, i + 1] = X[:, i] + r * X[:, i] * dt + sigma * X[:, i] * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    paths = {"time": time, "X": X}
    return paths


def obtainOptionPrice(NoOfPaths, NoOfSteps, T, r, K, sigma, X_0, standardization):
    Paths = generateEulerPaths(NoOfPaths, NoOfSteps, T, r, sigma, X_0, standardization)
    X = Paths["X"]

    H = np.zeros((len(K), NoOfPaths))

    for i, k in enumerate(K):
        H_k = np.maximum(X[:, -1] - k, 0)
        H[i, :] = H_k

    expectation_est = np.mean(H, axis=1)

    V_0 = expectation_est * np.exp(-r*T)
    df = pd.DataFrame({
        'optionPrice': V_0,
        'strike': K,
        'NoOfPaths': NoOfPaths
    })
    return df


def black_scholes_call(S, K, T, r, sigma):
    # Calculate d1 and d2
    d1 = (np.log(S / K) + (r + 0.5 * sigma ** 2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    # Calculate the call option price
    call_price = S * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)

    return call_price


def mainCalculation():
    pathLengths = np.arange(1, 1001, 10)
    NoOfSteps = 1000
    T = 7
    r = 0.06
    # K = np.arange(0, 10.05, 0.05)
    K = [5]
    sigma = 0.15
    X_0 = 4

    stand_df = pd.DataFrame()
    nonstand_df = pd.DataFrame()

    for pathLength in pathLengths:
        newstand_df = obtainOptionPrice(pathLength, NoOfSteps, T, r, K, sigma, X_0, True)
        newnonstand_df = obtainOptionPrice(pathLength, NoOfSteps, T, r, K, sigma, X_0, False)

        stand_df = pd.concat([stand_df, newstand_df], ignore_index=True)
        nonstand_df = pd.concat([nonstand_df, newnonstand_df], ignore_index=True)

    NoOfPaths = stand_df['NoOfPaths']
    standV_0 = stand_df['optionPrice']
    nonstandV_0 = nonstand_df['optionPrice']

    print(black_scholes_call(X_0, K[0], T, r, sigma))

    plt.figure(1)
    plt.plot(NoOfPaths, standV_0, label='standardized')
    plt.plot(NoOfPaths, nonstandV_0, label='nonstandardized')
    plt.xlabel('No of simulated paths')
    plt.ylabel('Price of the call option')
    plt.grid(True)
    plt.legend()

    plt.show()

mainCalculation()
