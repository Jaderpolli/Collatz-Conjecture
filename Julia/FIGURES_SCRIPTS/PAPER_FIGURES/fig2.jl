module PascalTriangle
    function pascaltriangle(n)

    row=Any[]

    #base case
    if n==1

        return Any[1]

    elseif n==2

        return Any[1,1]

    else

        #calculate the elements in each row
        for i in 2:n-1

            #rolling sum all the values within 2 windows from the previous row
            #but we cannot include two boundary numbers 1 in this row
            push!(row,pascaltriangle(n-1)[i-1]+pascaltriangle(n-1)[i])

        end

        #append 1 for both front and rear of the row
        pushfirst!(row,1)
        push!(row,1)

    end

    return row

    end
end

using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames, Combinatorics
pasta = "FIGURES/fig2"
mkpath(pasta)
import Main.PascalTriangle

function ps_boxplots()

    types = ["Random", "Prime", "Odd", "Even", "Oscilatory", "Pascal", "Linear"]

    a = plot(size = (420,250), fontfamily = "Computer Modern", frame = :box,
        xlabel = "type",
        ylabel =  L"\beta", dpi = 500)
    colors = [:red, :orange3, :yellow, :green, :blue, :purple4, :magenta]
    j = 0
    
    for type in types
        j = j+1
        folder = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_$(type)"
        files = readdir(folder)
        power_law = []
        PL = zeros(1, length(files))
        for file in files
            fit = readdlm(string(folder,"/",file))
            power_law = vcat(power_law, fit[2])
        end
        PL[1,:] = power_law
        data = DataFrame(transpose(PL), [type])
        a = @df data dotplot!([type], data[!,1], marker = (colors[j], stroke(0)), label = false)
        a = @df data boxplot!([type], data[!,1], fillalpha  = 0.7, c = colors[j], label = false, linewidth = 2)
    end

    savefig(a, string(pasta,"/ps_box_plot.pdf"))
end

function DFA_boxplots()
    types = ["Random", "Prime", "Odd", "Even", "Oscilatory", "Pascal", "Linear"]

    a = plot(size = (420,250), fontfamily = "Computer Modern", frame = :box,
        xlabel = "type",
        ylabel =  L"\alpha", dpi = 500)
    colors = [:red, :orange3, :yellow, :green, :blue, :purple4, :magenta]
    j = 0
    
    for type in types
        j = j+1
        folder = "DATA/DFA_STATIONARY_FIT/DFA_FIT_$(type)"
        files = readdir(folder)
        power_law = []
        PL = zeros(1, length(files))
        for file in files
            fit = readdlm(string(folder,"/",file))
            power_law = vcat(power_law, fit[2])
        end
        PL[1,:] = power_law
        data = DataFrame(transpose(PL), [type])
        a = @df data dotplot!([type], data[!,1], marker = (colors[j], stroke(0)), label = false)
        a = @df data boxplot!([type], data[!,1], fillalpha  = 0.7, c = colors[j], label = false, linewidth = 2)
    end

    savefig(a, string(pasta,"/DFA_box_plot.pdf"))
end

function plot_ps()
    randpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Random/powerspectra_n_0_1_Random_mVectorSize_180_MaxRand_10_BlockSize_2.csv", header=false)
    primepowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Prime/powerspectra_n_0_3_Prime_mVectorSize_180_MaxRand_10_BlockSize_4.csv", header=false)
    evenpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Even/powerspectra_n_0_1_Even_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oddpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Odd/powerspectra_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oscilatorypowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Oscilatory/powerspectra_n_0_2_Oscilatory_mVectorSize_2000_MaxRand_10_BlockSize_2.csv", header=false)
    pascalpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Pascal/powerspectra_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header=false)
    linearpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/PS_Linear/powerspectra_n_0_2_Linear_mVectorSize_1000_MaxRand_10_BlockSize_3.csv", header=false)

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

    colors = [:red, :orange3, :yellow, :green, :blue, :purple4, :magenta]

    figure = plot!(randpowerspectra[:,1],randpowerspectra[:,2],  lc = colors[1], label = false)
    figure = plot!(primepowerspectra[:,1], primepowerspectra[:,2], linealpha = 0.8, lc = colors[2], label = false)
    figure = plot!(evenpowerspectra[:,1], evenpowerspectra[:,2], linealpha = 0.7, lc = colors[3], label = false)
    figure = plot!(oddpowerspectra[:,1], oddpowerspectra[:,2], linealpha = 0.6, lc = colors[4], label = false)
    figure = plot!(oscilatorypowerspectra[:,1], oscilatorypowerspectra[:,2], linealpha = 0.5, lc = colors[5], label = false)
    figure = plot!(pascalpowerspectra[:,1], pascalpowerspectra[:,2], linealpha = 0.5, lc = colors[6], label = false)
    figure = plot!(linearpowerspectra[:,1], linearpowerspectra[:,2], linealpha = 0.3, lc = colors[7], label = false)
    figure = plot!(size = (400, 250), dpi = 500, left_margin = 5mm, bottom_margin = 1mm)
    figure = plot!(randpowerspectra[:,1], 0.3*randpowerspectra[:,1].^(0), ls = :dash, lc = :black, label = L"c \propto f^{0}")
    savefig(figure, string(pasta, "/power_spectra_plot.pdf"))
