import numpy as np
import matplotlib.pyplot as plt


# We simulate paths for dX(t) = W(t) dW(t) with X(t_0)=0
def GenerateMonteCarloPaths(NoOfPaths,NoOfSteps,T):    
    Z = np.random.normal(0.0,1.0,[NoOfPaths,NoOfSteps])
    I = np.zeros([NoOfPaths, NoOfSteps+1])
    W = np.zeros([NoOfPaths, NoOfSteps+1])

    dt = T / float(NoOfSteps)
    t = 0.0
    for i in range(0,NoOfSteps):
        # making sure that samples from normal have mean 0 and variance 1
        if NoOfPaths > 1:
            Z[:,i] = (Z[:,i] - np.mean(Z[:,i])) / np.std(Z[:,i])
        W[:,i+1] = W[:,i] + np.power(dt, 0.5)*Z[:,i]
        I[:,i+1] = I[:,i] + W[:,i]**6.0 * (W[:,i+1]-W[:,i])
        t = t + dt
    return I


def mainCalculation():
    NoOfPaths = 10000
    NoOfSteps = 100
    T = 1/2
    I = GenerateMonteCarloPaths(NoOfPaths,NoOfSteps,T)
        
    EI_T = np.mean(I[:,-1])
    VarI_T = np.var(I[:,-1])
    print("E(I(T)) = {0:4e}  and Var(I(T))={1:4f}".format(EI_T,VarI_T))
    EI_theo = 0.0
    VarI_theo = 1485*T**7.0
    print("Exact solution: E(I(T)) = {0:4e}  and Var(I(T))={1:4f}".format(EI_theo,VarI_theo))

    plt.figure(1)
    plt.subplot(1,2,1)
    plt.plot(np.linspace(0,T,NoOfSteps+1), np.transpose(I))
    plt.grid()
    plt.xlabel("time")
    plt.ylabel("I(t)")
    
    plt.subplot(1,2,2)
    plt.grid()
    plt.hist(I[:,-1],25)

    plt.show()

mainCalculation()
