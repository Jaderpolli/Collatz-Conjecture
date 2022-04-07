using DelimitedFiles

# These are the variables that define what type of initial condition is being used
type = "Random"
var = readdlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat", header = false)
var = Array(var)
vecsize = var[1] #size of the m-vector
maxrand = var[2] #when type = "Random" this is the maximum value possible
blocksize = var[3] # when type = "Prime" this is the number of the first primes taken

# This module contains the functions for generating the stationary orbit from collatz base 10
module StationaryOrbits
    using DelimitedFiles
    function gamma_2(i::Int64; type::String)
        if type == "Prime"
            orb = readdlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_base10.csv", BigInt, header = false)
        elseif type == "Random"
            orb = readdlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_base10.csv", BigInt, header = false)
        end
        orb = log2.(orb)
        dy = orb[end]-orb[1]
        dx = length(orb)
        γ₂ = dy/dx
        return(orb,γ₂)
    end

    function fit_gamma_2(orb, γ₂)
        dx = length(orb)
        fit = zeros(dx)
        n = range(1, dx, length = dx)
        for i in 1:dx
            fit[i] = orb[1]+γ₂*i
        end
        return(fit)
    end

    function stacionary(orb, fit)
        dx = length(orb)
        dif = zeros(dx)
        for i in 1:dx
            dif[i] = orb[i] - fit[i]
        end
        return(dif)
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
        ps_dif = (fft_dif).^2
    end
end
