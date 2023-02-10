# ler vetor m Random, Prime, Even, Odd, Oscilatory, Pascal
# calcular matriz de correlação e salvar e plotar
# ler entropia e plotar o máximo de cada em função de t/T

include("../DATA_ANALYSIS/VON_NEUMANN_ENTROPY/von_neumann_entropy_modules.jl")
import.Main.VNEntropy

using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames
pasta = "FIGURES/fig7"
mkpath(pasta)


function max_entropy(s)

    types = ["Random", "Prime", "Odd", "Even", "Pascal"]

    a = plot(size = (350/s,250/s), fontfamily = "Palatino", frame = :box,
        xlabel = "",
        ylabel =  "", dpi = 500)
    colors = [:red3, :orange3, :yellow, :green, :blue, :purple4, :magenta]
    j = 0
    
    for type in types
        j = j+1
        folder = "DATA/VON_NEUMANN_ENTROPY/VN_$(type)"
        files = readdir(folder)
        maxEn = []
        En = zeros(1, length(files))
        for file in files
            S = readdlm(string(folder,"/",file))
            maxS = maximum(S[:,2])
            maxEn = vcat(maxEn, maxS)
        end
        En[1,:] = maxEn
        data = DataFrame(transpose(En), [type])
        a = @df data dotplot!([type], data[!,1], marker = (colors[j], stroke(0)), label = false)
        a = @df data boxplot!([type], data[!,1], fillalpha  = 0.7, c = colors[j], label = false, linewidth = 2)
        a = plot!(yrange = (0.9,1))
    end

    savefig(a, string(pasta,"/7a.pdf"))

    types = ["Oscilatory", "Linear"]

    a = plot(size = (200/s,250/s), fontfamily = "Palatino", frame = :box,
        xlabel = "",
        ylabel =  "", dpi = 500)
    colors = [:purple4, :magenta]
    j = 0
    
    for type in types
        j = j+1
        folder = "DATA/VON_NEUMANN_ENTROPY/VN_$(type)"
        files = readdir(folder)
        maxEn = []
        En = zeros(1, length(files))
        for file in files
            S = readdlm(string(folder,"/",file))
            maxS = maximum(S[:,2])
            maxEn = vcat(maxEn, maxS)
        end
        En[1,:] = maxEn
        data = DataFrame(transpose(En), [type])
        a = @df data dotplot!([type], data[!,1], marker = (colors[j], stroke(0)), label = false)
        a = @df data boxplot!([type], data[!,1], fillalpha  = 0.7, c = colors[j], label = false, linewidth = 2)
        a = plot!(yrange = (0.9,1))
    end

    savefig(a, string(pasta,"/7b.pdf"))
end


function plote()
    s = 1.35
    max_entropy(s)
end

plote()