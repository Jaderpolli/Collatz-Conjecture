# ler vetor m Random, Prime, Even, Odd, Oscilatory, Pascal Triangle
# calcular matriz de correlação e salvar e plotar
# ler entropia e plotar o máximo de cada em função de t/T

include("D:/WINDOWS/Usuario/Documents/Collatz_map/Julia/DATA_ANALYSIS/VON_NEUMANN_ENTROPY/von_neumann_entropy_modules.jl")
import.Main.VNEntropy

using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames
pasta = "FIGURES/fig4"
mkpath(pasta)

function plot_corr()

    L = 100

    mRand = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Random_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mRand = mRand[:,1:L]
    mRand = Int64.(replace(mRand, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Random_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mRand[:,1])*S[t[1],1])
    mSample = mRand[1:t,:]
    corrMatrixRand = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixRand)), c= cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixRand.pdf"))

    mPrime = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Prime_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mPrime = mPrime[:,1:L]
    mPrime = Int64.(replace(mPrime, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Prime_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mPrime[:,1])*S[t[1],1])
    mSample = mPrime[1:t,:]
    corrMatrixPrime = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixPrime)), c= cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixPrime.pdf"))

    mEven = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Even_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mEven = mEven[:,1:L]
    mEven = Int64.(replace(mEven, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Even_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mEven[:,1])*S[t[1],1])
    mSample = mEven[1:t,:]
    corrMatrixEven = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixEven)), c = cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixEven.pdf"))

    mOdd = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Odd_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mOdd = mOdd[:,1:L]
    mOdd = Int64.(replace(mOdd, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Odd_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mOdd[:,1])*S[t[1],1])
    mSample = mOdd[1:t,:]
    corrMatrixOdd = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixOdd)), c = cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixOdd.pdf"))

    mOscilatory = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mOscilatory = mOscilatory[:,1:L]
    mOscilatory = Int64.(replace(mOscilatory, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mOscilatory[:,1])*S[t[1],1])
    mSample = mOscilatory[1:t,:]
    corrMatrixOscilatory = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixOscilatory)), c = cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixOscilatory.pdf"))

    mPascal = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    mPascal = mPascal[:,1:L]
    mPascal = Int64.(replace(mPascal, "" => -1))
    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Pascal Triangle_mVectorSize_2100_MaxRand_10_BlockSize_2.csv", header = false)
    maxS = maximum(S[:,2])
    t = findall(isequal(maxS), S[:,2])
    t = round(Int64, length(mPascal[:,1])*S[t[1],1])
    mSample = mPascal[1:t,:]
    corrMatrixPascal = VNEntropy.corrmatrix(mSample)
    fig = plot(fontfamily = "Computer Modern", size = (220,200), dpi = 500, xlabel = L"j", ylabel = L"i")
    fig = heatmap!(abs.(transpose(corrMatrixPascal)), c = cgrad(:afmhot, scale = :linear))
    savefig(fig, string(pasta, "/corrMatrixPascal.pdf"))
end

function max_entropy()
    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types1 = ["Random", "Prime", "Odd"]
    En = zeros(3, 156)
    L = 0

    for type in types1
        L +=1
        maxEn = []
        for mVectorSize in mVectorSizes
            if mVectorSize < 360
                for j in 2:maximumBlockSize
                    BlockSize = j
                    for k in 1:factorial(BlockSize)
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        maxEn = vcat(maxEn, maxS)
                    end
                end
            else
                if type == "Random"
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        maxEn = vcat(maxEn, maxS)
                    end
                elseif type == "Even"
                    for j in 2:maximumBlockSize-1
                        BlockSize = j
                        k = 1
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        maxEn = vcat(maxEn, maxS)
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        k = 1
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        maxEn = vcat(maxEn, maxS)
                    end
                end
            end
        end
        En[L,:] = maxEn
    end

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    data= DataFrame(transpose(En), types1)
    a = plot(size = (250,350), fontfamily = "Computer Modern",
        xlabel = "type",
        ylabel =  L"\beta", dpi = 500)
    a = @df data violin!(["Random"], :Random, fillcolor = colors[1], label = false)
    a = @df data boxplot!(["Random"], :Random, fillalpha  = 0.7, c = colors[1], label = false, linewidth = 2)
    a =@df data violin!(["Prime"], :Prime, fillcolor = colors[2], label = false)
    a =@df data boxplot!(["Prime"], :Prime, fillalpha  = 0.7, c = colors[2], label = false, linewidth = 2)
    # a =@df data dotplot!(["Even"], :Even, marker = (colors[3], stroke(0)), label = false)
    # a =@df data boxplot!(["Even"], :Even, fillalpha  = 0.7, c = colors[3], label = false, linewidth = 2)
    a =@df data violin!(["Odd"], :Odd, fillcolor = colors[4], label = false)
    a =@df data boxplot!(["Odd"], :Odd, fillalpha  = 0.7, c = colors[4], label = false, linewidth = 2)
    #

        types3 = ["Even"]
        En = zeros(1, 155)
        L = 0
        for type in types3
            L +=1
            maxEn = []
            for mVectorSize in mVectorSizes
                if mVectorSize < 360
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        for k in 1:factorial(BlockSize)
                            S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                            maxS = maximum(S[:,2])
                            maxEn = vcat(maxEn, maxS)
                        end
                    end
                else
                    if type == "Random"
                        for j in 2:maximumBlockSize
                            BlockSize = j
                            k = 1
                            S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                            maxS = maximum(S[:,2])
                            maxEn = vcat(maxEn, maxS)
                        end
                    else
                        for j in 2:4
                            BlockSize = j
                            k = 1
                            S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                            maxS = maximum(S[:,2])
                            maxEn = vcat(maxEn, maxS)
                        end
                    end
                end
            end
            En[L,:] = maxEn[:]
        end
    data= DataFrame(transpose(En), ["Even"])
    a = @df data violin!(["Even"], :Even, fillcolor = colors[3], label = false)
    a = @df data boxplot!(["Even"], :Even, fillalpha  = 0.7, c = colors[3], label = false, linewidth = 2)

    a = plot!(yrange = (0.9, 1), ylabel = L"S/S_{\mathrm{max}}")

    savefig(a, string(pasta,"/maxEn_box_plot.pdf"))
end

plot_corr()
#max_entropy()
