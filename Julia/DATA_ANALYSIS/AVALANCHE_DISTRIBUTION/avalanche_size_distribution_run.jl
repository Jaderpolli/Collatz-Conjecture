include("avalanche_distribution_modules.jl")
import Main.AvalanchesDistributions

function main()
    mkpath("DATA/AVALANCHES")
    mkpath("DATA/AVALANCHES_FIT")

    mVectorSize = 180
    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random", "Prime"]

    for i in eachindex(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                println(
                100*(k/(factorial(primeBlockSize))*1/((maximumPrimeBlockSize-1)*(length(types))) +(j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
                )
                #AvalanchesDistributions.savingavalanchedistribution(k, mVectorSize, MaxRand, primeBlockSize; type)
                AvalanchesDistributions.fitdistribution(k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

main()
