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

    function savingpowerspectrum(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    stationaryOrbit = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    frequencies = powerspectrum(stationaryOrbit)[1]
                    powerSpectraOfStationary = powerspectrum(stationaryOrbit)[2]
                    pairF_PS = hcat(frequencies,powerSpectraOfStationary)
                    writedlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", pairF_PS, header = false)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                stationaryOrbit = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                frequencies = powerspectrum(stationaryOrbit)[1]
                powerSpectraOfStationary = powerspectrum(stationaryOrbit)[2]
                pairF_PS = hcat(frequencies,powerSpectraOfStationary)
                writedlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", pairF_PS, header = false)
            end
        else
            if type == "Random"
                for i in 1:4
                    stationaryOrbit = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    frequencies = powerspectrum(stationaryOrbit)[1]
                    powerSpectraOfStationary = powerspectrum(stationaryOrbit)[2]
                    pairF_PS = hcat(frequencies,powerSpectraOfStationary)
                    writedlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", pairF_PS, header = false)
                end
            else
                i = 1
                stationaryOrbit = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                frequencies = powerspectrum(stationaryOrbit)[1]
                powerSpectraOfStationary = powerspectrum(stationaryOrbit)[2]
                pairF_PS = hcat(frequencies,powerSpectraOfStationary)
                writedlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", pairF_PS, header = false)
            end
        end
    end

    function fitPowerSpectra(frequencies, powerSpectraOfStacionary)
        initialCutCounter = 1
        finalCutCounter = 1
        while frequencies[1] ≤ 10/length(powerSpectraOfStacionary)
            frequencies = frequencies[2:end]
            initialCutCounter = initialCutCounter + 1
        end
        while frequencies[end] ≥ 0.1
            frequencies = frequencies[1:end-1]
            finalCutCounter = finalCutCounter + 1
        end
        powerSpectraOfStacionary = powerSpectraOfStacionary[initialCutCounter-1:end-finalCutCounter]

        p0 = [0.01, 0.0]
        model(t,p) = log(p[1]) .+ t .* p[2]

        OrdinaryLeastSquareFit = curve_fit(model,log.(frequencies[1:end]),log.(powerSpectraOfStacionary[1:end]),p0)
        weigth = abs.(1 ./ OrdinaryLeastSquareFit.resid)
        WeigthedLeastSquareFit = curve_fit(model,log.(frequencies[1:end]),log.(powerSpectraOfStacionary[1:end]),weigth,p0)
        return(WeigthedLeastSquareFit.param[1], WeigthedLeastSquareFit.param[2])
    end

    function savingfitPowerSpectra(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    data = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    frequencies = data[:,1]
                    powerSpectraOfStationary = data[:,2]
                    fitPS = fitPowerSpectra(frequencies, powerSpectraOfStationary)
                    writedlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", fitPS, header = false)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                data = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                frequencies = data[:,1]
                powerSpectraOfStationary = data[:,2]
                fitPS = fitPowerSpectra(frequencies, powerSpectraOfStationary)
                writedlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", fitPS, header = false)
            end
        else
            if type == "Random"
                for i in 1:4
                    data = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    frequencies = data[:,1]
                    powerSpectraOfStationary = data[:,2]
                    fitPS = fitPowerSpectra(frequencies, powerSpectraOfStationary)
                    writedlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", fitPS, header = false)
                end
            else
                i = 1
                data = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                frequencies = data[:,1]
                powerSpectraOfStationary = data[:,2]
                fitPS = fitPowerSpectra(frequencies, powerSpectraOfStationary)
                writedlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", fitPS, header = false)
            end
        end
    end
end
