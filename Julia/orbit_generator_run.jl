include("orbit_generator_modules.jl")

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

import Main.SavingOrbitsBase10
SavingOrbitsBase10.savingorbitbase10()

import Main.SavingOrbitsPowerOf2
SavingOrbitsPowerOf2.savingorbitpowerof2()
