include("power_spectra_modules.jl")

import Main.PowerSpectra

println("Rodando power_spectra_run.jl")

mkpath("DATA/POWER_SPECTRA_STATIONARY")
mkpath("DATA/POWER_SPECTRA_STATIONARY_FIT")

mVectorSizes = [180, 2100]
MaxRand = 10
maximumBlockSize =  5
types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]

function main()
    Threads.@threads for mVectorSize in mVectorSizes
        i = 0
        Threads.@threads for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    PowerSpectra.savingpowerspectrum(mVectorSize, MaxRand, BlockSize; type)
                    PowerSpectra.savingfitPowerSpectra(mVectorSize, MaxRand, BlockSize; type)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    println(
                    "Power Spectra $(100*(1/((maximumBlockSize-1)*(length(types))) +(j-2)/((maximumBlockSize-1)*(length(types)))+(i-1)/length(types))),
                    type = $(type), mVectorSize = $(mVectorSize)"
                    )
                    PowerSpectra.savingpowerspectrum(mVectorSize, MaxRand, BlockSize; type)
                    PowerSpectra.savingfitPowerSpectra(mVectorSize, MaxRand, BlockSize; type)
                end
            end
        end
    end
end

main()
