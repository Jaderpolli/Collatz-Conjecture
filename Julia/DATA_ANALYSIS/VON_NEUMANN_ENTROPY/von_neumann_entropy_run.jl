include("von_neumann_entropy_modules.jl")
import Main.VNEntropyEvaluation

println("Rodando von_neumann_entropy_run.jl")

function main()
    mkpath("DATA/VON_NEUMANN_ENTROPY")

    mVectorSizes = [2100]
    maximumBlockSize = 5
    MaxRand = 10
    types = [#="Random", "Prime", "Even",=# "Odd", "Pascal Triangle", "Oscilatory"#=, "Linear"=#]

    for mVectorSize in mVectorSizes
        i = 0
        for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    println(
                    "Von Neumann Entropy $(100*1/((maximumBlockSize-1)*(length(types))) +(j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))),
                    type = $(type), mVectorSize = $(mVectorSize)"
                    )
                    VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end
end

main()
