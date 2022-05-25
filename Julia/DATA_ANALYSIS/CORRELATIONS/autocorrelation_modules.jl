module Autocorrelations
    using StatsBase

    function autocorrelation(x, lag)
        acf = autocor(x, lag)
        return(acf)
    end
end

module SavingAutocorrelation
    using DelimitedFiles
    using Primes
    using Combinatorics
    import Main.Autocorrelations

    function savingAutocorrelation(k::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        increment = readdlm("DATA/INCREMENTS/log_increments_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", BigFloat, header = false)
        lag = Int64.(range(0, length(increment)-2))
        acf = Autocorrelations.autocorrelation(increment, lag)
        writedlm("DATA/ACF/acf_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", acf)
    end

    function savingSpecialAutocorrelation(primeOrder::Int64=2, mVectorSize::Int64=100, primeBlockSize::Int64=4; type::String)
        primeblock = Int64[]
        for i in 1:primeOrder
            primeblock = vcat(primeblock, prime(i))
        end
        L = length(collect(combinations(primeblock,primeBlockSize)))
        for i in 1:L
            increment = readdlm("DATA/SPECIAL_INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize).csv", BigFloat, header = false)
            lag = Int64.(range(0, length(increment)-2))
            acf = Autocorrelations.autocorrelation(increment, lag)
            writedlm("DATA/ACF/acf_special_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize).csv", acf)
        end
    end

end #module
