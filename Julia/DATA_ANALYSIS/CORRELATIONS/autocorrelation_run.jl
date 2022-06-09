include("autocorrelation_modules.jl")
import Main.SavingAutocorrelation

function acf()
    mkpath("DATA/ACF")

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
                SavingAutocorrelation.savingAutocorrelation(k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

function acfspecial()
    mkpath("DATA/ACF")

    primeOrder = 5
    mVectorSize = 1002 #divisible by 2 and 3 (the primeblocksizes below)
    primeBlockSize = [2, 3]
    type = "Prime"
    for j in primeBlockSize
        SavingAutocorrelation.savingSpecialAutocorrelation(primeOrder,mVectorSize,j; type)
    end
end

mkpath("DATA/ACF_STATIONARY_FIT")
mkpath("DATA/ACF_STATIONARY")

function acfstationary()

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
                SavingAutocorrelation.savingAutocorrelationStationary(k, mVectorSize, MaxRand, primeBlockSize; type)
                SavingAutocorrelation.savingfitautocorrelation(k, mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

acfstationary()
