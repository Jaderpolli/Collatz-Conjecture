using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
pasta = "FIGURES/fig1"
mkpath(pasta)

function figMrandom()
    palette = [
        colorant"blue",
        colorant"red",
        colorant"gold1",
        colorant"darkblue",
        colorant"red3",
        colorant"gold",
        colorant"skyblue",
        colorant"tomato",
        colorant"lightblue1",
        colorant"lightsalmon",
    ]
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_22_Random_mVectorSize_180_MaxRand_10_BlockSize_5_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    l = maximum(m)
    loadcolorscheme(:cs, vcat(RGB{Float64}(0,0,0), colorant"olivedrab1", make_colorscheme(palette, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Computer Modern",
                xlabel = L"t",
                ylabel =  L"m_i",
                c = cgrad(:cs, categorical = true),
                size = (400,300), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_22_Random_mVectorSize_180_MaxRand_10_BlockSize_5.pdf"))
end

function figMoscilatory()
    palette = [
        colorant"blue",
        colorant"red",
        colorant"gold1",
        colorant"darkblue",
        colorant"red3",
        colorant"gold",
        colorant"skyblue",
        colorant"tomato",
        colorant"lightblue1",
        colorant"lightsalmon",
    ]
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    l = maximum(m)
    loadcolorscheme(:cs, vcat(RGB{Float64}(0,0,0), colorant"olivedrab1", make_colorscheme(palette, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Computer Modern",
                xlabel = L"t",
                ylabel =  L"m_i",
                c = cgrad(:cs, categorical = true),
                size = (400,300), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_1_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_2.pdf"))
end

function figMpascal()
    palette = [
        colorant"firebrick",
        colorant"royalblue4",
        colorant"gold1",
        colorant"indianred2",
        colorant"steelblue1",
        colorant"lemonchiffon1",
        colorant"lightsalmon",
        colorant"lightblue1"
    ]
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    l = maximum(m)
    loadcolorscheme(:cs, vcat(RGB{Float64}(0,0,0), colorant"olivedrab1", make_colorscheme(palette, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Computer Modern",
                xlabel = L"t",
                ylabel =  L"m_i",
                c = cgrad(:cs, categorical = true),
                size = (400,150), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

function figModd()
    palette = [
        colorant"firebrick",
        colorant"royalblue4",
        colorant"gold1",
        colorant"indianred2",
        colorant"steelblue1",
        colorant"lemonchiffon1",
        colorant"lightsalmon",
        colorant"lightblue1"
    ]
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_odd_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    l = maximum(m)
    loadcolorscheme(:cs, vcat(RGB{Float64}(0,0,0), colorant"olivedrab1", make_colorscheme(palette, l)[1:end]))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    plt = heatmap(transpose(m[:,:]),
                fontfamily = "Computer Modern",
                xlabel = L"t",
                ylabel =  L"m_i",
                c = cgrad(:cs, categorical = true),
                size = (400,300), dpi = 500)
    savefig(plt, string(pasta,"/M_Matrix_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

figMrandom()
figMoscilatory()
# figMpascal()
#figModd()

lws = [1.5, 0.5]

function OrbitMrandom()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_22_Random_mVectorSize_180_MaxRand_10_BlockSize_5_power_of_2.csv", header = false)
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_22_Random_mVectorSize_180_MaxRand_10_BlockSize_5_base10.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    orbit_m_sum = zeros(length(m[:,1]))
    for i in 1:length(m[:,1])
        orbit_m_sum[i] = sum(m[i,:])
    end
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Computer Modern", fg_legend = :false)
    plt = plot!(orbit_m_sum,
                size = (400,150),
                lw = lws[1],
                lc = RGB(0.2, 0.33, 0.5),
                xlabel = L"t",
                ylabel = L"\log_2 \mathcal{O}(t), \sum m_i(t)",
                frame = :box,
                #left_margin = 3mm,
                #bottom_margin = 5mm,
                legend = :topright,
                label = L"\sum m_i(t)",
                dpi = 500)
    plt = plot!(logorbit, label = L"\mathcal{O}(t)", lc = :red, lw = lws[2], linealpha = 0.7)
    savefig(plt, string(pasta,"/sum_M_orbit_n_0_22_Random_mVectorSize_180_MaxRand_10_BlockSize_5.pdf"))
end

function OrbitMoscilatory()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_2_base10.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    orbit_m_sum = zeros(length(m[:,1]))
    for i in 1:length(m[:,1])
        orbit_m_sum[i] = sum(m[i,:])
    end
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Computer Modern", fg_legend = :false)
    plt = plot!(orbit_m_sum,
                size = (400,150),
                lw = lws[1],
                lc = RGB(0.2, 0.33, 0.5),
                xlabel = L"t",
                ylabel = L"\log_2 \mathcal{O}(t), \sum m_i(t)",
                frame = :box,
                #left_margin = 3mm,
                #bottom_margin = 5mm,
                legend = :topright,
                label = L"\sum m_i(t)",
                dpi = 500)
    plt = plot!(logorbit, label = L"\mathcal{O}(t)", lc = :red, lw = lws[2], linealpha = 0.7)
    savefig(plt, string(pasta,"/sum_M_orbit_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

function OrbitMpascal()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2_base10.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    orbit_m_sum = zeros(length(m[:,1]))
    for i in 1:length(m[:,1])
        orbit_m_sum[i] = sum(m[i,:])
    end
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Computer Modern", fg_legend = :false)
    plt = plot!(orbit_m_sum,
                size = (400,150),
                lw = lws[1],
                lc = RGB(0.2, 0.33, 0.5),
                xlabel = L"t",
                ylabel = L"\log_2 \mathcal{O}(t), \sum m_i(t)",
                frame = :box,
                #left_margin = 3mm,
                #bottom_margin = 5mm,
                legend = :topright,
                label = L"\sum m_i(t)",
                dpi = 500)
    plt = plot!(logorbit, label = L"\mathcal{O}(t)", lc = :red, lw = lws[2], linealpha = 0.7)
    savefig(plt, string(pasta,"/sum_M_orbit_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

function OrbitModd()
    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_2_power_of_2.csv", header = false)
    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_2_base10.csv", header = false)
    m = Int64.(replace(m, "" => 0))
    orbit_m_sum = zeros(length(m[:,1]))
    for i in 1:length(m[:,1])
        orbit_m_sum[i] = sum(m[i,:])
    end
    logorbit = log2.(orbit)
    plt = plot(fontfamily = "Computer Modern", fg_legend = :false)
    plt = plot!(orbit_m_sum,
                size = (400,150),
                lw = lws[1],
                lc = RGB(0.2, 0.33, 0.5),
                xlabel = L"t",
                ylabel = L"\log_2 \mathcal{O}(t), \sum m_i(t)",
                frame = :box,
                #left_margin = 3mm,
                #bottom_margin = 5mm,
                legend = :topright,
                label = L"\sum m_i(t)",
                dpi = 500)
    plt = plot!(logorbit, label = L"\mathcal{O}(t)", lc = :red, lw = lws[2], linealpha = 0.7)
    savefig(plt, string(pasta,"/sum_M_orbit_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_2.pdf"))
end

# OrbitMrandom()
# OrbitMoscilatory()
# OrbitMpascal()
# OrbitModd()
