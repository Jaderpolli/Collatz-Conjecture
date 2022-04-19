include("orbit_generator_modules.jl")

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

# variables of creation of initial conditions

mVectorSize = 180 #this value is picked so that it is the closest to 200 (the best size for the purposes)
                    #divisible by 2,3,4,5,6 that are the blocksizes of primes
MaxRand = 10
maximumPrimeBlockSize =  6 # with this variable, we create 1!+2!+3!+4!+5!+6!=873 initial conditions for each type (i.e. 1746 initial conditions)
types = ["Random", "Prime"]

import Main.SavingOrbitsBase10
for i in 1:length(types)
    type = types[i]
    for j in 2:maximumPrimeBlockSize
        primeBlockSize = j
        SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, primeBlockSize ;type)
    end
end

import Main.SavingOrbitsPowerOf2
for i in 1:length(types)
    type = types[i]
    for j in 2:maximumPrimeBlockSize
        primeBlockSize = j
        SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, primeBlockSize ;type)
    end
end
