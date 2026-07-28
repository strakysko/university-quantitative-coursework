import numpy as np
import matplotlib.pyplot as plt
import math


def simulate_ucb_regret(n, mu1, mu2, num_simulations, delta):
    regrets = []

    for _ in range(num_simulations):
        counts = np.zeros(2)  # Number of times each arm is pulled
        rewards = np.zeros(2)  # Total reward from each arm
        ucb = np.zeros(2)  # Upper confidence bounds

        # Initial pull for each arm to initialize
        for i in range(2):
            reward = np.random.normal([mu1, mu2][i], 1)
            counts[i] += 1
            rewards[i] += reward

        # Subsequent pulls according to UCB
        for _ in range(2, n):
            ucb = rewards / counts + np.sqrt(2 * np.log(1/delta) / counts)
            arm = np.argmax(ucb)
            reward = np.random.normal([mu1, mu2][arm], 1)
            rewards[arm] += reward
            counts[arm] += 1

        # Calculate total regret
        optimal_reward = mu1 * n
        actual_reward = rewards[0] + rewards[1]
        regret = optimal_reward - actual_reward

        regrets.append(regret)

    return np.mean(regrets)


# Parameters
n = 1000
m = [25, 50, 75, 100]
mu1 = 0
num_simulations = 1000
delta_values = np.linspace(0.001, 1, 100)
Delta_values = [1/math.sqrt(n), 1/n, 1/(n**2)]

# Simulate regrets for varying Δ using UCB
for Delta in Delta_values:
    regrets_ucb = []
    for delta in delta_values:
        mu2 = -delta
        regret = simulate_ucb_regret(n, mu1, mu2, num_simulations, Delta)
        regrets_ucb.append(regret)

    plt.plot(delta_values, regrets_ucb, label='UCB with $\delta$ = {}'.format(Delta), linewidth=2)

# Plotting
plt.title('Expected Regret of ETC for Gaussian Bandit')
plt.xlabel('Suboptimality Gap Δ')
plt.ylabel('Expected Regret')
plt.grid(True)
plt.legend()
plt.show()
