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
                order::Int64=1,
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
                if order == 1
                    fit = linear_fit(dn, segment)
                else
                    fit = poly_fit(dn, segment, order)
                end
                segmentFit = fit[1] .+ fit[2].*dn
                difSegmentToFit[dn] = (segment .- segmentFit).^2
            end
            fluctuation = sqrt(sum(difSegmentToFit)/N)
            fluctuations = vcat(fluctuations,fluctuation)
        end
        return(Δns, fluctuations)
    end

    function savingdfa(i,
                        mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        primeBlockSize::Int64=4;
                        type::String)
        stationaryOrbit = readdlm("DATA/STEP_STATIONARY/step_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
        #=LogOrbit = log2.(Orbit)
        N = length(LogOrbit)
        differences = []
        for j in 1:N-1
            difference = LogOrbit[j+1]-LogOrbit[j]
            differences = vcat(differences, difference)
        end=#
        data = dfa(stationaryOrbit, 1)
        n = data[1]
        detrendedFluctuation = data[2]
        savingdata = hcat(n,detrendedFluctuation)
        writedlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", savingdata)
    end

    function fitdfa(n, dfa)
        fit = power_fit(n[6:end],dfa[6:end])
        return(fit[1],fit[2])
    end

    function savingfitdfa(i,
                        mVectorSize::Int64=100,
                        MaxRand::Int64=10,
                        primeBlockSize::Int64=4;
                        type::String)
        data = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv")
        n = data[:,1]
        dfa = data[:,2]
        fits = fitdfa(n,dfa)
        writedlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", fits)
    end

end #module
