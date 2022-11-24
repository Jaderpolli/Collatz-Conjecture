using Plots, ColorSchemes
#pyplot()
using DelimitedFiles

function heatmap_M()
    pasta = "FIGURES/FIGURAS_BONITAS"
    mkpath(pasta)

    m = readdlm("D:/Windows/Usuario/Documents/Collatz_map/RAW_DATA/ORBITS/orbit_n_0_1_Adjacent_mVectorSize_360_MaxRand_10_primeBlockSize_4_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    lenx = length(m[:,1])
    leny = length(m[1,:])
    figure = heatmap(transpose(m), palette = cgrad(ColorSchemes.thermal.colors  , categorical = true))

    png(figure, string(pasta, "/teste.png"))
end

heatmap_M()
