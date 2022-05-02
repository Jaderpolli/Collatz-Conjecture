module DFA
    using StatsBase
    using CurveFit
    using DelimitedFiles

    function integration(orbit)
        N = length(orbit)
        meanOrbit = mean(orbit)
        integratedOrbit = zeros(N)
        sumOrbit = 0.0
        sumMean = 0.0
        for j in 1:N
            sumOrbit += orbit[j]
            sumMean += meanOrbit
            integratedOrbit[j] = sumOrbit - sumMean
        end
        return(integratedOrbit)
    end

    function dfa(x,
                Δn₀::Int64=4,
                Δnₘ::Int64=div(length(x),2))
        x = integration(x)
        N = length(x)
        fluctuations = []
        Δns = range(Δn₀,Δnₘ)
        for Δn in Δn₀:Δnₘ
            segmentation = zeros(div(N,Δn),Δn)
            segmentation[1,:] = x[1:Δn]
            for i in 1:div(N,Δnₘ)-1
                segmentation[i+1,:] = x[i*Δn+1:i*Δn+Δn]
            end
            difSegmentToFit = zeros(N)
            for j in 1:div(N,Δn)
                dn = range((j-1)*Δn+1,j*Δn)
                segment = segmentation[j,:]
                fit = linear_fit(dn, segment)
                segmentFit = fit[1] .+ fit[2].*dn
                difSegmentToFit[dn] = segment .- segmentFit
            end
            fluctuation = 1/N*sum(difSegmentToFit.^2)
            fluctuations = vcat(fluctuations,fluctuation)
        end
        return(Δns, fluctuations)
    end

    function savingdfa(i,
                        mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        primeBlockSize::Int64=4;
                        type::String)
        stationaryOrbit = readdlm("DATA/STATIONARY_ORBITS/stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        n = dfa(stationaryOrbit)[1]
        detrendedFluctuation = dfa(stationaryOrbit)[2]
        data = hcat(n,detrendedFluctuation)
        writedlm("DATA/DFA_STATIONARY/dfa_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", data)
    end

end #module
