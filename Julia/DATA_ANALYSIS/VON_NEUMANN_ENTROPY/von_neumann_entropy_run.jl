include("von_neumann_entropy_modules.jl")
import Main.VNEntropyEvaluation
using Plots

function main()
    mkpath("DATA/VON_NEUMANN_ENTROPY")

    mVectorSize = 360
    maximumPrimeBlockSize = 4
    MaxRand = 10
    types = ["Even", "Odd", "Adjacent"]

    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                percent = 100*(k/10+(j-2)/maximumPrimeBlockSize)
                println(percent)
                VNEntropyEvaluation.savingVariatingTimeSeries(percent, k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

main()