end

function plot_dfa()
    randdfa = readdlm("DATA/DFA_STATIONARY/DFA_Random/dfa_stationary_n_0_1_Random_mVectorSize_180_MaxRand_10_BlockSize_2.csv", header=false)
    primedfa = readdlm("DATA/DFA_STATIONARY/DFA_Prime/dfa_stationary_n_0_3_Prime_mVectorSize_180_MaxRand_10_BlockSize_4.csv", header=false)
    evendfa = readdlm("DATA/DFA_STATIONARY/DFA_Even/dfa_stationary_n_0_1_Even_mVectorSize_180_MaxRand_10_BlockSize_4.csv", header=false)
    odddfa = readdlm("DATA/DFA_STATIONARY/DFA_Odd/dfa_stationary_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oscilatorydfa = readdlm("DATA/DFA_STATIONARY/DFA_Oscilatory/dfa_stationary_n_0_2_Oscilatory_mVectorSize_1200_MaxRand_10_BlockSize_6.csv", header=false)
    pascaldfa = readdlm("DATA/DFA_STATIONARY/DFA_Pascal/dfa_stationary_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header=false)
    lineardfa = readdlm("DATA/DFA_STATIONARY/DFA_Linear/dfa_stationary_n_0_1_Linear_mVectorSize_1000_MaxRand_10_BlockSize_3.csv", header=false)

    figure = plot(
                yscale = :log10,
                xscale = :log10,
                fontfamily = "Computer Modern",
                xlabel = L"\ell",
                ylabel = L"F(\ell)",
                yguidefontrotation = -90,
                framestyle = :box,
                legend = :topleft,
                fg_legend = :false
    )
    figure = plot!( xticks = [1, 10, 100, 1000],
            yticks = [0.1, 1, 10],
            #minorgrid = true#=,
            minorticks = true
    )

    colors = [:red, :orange3, :yellow, :green, :blue, :purple4, :magenta]

    figure = plot!(randdfa[:,1],randdfa[:,2], lc = colors[1],  ms = 2, marker = (colors[1], stroke(0)),  markeralpha = 1, label = "Random")
    figure = plot!(primedfa[:,1], primedfa[:,2], linealpha = 0.8, lc = colors[2],  ms = 1.5, marker = (colors[2], stroke(0)),  markeralpha = 0.8, label = "Prime")
    figure = plot!(evendfa[:,1], evendfa[:,2], linealpha = 0.7, lc = colors[3],  ms = 1.5, marker = (colors[3], stroke(0)),  markeralpha = 0.7, label = "Even")
    figure = plot!(odddfa[:,1], odddfa[:,2], linealpha = 0.6, lc = colors[4],  ms = 1.5, marker = (colors[4], stroke(0)),  markeralpha = 0.6, label = "Odd")
    figure = plot!(oscilatorydfa[:,1], oscilatorydfa[:,2], linealpha = 0.5, lc = colors[5],  ms = 1.5, marker = (colors[5], stroke(0)), markeralpha = 0.5, label = "Oscilatory")
    figure = plot!(pascaldfa[:,1], pascaldfa[:,2], linealpha = 0.4, lc = colors[6],  ms = 1.5, marker = (colors[6], stroke(0)),  markeralpha = 0.4,label = "Pascal")
    figure = plot!(lineardfa[:,1], lineardfa[:,2], linealpha = 0.4, lc = colors[7],  ms = 1.5, marker = (colors[7], stroke(0)),  markeralpha = 0.4,label = "Linear")
    figure = plot!(size = (400, 250), dpi = 500, left_margin = 5mm, bottom_margin = 1mm)
    figure = plot!(oscilatorydfa[:,1], 0.2*oscilatorydfa[:,1].^(1/2), ls = :dash, lc = :black, label = L"n^{1/2}")
    savefig(figure, string(pasta, "/dfa_plot.pdf"))
end



ps_boxplots()
DFA_boxplots()
plot_ps()
plot_dfa()
