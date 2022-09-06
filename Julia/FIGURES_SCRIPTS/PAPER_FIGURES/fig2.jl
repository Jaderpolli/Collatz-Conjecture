using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames
pasta = "FIGURES/fig2"
mkpath(pasta)

function ps_boxplots()
    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types1 = ["Random", "Prime", "Odd", "Even"]
    PL = zeros(4, 156)
    L = 0

    for type in types1
        L +=1
        power_law = []
        for mVectorSize in mVectorSizes
            if mVectorSize < 360
                for j in 2:maximumBlockSize
                    BlockSize = j
                    for k in 1:factorial(BlockSize)
                        fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                        power_law = vcat(power_law, fit[2])
                    end
                end
            else
                if type == "Random"
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                        fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                        power_law = vcat(power_law, fit[2])
                    end
                end
            end
        end
        PL[L,:] = power_law[:]
    end

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    data= DataFrame(transpose(PL), types1)
    a = plot(size = (400,300), fontfamily = "Computer Modern",
        xlabel = "type",
        ylabel =  L"\beta", dpi = 500)
    a = @df data dotplot!(["Random"], :Random, marker = (colors[1], stroke(0)), label = false)
    a = @df data boxplot!(["Random"], :Random, fillalpha  = 0.7, c = colors[1], label = false, linewidth = 2)
    a =@df data dotplot!(["Prime"], :Prime, marker = (colors[2], stroke(0)), label = false)
    a =@df data boxplot!(["Prime"], :Prime, fillalpha  = 0.7, c = colors[2], label = false, linewidth = 2)
    a =@df data dotplot!(["Even"], :Even, marker = (colors[3], stroke(0)), label = false)
    a =@df data boxplot!(["Even"], :Even, fillalpha  = 0.7, c = colors[3], label = false, linewidth = 2)
    a =@df data dotplot!(["Odd"], :Odd, marker = (colors[4], stroke(0)), label = false)
    a =@df data boxplot!(["Odd"], :Odd, fillalpha  = 0.7, c = colors[4], label = false, linewidth = 2)

        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        types2 = ["Oscilatory", "Pascal Triangle"]
        PL = zeros(2, 8)
        L = 0

        for type in types2
            L +=1
            power_law = []
            for mVectorSize in mVectorSizes
                if mVectorSize < 360
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                    end
                else
                    if type == "Random"
                        for j in 2:maximumBlockSize
                            BlockSize = j
                            k = 1
                                fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                                power_law = vcat(power_law, fit[2])
                        end
                    else
                        for j in 2:maximumBlockSize
                            BlockSize = j
                            k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                        end
                    end
                end
            end
            PL[L,:] = power_law[:]
        end
    data= DataFrame(transpose(PL), ["Oscilatory", "Pascal"])
    a = @df data dotplot!(["Oscilatory"], :Oscilatory, marker = (colors[5], stroke(0)), label = false)
    a = @df data boxplot!(["Oscilatory"], :Oscilatory, fillalpha  = 0.7, c = colors[5], label = false, linewidth = 2)
    a = @df data dotplot!(["Pascal"], :Pascal, marker = (colors[6], stroke(0)), label = false)
    a = @df data boxplot!(["Pascal"], :Pascal, fillalpha  = 0.7, c = colors[6], label = false, linewidth = 2)
    savefig(a, string(pasta,"/ps_box_plot.pdf"))
end

function DFA_boxplots()
    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types1 = ["Random", "Prime", "Odd", "Even"]
    PL = zeros(4, 156)
    L = 0

    for type in types1
        L +=1
        power_law = []
        for mVectorSize in mVectorSizes
            if mVectorSize < 360
                for j in 2:maximumBlockSize
                    BlockSize = j
                    for k in 1:factorial(BlockSize)
                        fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                        power_law = vcat(power_law, fit[2])
                    end
                end
            else
                if type == "Random"
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                        fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                        power_law = vcat(power_law, fit[2])
                    end
                end
            end
        end
        PL[L,:] = power_law[:]
    end

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    data= DataFrame(transpose(PL), types1)
    a = plot(size = (400,300), fontfamily = "Computer Modern",
        xlabel = "type",
        ylabel =  L"\alpha", dpi = 500)
    a = @df data dotplot!(["Random"], :Random, marker = (colors[1], stroke(0)), label = false)
    a = @df data boxplot!(["Random"], :Random, fillalpha  = 0.7, c = colors[1], label = false, linewidth = 2)
    a =@df data dotplot!(["Prime"], :Prime, marker = (colors[2], stroke(0)), label = false)
    a =@df data boxplot!(["Prime"], :Prime, fillalpha  = 0.7, c = colors[2], label = false, linewidth = 2)
    a =@df data dotplot!(["Even"], :Even, marker = (colors[3], stroke(0)), label = false)
    a =@df data boxplot!(["Even"], :Even, fillalpha  = 0.7, c = colors[3], label = false, linewidth = 2)
    a =@df data dotplot!(["Odd"], :Odd, marker = (colors[4], stroke(0)), label = false)
    a =@df data boxplot!(["Odd"], :Odd, fillalpha  = 0.7, c = colors[4], label = false, linewidth = 2)

        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        types2 = ["Oscilatory", "Pascal Triangle"]
        PL = zeros(2, 8)
        L = 0

        for type in types2
            L +=1
            power_law = []
            for mVectorSize in mVectorSizes
                if mVectorSize < 360
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                    end
                else
                    if type == "Random"
                        for j in 2:maximumBlockSize
                            BlockSize = j
                            k = 1
                                fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                                power_law = vcat(power_law, fit[2])
                        end
                    else
                        for j in 2:maximumBlockSize
                            BlockSize = j
                            k = 1
                            fit = readdlm("D:/WINDOWS/Usuario/Documents/Collatz_map/DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv")
                            power_law = vcat(power_law, fit[2])
                        end
                    end
                end
            end
            PL[L,:] = power_law[:]
        end
    data= DataFrame(transpose(PL), ["Oscilatory", "Pascal"])
    a = @df data dotplot!(["Oscilatory"], :Oscilatory, marker = (colors[5], stroke(0)), label = false)
    a = @df data boxplot!(["Oscilatory"], :Oscilatory, fillalpha  = 0.7, c = colors[5], label = false, linewidth = 2)
    a = @df data dotplot!(["Pascal"], :Pascal, marker = (colors[6], stroke(0)), label = false, yrange = (0.35, 0.65))
    a = @df data boxplot!(["Pascal"], :Pascal, fillalpha  = 0.7, c = colors[6], label = false, linewidth = 2)
    savefig(a, string(pasta,"/DFA_box_plot.pdf"))
