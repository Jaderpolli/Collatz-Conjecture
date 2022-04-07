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

    function fitOrbitGamma_2(orbit, γ₂)
        Δx = length(orbit)
        fitOrbit = zeros(Δx)
        for i in 1:Δx
            fitOrbit[i] = orbit[1]+γ₂*i
        end
        return(fitOrbit)
    end

    function stationary(orbit, fitOrbit)
        Δx = length(orbit)
        stacionaryOrbit = zeros(Δx)
        for i in 1:Δx
            stationaryOrbit[i] = orbit[i] - fitOrbit[i]
        end
        return(stationaryOrbit)
    end
end

module PowerSpectra
    using FFTW
    using LsqFit

    import Main.StationaryOrbits
    function powerspectrum()
        orbit_gamma = StationaryOrbits.gamma_2(i; type)
        orbit = orbit_gamma[1]
        γ₂ = orbit_gamma[2]

        fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit,γ₂)
        stationaryOrbit = StationaryOrbits.stacionary(orbit, fitOrbit)

        fftStationaryOrbit = fftshift(abs.(fft(stationaryOrbit)))

        powerSpectraOfStationary = fftStationaryOrbit.^2
        frequencies = fftshift(fftfreq(length(powerSpectraOfStationary)))

        i = 1
        while frequencies[i] ≤ 0
            frequencies = frequencies[i+1:end]
        end
        powerSpectraOfStationary = powerSpectraOfStationary[1+(end-length(frequencies)):end]

        return(frequencies, powerSpectraOfStationary)
    end

    function fitPowerSpectra(frequencies, powerSpectraOfStacionary)

    end
end
