using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings

pasta = "FIGURES/AVALANCHES_FIGURES"
mkpath(pasta)

function main()

    mVectorSize = 180
    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random","Prime"]
    fsize = 16
    figure = plot(
            fontfamily = "Computer Modern",
            xlabel = L"\log_2(l)",
            ylabel = L"\log_2[D(l)]",
            yguidefontrotation = -90
    )

    for i in 1:length(types)
            type = types[i]
            for j in 2:maximumPrimeBlockSize
                primeBlockSize = j
                for k in 1:factorial(primeBlockSize)
                    distribution = readdlm("DATA/AVALANCHES/avalanche_distribution_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                    figure = scatter!(log2.(distribution./(sum(distribution))), label = false, ms = 1.5, mc = :red, markerstrokewidth = 0)
                end
            end
    end
    figure = scatter!([-1], ms = 1.5, mc = :red, markerstrokewidth = 0, label = "Data")
    x = 1:1:9
    figure = plot!(x, -x, label = L"D(l) = l^{-1}", lc = :black)
    plotfinal = plot(figure,
        size = (500,300),
        framestyle = :box,
        dpi = 500,
        left_margin = 10mm
        )
    png(plotfinal, string(pasta, "/avalanche_distribution"))
end

main()
