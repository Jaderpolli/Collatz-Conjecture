
module Increments
    function logarithmicIncrements(x)
        logx = log2.(x)
        increments = zeros(BigFloat, length(x)-1, 2)
        for i in 1:length(increments[:,1])
            increments[i,1] = i
            increments[i,2] = abs(logx[i+1]-logx[i])
        end
        return(increments)
    end
end

module SavingIncrements
    using DelimitedFiles
    using Primes
    using Combinatorics
    import Main.Increments

    function savingLogarithmcIncrements(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    increments = Increments.logarithmicIncrements(orbit)
                    writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                increments = Increments.logarithmicIncrements(orbit)
                writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
            end
        else
            if type == "Random"
                for i in 1:4
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    increments = Increments.logarithmicIncrements(orbit)
                    writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
                end
            else
                i = 1
                orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                increments = Increments.logarithmicIncrements(orbit)
                writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
            end
        end
    end
end
