import numpy as np
import matplotlib.pyplot as plt


class CILS:
    def __init__(self, alpha, beta, kappa, periods, sigma=0.1):
        self.alpha = alpha  # Intercept of demand function
        self.beta = beta    # Slope of demand function
        self.kappa = kappa  # Threshold parameter for price adjustments
        self.periods = periods
        self.sigma = sigma  # Standard deviation of demand noise
        self.prices = []
        self.demands = []
        self.regrets = []

    def simulate_demand(self, price):
        """Simulate demand using the linear model with noise."""
        return self.alpha + self.beta * price + np.random.normal(0, self.sigma)

    def update_price(self, t):
        """Update price using the constrained ILS approach."""
        if t == 0:
            return np.random.uniform(1, 10)  # Random initial price
        else:
            avg_price = np.mean(self.prices)
            last_price = self.prices[-1]
            delta = last_price - avg_price
            if abs(delta) < self.kappa * t**-0.25:
                return last_price + np.sign(delta) * self.kappa * t**-0.25
            return self.phi()

    def phi(self):
        """Calculate the revenue maximizing price."""
        return -self.alpha / (2 * self.beta)

    def run_simulation(self):
        """Run the simulation for a given number of periods."""
        for t in range(self.periods):
            price = self.update_price(t)
            demand = self.simulate_demand(price)
            self.prices.append(price)
            self.demands.append(demand)
            optimal_price = self.phi()
            optimal_demand = self.simulate_demand(optimal_price)
            optimal_revenue = optimal_price * optimal_demand
            actual_revenue = price * demand
            regret = optimal_revenue - actual_revenue
            self.regrets.append(regret if t == 0 else self.regrets[-1] + regret)

    def plot_results(self):
        """Generate plots for the simulation results."""
        plt.figure(figsize=(18, 6))

        # Plot demand vs price
        plt.subplot(131)
        plt.scatter(self.prices, self.demands, color='blue', label='Price vs Demand')
        plt.plot(self.prices, [self.alpha + self.beta * p for p in self.prices], label='True Demand')
        plt.title('Demand vs Price')
        plt.xlabel('Price')
        plt.ylabel('Demand')
        plt.legend()

        # Plot cumulative regret for kappa = 0
        plt.subplot(132)
        plt.plot(self.regrets, label='Cumulative Regret (kappa=0)')
        plt.title('Cumulative Regret Over Time')
        plt.xlabel('Time Period')
        plt.ylabel('Cumulative Regret')
        plt.legend()

        # Plot regret for various values of kappa
        plt.subplot(133)
        for kappa in [0, 0.1, 0.5, 1.0]:
            self.kappa = kappa
            self.prices = []
            self.demands = []
            self.regrets = []
            self.run_simulation()
            plt.plot(self.regrets, label=f'kappa={kappa}')

        plt.title('Regret for Various Kappa')
        plt.xlabel('Time Period')
        plt.ylabel('Regret')
        plt.legend()

        plt.tight_layout()
        plt.show()

# Parameters
alpha = 20  # Intercept
beta = -2   # Slope
kappa = 0.5 # Threshold parameter
periods = 100

# Create instance and run
cils_model = CILS(alpha, beta, kappa, periods)
cils_model.run_simulation()
cils_model.plot_results()
