import numpy as np
import matplotlib.pyplot as plt


def ComputeIntegrals(NoOfPaths, NoOfSteps, T):
    Z = np.random.normal(0.0, 1.0, [NoOfPaths, NoOfSteps])
    W = np.zeros([NoOfPaths, NoOfSteps + 1])
    I1 = np.zeros([NoOfPaths, NoOfSteps + 1])
    I2 = np.zeros([NoOfPaths, NoOfSteps + 1])
    time = np.zeros([NoOfSteps + 1])

    dt = T / float(NoOfSteps)
    for i in range(0, NoOfSteps):

        # Making sure that samples from a normal have mean 0 and variance 1

        if NoOfPaths > 1:
            Z[:, i] = (Z[:, i] - np.mean(Z[:, i])) / np.std(Z[:, i])
        W[:, i + 1] = W[:, i] + np.power(dt, 0.5) * Z[:, i]
        I1[:, i + 1] = I1[:, i] + W[:, i] * dt
        I2[:, i + 1] = I2[:, i] + (T - i*dt) * (W[:, i + 1] - W[:, i])
        time[i + 1] = time[i] + dt

    paths = {"time": time, "W": W, "I1": I1, "I2": I2}
    return paths


NoOfPaths = 1
NoOfSteps = 1000
T = 5

W_t = ComputeIntegrals(NoOfPaths, NoOfSteps, T)
timeGrid = W_t["time"]
intWsds = W_t["I1"]
inttsdWs = W_t["I2"]

print(intWsds[0][-1])
print(inttsdWs[0][-1])

plt.figure(1)
plt.subplot(1, 2, 1)
plt.plot(timeGrid, np.transpose(intWsds), 'r')
plt.grid()
plt.xlabel("time")
plt.ylabel("value")
plt.title("$\int_0^t W(s) ds$")

plt.subplot(1, 2, 2)
plt.plot(timeGrid, np.transpose(inttsdWs), 'k')
plt.grid()
plt.xlabel("time")
plt.ylabel("value")
plt.title("$\int_0^t(t-s)dW(s)$")

plt.show()
