using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures

function plotACF()
    mkpath("FIGURES/ACF_FIGURES")

    mVectorSize = 180

    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random", "Prime"]

    for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                println(
                100*(k/(factorial(primeBlockSize))*1/((maximumPrimeBlockSize-1)*(length(types))) +(j-2)/((maximumPrimeBlockSize-1)*(length(types))))
                )
                type = types[1]
                orbit_rand = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
                acf_rand = readdlm("DATA/ACF/acf_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", BigFloat, header = false)
                high_corr_rand = highCorrelations(acf_rand)
                type = types[2]
                orbit_prim = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
                acf_prim = readdlm("DATA/ACF/acf_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", BigFloat, header = false)
                high_corr_prim = highCorrelations(acf_prim)

                figure = plot(layout = (2,2), size = (800,400), minorticks = true,  dpi = 200)
                figure = plot!(log.(orbit_rand),
                                    title = "Random Initial "*L"m-"*"vector",
                                    fontfamily = "Computer Modern",
                                    left_margin = 5mm,
                                    subplot = 1,
                                    label = "Initial Condition"*L"(\mathrm{rand}, %$(k), %$(primeBlockSize))",
                                    legend = :bottomleft,
                                    xlabel = L"t",
                                    ylabel = L"\log_2(f(t))",
                                    lc = :black)
                figure = plot!(log.(orbit_prim),
                                    subplot =2,
                                    legend = :bottomleft,
                                    title = "Prime Initial "*L"m-"*"vector",
                                    label = label = "Initial Condition"*L"(\mathrm{prime}, %$(k), %$(primeBlockSize))",
                                    xlabel = L"t",
                                    lc = :black)
                figure = plot!(abs.(acf_rand),
                                    subplot = 3,
                                    minorgrid = true,
                                    lc = :blue,
                                    left_margin = 5mm,
                                    yticks = [0.0000001,0.000001,0.0001,0.001,0.01,0.1,1],
                                    xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                                    yscale = :log10,
                                    xscale = :log10,
                                    legend = :bottomleft,
                                    label = L"C( \tau)")
                figure = scatter!(high_corr_rand[:,1],high_corr_rand[:,2],
                                    subplot = 3, ms = 4,
                                    label = L"C(\tau) > 0.1",
                                    lc = :green,
                                    markerstrokewidth = 0,
                                    yscale = :log10,
                                    xscale = :log10,
                                    bottom_margin = 5mm)
                figure = plot!(abs.(acf_prim),
                                    lc = :red, xlabel = L"\tau",
                                    label = L"C(\tau)",
                                    xticks = [1, 10, 100, 1000],
                                    subplot = 4,
                                    minorgrid = true,
                                    yscale = :log10,
                                    xscale = :log10,
                                    legend = :bottomleft)
                figure = scatter!(high_corr_prim[:,1],high_corr_prim[:,2],
                                    label = L"C(\tau) > 0.1",
                                    subplot = 4,
                                    ms = 4,
                                    markerstrokewidth = 0,
                                    yscale = :log10,
                                    xscale = :log10,
                                    bottom_margin = 5mm)
                png(figure, "FIGURES/ACF_FIGURES/acf_n_0_$(k)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).png")
            end
    end
end

function highCorrelations(x)
    high_corr = reshape([],0,2)
    for i in 1:length(x)
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
