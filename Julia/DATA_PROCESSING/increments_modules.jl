module Increments

#this function probably will not be used, but is here for completeness
    function linearIncrements(x)
        increments = zeros(BigFloat, length(x)-1)
        for i in 1:length(increments)
            increments[i] = abs(x[i+1]-x[i])
        end
        return(increments)
    end

    function logarithmicIncrements(x)
        logx = log2.(x)
        increments = zeros(BigFloat, length(x)-1)
        for i in 1:length(increments)
            increments[i] = abs(logx[i+1]-logx[i])
        end
        return(increments)
    end
end

module SavingIncrements
    using DelimitedFiles
    using Primes
    using Combinatorics 
    import Main.Increments

    function savingLogarithmcIncrements(k::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
        increments = Increments.logarithmicIncrements(orbit)
        writedlm("DATA/INCREMENTS/log_increments_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", increments)
    end

#this function probably will not be used, but is here for completeness
    function savingLinearIncrements(k::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
        increments = Increments.linearIncrements(orbit)
        writedlm("DATA/INCREMENTS/linear_increments_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", increments)
    end

    function savingSpecialLogarithmcIncrements(primeOrder::Int64=2, mVectorSize::Int64=100, primeBlockSize::Int64=4; type::String)
        primeblock = Int64[]
        for i in 1:primeOrder
            primeblock = vcat(primeblock, prime(i))
        end
        L = length(collect(combinations(primeblock,primeBlockSize)))
        for i in 1:L
            orbit = readdlm("RAW_DATA/SPECIAL_ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
            increments = Increments.logarithmicIncrements(orbit)
            writedlm("DATA/SPECIAL_INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize).csv", increments)
        end
    end

end
