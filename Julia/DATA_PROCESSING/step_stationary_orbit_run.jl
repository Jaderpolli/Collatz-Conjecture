include("step_stationary_orbit_modules.jl")

import Main.StepStationary

println("Rodando step_stationary_orbit_run.jl")

mkpath("DATA/STEP_STATIONARY")

mVectorSizes = [180#=, 2100=#]
MaxRand = 10
maximumBlockSize =  5
types = [#="Random", "Prime", "Even", "Odd", =#"Pascal", "Oscilatory", "Linear"]

function main()
    i = 0
    Threads.@threads for type in types
        i += 1
        if type == "Linear"
            BlockSizes = range(3,60, step = 1)
            logsum = 2000
            for BlockSize in BlockSizes
                epsilon = BlockSize*(BlockSize+1)/2
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                StepStationary.savingstepsstationary(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Pascal"
            mVectorSize = 180
            BlockSizes = range(2, 6, step = 1)
            for BlockSize in BlockSizes
                StepStationary.savingstepsstationary(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Oscilatory"
            logsum = 3000
            BlockSizes = range(2, 100, step = 2)
            for BlockSize in BlockSizes
                epsilon = round(Int,BlockSize^2/4+BlockSize)
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                StepStationary.savingstepsstationary(mVectorSize, MaxRand, BlockSize; type)
            end
        end
    end
end

main()
