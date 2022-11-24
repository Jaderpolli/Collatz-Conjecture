module AvalanchesDistributions
    using DelimitedFiles
    using CurveFit

    function avalanchesizes(m1)
        m1Values = []
        for j in eachindex(m1)-1
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
        fit = linear_fit(x, log2.(distribution ./ normalizer)[eachindex(x)])
        writedlm("DATA/AVALANCHES_FIT/fit_avalanche_distribution_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", fit, header = false)
    end
end

module AvalanchesDistance

    using StatsBase
    using Plots
    using DelimitedFiles

    function distanceAvalanches(m1)
        m1Values = reshape([],0,2)
        i = 1
        for j in eachindex(m1)-1
            if m1[j] == 0 && m1[j+1] > 0
                pair = [m1[j+1] j+1-i]
                m1Values = vcat(m1Values,pair)
                i = j+1
            else
                nothing
            end
        end
        avgs = reshape([],0,2)
        for i in 1:maximum(m1Values[:,1])
            indexs = findall(isequal(i), m1Values[:,1])
            (isequal(length(indexs),0) || isequal(length(indexs),1)) && continue
            distances = []
            for j in eachindex(indexs)-1
                d = sum(m1Values[indexs[j]:indexs[j+1]])
                distances = vcat(distances, d)
            end
            avgds = mean(distances)
            data = [i avgds]
            avgs = vcat(avgs, data)
        end
        return(avgs)
    end

    function savingdistanceavalanches(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        M = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", header = false)
        m1 = M[:,1]
        avgs = distanceAvalanches(m1)
        writedlm("DATA/AVALANCHES_DISTANCE/avalance_distance_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", avgs, header = false)
    end
end
