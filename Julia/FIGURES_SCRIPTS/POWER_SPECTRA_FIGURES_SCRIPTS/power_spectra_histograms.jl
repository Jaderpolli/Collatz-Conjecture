using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures

pasta = "FIGURES/POWER_SPECTRA_FIGURES"
mkpath(pasta)

function histograms()
    mVectorSize = 180
    MaxRand = 10
    maximumPrimeBlockSize =  6
    types = ["Random","Prime"]
    fsize = 16

    topPlots  = plot(layout = (1,2), top_margin = 5mm)

    for i in 1:length(types)
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
            c=:red,
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
            label = L"\langle\beta\rangle =  %$(-Float16(average)) \pm %$(Float16(stdDeviation[1]))"
            )
    end
    topPlots = plot!(subplot = 1, ylabel = L"D(\beta)", annotation = ((0.1,0.9), L"(a)"))
    topPlots = plot!(subplot = 2, yticks = false, annotation = ((0.1,0.9), L"(b)"))

    bottomPlot = plot(size = (300,150))
    types = ["Random", "Prime"]
    power_law = []

    for i in 1:length(types)
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
        c=:red,
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
        label = label = L"\langle\beta\rangle=  %$(-Float16(average)) \pm %$(Float16(stdDeviation[1]))"
        )
    bottomPlot = plot!(annotation = ((0.05,0.9), L"(c)"))

    plotfinal = plot(topPlots, bottomPlot,
        layout = (2,1),
        size = (600,420),
        dpi = 500,
        left_margin = 6mm
        )
    png(plotfinal, string(pasta,"/power_spectra_histogram"))
end

histograms()
