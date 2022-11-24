module Autocorrelations
    using StatsBase

    function autocorrelation(x, lag)
        acf = autocor(x, lag)
        return(acf)
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

module SavingAutocorrelation
    using DelimitedFiles
    using CurveFit
    using Primes
    using Combinatorics
    import Main.PascalTriangle
    import Main.Autocorrelations

    function savingAutocorrelation(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2,step = 1))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2, step = 1))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2, step = 1))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            end
        else
            if type == "Random"
                for i in 1:4
                    increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                    lag = Int64.(range(0, length(increment[:,1])-2, step = 1))
                    acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                    writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
                end
            else
                i = 1
                increment = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", BigFloat, header = false)
                lag = Int64.(range(0, length(increment[:,1])-2, step = 1))
                acf = Autocorrelations.autocorrelation(increment[:,1], lag)
                writedlm("DATA/ACF/acf_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", acf)
            end
        end
    end
end #module
