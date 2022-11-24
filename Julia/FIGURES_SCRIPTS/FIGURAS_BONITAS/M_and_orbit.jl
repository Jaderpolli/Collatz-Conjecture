include("initial_condition_modules.jl")
include("orbit_generator_modules.jl")

using Plots, Plots.PlotMeasures
using LaTeXStrings
import Main.AlgorithmsOfmVectors
import Main.InitialConditionsGenerator
import Main.SavingInitialConditions
import Main.OrbitsBase10
import Main.OrbitPowersOf2

function m_initial_condition(mVectorSize, MaxRand)
    m₀ = hcat(0,transpose(rand(1:MaxRand,mVectorSize))) #this will create one initial conditions
    return(m₀)
end

function n_initial_condition(m₀)
    n₀ = AlgorithmsOfmVectors.rev_algorithm_m_vector(m₀)
    return(n₀)
end

function orbit_base10(n₀)
    orbit = OrbitsBase10.orbitbase10(n₀)
    return(orbit)
end

function orbit_m(orbit)
    M = OrbitPowersOf2.orbitpowerof2(orbit)
    return(M)
end

function data_generator()
    for i in 1:10
        MaxRand = 5
        mVectorSize = 20
        m₀ = m_initial_condition(mVectorSize, MaxRand)
        n₀ = n_initial_condition(m₀)
        orbit =  orbit_base10(n₀)
        M = orbit_m(orbit)
        writedlm("Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS/orbit_$(i).csv", orbit, header = false)
        writedlm("Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS/M_$(i).csv", M, header = false)
    end
end

function figure1()
    pasta = "Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS"

    # M = readdlm("Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS/M.csv", header = false)
    # M = Int64.(replace(M, "" => -1))
    # cscheme = [:cherry, :avocado, :sunset, :vangogh]
    # plt1 = plot(fontfamily = "Computer Modern")
    # plt1 = heatmap!(transpose(M),
    #             c = cgrad([:white, RGB(0.1, 0.1, 0.3), RGB(0.03, 0.25, 0.5), RGB(0.2, 0.33, 0.5), :deepskyblue3, :lightblue3, :lemonchiffon3, :wheat2, :darkseagreen1, :lightyellow1],
    #              [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9],
    #              rev = :false, categorical = true),
    #             size = (700,200),
    #             xlabel = L"t",
    #             ylabel = L"m-\mathrm{vector \ component}",
    #             frame = :box,
    #             left_margin = 3mm,
    #             bottom_margin = 5mm,
    #             legend = :topright,
    #             dpi = 1000)
    # plt = plot(plt1, title = L"\mathbf{m_0} = (0, 3, 5, 5, 1, 3, 3, 5, 4, 4, 2, 3, 1, 1, 5, 1, 4, 2, 1, 5, 3)", top_margin = 3mm)
    # savefig(plt, string(pasta,"/M_random.pdf"))
    #
    # M = readdlm("Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS/M.csv", header = false)
    # M = Int64.(replace(M, "" => -0))
    # orbit_m_sum = zeros(length(M[:,1]))
    # for i in eachindex(M[:,1])
    #     orbit_m_sum[i] = sum(M[i,:])
    # end
    plt2 = plot(fontfamily = "Computer Modern", size = (400,150), dpi = 500, fg_legend = :false,
                label = L"\mathcal{O}(t)", lc = :red, lw = 2,
                frame = :box, xlabel = L"t", ylabel = L"\log_2(\mathcal{O}(t))")
    # plt2 = plot!(orbit_m_sum,
    #             size = (700,400),
    #             lw = 3,
    #             lc = RGB(0.2, 0.33, 0.5),
    #             xlabel = L"t",
    #             ylabel = L"\log_2(\mathcal{O}(t)), \sum m_i(t)",
    #             frame = :box,
    #             left_margin = 3mm,
    #             bottom_margin = 5mm,
    #             legend = :topright,
    #             label = L"\sum m_i(t)",
    #             dpi = 1000)
    colors = [:orange, :red, :gold, :green, :magenta,  :blue, :purple]
    for i in 1:7
        orbit = readdlm("Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS/orbit_$(i).csv", header = false)
        logorbit = log2.(orbit)
        plt2 = plot!(logorbit, label = false, lc = colors[i])
    end
    savefig(plt2, string(pasta,"/M_orbit.pdf"))
end

function figure2()
    pasta = "Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS"

    m = readdlm("D:/Windows/Usuario/Documents/Collatz_map/RAW_DATA/ORBITS/orbit_n_0_7_Adjacent_mVectorSize_360_MaxRand_10_primeBlockSize_4_power_of_2.csv", header = false)
    m = Int64.(replace(m, "" => -1))
    plt1 = plot(fontfamily = "Computer Modern")

    plt2 = plot(fontfamily = "Computer Modern")
    plt2 = heatmap!(transpose(m),
                c = cgrad([:white, RGB(0.1, 0.1, 0.3), RGB(0.03, 0.25, 0.5), RGB(0.2, 0.33, 0.5),
                            :dodgerblue3, :deepskyblue3, :lightblue3, :steelblue,
                            :dodgerblue2, :deepskyblue2, :lightblue2, :lightskyblue3,
                            :lemonchiffon3, :lightyellow3, :wheat2, :gold2,
                            :darkseagreen1, :aquamarine1, :palegreen, :lightyellow2,:lightyellow1],
                [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1],
                 rev = :false, categorical = true),
                size = (700,200),
                xlabel = L"t",
                ylabel = L"m-\mathrm{vector \ component}",
                frame = :box,
                left_margin = 3mm,
                bottom_margin = 5mm,
                legend = :topright,
                dpi = 1000)
    plt = plot(plt2, title = title = L"\mathbf{m_0} = (0, 2, 1, 3, 4, 2, 1, 3, 4, \dots, 2, 1, 3, 4, 2, 1, 3, 4)", top_margin = 3mm)
    savefig(plt, string(pasta,"/M_struct.pdf"))

    plt3 = plot(fontfamily = "Computer Modern")
    plt3 = heatmap!(transpose(m[1:500,:]),
                c = cgrad([:white, RGB(0.1, 0.1, 0.3), RGB(0.03, 0.25, 0.5), RGB(0.2, 0.33, 0.5),
                            :dodgerblue3, :deepskyblue3, :lightblue3, :steelblue,
                            :dodgerblue2, :deepskyblue2, :lightblue2, :lightskyblue3,
                            :lemonchiffon3, :lightyellow3, :wheat2, :gold2,
                            :darkseagreen1, :aquamarine1, :palegreen, :lightyellow2,:lightyellow1],
                [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1],
                 rev = :false, categorical = true),
                size = (700,400),
                xlabel = L"t",
                ylabel = L"m-\mathrm{vector \ component}",
                frame = :box,
                left_margin = 3mm,
                bottom_margin = 5mm,
                legend = :topright,
                dpi = 1000)
    plt = plot(plt3, title = title = L"\mathbf{m_0} = (0, 2, 1, 3, 4, 2, 1, 3, 4, \dots, 2, 1, 3, 4, 2, 1, 3, 4)", top_margin = 3mm)
    savefig(plt, string(pasta,"/M_struct_zoom.pdf"))
end

#data_generator()
figure1()
