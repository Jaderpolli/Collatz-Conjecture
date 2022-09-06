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

    function savingAutocorrelation(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                lag = Int64.(range(0, length(increment[:,1])-2))
                acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
            end
        else
            if type == "Random"
                for i in 1:4
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            else
                i = 1
                increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                lag = Int64.(range(0, length(increment[:,1])-2))
                acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
            end
        end
    end
end #module
