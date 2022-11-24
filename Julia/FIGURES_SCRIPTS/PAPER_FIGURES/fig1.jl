using ColorSchemeTools
using ColorSchemes
using Colors
using DelimitedFiles
using LaTeXStrings
using Plots
using Plots.PlotMeasures
pasta = "FIGURES/fig1"
mkpath(pasta)

palette = [
    colorant"darkred",
    colorant"navyblue",
    colorant"yellow",
    colorant"magenta",
    colorant"cyan",
    colorant"green1",
    colorant"red",
    colorant"blue",
    colorant"gold",
    colorant"deeppink",
    colorant"darkcyan",
    colorant"green2",
    colorant"firebrick4",
    colorant"midnightblue",
    colorant"lawngreen",
    colorant"hotpink",
    colorant"paleturquoise2",
    colorant"yellow3",
    colorant"tomato",
    colorant"royalblue1",
    colorant"greenyellow",
]

function figMrandom()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    s = sum(m[1,:])
    println(s)
    l = maximum(m)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Computer Modern",
                xlabel = L"t",
                ylabel =  L"m_i",
                grid = true,
                frame = :box,
                c = cgrad(:cs, categorical = true),
                size = (325,125), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

function figMrandomzoom1()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    mi = m[800:1200,1:400]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(m[800:1200,1:400]),
                fontfamily = "Computer Modern",
                colorbar_entry = false,
                xticks = ([1:200:401;],["800", "1000", "1200"]),
                yticks = ([1:100:401;],["0","100", "200", "300", "400"]),
                xlabel = L"t",
                ylabel =  L"m_i",
                grid = true,
                frame = :box,
                left_margin = -2mm,
                bottom_margin = -2mm,
                c = cgrad(:cs, categorical = true),
                size =  (160,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_zoom1.pdf"))
end

function figMrandomzoom2()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    mi = m[1000:1200,1:200]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(m[1000:1200,1:200]),
                fontfamily = "Computer Modern",
                xticks = ([1:100:201;],["1000", "1100", "1200"]),
                yticks = ([1:50:201;],["0","50", "100", "150", "200"]),
                xlabel = L"t",
                colorbar_entry = false,
                ylabel =  L"m_i",
                grid = true,
                frame = :box,
                left_margin = -2mm,
                bottom_margin = -2mm,
                c = cgrad(:cs, categorical = true),
                size =  (160,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_zoom2.pdf"))
end

function figMrandomzoom3()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    mi = m[1100:1200,1:100]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(m[1100:1200,1:100]),
                c = cgrad(:cs, categorical = true),
                colorbar_entry = false,
                fontfamily = "Computer Modern",
                xticks = ([1:50:101;],["1100","1150", "1200"]),
                yticks = ([1:25:101;],["0","25", "50", "75", "100"]),
                xlabel = L"t",
                ylabel =  L"m_i",
                grid = true,
                frame = :box,
                left_margin = -2mm,
                bottom_margin = -2mm,
                size =  (160,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_zoom3.pdf"))
end

function figMrandomzoom4()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    mi = m[1100:1150,1:50]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(m[1100:1150,1:50]),
                fontfamily = "Computer Modern",
                colorbar_entry = false,
                xticks = ([1:25:51;],["1100", "1125", "1150"]),
                yticks = ([1:25:51;],["0","25", "50"]),
                xlabel = L"t",
                ylabel =  L"m_i",
                grid = true,
                frame = :box,
                left_margin = -2mm,
                bottom_margin = -2mm,
                c = cgrad(:cs, categorical = true),
                size =  (160,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_zoom4.pdf"))
end

figMrandom()
figMrandomzoom1()
figMrandomzoom2()
figMrandomzoom3()
figMrandomzoom4()

lws = [1.5, 0.5]

function OrbitMrandom()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2_base10.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    orbit_m_sum = zeros(length(m[:,1]))
    for i in eachindex(m[:,1])
        orbit_m_sum[i] = sum(m[i,:])
    end
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Computer Modern", fg_legend = :false)
    plt = plot!(orbit_m_sum,
                size = (325,125),
                lw = lws[1],
                lc = RGB(0.2, 0.33, 0.5),
                xlabel = L"t",
                ylabel = L"\log_2 [n_t]",
                frame = :box,
                legend = :topright,
                label = L"\sum m_i(t)",
                dpi = 500)
    plt = plot!(logorbit, label = L"\log_2 [n_t]", lc = :red, lw = lws[2], linealpha = 0.7)
    savefig(plt, string(pasta,"/sum_M_orbit_n_0_2_Random_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

OrbitMrandom()
