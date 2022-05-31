using Plots
using DelimitedFiles
using Plots.PlotMeasures
using LaTeXStrings

pasta = "FIGURES/DFA_FIGURES"
mkpath(pasta)

function main()
    randdfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Random_mVectorSize_180_MaxRand_10_primeBlockSize_6.csv", header=false)
    primedfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_3_Prime_mVectorSize_180_MaxRand_10_primeBlockSize_6.csv", header=false)
    figure = plot(
                yscale = :log10,
                xscale = :log10,
                fontfamily = "Computer Modern",
                xlabel = L"n",
                ylabel = L"F(n)",
                yguidefontrotation = -90,
                framestyle = :box,
                legend = :topleft
    )
    figure = plot!(
            xticks = [1, 10, 100, 1000],
            yticks = [0.1, 1, 10],
            #minorgrid = true,
            minorticks = true
    )
    figure = plot!(randdfa[:,1], randdfa[:,2],  lc = :blue, label = "Random")
    figure = plot!(primedfa[:,1], primedfa[:,2], linealpha = 0.8, lc = :red, label = "Prime")
    figure = plot!(size = (500, 200), dpi = 500,left_margin = 6mm, bottom_margin = 5mm)
    figure = plot!(randdfa[:,1], 0.24*randdfa[:,1].^(1/2), label = L"n^{1/2}", lc = :black, ls = :dash)
    png(figure, string(pasta, "/dfa_plot"))
end

main()
