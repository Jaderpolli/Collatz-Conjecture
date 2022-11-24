include("orbit_generator_modules.jl")

import Main.SavingOrbitsPowerOf2
import Main.SavingOrbitsBase10

println("Rodando orbit_generator_run.jl")

# If you will run SavingBase10, then you should do it BEFORE SavingPowerOf2,
# because PowerOf2 reads from the base10 that has been generated.

function orbits_generators()
    mkpath("RAW_DATA/ORBITS")

    # variables of creation of initial conditions

    mVectorSizes = [180 2100] #this value is picked so that it generate large enough orbits and is
                        #divisible by 2,3,4,5 that are the blocksizes of primes
    MaxRand = 10
    maximumBlockSize =  5 # with this variable, we create 1!+2!+3!+4!+5!=152 initial conditions for each type (i.e. 608 initial conditions)
    types = [#="Random", "Prime", "Even", "Odd",=# "Pascal", "Oscilatory","Linear"]
    #types = ["Linear"]

    i = 0
    Threads.@threads for type in types
        if type == "Linear"
            BlockSizes = range(3,60, step = 1)
            logsum = 2000
            for BlockSize in BlockSizes
                epsilon = BlockSize*(BlockSize+1)/2
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
            end
        elseif type == "Pascal"
            mVectorSize = 180
            BlockSizes = range(2, 6, step = 1)
            for BlockSize in BlockSizes
                SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
            end
        elseif type == "Oscilatory"
            logsum = 3000
            BlockSizes = range(2, 100, step = 2)
            for BlockSize in BlockSizes
                epsilon = round(Int,BlockSize^2/4+BlockSize)
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
            end
        else
            for mVectorSize in mVectorSizes
                for j in 2:maximumBlockSize
                    BlockSize = j
                    SavingOrbitsBase10.savingorbitbase10(mVectorSize, MaxRand, BlockSize ;type)
                end
            end
        end
    end
    i = 0
    Threads.@threads for type in types
        i += 1
        if type == "Linear"
            BlockSizes = range(3,60, step = 1)
            logsum = 2000
            for BlockSize in BlockSizes
                epsilon = BlockSize*(BlockSize+1)/2
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
            end
        elseif type == "Pascal"
            mVectorSize = 180
            BlockSizes = range(2, 6, step = 1)
            for BlockSize in BlockSizes
                SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
            end
        elseif type == "Oscilatory"
            logsum = 3000
            BlockSizes = range(2, 100, step = 2)
            for BlockSize in BlockSizes
                epsilon = round(Int,BlockSize^2/4+BlockSize)
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
            end
        else
            for mVectorSize in mVectorSizes
                for j in 2:maximumBlockSize
                    BlockSize = j
                    SavingOrbitsPowerOf2.savingorbitpowerof2(mVectorSize, MaxRand, BlockSize ;type)
                end
            end
        end
    end
end

orbits_generators()
