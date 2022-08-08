include("initial_condition_modules.jl")

import Main.AlgorithmsOfmVectors
import Main.InitialConditionsGenerator
import Main.SavingInitialConditions

println("Rodando initial_condition_run.jl")

function standardinitialcontitions()
    mkpath("RAW_DATA/INITIAL_CONDITIONS")

    # variables of creation of initial conditions

    mVectorSizes = [#=180,=# 2100] #this value is picked so that it generate large enough orbits and is
                        #divisible by 2,3,4,5 that are the blocksizes of primes
    MaxRand = 10
    maximumBlockSize =  5 # with this variable, we create 1!+2!+3!+4!+5!=152 initial conditions for each type (i.e. 608 initial conditions)
    types = [#="Random", "Prime"=# "Even"#=, "Odd", "Pascal Triangle", "Oscilatory", "Linear"=#]

    for mVectorSize in mVectorSizes
        i = 0
        for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    SavingInitialConditions.saving_powers_of_2(mVectorSize, MaxRand, BlockSize; type)
                    SavingInitialConditions.saving_base10(mVectorSize, MaxRand, BlockSize; type)
                end
            else
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
