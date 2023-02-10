# ler vetor m Random, Prime, Even, Odd, Oscilatory, Pascal
# calcular matriz de correlação e salvar e plotar
# ler entropia e plotar o máximo de cada em função de t/T

include("../DATA_ANALYSIS/VON_NEUMANN_ENTROPY/von_neumann_entropy_modules.jl")
import.Main.VNEntropy

using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames
pasta = "FIGURES/fig6"
mkpath(pasta)
pasta1 = "DATA/PEARSON_CORR_MATRICES"
mkpath(pasta1)

function plot_corr(s)

    L = 100

    mRand = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Random_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mRand = mRand[:,1:L]
    mRand = Int64.(replace(mRand, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Random/vn_entropy_n_0_1_Random_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mRand[:,1])*S[t[1],1])
    mSample = mRand[1:t,:]
    corrMatrixRand = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_random.csv"), corrMatrixRand)
    fig = plot(fontfamily = "Palatino", size = (230/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixRand)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6a_rand.pdf"))

    mPrime = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Prime_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mPrime = mPrime[:,1:L]
    mPrime = Int64.(replace(mPrime, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Prime/vn_entropy_n_0_1_Prime_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mPrime[:,1])*S[t[1],1])
    mSample = mPrime[1:t,:]
    corrMatrixPrime = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_prime.csv"), corrMatrixPrime)
    fig = plot(fontfamily = "Palatino", size = (230/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixPrime)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6a.pdf"))

    mEven = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Even_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mEven = mEven[:,1:L]
    mEven = Int64.(replace(mEven, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Even/vn_entropy_n_0_1_Even_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mEven[:,1])*S[t[1],1])
    mSample = mEven[1:t,:]
    corrMatrixEven = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_even.csv"), corrMatrixEven)
    fig = plot(fontfamily = "Palatino", size = (230/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixEven)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6b.pdf"))

    mOdd = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Odd_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mOdd = mOdd[:,1:L]
    mOdd = Int64.(replace(mOdd, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Odd/vn_entropy_n_0_1_Odd_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mOdd[:,1])*S[t[1],1])
    mSample = mOdd[1:t,:]
    corrMatrixOdd = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_odd.csv"), corrMatrixOdd)
    fig = plot(fontfamily = "Palatino", size = (230/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixOdd)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6c.pdf"))

    mOscilatory = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mOscilatory = mOscilatory[:,1:L]
    mOscilatory = Int64.(replace(mOscilatory, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Oscilatory/vn_entropy_n_0_1_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mOscilatory[:,1])*S[t[1],1])
    mSample = mOscilatory[1:t,:]
    corrMatrixOscilatory = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_oscilatory.csv"), corrMatrixOscilatory)
    fig = plot(fontfamily = "Palatino", size = (230/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixOscilatory)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6d.pdf"))

    mPascal = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mPascal = mPascal[:,1:L]
    mPascal = Int64.(replace(mPascal, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Pascal/vn_entropy_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mPascal[:,1])*S[t[1],1])
    mSample = mPascal[1:t,:]
    corrMatrixPascal = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_pascal.csv"), corrMatrixPascal)
    fig = plot(fontfamily = "Palatino", size = (220/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixPascal)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6e.pdf"))

    mLinear = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Linear_mVectorSize_1000_MaxRand_10_BlockSize_3_power_of_2.csv", header = false)
    mLinear = mLinear[:,1:L]
    mLinear = Int64.(replace(mLinear, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/VN_Linear/vn_entropy_n_0_1_Linear_mVectorSize_1000_MaxRand_10_BlockSize_3.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mLinear[:,1])*S[t[1],1])
    mSample = mLinear[1:t,:]
    corrMatrixLinear = VNEntropy.corrmatrix(mSample)
    writedlm(string(pasta1, "/PCM_linear.csv"), corrMatrixLinear)
    fig = plot(fontfamily = "Palatino", size = (220/s,200/s), dpi = 500, xlabel = "", ylabel = "")
    fig = heatmap!(abs.(transpose(corrMatrixLinear)), c= cgrad(:inferno), right_margin = 2mm)
    savefig(fig, string(pasta, "/6f.pdf"))
end

function max_entropy(s)

    types = ["Random", "Prime", "Odd", "Even", "Oscilatory", "Pascal", "Linear"]

    a = plot(size = (600/s,200/s), fontfamily = "Palatino", frame = :box,
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

    savefig(a, string(pasta,"/6g.pdf"))
end


function plote()
    s = 1.35
    plot_corr(s)
    max_entropy(s)
end

plote()