end

function plot_ps()
    randpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Random_mVectorSize_180_MaxRand_10_BlockSize_2.csv", header=false)
    primepowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_3_Prime_mVectorSize_180_MaxRand_10_BlockSize_4.csv", header=false)
    evenpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Even_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oddpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oscilatorypowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    pascalpowerspectra = readdlm("DATA/POWER_SPECTRA_STATIONARY/powerspectra_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)

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

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure = plot!(randpowerspectra[:,1],randpowerspectra[:,2],  lc = colors[1], label = false)
    figure = plot!(primepowerspectra[:,1], primepowerspectra[:,2], linealpha = 0.8, lc = colors[2], label = false)
    figure = plot!(evenpowerspectra[:,1], evenpowerspectra[:,2], linealpha = 0.7, lc = colors[3], label = false)
    figure = plot!(oddpowerspectra[:,1], oddpowerspectra[:,2], linealpha = 0.6, lc = colors[4], label = false)
    figure = plot!(oscilatorypowerspectra[:,1], oscilatorypowerspectra[:,2], linealpha = 0.5, lc = colors[5], label = false)
    figure = plot!(pascalpowerspectra[:,1], pascalpowerspectra[:,2], linealpha = 0.4, lc = colors[6], label = false)
    figure = plot!(size = (400, 250), dpi = 500, left_margin = 5mm, bottom_margin = 1mm)
    figure = plot!(randpowerspectra[:,1], 0.3*randpowerspectra[:,1].^(0), ls = :dash, lc = :black, label = L"f^{0}")
    savefig(figure, string(pasta, "/power_spectra_plot.pdf"))
end

function plot_dfa()
    randdfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Random_mVectorSize_180_MaxRand_10_BlockSize_2.csv", header=false)
    primedfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_3_Prime_mVectorSize_180_MaxRand_10_BlockSize_4.csv", header=false)
    evendfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Even_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    odddfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    oscilatorydfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)
    pascaldfa = readdlm("DATA/DFA_STATIONARY/dfa_stationary_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_3.csv", header=false)

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
    figure = plot!( xticks = [1, 10, 100, 1000],
            yticks = [0.1, 1, 10],
            #minorgrid = true#=,
            minorticks = true
    )

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure = plot!(randdfa[:,1],randdfa[:,2], lc = colors[1],  ms = 2, marker = (colors[1], stroke(0)),  markeralpha = 1, label = "Random")
    figure = plot!(primedfa[:,1], primedfa[:,2], linealpha = 0.8, lc = colors[2],  ms = 2, marker = (colors[2], stroke(0)),  markeralpha = 0.8, label = "Prime")
    figure = plot!(evendfa[:,1], evendfa[:,2], linealpha = 0.7, lc = colors[3],  ms = 2, marker = (colors[3], stroke(0)),  markeralpha = 0.7, label = "Even")
    figure = plot!(odddfa[:,1], odddfa[:,2], linealpha = 0.6, lc = colors[4],  ms = 2, marker = (colors[4], stroke(0)),  markeralpha = 0.6, label = "Odd")
    figure = plot!(oscilatorydfa[:,1], oscilatorydfa[:,2], linealpha = 0.5, lc = colors[5],  ms = 2, marker = (colors[5], stroke(0)), markeralpha = 0.5, label = "Oscilatory")
    figure = plot!(pascaldfa[:,1], pascaldfa[:,2], linealpha = 0.4, lc = colors[6],  ms = 2, marker = (colors[6], stroke(0)),  markeralpha = 0.4,label = "Pascal Triangle")
    figure = plot!(size = (400, 250), dpi = 500, left_margin = 5mm, bottom_margin = 1mm)
    figure = plot!(randdfa[:,1], 0.2*randdfa[:,1].^(1/2), ls = :dash, lc = :black, label = L"n^{1/2}")
    savefig(figure, string(pasta, "/dfa_plot.pdf"))
end


ps_boxplots()
DFA_boxplots()
plot_ps()
plot_dfa()
