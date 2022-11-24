using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Primes
using Combinatorics
using Plots.PlotMeasures

function plotACF()
    mkpath("FIGURES/SPECIAL_ACF_FIGURES")

    primeOrder = 5
    mVectorSize = 1002 #divisible by 2 and 3 (the primeblocksizes below)
    primeBlockSize = [2, 3]
    type = "Prime"
    for j in primeBlockSize
        primeblock = Int64[]
        for i in 1:primeOrder
            primeblock = vcat(primeblock, prime(i))
        end
        L = length(collect(combinations(primeblock,j)))
        for i in 1:L
                orbit_prim = readdlm("RAW_DATA/SPECIAL_ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(j)_base10.csv", BigInt, header = false)
                acf_prim = readdlm("DATA/ACF/acf_special_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(j).csv", BigFloat, header = false)
                high_corr_prim = highCorrelations(acf_prim)

                figure = plot(layout = (2,1), size = (800,400), minorticks = true,  dpi = 200)
                figure = plot!(log.(orbit_prim),
                                    subplot =1,
                                    fontfamily = "Computer Modern",
                                    legend = :bottomleft,
                                    title = "Prime Initial "*L"m-"*"vector",
                                    label = "Initial Condition"*L"(\mathrm{prime}, %$(i), %$(j))",
                                    xlabel = L"t",
                                    lc = :black)
                figure = plot!(abs.(acf_prim),
                                    lc = :red, xlabel = L"\tau",
                                    label = L"C(\tau)",
                                    xticks = [1, 10, 100, 1000],
                                    subplot = 2,
                                    minorgrid = true,
                                    yscale = :log10,
                                    xscale = :log10,
                                    legend = :bottomleft)
                figure = scatter!(high_corr_prim[:,1],high_corr_prim[:,2],
                                    label = L"C(\tau) > 0.1",
                                    subplot = 2,
                                    ms = 3,
                                    mc = :blue,
                                    markerstrokewidth = 0,
                                    yscale = :log10,
                                    xscale = :log10,
                                    bottom_margin = 5mm)
                png(figure, "FIGURES/SPECIAL_ACF_FIGURES/acf_n_0_$(i)_mVectorSize_$(mVectorSize)_primeBlockSize_$(j).png")
            end
    end
end

function highCorrelations(x)
    high_corr = reshape([],0,2)
    for i in eachindex(x)
        if x[i] > 0.1
            hc = [i x[i]]
            high_corr = vcat(high_corr, hc)
        else
            nothing
        end
    end
    return(high_corr)
end

plotACF()
