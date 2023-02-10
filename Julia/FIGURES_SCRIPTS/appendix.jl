# para cada type:
# pegar S max e o t em que isso ocorre, gerar a matrix R, transformar em vetor e ir concatenando

include("../DATA_ANALYSIS/VON_NEUMANN_ENTROPY/von_neumann_entropy_modules.jl")
import.Main.VNEntropy

using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames, LinearAlgebra, StatsBase, Distributions
pasta = "DATA/PEARSON_CORR_MATRICES"
mkpath(pasta)

function Rm()
    types = ["Random","Prime", "Even", "Odd", "Pascal", "Oscillatory", "Linear"]
    L = 100

    for type in types
        j = 0
        folderM = "RAW_DATA/ORBITS_ORG/ORBITS_$(type)"
        filesM = readdir(folderM)
        folderS = "DATA/VON_NEUMANN_ENTROPY/VN_$(type)"
        filesS = readdir(folderS)
        #println(filesM)
        R = []
        for files in filesS
            j = j+1
            filem = filesM[j]
            m = readdlm(string(folderM,"/",filem), header = false)
            m = m[:,1:L]
            m = Int64.(replace(m, "" => -1))
            #println(files, filem)
            println(files, type, "$(j/length(filesS)*100)")
            S = readdlm(string(folderS,"/",files))
            maxS = maximum(S[:,2])
            t = findall(isequal(maxS), S[:,2])
            t = round(Int64, length(m[:,1])*S[t[1],1])
            mSample = m[1:t,:]
            corrMatrix = VNEntropy.corrmatrix(mSample)
            R = vcat(R, vec(corrMatrix))
        end
        writedlm(string(pasta,"/","PCM_$(type)"),R)
    end
end

pasta2 = "FIGURES/appendix"
mkpath(pasta2)


function plote()
    types1 = ["Random"]
    types2 = ["Even", "Prime","Odd", "Pascal", "Oscillatory", "Linear"]
    #types3 = []

    colors1 = [:red]
    colors2 = [:yellow, :orange3, :green, :blue, :purple4, :magenta]
    #colors3 = []

    hst = plot()
    j = 0
    for type in types1
        j += 1
        R = readdlm("DATA/PEARSON_CORR_MATRICES/PCM_$(type).csv", header = false)
        Rfu = unique(filter(! >(0.9), R))
        hist = fit(Histogram, vec(Rfu), minimum(Rfu):0.001:maximum(Rfu))
        nhist = normalize(hist, mode = :pdf)
        x = range(minimum(Rfu), maximum(Rfu), length = length(nhist.weights))
        fithist = fit_mle(Laplace, Rfu)
        hst = plot(x, nhist.weights, fontfamily = "Palatino", 
                        xlabel = "", ylabel = "", legend = :topright, fg_legend = false,
                        label = "$(type)", lw = 2,
                        lc = colors1[j], frame = :box, size = (200, 200)
                        )
        hst = plot!(x, fithist, lw = 2, ls = :dash, lc = :grey31, label = "Laplace pdf")
    end
    savefig(hst, string(pasta2,"/","hist_types1.pdf"))

    hst = plot()
    j = 0
    for type in types2
        j += 1
        R = readdlm("DATA/PEARSON_CORR_MATRICES/PCM_$(type).csv", header = false)
        Rfu = unique(filter(! >(0.9), R))
        hist = fit(Histogram, vec(Rfu), minimum(Rfu):0.001:maximum(Rfu))
        nhist = normalize(hist, mode = :pdf)
        x = range(minimum(Rfu), maximum(Rfu), length = length(nhist.weights))
        hst = plot!(x, nhist.weights, fontfamily = "Palatino", 
                        xlabel = "", ylabel = "", legend = :topright, fg_legend = false,
                        label = "$(type)", xrange = (-0.15, 0.3), lw = 2,
                        lc = colors2[j], frame = :box, size = (300, 200)
                        )
        #hst = plot!(x, fithist, lw = 1, ls = :dash, lc = :grey31, label = "Laplace pdf")
    end
    savefig(hst, string(pasta2,"/","hist_types2.pdf"))
    
    # hst = plot()
    # j = 0
    # for type in types3
    #     j += 1
    #     R = readdlm("DATA/PEARSON_CORR_MATRICES/PCM_$(type).csv", header = false)
    #     hst = histogram!(vec(R), fontfamily = "Palatino", 
    #                     xlabel = L"R", ylabel = L"D(R)", legend = :topright, fg_legend = false,
    #                     label = "$(type)", bins = 10000, xrange = (minimum(R[:,1]), 0.5), yrange = (0,4100),
    #                     lc = colors3[j], frame = :box, size = (300, 200)
    #                     )
    # end
    # savefig(hst, string(pasta2,"/","hist_types3.pdf"))
    
    #savefig(hst, string(pasta2,"/","hist_all.pdf"))

end

R()
plote()