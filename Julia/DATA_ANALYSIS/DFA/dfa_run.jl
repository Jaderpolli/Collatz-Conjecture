include("dfa_modules.jl")

import Main.DFA

mkpath("DATA/DFA_STATIONARY")
mkpath("DATA/DFA_STATIONARY_FIT")

mVectorSize = 180
MaxRand = 10
maximumPrimeBlockSize =  6
types = ["Random", "Prime"]

function main()
    for i in 1:length(types)
        type = types[i]
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                println(
                100*(k/(factorial(primeBlockSize))*1/((maximumPrimeBlockSize-1)*(length(types))) +(j-2)/((maximumPrimeBlockSize-1)*(length(types)))+(i-1)/length(types))
                )
                DFA.savingdfa(k,mVectorSize, MaxRand, primeBlockSize; type)
                DFA.savingfitdfa(k,mVectorSize, MaxRand, primeBlockSize; type)
            end
        end
    end
end

main()
