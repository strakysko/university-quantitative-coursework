import numpy as np
import matplotlib.pyplot as plt
import math


def simulate_etc_regret(n, mu1, mu2, num_simulations, m):
    regrets = []

    for _ in range(num_simulations):
        # Simulate rewards from both arms during the exploration phase
        rewards_arm1 = np.random.normal(mu1, 1, m)
        rewards_arm2 = np.random.normal(mu2, 1, m)

        # Compute empirical means
        mean_arm1 = np.mean(rewards_arm1)
        mean_arm2 = np.mean(rewards_arm2)

        # Decide best arm for the commitment phase
        best_arm = 1 if mean_arm1 >= mean_arm2 else 2

        # Simulate rewards for the commitment phase
        if best_arm == 1:
            rewards_commitment = np.random.normal(mu1, 1, n - m)
        else:
            rewards_commitment = np.random.normal(mu2, 1, n - m)

        # Calculate regret
        optimal_reward = mu1 * n
        actual_reward = np.sum(rewards_arm1) + np.sum(rewards_arm2) + np.sum(rewards_commitment)
        regret = optimal_reward - actual_reward

        regrets.append(regret)

    # Return the average regret
    return np.mean(regrets)


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
num_simulations = 100
delta_values = np.linspace(0.001, 1, 100)
Delta = 1/(n**2)

# Simulate regrets for varying Δ
for m_value in m:
    regrets = []

    for delta in delta_values:
        mu2 = -delta
        regret = simulate_etc_regret(n, mu1, mu2, num_simulations, m_value)
        regrets.append(regret)

    plt.plot(delta_values, regrets, label='ETC with m = {}'.format(m_value), linewidth=2)

# Simulate regrets for the optimal m
regrets = []
for delta in delta_values:
    mu2 = -delta
    m_value = max(1, int(4 / delta ** 2 * math.log((n * delta ** 2) / 4)))
    regret = simulate_etc_regret(n, mu1, mu2, num_simulations, m_value)
    regrets.append(regret)

plt.plot(delta_values, regrets, label='ETC with m in (6.5)', linewidth=2)

# Simulate regrets for varying Δ using UCB
regrets_ucb = []
for delta in delta_values:
    mu2 = -delta
    regret = simulate_ucb_regret(n, mu1, mu2, num_simulations, Delta)
    regrets_ucb.append(regret)

plt.plot(delta_values, regrets_ucb, label='UCB', linewidth=2)

# Plotting
plt.title('Expected Regret of ETC for Gaussian Bandit')
plt.xlabel('Suboptimality Gap Δ')
plt.ylabel('Expected Regret')
plt.grid(True)
plt.legend()
plt.show()
