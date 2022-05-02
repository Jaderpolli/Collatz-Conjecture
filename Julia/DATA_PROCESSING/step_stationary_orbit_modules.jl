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

    function savingstepsstationary(i,
                        mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        primeBlockSize::Int64=4;
                        type::String)
        stationary = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        stepsOfStationary = stepsstationary(stationary)
        writedlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", stepsOfStationary)
    end
end
