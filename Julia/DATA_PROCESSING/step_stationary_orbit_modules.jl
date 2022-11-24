
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


module StepStationary

using DelimitedFiles
import Main.PascalTriangle
using Combinatorics

    function stepsstationary(stationary)
        N = length(stationary)
        steps = []
        for j in 1:N-1
            step = stationary[j+1]-stationary[j]
            steps = vcat(steps, step)
        end
        return(steps)
    end

    function savingstepsstationary(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    stepsOfStationary = stepsstationary(stationary)
                    writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    stepsOfStationary = stepsstationary(stationary)
                    writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    stepsOfStationary = stepsstationary(stationary)
                    writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
                end
            end
        else
            if type == "Random"
                for i in 1:4
                    stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    stepsOfStationary = stepsstationary(stationary)
                    writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
                end
            else
                i = 1
                stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                stepsOfStationary = stepsstationary(stationary)
                writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
            end
        end
    end
end
