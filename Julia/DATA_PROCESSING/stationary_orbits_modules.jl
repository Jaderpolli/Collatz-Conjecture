# This module contains the functions for generating the stationary orbit from collatz base 10
module StationaryOrbits
    using DelimitedFiles
    function gamma_2(k::Int64, mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
        orbit = log2.(orbit)
        Δy = orbit[end]-orbit[1]
        Δx = length(orbit)
        γ₂ = Δy/Δx
        return(orbit,γ₂)
    end

    function gamma_2(orbit)
        orbit = log2.(orbit)
        Δy = orbit[end]-orbit[1]
        Δx = length(orbit)
        γ₂ = Δy/Δx
        return(orbit,γ₂)
    end

    function fitOrbitGamma_2(orbit, γ₂)
        Δx = length(orbit)
        fitOrbit = zeros(Δx)
        orbit = log2.(orbit)
        for i in 1:Δx
            fitOrbit[i] = orbit[1] + γ₂*i
        end
        return(fitOrbit)
    end

    function stationary(orbit, fitOrbit)
        stationaryOrbit = log2.(orbit) .- fitOrbit
        return(stationaryOrbit)
    end
end

module SavingStationaryOrbits
    using DelimitedFiles
    import Main.StationaryOrbits

    function savinggamma2(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                    writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
            end
        else
            if type == "Random"
                for i in 1:4
                    γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                    writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
                end
            else
                i = 1
                γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
            end
        end
    end

    function savingstationary(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                    stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                    writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
            end
        else
            if type == "Random"
                for i in 1:4
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                    stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                    writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
                end
            else
                i = 1
                γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
            end
        end
    end
end
