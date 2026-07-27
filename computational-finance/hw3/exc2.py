import numpy as np
import scipy.stats as st
import matplotlib.pyplot as plt


def ImpliedVolatility(CP, S_0, K, sigma, tau, r, V_market):
    error = 1e11;  # initial error

    # Convenient lambda expressions

    optPrice = lambda sigma: BS_Call_Option_Price(CP, S_0, K, sigma, tau, r)
    vega = lambda sigma: dV_dsigma(S_0, K, sigma, tau, r)

    # When the difference between the model and market price is large
    # perform the following iteration

    while error > 10e-10:  # 10e-10
        f = V_market - optPrice(sigma);
        f_prim = -vega(sigma);
        sigma_new = sigma - f / f_prim;

        error = abs(sigma_new - sigma);
        sigma = sigma_new;
    return sigma


# Vega, dV/dsigma

def dV_dsigma(S_0, K, sigma, tau, r):
    # Parameters and the value of Vega

    d2 = (np.log(S_0 / float(K)) + (r - 0.5 * np.power(sigma, 2.0)) * tau) / float(sigma * np.sqrt(tau))
    value = K * np.exp(-r * tau) * st.norm.pdf(d2) * np.sqrt(tau)
    return value


def BS_Call_Option_Price(CP, S_0, K, sigma, tau, r):
    # Black-Scholes call option price

    d1 = (np.log(S_0 / float(K)) + (r + 0.5 * np.power(sigma, 2.0)) * tau) / float(sigma * np.sqrt(tau))
    d2 = d1 - sigma * np.sqrt(tau)
    if str(CP).lower() == "c" or str(CP).lower() == "1":
        value = st.norm.cdf(d1) * S_0 - st.norm.cdf(d2) * K * np.exp(-r * tau)
    elif str(CP).lower() == "p" or str(CP).lower() == "-1":
        value = st.norm.cdf(-d2) * K * np.exp(-r * tau) - st.norm.cdf(-d1) * S_0
    return value


def generateEulerPaths(NoOfPaths, NoOfSteps, T, r, S_0, sigma):
    np.random.seed(1)
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

        S[:, i + 1] = S[:, i] + r * S[:, i] * dt + sigma(time[i]) * S[:, i] * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    # paths = {"time": time, "S": S}
    return S[:, -1]


def MainCalculation():
    # Initial parameters and market quotes

    NoOfPaths = 10000
    NoOfSteps = 500
    K = 1;  # Strike price
    tau = np.linspace(1, 6, 20)  # Time-to-maturity
    r = 0.05;  # Interest rate
    S_0 = 1;  # Today's stock price
    sigmaInit = 0.56;  # Initial implied volatility
    sigma_imp = np.zeros(len(tau))

    CP = "c"  # C is call and P is put

    sigma = lambda T: 0.6 - 0.2 * np.exp(-1.5 * T)
    sigmaStar = lambda T: np.sqrt(
        1 / T * (0.36 * T + 0.24 * (2 / 3) * (np.exp(-1.5 * T) - 1) - 0.04 * (1 / 3) * (np.exp(-3 * T) - 1)))

    for i in range(len(tau)):
        S = generateEulerPaths(NoOfPaths, NoOfSteps, tau[i], r, S_0, sigma)

        H = np.maximum(S - K, 0)

        V_0 = np.mean(H) * np.exp(-r * tau[i])

        sigma_imp[i] = ImpliedVolatility(CP, S_0, K, sigmaInit, tau[i], r, V_0)

    plt.plot(tau, sigma_imp)
    plt.plot(tau, sigmaStar(tau))
    plt.grid()
    plt.show()


MainCalculation()
