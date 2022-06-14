module VNEntropy
    using DelimitedFiles
    using StatsBase
    using LinearAlgebra
    using Plots
    using LaTeXStrings
    using Plots.PlotMeasures

    function corrmatrix(mSample)
        n = length(mSample[:,1])
        N = length(mSample[1,:])
        R = zeros(N,N)
        for j in 1:N
            for i in 1:N
                Xᵢ = mSample[:,i] .- mean(mSample[:,i])
                Xⱼ = mSample[:,j] .- mean(mSample[:,j])
                XiXj = sum(Xᵢ .* Xⱼ)/n
                σᵢ = sqrt(mean(Xᵢ .* Xᵢ))
                σⱼ = sqrt(mean(Xⱼ .* Xⱼ))
                R[i,j] = XiXj/(σᵢ*σⱼ)
            end
        end
        return(R)
    end

    function vnentropy(R)
        N = length(R[:,1])
        ρ = R ./ N
        λ = eigvals(ρ)
        S = 0.0
        for i in 1:N
           S = S - λ[i]*log(λ[i])
        end
        return(S)
    end
end #VNEntropy module

module VNEntropyEvaluation
    import Main.VNEntropy
    using DelimitedFiles
    using StatsBase
    using LinearAlgebra
    using Plots
    using LaTeXStrings
    using Plots.PlotMeasures

    #=function random_evolution_S()
        m = readdlm("RAW_DATA/ORBITS/orbit_n_0_5_Random_mVectorSize_180_MaxRand_10_primeBlockSize_4_power_of_2.csv", header = false)
        m = Int64.(replace(m, "" => -1))
        ts = 1000:25:length(m[:,1])
        plt1 = plot(dpi = 200)
        plt2 = plot(dpi = 200)
        anim = @animate for i in ts
                println(i/length(m[:,1]))
                mSample = m[1:i,1:100]
                R = VNEntropy.corrmatrix(mSample)
                S = VNEntropy.vnentropy(R)
                #entropias = vcat(entropias, S)
                heatmap!(plt1,R, title = "Entropy = $(Float16(S)), Time series length = $(1000+i)")
                scatter!(plt2, [i],[S], label = false, mc = :blue, ms = 1.5, markerstrokewidth = 0, xrange = (1000,length(m[:,1])), yrange = (4.2, log(100)))
                plt3 = plot(plt1, plt2, layout = (2,1))
        end
        gif(anim, string(pasta,"/random_evolution_S.gif"), fps = 10)
    end=#

    function variatingTimeSeries(m, L, percent)
        T = length(m[:,1])
        ts = round(Int64, 4*T/10):200:T
        data = reshape([],0,2)
        for i in ts
            println([i/length(m[:,1]) percent])
            mSample = m[1:i,1:L]
            S = VNEntropy.vnentropy(VNEntropy.corrmatrix(mSample))
            arr = [i/T S]
            data = vcat(data, arr)
        end
        return(data)
    end

    function savingVariatingTimeSeries(percent, i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", header = false)
        m = Int64.(replace(m, "" => -1))
        L = 100
        data = variatingTimeSeries(m, L, percent)
        writedlm("DATA/VON_NEUMANN_ENTROPY/variating_time_series_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", data, header = false)
    end

    function savingVariatingTimeSeries(percent, i::Int64, mVectorSize::Int64=100, primeBlockSize::Int64=4)
        m = readdlm("RAW_DATA/SPECIAL_ORBITS/orbit_n_0_$(i)_Prime_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", header = false)
        m = Int64.(replace(m, "" => -1))
        L = 100
        data = variatingTimeSeries(m, L, percent)
        writedlm("DATA/VON_NEUMANN_ENTROPY/variating_time_series_entropy_n_0_$(i)_Prime_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize).csv", data, header = false)
    end
end
