using Plots
using DelimitedFiles
using Plots.PlotMeasures
using StatsBase
using LaTeXStrings

pasta = "Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS"

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
    figure = plot!(size = (600, 225), dpi = 500,left_margin = 6mm, bottom_margin = 5mm)
    figure = plot!(randpowerspectra[:,1], 0.01*randpowerspectra[:,1].^(-2), ls = :dash, lc = :black, label = L"f^{-2}")
    savefig(figure, string(pasta,"/power_spectra_plot.pdf"))
end

main()

function histograms()
    mVectorSize = 180
    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random","Prime"]
    fsize = 16
    colors = [:blue, :red]

    topPlots  = plot(layout = (1,2), top_margin = 5mm, size = (500,200))

    for i in eachindex(types)
        type = types[i]
        power_law = []
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                fit = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv")
                power_law = vcat(power_law,fit[2])
            end
        end
        average = mean(power_law)
        stdDeviation = std(power_law)
        topPlots = histogram!(power_law,
            subplot = i,
            bins = 30,
            title = L"\mathrm{%$(type)} \ \mathrm{initial} \ m-\mathrm{vector}",
            c=colors[i],
            fontfamily = (12,"Computer Modern"),
            xlabel = L"\beta",
            yguidefontrotation = -90,
            framestyle = :box,
            legendposition = :topright,
            label = :false
            )
        topPlots = plot!([mean(power_law);mean(power_law)],
            [0;150],
            subplot = i,
            ls = :dash,
            lw = 1.5,
            lc = :black,
            label = L"\langle\beta\rangle =  %$(Float16(average)) \pm %$(Float16(stdDeviation[1]))"
            )
    end
    topPlots = plot!(subplot = 1, ylabel = L"D(\beta)")
    topPlots = plot!(subplot = 2, yticks = false)

    bottomPlot = plot(size = (600,200))
    types = ["Random", "Prime"]
    power_law = []

    for i in eachindex(types)
            type = types[i]
            for j in 2:maximumPrimeBlockSize
                primeBlockSize = j
                for k in 1:factorial(primeBlockSize)
                    fit = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv")
                    power_law = vcat(power_law,fit[2])
                end
            end
    end
    average = mean(power_law)
    stdDeviation = std(power_law)
    bottomPlot = histogram!(power_law,
        c=:magenta4,
        fontfamily = "Computer Modern",
        xlabel = L"\beta",
        ylabel = L"D(\beta)",
        yguidefontrotation = -90,
        left_margin = 3mm,
        framestyle = :box,
        title = L"\mathrm{Random \ and \ Prime \ initial} \ m-\mathrm{vector}",
        #top_margin = mm,
        label = :false
        )
    bottomPlot = plot!([mean(power_law);mean(power_law)],[0;200],
        ls = :dash,
        lw = 1.5,
        lc = :black,
        label = label = L"\langle\beta\rangle=  %$(Float16(average)) \pm %$(Float16(stdDeviation[1]))"
        )

    plotfinal = plot(topPlots, bottomPlot,
        layout = (2,1),
        size = (600,420),
        dpi = 500,
        left_margin = 6mm
        )
    savefig(plotfinal, string(pasta,"/power_spectra_histogram.pdf"))
end

histograms()
