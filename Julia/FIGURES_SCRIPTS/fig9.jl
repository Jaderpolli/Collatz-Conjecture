using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames, LinearAlgebra, StatsBase, Distributions, CurveFit

function lyapunovplot1()
    data = readdlm("DATA/FSLE/lyapunovs-2-4-to-2-17.csv")
    #l = round(Int64, length(data[:,1])/4)
    min = minimum(data[:,2] ./ log.(data[:,1]))
    plt = scatter(data[1:end, 1], data[1:end, 2], fontfamily = "Palatino", label = false,
                                    #xlabel = L"n_0", ylabel = L"\langle \lambda/\log[n_0] \rangle",
                                    frame = :box, size = (180,200), yscale = :log10,# yrange = (min, 1.1),
                                    ms = .5, msw = 0, mc = :orange
    )
    savefig(plt, "FIGURES/fig9/lyapunov_2-4_2-17.pdf")
end

function lyapunovplot2()
    data = readdlm("DATA/FSLE/lyapunovs_2-1000-considering-contraction.csv")
    data2 = readdlm("DATA/FSLE/lyapunovs.csv")
    min = minimum(data2[:,2] ./ log.(data2[:,1]))
    plt = scatter(data[:, 1], data[:, 2], fontfamily = "Palatino", label = false,
                                    #xlabel = L"n_0", ylabel = L"\langle \lambda/\log[n_0] \rangle",
                                    frame = :box, size = (180,200),yscale = :log10,# yrange = (min, 1.1),
                                    ms = 0.5, msw = 0, mc = :orange
    )
    savefig(plt, "FIGURES/fig9/lyapunov_2-1000.pdf")
end

function plotcoal()
    data1 = readdlm("DATA/FSLE/percentual-of-non-coalescent-orbits-2-4-to-2-18.csv")
    data2 = readdlm("DATA/FSLE/percentual-of-non-coalescent-orbits-2-18-to-2-1000.csv")
    data = vcat(data1, data2)
    x = Float64.(5:1:1000)
    fit = power_fit(x[195:end], data[95:end])
    plt = scatter(x, data, yscale = :log10, xscale = :log10, ms = 1.5, msw = 0, leftmargin = -2mm, 
                    label = L"\langle P_{nc}\rangle", fg_legend = nothing,
                    fontfamily = "Palatino", frame = :box, size = (220,120))#,
                    #xlabel = L"\log[n_0]", ylabel = L"\log[P_{n.c.}(n_0)]")
    plt = plot!(x[95:end], fit[1] .* x[95:end] .^(fit[2]), lc = :black, ls = :dash, label = L"x^{%$(round(fit[2], digits = 3))}")
    savefig(plt, "FIGURES/fig9/non-coalescent.pdf")
end

lyapunovplot1()
lyapunovplot2()
plotcoal()