module Autocorrelations
    using StatsBase

    function autocorrelation(x, lag)
        acf = autocor(x, lag)
        return(acf)
    end
end

module SavingAutocorrelation
    using DelimitedFiles
    using CurveFit
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

    function savingAutocorrelationStationary(k::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        steps = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        lag = Int64.(range(0,length(steps)-2))
        acf = Autocorrelations.autocorrelation(steps, lag)
        writedlm("DATA/ACF_STATIONARY/acf_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", acf)
    end

    function fitautocorrelation(acf)
        n = range(1,length(acf),length = length(acf))
        fit = power_fit(n[100:length(n)],acf[100:length(n)])
        return(fit[1],fit[2])
    end

    function savingfitautocorrelation(i,
                        mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        primeBlockSize::Int64=4;
                        type::String)
        acf = readdlm("DATA/ACF_STATIONARY/acf_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv")
        fits = fitautocorrelation(abs.(acf))
        writedlm("DATA/ACF_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", fits)
    end

end #module
