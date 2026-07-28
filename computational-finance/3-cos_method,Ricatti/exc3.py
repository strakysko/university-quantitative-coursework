import numpy as np
import matplotlib.pyplot as plt


def GeneratePathsGBMEuler(NoOfPaths, NoOfSteps, T, gamma, S_0):
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

        S[:, i + 1] = np.maximum(S[:, i] + gamma * np.sqrt(np.maximum(S[:, i], 0)) * (W[:, i + 1] - W[:, i]), 0)
        time[i + 1] = time[i] + dt

    # Return S
    paths = {"time": time, "S": S}
    return paths


def COSDensity(cf, x, N, a, b):
    i = complex(0.0, 1.0)  # assigning i=sqrt(-1)
    k = np.linspace(0, N - 1, N)
    u = np.zeros([1, N])
    u = k * np.pi / (b - a)

    # F_k coefficients

    F_k = 2.0 / (b - a) * np.real(cf(u) * np.exp(-i * u * a));
    F_k[0] = F_k[0] * 0.5;  # adjustment for the first term

    # Density calculation

    f_X = np.matmul(F_k, np.cos(np.outer(u, x - a)))

    return f_X


def char_func(t, gamma, S):
    i = complex(0.0, 1.0)
    St = np.mean(S[:, t])
    return lambda u: np.exp(i * u * St / (1 - 0.5 * i * u * t * gamma ** 2))


def main_calculation():
    # Parameters for the GBM and VG models
    no_of_paths = 10 ** 5
    no_of_steps = 500
    T = 5
    gamma = 0.25
    S_0 = 1

    # Generate paths using GBM with Euler discretization
    paths = GeneratePathsGBMEuler(no_of_paths, no_of_steps, T, gamma, S_0)
    S = paths["S"]

    # Parameters for COS method
    N_values = [8, 16, 32, 4096]  # Expansion terms
    a, b = -10.0, 10.0  # COS method integration range
    x = np.linspace(0.01, 10, 5000)  # Domain for density

    # Compute characteristic function
    cF = char_func(T, gamma, S)

    # Plotting the COS method approximation
    plt.figure(1)
    for N in N_values:
        f_X = COSDensity(cF, x, N, a, b)
        plt.plot(x, f_X, label=f"N={N}")
    plt.xlabel("x")
    plt.ylabel("$f_X(x)$")
    plt.title("$S(T)$ Density Recovery Using the COS Method")
    plt.legend()
    plt.grid()

    # Plot histogram to approximate PDF of S(T)
    plt.figure(2)
    plt.plot(x, COSDensity(cF, x, N_values[-1], a, b), label=f"N={N}")
    plt.hist(S[:, -1], bins=50, density=True, alpha=0.6, edgecolor='grey')
    plt.title("Simulated Density for $S(T)$")
    plt.grid()

    # Show the plots
    plt.show()


# Example usage
main_calculation()
