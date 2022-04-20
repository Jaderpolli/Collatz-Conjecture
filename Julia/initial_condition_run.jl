include("initial_condition_modules.jl")

import Main.AlgorithmsOfmVectors
import Main.InitialConditionsGenerator
import Main.SavingInitialConditions

mkpath("RAW_DATA")

# variables of creation of initial conditions

mVectorSize = 180 #this value is picked so that it is the closest to 200 (the best size for the purposes)
                    #divisible by 2,3,4,5,6 that are the blocksizes of primes
MaxRand = 10
maximumPrimeBlockSize =  6 # with this variable, we create 1!+2!+3!+4!+5!+6!=873 initial conditions for each type (i.e. 1746 initial conditions)
types = ["Random", "Prime"]

for i in 1:length(types)
    type = types[i]
    for j in 2:maximumPrimeBlockSize
        primeBlockSize = j
        var = (mVectorSize, MaxRand, primeBlockSize, type)

        #=
        using DelimitedFiles
        writedlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat",var)
        =#

        SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, primeBlockSize; type)
        SavingInitialConditions.saving_base10(mVectorSize, MaxRand, primeBlockSize; type)
    end
end
