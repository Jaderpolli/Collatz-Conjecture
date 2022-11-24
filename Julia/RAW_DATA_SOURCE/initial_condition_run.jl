include("initial_condition_modules.jl")

import Main.AlgorithmsOfmVectors
import Main.InitialConditionsGenerator
import Main.SavingInitialConditions

println("Rodando initial_condition_run.jl")

function standardinitialcontitions()
    mkpath("RAW_DATA/INITIAL_CONDITIONS")

    # variables of creation of initial conditions

    mVectorSizes = [180,#= 2100=#] #this value is picked so that it generate large enough orbits and is
                        #divisible by 2,3,4,5 that are the blocksizes of primes
    MaxRand = 10
    maximumBlockSize =  5 # with this variable, we create 1!+2!+3!+4!+5!=152 initial conditions for each type (i.e. 608 initial conditions)
    types = [#="Random", "Prime" "Even", "Odd", =# "Pascal", "Oscilatory", "Linear"]

    i = 0
    for type in types
        i += 1
        if type == "Linear"
            BlockSizes = range(3,60, step = 1)
            logsum = 2000
            for BlockSize in BlockSizes
                epsilon = BlockSize*(BlockSize+1)/2
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, BlockSize; type)
                SavingInitialConditions.saving_base10(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Pascal"
            mVectorSize  = 180
            BlockSizes = range(2, 6, step = 1)
            for BlockSize in BlockSizes
                SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, BlockSize; type)
                SavingInitialConditions.saving_base10(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Oscilatory"
            logsum = 3000
            BlockSizes = range(2, 100, step = 2)
            for BlockSize in BlockSizes
                epsilon = round(Int,BlockSize^2/4+BlockSize)
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                #println("$(epsilon), $(BlockSize), $(mVectorSize)")
                SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, BlockSize; type)
                SavingInitialConditions.saving_base10(mVectorSize, MaxRand, BlockSize; type)
            end
        else
            for mVectorSize in mVectorSizes
                for j in 2:maximumBlockSize
                    BlockSize = j
                    println(
                    100*((j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))
                    )
                    SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, BlockSize; type)
                    SavingInitialConditions.saving_base10(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end
end

standardinitialcontitions()
