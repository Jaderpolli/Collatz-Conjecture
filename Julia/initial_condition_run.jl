include("initial_condition_modules.jl")

import Main.Algorithms
import Main.InitialConditions
import Main.Saving

# variables of creation of initial conditions

vecsize = 100
maxrand = 10
blocksize = 4
type = "Random"

var = (vecsize, maxrand, blocksize, type)

using DelimitedFiles
writedlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat",var)

Saving.saving_powers_of_2(vecsize, maxrand, blocksize; type)
Saving.saving_base10(vecsize, maxrand, blocksize; type)
