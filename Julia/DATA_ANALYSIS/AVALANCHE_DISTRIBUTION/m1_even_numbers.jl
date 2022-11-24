include("D:/Windows/Usuario/Documents/Collatz_map/Julia/RAW_DATA_SOURCE/initial_condition_modules.jl")
import Main.AlgorithmsOfmVectors
using Plots
using Plots.PlotMeasures
using LaTeXStrings

pasta = "FIGURES/AVALANCHES_FIGURES"
mkpath(pasta)

function distributionm1(initial::Int64, final::Int64)
    m1s = []
    for n in BigInt(6*initial+2):6:BigInt(6*final+2)
        m1 = AlgorithmsOfmVectors.algorithm_m1(n)
        m1s = vcat(m1s, m1)
    end
    L = maximum(m1s)
    distribution = []
    for i in 1:L
        s = count(x -> (x==i), m1s)
        distribution = vcat(distribution, s)
    end
    x = 1:eachindex(distribution)
    figure = plot(
            titlefontsize= 9,
            title = "Distribuição de valores de "*L"m_1"*" entre os pares de $(6*initial+2) a $(6*final+2)",
            fontfamily = "Computer Modern",
            xlabel = L"m_1",
            ylabel = L"D(m_1)",
            yguidefontrotation = -90,
            dpi = 500
    )
    figure = scatter!(log2.(distribution./(sum(distribution))), label = false, ms = 2.5, mc = :red, markerstrokewidth = 0)
    figure = plot!(x, -x, lc = :black, label = L"D = m_1^{-1}")
    plotfinal = plot(figure,
        size = (500,300),
        framestyle = :box,
        dpi = 500,
        left_margin = 10mm
        )
    png(plotfinal, string(pasta,"/m1_distribution_naturals.png"))
end

distributionm1(10,20000)
