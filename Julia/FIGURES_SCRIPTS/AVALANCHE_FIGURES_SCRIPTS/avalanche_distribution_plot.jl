using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures

pasta = "FIGURES/AVALANCHES_FIGURES/IND_AVALANCHES_FIGURES"
mkpath(pasta)

function main()

    mVectorSize = 180
    MaxRand = 10
    maximumPrimeBlockSize =  5
    types = ["Random","Prime"]
    fsize = 16

    for i in eachindex(types)
            type = types[i]
            for j in 5:maximumPrimeBlockSize
                primeBlockSize = j
                for k in 1:factorial(primeBlockSize)
                    figure = plot(
                            fontfamily = "Computer Modern",
                            xlabel = L"\log_2(l)",
                            ylabel = L"\log_2[D(l)]",
                            yguidefontrotation = -90
                    )
                    distribution = readdlm("DATA/AVALANCHES/avalanche_distribution_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                    figure = plot!(log2.(distribution./(sum(distribution))),
                            marker = [:circle], lc = :red, linealpha = 1,
                            label = false, ms = 3, mc = :red, markerstrokewidth = 0)
                    figure = plot!(size = (500,300),
                    framestyle = :box,
                    dpi = 500,
                    left_margin = 10mm)
                    png(figure, string(pasta, "/avalanche_distribution_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_ $(MaxRand)_primeBlockSize_$(primeBlockSize)"))
                end
            end
    end
    #=figure = scatter!([-1], ms = 1.5, mc = :red, markerstrokewidth = 0, label = "Data")
    x = 1:1:9
    figure = plot!(x, -x, label = L"D(l) = l^{-1}", lc = :black)
    plotfinal = plot(figure,
        size = (500,300),
        framestyle = :box,
        dpi = 500,
        left_margin = 10mm
        )
    png(plotfinal, string(pasta, "/avalanche_distribution_2"))=#
end

main()
