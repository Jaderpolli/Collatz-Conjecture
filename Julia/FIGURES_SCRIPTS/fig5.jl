using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings, ColorSchemes,  Colors, ColorSchemeTools
using Plots.PlotMeasures

pasta = "FIGURES/fig4"
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
    colorant"pink2",
    colorant"paleturquoise1",
    colorant"goldenrod2",
    colorant"salmon",
    colorant"royalblue3",
    colorant"olivedrab1"
]

function PlotOrbit(i, mVectorSize, blocksize, type, subfig, sub, s) 
    println("plotorbit, $(type), $(mVectorSize), $(blocksize)")
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_base10.csv", BigFloat, header = false)
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Palatino", fg_legend = :false)
    plt = plot!(logorbit,
                size = (415/s,150/s),
                lc = :black,
                xlabel = "",
                ylabel = "",
                #xrange = (1,5500),
                #xticks = [1000, 2000, 3000, 4000, 5000],
                frame = :box,
                #left_margin = 3mm,
                legend = :bottomleft,
                label = false,
                dpi = 500)
    savefig(plt, string(pasta,"/fig4_$(subfig[sub]).pdf"))
end

function zoom1plotOrbit(i, mVectorSize, blocksize, type, subfig, sub, s)
    println("zoom_plotorbit, $(type), $(mVectorSize), $(blocksize)")
    orb_prime = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_base10.csv", BigFloat, header = false)
    orb_prime = log2.(orb_prime)
    inset_figure_orb = plot(orb_prime[1:250],
                    fontfamily = "Palatino",
                    size = (220/s,150/s),
                    lc = :black,
                    frame = :box,
                    label = false,
                    xlabel = "",
                    xticks = [1:75:250],
                    #yrange = (minimum(orb_prime[1:2000]),maximum(orb_prime)+200),
                    ylabel = ""
                    )
    savefig(inset_figure_orb, string(pasta,"/fig4_$(subfig[sub]).pdf"))
end

function zoom2plotOrbit(i, mVectorSize, blocksize, type)
    println("zoom_plotorbit, $(type), $(mVectorSize), $(blocksize)")
    orb_prime = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_base10.csv", BigFloat, header = false)
    orb_prime = log2.(orb_prime)
    inset_figure_orb = plot(orb_prime[1:50],
                    fontfamily = "Palatino",
                    size = (220,150),
                    lc = :black,
                    frame = :box,
                    label = false,
                    xlabel = L"t",
                    #xticks = ([1:25:51;], [400, 425, 450]),
                    #yrange = (minimum(orb_prime[1:2000]),maximum(orb_prime)+200),
                    ylabel = L"\log_2 [f^t(n_0)]"
                    )
    savefig(inset_figure_orb, string(pasta,"/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_zoom2.pdf"))
end

function plotM(i, mVectorSize, blocksize, type, subfig, sub, s)
    println("plotM, $(type), $(mVectorSize), $(blocksize)")
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    l = maximum(m)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Palatino",
                xlabel = "",
                ylabel =  "",
                #xticks = [2500, 5000, 7500, 10000, 12500],
                frame = :box,
                c = cgrad(:cs, categorical = true),
                size = (450/s,150/s), dpi = 500)
    savefig(plt, string(pasta,"/fig4_$(subfig[sub]).pdf"))
end

function zoom1plotM(i, mVectorSize, blocksize, type, subfig, sub, s)
    println("zoomplotM, $(type), $(mVectorSize), $(blocksize)")
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    H = length(m[1,:])
    # if H > 500
    #     mi = m[1:500, 1:500]
    # else
    #     mi = m[1:H,1:H]
    # end
    mi = m[1:250,1:250]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(mi),
                fontfamily = "Palatino",
                #xticks = ([1:25:51;], [400, 425, 450]),
                #yticks = ([25:50:225;],["900","950", "1000", "1050", "1100"]),
                xlabel = "",
                ylabel =  "",
                grid = true,
                frame = :box,
                c = cgrad(:cs, categorical = true),
                size = (250/s,150/s), dpi = 500)
    savefig(plt, string(pasta,"/fig4_$(subfig[sub]).pdf"))
end

function zoom2plotM(i, mVectorSize, blocksize, type)
    println("zoomplotM, $(type), $(mVectorSize), $(blocksize)")
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    H = length(m[1,:])
    # if H > 500
    #     mi = m[1:500, 1:500]
    # else
    #     mi = m[1:H,1:H]
    # end
    mi = m[1:50,1:50]
    l = maximum(mi)
    pal = palette[1:l]
    loadcolorscheme(:cs, vcat(RGB{Float64}(1,1,1), make_colorscheme(pal, l)[1:end]))
    plt = heatmap(transpose(mi),
                fontfamily = "Palatino",
                #xticks = ([1:25:51;], [400, 425, 450]),
                #yticks = ([25:50:225;],["900","950", "1000", "1050", "1100"]),
                xlabel = L"t",
                ylabel =  L"m_i",
                grid = true,
                right_margin = 2mm,
                frame = :box,
                c = cgrad(:cs, categorical = true),
                size = (250,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_10_BlockSize_$(blocksize)_zoom2.pdf"))
end

# i = 1
# mVectorSize = 180
# blocksizes = [2, 5]
# types = ["Prime","Even", "Odd", "Oscilatory", "Pascal"]
#
# for type in types
#     for blocksize in blocksizes
#         if type == "Even" && blocksize == 5
#             continue
#         else
#             PlotOrbit(i, mVectorSize, blocksize, type)
#             zoomplotOrbit(i, mVectorSize, blocksize, type)
#             plotM(i, mVectorSize, blocksize, type)
#             zoomplotM(i, mVectorSize, blocksize, type)
#         end
#     end
# end

function plotes()

    i = 1
    mVectorSize = 180
    blocksizes = [2 5]
    type = "Prime"
    subfig = ["a", "b", "c", "d", "e", "f", "g", "h"]
    sub = 0
    s = 1.44
    
    for blocksize in blocksizes
        sub += 1
        PlotOrbit(i, mVectorSize, blocksize, type, subfig, sub, s)
        sub += 1
        zoom1plotOrbit(i, mVectorSize, blocksize, type, subfig, sub, s)
        sub += 1
        plotM(i, mVectorSize, blocksize, type, subfig, sub, s)
        sub += 1
        zoom1plotM(i, mVectorSize, blocksize, type, subfig, sub, s)
    end
end

plotes()
