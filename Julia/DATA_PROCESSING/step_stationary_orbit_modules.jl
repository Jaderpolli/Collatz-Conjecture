module StepStationary

using DelimitedFiles

    function stepsstationary(stationary)
        N = length(stationary)
        steps = []
        for j in 1:N-1
            step = stationary[j+1]-stationary[j]
            steps = vcat(steps, step)
        end
        return(steps)
    end

    function savingstepsstationary(mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        BlockSize::Int64=4;
                        type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    stepsOfStationary = stepsstationary(stationary)
                    writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                i = 1
                stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                stepsOfStationary = stepsstationary(stationary)
                writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", stepsOfStationary)
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
