using Plots
using DelimitedFiles
using Plots.PlotMeasures
using LaTeXStrings

pasta = "FIGURES/POWER_SPECTRA_FIGURES"
mkpath(pasta)

function main()
    randpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Random_mVectorSize_180_MaxRand_10_primeBlockSize_2.csv", header=false)
    primepowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_3_Prime_mVectorSize_180_MaxRand_10_primeBlockSize_4.csv", header=false)
    figure = plot(
                yscale = :log10,
                xscale = :log10,
                fontfamily = "Computer Modern",
                xlabel = L"f",
                ylabel = L"P(f)",
                yguidefontrotation = -90,
                framestyle = :box,
                legend = :bottomleft
    )
    figure = plot!(
            #xticks = [1, 10, 100, 1000],
            yticks = [0.001, 0.1, 10, 1000 , 100000],
            #minorgrid = true#=,
            minorticks = true
    )
    figure = plot!(randpowerspectra[:,1],randpowerspectra[:,2],  lc = :blue, label = "Random")
    figure = plot!(primepowerspectra[:,1], primepowerspectra[:,2], linealpha = 0.8, lc = :red, label = "Prime")
    figure = plot!(size = (500, 200), dpi = 500,left_margin = 6mm, bottom_margin = 5mm)
    figure = plot!(randpowerspectra[:,1], 0.01*randpowerspectra[:,1].^(-2), ls = :dash, lc = :black, label = L"f^{-2}")
    png(figure, string(pasta, "/power_spectra_plot"))
end

main()
