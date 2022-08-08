include("increments_modules.jl")
import Main.SavingIncrements

println("Rodando increments_run.jl")

function increments()
    mkpath("DATA/INCREMENTS")


    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]

    Threads.@threads for mVectorSize in mVectorSizes
        i = 0
        Threads.@threads for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    println("Linear, BlockSize = $(BlockSize)")
                    SavingIncrements.savingLogarithmcIncrements(mVectorSize, MaxRand, BlockSize; type)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    percent = 100*(1/((maximumBlockSize-1)*(length(types))) +(j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))
                    println(
                    "Increments $(percent),
                    type = $(type), mVectorSize = $(mVectorSize)"
                    )
                    SavingIncrements.savingLogarithmcIncrements(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end
end

increments()
