include("power_spectra_modules.jl")

import Main.PowerSpectra

mkpath("DATA/POWER_SPECTRA_STATIONARY")
mkpath("DATA/POWER_SPECTRA_STATIONARY_FIT")

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
                # HERE I SHOULD CALL THE FUNCTIONS FROM MODULES AND SAVE THE POWER SPECTRA AND FITS
            end
        end
    end
end

main()
