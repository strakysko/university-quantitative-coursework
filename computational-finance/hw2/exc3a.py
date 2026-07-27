from scipy.misc import derivative
import numpy as np
from scipy.optimize import brentq
import matplotlib.pyplot as plt


# Function definition
g = lambda x: (np.exp(x) + np.exp(-x)) / 2 - (2 * x)


brecht_root_1 = []
def wrapper_function1(x):
    brecht_root_1.append(x)
    return g(x)


brecht_root_2 = []
def wrapper_function2(x):
    brecht_root_2.append(x)
    return g(x)


def combined_root_finder(func, interval, tol=1e-6, only_newton=False):
    if func(interval[0]) * func(interval[1]) > 0:
        print("there is no root in this interval!")
    elif func(interval[0]) * func(interval[1]) < 0:
        k = 1
        x = [(interval[0] + interval[1]) / 2.0]
        delta = - func(x[-1]) / derivative(func, x[-1])

        while abs(delta / x[-1]) > tol:
            x.append(x[-1] + delta)
            if not only_newton:
                if np.sum(x[-1] < interval) in [0, 2]:
                    if func(interval[0]) * func(x[-1]) > 0:
                        interval[0] = x[-1] - delta
                    else:
                        interval[1] = x[-1] - delta
                        x[-1] = (interval[0] + interval[1]) / 2.0
            delta = - func(x[-1]) / derivative(func, x[-1])
            k += 1
        return x, k
    else:
        print("Lotterryy")


def combined_root_finder2(func, interval, tol=1e-6, only_newton=False):
    if func(interval[0]) * func(interval[1]) > 0:
        print("there is no root in this interval!")
    elif func(interval[0]) * func(interval[1]) < 0:
        k = 1
        x = (interval[0] + interval[1]) / 2.0
        delta = - func(x) / derivative(func, x)
        print(k, x)
        while abs(delta / x) > tol:
            x = x + delta
            if not only_newton:
                if np.sum(x < interval) in [0, 2]:
                    if func(interval[0]) * func(x) > 0:
                        interval[0] = x - delta
                    else:
                        interval[1] = x - delta
                        x = (interval[0] + interval[1]) / 2.0
            delta = - func(x) / derivative(func, x)
            k += 1
            print(k, x)
        return x, k
    else:
        print("Lotterryy")


# Newton-Raphson
newton_root_1, newton_k1 = combined_root_finder(g, [2, 3], only_newton=True)
newton_root_2, newton_k2 = combined_root_finder(g, [0, 2], only_newton=True)

print('From Newton-Raphson we have root = {0}'.format(newton_root_1[-1]))
print('From Newton-Raphson we have root = {0}'.format(newton_root_2[-1]))

# Combined root-finding
combined_root_1, k1 = combined_root_finder(g, [2, 3])
combined_root_2, k2 = combined_root_finder(g, [0, 2])

print('From combined root we have root = {0}'.format(combined_root_1[-1]))
print('From combined root we have root = {0}'.format(combined_root_2[-1]))


# Brent algorithm
brent_root_1 = brentq(wrapper_function1, 2, 3, full_output=True)
brent_root_2 = brentq(wrapper_function2, 0, 2, full_output=True)

print('From Brent algorithm we have root = {0}'.format(brent_root_1[0]))
print('From Brent algorithm we have root = {0}'.format(brent_root_2[0]))


plt.figure(1)

# Create index arrays for each vector
index1 = range(len(newton_root_1))
index2 = range(len(combined_root_1))
index3 = range(len(brecht_root_1))

# Plot each vector
plt.plot(index1, newton_root_1, '-o', label='Newton-Rhapson')
plt.plot(index2, combined_root_1, '-s', label='Combined method')
plt.plot(index3, brecht_root_1, '-s', label='Brechts method')

# Add some plot features
plt.title('Plot of iterations of root 1')
plt.xlabel('Iteration')
plt.ylabel('Value')
plt.legend()
plt.grid(True)

plt.figure(2)

# Create index arrays for each vector
index1 = range(len(newton_root_2))
index2 = range(len(combined_root_2))
index3 = range(len(brecht_root_2))

# Plot each vector
plt.plot(index1, newton_root_2, '-o', label='Newton-Rhapson')
plt.plot(index2, combined_root_2, '-s', label='Combined method')
plt.plot(index3, brecht_root_2, '-s', label='Brechts method')

# Add some plot features
plt.title('Plot of iterations of root 2')
plt.xlabel('Iteration')
plt.ylabel('Value')
plt.legend()
plt.grid(True)

# Show the plot
plt.show()
