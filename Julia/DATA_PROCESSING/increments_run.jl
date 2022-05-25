include("increments_modules.jl")
import Main.SavingIncrements

function increments()
    mkpath("DATA/INCREMENTS")

    mVectorSize = 180

    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random", "Prime"]

    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                println(
                100*(k/(factorial(primeBlockSize))*1/((maximumPrimeBlockSize-1)*(length(types))) +(j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
                )
                SavingIncrements.savingLogarithmcIncrements(k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

function increments()
    mkpath("DATA/INCREMENTS")

    mVectorSize = 180

    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random", "Prime"]

    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                println(
                100*(k/(factorial(primeBlockSize))*1/((maximumPrimeBlockSize-1)*(length(types))) +(j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
                )
                SavingIncrements.savingLogarithmcIncrements(k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

function specialincrements()
    mkpath("DATA/SPECIAL_INCREMENTS")

    primeOrder = 5
    mVectorSize = 1002 #divisible by 2 and 3 (the primeblocksizes below)
    primeBlockSize = [2, 3]
    type = "Prime"
    for j in primeBlockSize
        SavingIncrements.savingSpecialLogarithmcIncrements(primeOrder,mVectorSize,j; type)
    end
end

specialincrements()
