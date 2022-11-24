include("von_neumann_entropy_modules.jl")
import Main.VNEntropyEvaluation

println("Rodando von_neumann_entropy_run.jl")

function main()
    mkpath("DATA/VON_NEUMANN_ENTROPY")

    mVectorSizes = [180 2100]
    maximumBlockSize = 5
    MaxRand = 10
    types = ["Random", "Prime", "Even", "Odd", "Pascal", "Oscilatory", "Linear"]

    i = 0
    for type in types
        mkpath("DATA/POWER_SPECTRA_STATIONARY/VN_$(type)")
        i += 1
        println("$(type), $(i/length(types))")
        if type == "Linear"
            BlockSizes = range(3,60, step = 1)
            logsum = 2000
            for BlockSize in BlockSizes
                epsilon = BlockSize*(BlockSize+1)/2
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Pascal"
            mVectorSize = 180
            BlockSizes = range(2, 6, step = 1)
            for BlockSize in BlockSizes
                VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
            end
        elseif type == "Oscilatory"
            logsum = 3000
            BlockSizes = range(2, 100, step = 2)
            for BlockSize in BlockSizes
                epsilon = round(Int,BlockSize^2/4+BlockSize)
                mVectorSize = round(Int, logsum*BlockSize/epsilon)
                VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
            end
        else
            for mVectorSize in mVectorSizes
                for j in 2:maximumBlockSize
                    BlockSize = j
                    VNEntropyEvaluation.savingVariatingTimeSeries(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end

end

main()
