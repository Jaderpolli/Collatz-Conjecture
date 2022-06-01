using DelimitedFiles
using StatsBase
using LinearAlgebra
using Plots
using LaTeXStrings
using Plots.PlotMeasures

pasta = "FIGURES/VON_NEUMANN_ENTROPY"
mkpath(pasta)

function random_evolution_S()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_5_Random_mVectorSize_180_MaxRand_10_primeBlockSize_4_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    ts = 1000:25:length(m[:,1])
    plt1 = plot(dpi = 200)
    plt2 = plot(dpi = 200)
    anim = @animate for i in ts
            println(i/length(m[:,1]))
            mSample = m[1:i,1:100]
            R = corrmatrix(mSample)
            S = vnentropy(R)
            #entropias = vcat(entropias, S)
            heatmap!(plt1,R, title = "Entropy = $(Float16(S)), Time series length = $(1000+i)")
            scatter!(plt2, [i],[S], label = false, mc = :blue, ms = 1.5, markerstrokewidth = 0, xrange = (1000,length(m[:,1])), yrange = (4.2, log(100)))
            plt3 = plot(plt1, plt2, layout = (2,1))
    end
    gif(anim, string(pasta,"/random_evolution_S.gif"), fps = 10)
end

function comparison_prime_random_S()
    plt = plot(
        dpi = 200,
        fontfamily = "Computer Modern"
        )
    colors = [:red, :blue]
    k = 0
    #anim = @animate
    for type in ["Random", "Prime"]
        k += 1
        m = readdlm("RAW_DATA/ORBITS/orbit_n_0_5_$(type)_mVectorSize_180_MaxRand_10_primeBlockSize_4_power_of_2.csv", header = false)
        m = Int64.(replace(m, "" => -1))
        ts = 1000:25:length(m[:,1])
        for i in ts
            println(i/length(m[:,1]))
            mSample = m[1:i,1:100]
            R = corrmatrix(mSample)
            S = vnentropy(R)
            #entropias = vcat(entropias, S)
            scatter!(plt, [i],[S], legend = :topleft, label = false, mc = colors[k], ms = 1.5, markerstrokewidth = 0, xrange = (1000,4500), yrange = (4.1, log(100)))
        end
    end
    plt = plot!(lc = :red, label = "Random")
    plt = plot!(lc = :blue, label = "Prime")
    plt = plot!(xlabel = L"t", ylabel = L"S", left_margin = 5mm, bottom_margin = 5mm)
    png(plt, string(pasta,"/comparison_prime_random_S"))
end

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

function heatmap_m()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Prime_mVectorSize_180_MaxRand_10_primeBlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    println(sum(m[1,:]))
end

comparison_prime_random_S()
