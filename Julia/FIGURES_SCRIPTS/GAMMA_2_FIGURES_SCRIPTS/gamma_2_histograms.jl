using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures

pasta = "FIGURES/GAMMA_2_FIGURES"
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
        gamma2 = []
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                gamma2 = vcat(gamma2,γ₂[1])
            end
        end
        average = mean(gamma2)
        stdDeviation = std(gamma2)
        topPlots = histogram!(gamma2,
            subplot = i,
            bins = 30,
            title = L"\mathrm{%$(type)} \ \mathrm{initial} \ m-\mathrm{vector}",
            c=:orange,
            fontfamily = (12,"Computer Modern"),
            xlabel = L"\gamma_2",
            yguidefontrotation = -90,
            framestyle = :box,
            legendposition = :topright,
            label = :false
            )
        topPlots = plot!([mean(gamma2);mean(gamma2)],
            [0;250],
            subplot = i,
            ls = :dash,
            lw = 1.5,
            lc = :black,
            label = L"\langle\gamma_2\rangle =  %$(Float16(average)) \pm %$(Float16(stdDeviation[1]))"
            )
    end
    topPlots = plot!(subplot = 1, ylabel = L"D(\gamma_2)", annotation = ((0.1,0.9), L"(a)"))
    topPlots = plot!(subplot = 2, yticks = false, annotation = ((0.1,0.9), L"(b)"))

    bottomPlot = plot(size = (300,150))
    types = ["Random", "Prime"]
    gamma2 = []

    for i in 1:length(types)
            type = types[i]
            for j in 2:maximumPrimeBlockSize
                primeBlockSize = j
                for k in 1:factorial(primeBlockSize)
                    γ₂ = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                    gamma2 = vcat(gamma2,γ₂[1])
                end
            end
    end
    average = mean(gamma2)
    stdDeviation = std(gamma2)
    bottomPlot = histogram!(gamma2,
        c=:orange,
        fontfamily = "Computer Modern",
        xlabel = L"\gamma_2",
        ylabel = L"D(\gamma_2)",
        yguidefontrotation = -90,
        left_margin = 3mm,
        framestyle = :box,
        title = L"\mathrm{Random \ and \ Prime \ initial} \ m-\mathrm{vector}",
        #top_margin = mm,
        label = :false
        )
    bottomPlot = plot!([mean(gamma2);mean(gamma2)],[0;310],
        ls = :dash,
        lw = 1.5,
        lc = :black,
        label = label = L"\langle\gamma_2\rangle=  %$(Float16(average)) \pm %$(Float16(stdDeviation[1]))"
        )
    bottomPlot = plot!(annotation = ((0.05,0.9), L"(c)"))

    plotfinal = plot(topPlots, bottomPlot,
        layout = (2,1),
        size = (600,420),
        dpi = 500,
        left_margin = 6mm
        )
    png(plotfinal, string(pasta,"/gamma_2_histogram"))
end

histograms()
