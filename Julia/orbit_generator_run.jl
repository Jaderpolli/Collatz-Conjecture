include("orbit_generator_modules.jl")

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

import Main.SavingBase10
SavingBase10.savingbase10()

import Main.SavingPowerOf2
SavingPowerOf2.savingpowerof2()
