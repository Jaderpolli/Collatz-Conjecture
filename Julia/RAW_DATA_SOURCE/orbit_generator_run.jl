include("orbit_generator_modules.jl")

import Main.SavingOrbitsPowerOf2
import Main.SavingOrbitsBase10

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

function orbits_generators()
    mkpath("RAW_DATA/ORBITS")

    # variables of creation of initial conditions

    mVectorSize = 360 #this value is picked so that it is the closest to 200 (the best size for the purposes)
                        #divisible by 2,3,4,5,6 that are the blocksizes of primes
    MaxRand = 10
    maximumPrimeBlockSize =  4 # with this variable, we create 1!+2!+3!+4!+5!+6!=873 initial conditions for each type (i.e. 1746 initial conditions)
    types = ["Even", "Odd", "Adjacent"]

    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            println(
            100*((j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
            )
            SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, primeBlockSize ;type)
        end
    end

    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            println(
            100*((j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
            )
            SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, primeBlockSize ;type)
        end
    end
end

function specialorbits()
    mkpath("RAW_DATA/SPECIAL_ORBITS")

    primeOrder = 5
    mVectorSize = 1002 #divisible by 2 and 3 (the primeblocksizes below)
    primeBlockSize = [2, 3]
    type = "Prime"
    for j in primeBlockSize
        SavingOrbitsBase10.savingspecialorbitbase10(primeOrder, mVectorSize, j; type)
        SavingOrbitsPowerOf2.savingspecialorbitpowerof2(primeOrder, mVectorSize, j; type)
    end
end

orbits_generators()
