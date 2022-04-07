using DelimitedFiles

# These are the variables that define what type of initial condition is being used
type = "Random"
var = readdlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat", header = false)
var = Array(var)
mVectorSize = var[1] #size of the m-vector
MaxRand = var[2] #when type = "Random" this is the maximum value possible
primeBlockSize = var[3] # when type = "Prime" this is the number of the first primes taken

# This module contains the functions for generating the stationary orbit from collatz base 10
module StationaryOrbits
    using DelimitedFiles
    function gamma_2(i::Int64; type::String)
        orbit = readdlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
        orbit = log2.(orbit)
        Δy = orbit[end]-orbit[1]
        Δx = length(orb)
        γ₂ = Δy/Δx
        return(orbit,γ₂)
    end

    function fit_gamma_2(orbit, γ₂)
        Δx = length(orbit)
        fit = zeros(Δx)
        for i in 1:Δx
            fitFunction[i] = orbit[1]+γ₂*i
        end
        return(fitFunction)
    end

    function stacionary(orbit, fitFunction)
        Δx = length(orbit)
        differenceOrbitFit = zeros(Δx)
        for i in 1:Δx
            differenceOrbitFit[i] = orbit[i] - fitFunction[i]
        end
        return(differenceOrbitFit)
    end
end

module PowerSpectra
    using FFTW
    using LsqFit


    import Main.StationaryOrbits
    function powerspectrum()
        orb_gamma = StationaryOrbits.gamma_2(i; type)
        orb = orb_gamma[1]
        γ₂ = orb_gamma[2]
        fit = fit_gamma_2(orb,γ₂)
        dif = stacionary(orb,fit)
        fft_dif = abs.(fft(dif))
        ps_dif = fft_dif.^2
    end
end
