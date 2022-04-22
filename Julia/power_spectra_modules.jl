module PowerSpectra
    using FFTW
    using LsqFit
    using DelimitedFiles

    function powerspectrum(stationaryOrbit)
        fftStationaryOrbit = fftshift(abs.(fft(stationaryOrbit)))

        powerSpectraOfStationary = 1/length(stationaryOrbit).*fftStationaryOrbit.^2
        frequencies = fftshift(fftfreq(length(powerSpectraOfStationary)))

        i = 1
        while frequencies[i] ≤ 0
            frequencies = frequencies[i+1:end]
        end
        powerSpectraOfStationary = powerSpectraOfStationary[1+(end-length(frequencies)):end]

        return(frequencies, powerSpectraOfStationary)
    end

    function savingpowerspectrum(i, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        stationaryOrbit = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        frequencies = powerspectrum(stationaryOrbit)[1]
        powerSpectraOfStationary = powerspectrum(stationaryOrbit)[2]
        pairF_PS = hcat(frequencies,powerSpectraOfStationary)
        writedlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", pairF_PS, header = false)
    end

    function fitPowerSpectra(frequencies, powerSpectraOfStacionary)

    end
end
