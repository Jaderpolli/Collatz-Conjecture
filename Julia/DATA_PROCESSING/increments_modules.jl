
module Increments
    function logarithmicIncrements(x)
        logx = log2.(x)
        increments = zeros(BigFloat, length(x)-1, 2)
        for i in eachindex(increments[:,1])
            increments[i,1] = i
            increments[i,2] = abs(logx[i+1]-logx[i])
        end
        return(increments)
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

module SavingIncrements
    using DelimitedFiles
    using Primes
    using Combinatorics
    import Main.PascalTriangle
    import Main.Increments

    function savingLogarithmcIncrements(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    increments = Increments.logarithmicIncrements(orbit)
                    writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    increments = Increments.logarithmicIncrements(orbit)
                    writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    increments = Increments.logarithmicIncrements(orbit)
                    writedlm("DATA/INCREMENTS/log_increments_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", increments)
                end
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
