import numpy as np
import math


# Function to calculate the UCB for an arm
def ucb_score(n_selections, sum_rewards, delta):
    if n_selections == 0:
        return float('inf')  # Handle the case where an arm hasn't been selected yet
    average_reward = sum_rewards / n_selections
    confidence_interval = math.sqrt((2 * math.log(1 / delta)) / n_selections)
    return average_reward + confidence_interval


# Main UCB algorithm implementation
def ucb(k, delta, n_rounds, true_reward_means):
    n_selections = np.zeros(k)  # Number of times each arm was selected
    sum_rewards = np.zeros(k)  # Sum of rewards for each arm
    chosen_arms = []  # List to keep track of which arm is chosen at each round

    for _ in range(n_rounds):
        arm = np.argmax([ucb_score(n_selections[i], sum_rewards[i], delta) for i in range(k)])
        chosen_arms.append(arm)

        # Simulating the reward (replace this with real reward mechanism)
        reward = np.random.binomial(n=1, p=true_reward_means[arm])

        n_selections[arm] += 1
        sum_rewards[arm] += reward

    return chosen_arms, sum_rewards


# Number of arms
k = 10
# Confidence level parameter
delta = 0.1
# Number of rounds
n_rounds = 1000
# True means of rewards for each arm (for simulation purposes)
true_reward_means = np.random.rand(k)

# Run the UCB algorithm
chosen_arms, sum_rewards = ucb(k, delta, n_rounds, true_reward_means)

print(true_reward_means, sum_rewards)

# output
# [0.07541132 0.5127361  0.73532455 0.41081583 0.50335577 0.12209112 0.42460312 0.37059041 0.48231878 0.03842689]
# [  0.  29. 588.  10.  18.   0.   0.   8.  17.   0.]
