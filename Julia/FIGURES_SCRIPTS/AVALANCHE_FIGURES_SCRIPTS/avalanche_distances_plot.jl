using Plots
using DelimitedFiles
using StatsBase
using Plots.PlotMeasures
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
            xlabel = L"m_1",
            ylabel = L"\log_2(\Delta t)",
            yguidefontrotation = -90,
            xticks = [2, 4, 6, 8, 10, 12]
    )

    for i in 1:length(types)
            type = types[i]
            for j in 2:maximumPrimeBlockSize
                primeBlockSize = j
                for k in 1:factorial(primeBlockSize)
                    data = readdlm("DATA/AVALANCHES_DISTANCE/avalance_distance_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", header = false)
                    m1 = data[:,1]
                    dt = data[:,2]
                    figure = scatter!(m1, log2.(dt), label = false, ms = 1.5, mc = :red, markerstrokewidth = 0)
                end
            end
    end
    figure = scatter!([2.5], ms = 1.5, mc = :red, markerstrokewidth = 0, label = "Data", legend = :bottomright)
    x = 1:1:9
    figure = plot!(x, x.+1.3, label = L"\Delta t(m_1) = 2^{m_1}", lc = :black)
    plotfinal = plot(figure,
        size = (500,300),
        framestyle = :box,
        dpi = 500,
        left_margin = 10mm
        )
    png(plotfinal, string(pasta, "/avalanche_disances"))
end

main()
