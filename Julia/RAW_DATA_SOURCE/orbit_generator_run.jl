include("orbit_generator_modules.jl")

import Main.SavingOrbitsPowerOf2
import Main.SavingOrbitsBase10

println("Rodando orbit_generator_run.jl")

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

function orbits_generators()
    mkpath("RAW_DATA/ORBITS")

    # variables of creation of initial conditions

    mVectorSizes = [2100] #this value is picked so that it generate large enough orbits and is
                        #divisible by 2,3,4,5 that are the blocksizes of primes
    MaxRand = 10
    maximumBlockSize =  5 # with this variable, we create 1!+2!+3!+4!+5!=152 initial conditions for each type (i.e. 608 initial conditions)
    types = ["Random"#=, "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory","Linear"=#]
    #types = ["Linear"]

    Threads.@threads for mVectorSize in mVectorSizes
        i = 0
        #=Threads.@threads for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
                end
            else
                for j in 4:maximumBlockSize
                    BlockSize = j
                    println(
                    "orbitbase10 $(100*((j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))) type = $(type), BlockSize = $(BlockSize)"
                    )
                    SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
                end
            end
        end
        i = 0=#
        Threads.@threads for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [#=30, 60,=# 180]
                for BlockSize in BlockSizes
                    SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
                end
            else
                for j in 4:maximumBlockSize
                    BlockSize = j
                    println(
                    "orbitpowersof2 $(100*((j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))) type = $(type), mVectorSize = $(mVectorSize)"
                    )
                    SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
                end
            end
        end
    end
end

orbits_generators()
