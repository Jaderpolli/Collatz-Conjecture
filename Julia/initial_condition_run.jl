include("initial_condition_modules.jl")

import Main.Algorithm
import Main.InitialConditions
import Main.Saving

# Global variables of creation of initial conditions
vecsize = 100
blocksize = 4
maxrand = 10
type = "Random"
Saving.saving_powers_of_2(vecsize, blocksize, maxrand; type)
Saving.saving_base10(vecsize, blocksize, maxrand; type)
