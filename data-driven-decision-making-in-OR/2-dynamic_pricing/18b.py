import numpy as np
import matplotlib.pyplot as plt


class ConstrainedILS:
    def __init__(self, theta_true, kappa, var=1, initial_guess=(0, 0)):
        self.theta_true = theta_true
        self.theta_est = np.array(initial_guess)
        self.kappa = kappa
        self.data = []
        self.cumulative_regret = 0
        self.regrets = []
        self.var = var

    def simulate_demand(self, price):
        return self.theta_true[0] + self.theta_true[1] * price + np.random.normal(0, self.var)

    def update_estimates(self):
        prices, demands = zip(*self.data)
        prices = np.array(prices)
        demands = np.array(demands)
        A = np.vstack([np.ones_like(prices), prices]).T
        theta_proposed, residuals, rank, s = np.linalg.lstsq(A, demands, rcond=None)
        if np.linalg.norm(theta_proposed - self.theta_est) > self.kappa:
            self.theta_est = theta_proposed

    def optimal_price(self):
        return -self.theta_true[0] / (2 * self.theta_true[1])

    def calculate_regret(self, price, demand):
        optimal_price = self.optimal_price()
        optimal_demand = self.theta_true[0] + self.theta_true[1] * optimal_price
        optimal_revenue = optimal_price * optimal_demand
        actual_revenue = price * demand
        regret = optimal_revenue - actual_revenue
        self.cumulative_regret += regret
        self.regrets.append(self.cumulative_regret)
        return regret

    def set_price(self):
        return np.random.uniform(1, 10)

    def run_simulation(self, num_periods):
        for _ in range(num_periods):
            price = self.set_price()
            demand = self.simulate_demand(price)
            self.data.append((price, demand))
            self.update_estimates()
            self.calculate_regret(price, demand)

    def plot_results(self):

        # Subplot 1: Demand vs Price
        prices = np.linspace(0, 10, 100)
        true_demands = self.theta_true[0] + self.theta_true[1] * prices
        estimated_demands = self.theta_est[0] + self.theta_est[1] * prices
        plt.plot(prices, true_demands, label='True Demand')
        plt.plot(prices, estimated_demands, label='Estimated Demand', linestyle='--')
        plt.scatter(*zip(*self.data), color='red', label='Data Points')
        plt.title('Demand vs Price')
        plt.xlabel('Price')
        plt.ylabel('Demand')
        plt.legend()
        plt.show()

        # Subplot 2: Cumulative Regret
        plt.plot(self.regrets, label='Cumulative Regret')
        plt.title('Cumulative Regret Over Time')
        plt.xlabel('Time Period')
        plt.ylabel('Cumulative Regret')
        plt.legend()

        plt.tight_layout()
        plt.show()


def analyze_kappa_vs_T(theta_true, kappa_values, T_values):
    results = np.zeros((len(kappa_values), len(T_values)))

    for i, kappa in enumerate(kappa_values):
        for j, T in enumerate(T_values):
            model = ConstrainedILS(theta_true=theta_true, kappa=kappa)
            model.run_simulation(num_periods=T)
            results[i, j] = model.cumulative_regret

    # Plot results
    plt.figure(figsize=(10, 6))
    for i, kappa in enumerate(kappa_values):
        plt.plot(T_values, results[i, :], label=f'kappa = {kappa}')
    plt.title('Regret over Different T for Various kappa')
    plt.xlabel('Number of Periods, T')
    plt.ylabel('Cumulative Regret')
    plt.legend()
    plt.grid(True)
    plt.show()


# Parameters
theta_true = [20, -2]
kappa = 0.5
T = 100
kappa_values = [0, 0.1, 0.5, 1.0, 1.5]
T_values = [20, 50, 100, 200, 500]

# Run and plot for a single run
model = ConstrainedILS(theta_true=theta_true, kappa=kappa)
model.run_simulation(num_periods=T)
model.plot_results()

# Analyze over different T and kappa
analyze_kappa_vs_T(theta_true, kappa_values, T_values)
