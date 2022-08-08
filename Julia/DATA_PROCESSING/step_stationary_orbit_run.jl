include("step_stationary_orbit_modules.jl")

import Main.StepStationary

println("Rodando step_stationary_orbit_run.jl")

mkpath("DATA/STEP_STATIONARY")

mVectorSizes = [180, 2100]
MaxRand = 10
maximumBlockSize =  5
types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]

function main()
    Threads.@threads for mVectorSize in mVectorSizes
        i = 0
        Threads.@threads for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    StepStationary.savingstepsstationary(mVectorSize, MaxRand, BlockSize; type)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    percent = 100*(1/((maximumBlockSize-1)*(length(types))) +(j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))
                    println(
                    "Step Stationary $(percent),
                    type = $(type), mVectorSize = $(mVectorSize)"
                    )
                    StepStationary.savingstepsstationary(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end
end

main()
