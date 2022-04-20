using DelimitedFiles

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
