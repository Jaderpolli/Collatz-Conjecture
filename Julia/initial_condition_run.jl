include("initial_condition_modules.jl")

import Main.AlgorithmsOfmVectors
import Main.InitialConditionsGenerator
import Main.SavingInitialConditions

# variables of creation of initial conditions

mVectorSize = 100
MaxRand = 10
primeBlockSize = 4
type = "Random"

var = (mVectorSize, MaxRand, primeBlockSize, type)

using DelimitedFiles
writedlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat",var)

SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, primeBlockSize; type)
SavingInitialConditions.saving_base10(mVectorSize, MaxRand, primeBlockSize; type)
