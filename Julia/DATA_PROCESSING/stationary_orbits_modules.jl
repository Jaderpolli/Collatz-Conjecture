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

module PascalTriangle
    function pascaltriangle(n)

    row=Any[]

    #base case
    if n==1

        return Any[1]

    elseif n==2

        return Any[1,1]

    else

        #calculate the elements in each row
        for i in 2:n-1

            #rolling sum all the values within 2 windows from the previous row
            #but we cannot include two boundary numbers 1 in this row
            push!(row,pascaltriangle(n-1)[i-1]+pascaltriangle(n-1)[i])

        end

        #append 1 for both front and rear of the row
        pushfirst!(row,1)
        push!(row,1)

    end

    return row

    end
end

module SavingStationaryOrbits
    using DelimitedFiles
    import Main.StationaryOrbits
    import Main.PascalTriangle
    using Combinatorics
    
    function savinggamma2(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                    writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                    writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    γ₂ = StationaryOrbits.gamma_2(i, mVectorSize, MaxRand, BlockSize; type)[2]
                    writedlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv",γ₂, header = false)
                end
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
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                    stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                    writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                    stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                    writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    fitOrbit = StationaryOrbits.fitOrbitGamma_2(orbit, γ₂[1])
                    stationaryOrbit = StationaryOrbits.stationary(orbit, fitOrbit)
                    writedlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stationaryOrbit, header = false)
                end
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
