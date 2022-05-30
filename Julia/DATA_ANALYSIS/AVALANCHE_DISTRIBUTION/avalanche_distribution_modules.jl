module AvalanchesDistributions
    using DelimitedFiles
    using CurveFit

    function avalanchesizes(m1)
        m1Values = []
        for j in 1:length(m1)-1
            if m1[j] == 0 && m1[j+1] > 0
                m1Values = vcat(m1Values,m1[j+1])
            else
                nothing
            end
        end
        return(m1Values)
    end

    function cutzeros(x)
        i = 1
        cut = []
        while x[i] ≠ 0
            cut = x[1:i]
            if i == length(x)
                break
            end
            i += 1
        end
        return(cut)
    end

    function avalanchedistribution(m1)
        m1Values = avalanchesizes(m1)
        L = maximum(m1Values)
        distribution = []
        for i in 1:L
            countingSize = count(x->(x==i), m1Values)
            distribution = vcat(distribution, countingSize)
        end
        distribution = cutzeros(distribution)
        return(distribution)
    end

    function savingavalanchedistribution(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        M = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", header = false)
        m1 = M[:,1]
        distribution = avalanchedistribution(m1)
        writedlm("DATA/AVALANCHES/avalanche_distribution_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", distribution, header = false)
    end

    function fitdistribution(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        distribution = readdlm("DATA/AVALANCHES/avalanche_distribution_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        normalizer = sum(distribution)
        if length(distribution)>9
            x = range(1,9)
        else
            x = range(1,length(distribution))
        end
        fit = linear_fit(x, log2.(distribution ./ normalizer)[1:length(x)])
        writedlm("DATA/AVALANCHES_FIT/fit_avalanche_distribution_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", fit, header = false)
    end
end

module AvalancheDistance

end
