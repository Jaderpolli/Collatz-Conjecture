using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures
mkpath("FIGURES/fig3")

function plotACF()
    acf_rand = readdlm("DATA/ACF/acf_n_0_1_Random_mVectorSize_180_MaxRand_10_BlockSize_3.csv", BigFloat, header = false)
    println("rand")
    iid_high_corr_rand = iid_highCorrelations(acf_rand, "rand")
    bartlett_high_corr_rand = Bartlett_highCorrelations(acf_rand, "rand")

    acf_prime = readdlm("DATA/ACF/acf_n_0_1_Prime_mVectorSize_180_MaxRand_10_BlockSize_2.csv", BigFloat, header = false)
    println("prime")
    iid_high_corr_prime = iid_highCorrelations(acf_prime, "prime")
    bartlett_high_corr_prime = Bartlett_highCorrelations(acf_prime, "prime")

    acf_even = readdlm("DATA/ACF/acf_n_0_1_Even_mVectorSize_180_MaxRand_10_BlockSize_2.csv", BigFloat, header = false)
    println("even")
    iid_high_corr_even = iid_highCorrelations(acf_even, "even")
    bartlett_high_corr_even = Bartlett_highCorrelations(acf_even, "even")

    acf_odd = readdlm("DATA/ACF/acf_n_0_1_Odd_mVectorSize_180_MaxRand_10_BlockSize_2.csv", BigFloat, header = false)
    println("odd")
    iid_high_corr_odd = iid_highCorrelations(acf_odd, "odd")
    bartlett_high_corr_odd = Bartlett_highCorrelations(acf_odd, "odd")

    acf_oscilatory = readdlm("DATA/ACF/acf_n_0_1_Oscilatory_mVectorSize_180_MaxRand_10_BlockSize_2.csv", BigFloat, header = false)
    println("oscilatory")
    iid_high_corr_oscilatory = iid_highCorrelations(acf_oscilatory, "oscilatory")
    bartlett_high_corr_oscilatory = Bartlett_highCorrelations(acf_oscilatory, "oscilatory")

    acf_pascal = readdlm("DATA/ACF/acf_n_0_1_Pascal Triangle_mVectorSize_180_MaxRand_10_BlockSize_2.csv", BigFloat, header = false)
    println("pascal")
    iid_high_corr_pascal = iid_highCorrelations(acf_pascal, "pascal")
    bartlett_high_corr_pascal = Bartlett_highCorrelations(acf_pascal, "pascal")

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_rand = plot(abs.(acf_rand),
                        lc = colors[1],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C(\tau)")
    figure_rand = scatter!(iid_high_corr_rand[:,1],iid_high_corr_rand[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :red4,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_rand = scatter!(bartlett_high_corr_rand[:,1],bartlett_high_corr_rand[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :red4,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_rand = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_rand, "FIGURES/fig3/acf_rand.pdf")

    figure_prime = plot(abs.(acf_prime),
                        lc = colors[2],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C( \tau)")
    figure_prime = scatter!(iid_high_corr_prime[:,1],iid_high_corr_prime[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :orangered,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_prime = scatter!(bartlett_high_corr_prime[:,1],bartlett_high_corr_prime[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :orangered,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_prime = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_prime, "FIGURES/fig3/acf_prime.pdf")

    figure_even = plot(abs.(acf_even),
                        lc = colors[3],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C( \tau)")
    figure_even = scatter!(iid_high_corr_even[:,1],iid_high_corr_even[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :darkgreen,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_even = scatter!(bartlett_high_corr_even[:,1],bartlett_high_corr_even[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :darkgreen,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_even = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_even, "FIGURES/fig3/acf_even.pdf")

    figure_odd = plot(abs.(acf_odd),
                        lc = colors[4],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C( \tau)")
    figure_odd = scatter!(iid_high_corr_odd[:,1],iid_high_corr_odd[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :navyblue,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_odd = scatter!(bartlett_high_corr_odd[:,1],bartlett_high_corr_odd[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :navyblue,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_odd = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_odd, "FIGURES/fig3/acf_odd.pdf")

    figure_oscilatory = plot(abs.(acf_oscilatory),
                        lc = colors[5],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C( \tau)")
    figure_oscilatory = scatter!(iid_high_corr_oscilatory[:,1],iid_high_corr_oscilatory[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :purple4,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_oscilatory= scatter!(bartlett_high_corr_oscilatory[:,1],bartlett_high_corr_oscilatory[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :purple4,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_oscilatory = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_oscilatory, "FIGURES/fig3/acf_oscilatory.pdf")

    figure_pascal = plot(abs.(acf_pascal),
                        lc = colors[6],
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = L"\tau", ylabel = L"C( \tau)",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = L"C( \tau)")
    figure_pascal = scatter!(iid_high_corr_pascal[:,1],iid_high_corr_pascal[:,2],
                        ms = 4,
                        label = L"C(\tau) > 3/\sqrt{N}",
                        mc = :darkviolet,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_pascal= scatter!(bartlett_high_corr_pascal[:,1],bartlett_high_corr_pascal[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :darkviolet,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_pascal = plot!(size = (400,200), dpi = 500, grid = true)
    savefig(figure_pascal, "FIGURES/fig3/acf_pascal.pdf")
end

function Bartlett_highCorrelations(x, type)
    high_corr = reshape([],0,2)
    N = length(x)
    σs = reshape([], 0,2)
    for τ in 1:N
        println("$(100*τ/N) %", "$(type)")
        S = 0
        for ν in 1:N
            if ν-τ ≤ 0
                ds = x[ν]^2+2*x[ν]^2*x[τ]
            elseif ν+τ ≥ N
                ds = x[ν]^2-4*x[τ]x[ν]x[ν-τ]+x[ν]^2*x[τ]^2
            else
                ds = x[ν]^2+x[ν+τ]*x[ν-τ]-4*x[τ]x[ν]x[ν-τ]+x[ν]^2*x[τ]^2
            end
            S = S+ds
        end
        σ = sqrt(S/N)
        if abs(x[τ]) > 3*σ
            hc = [τ abs(x[τ])]
            high_corr = vcat(high_corr, hc)
        else
            nothing
        end
        τσ = [τ σ]
        σs = vcat(σs, τσ)
    end
    writedlm("FIGURES/fig3/σ_$(type).csv", σs)
    return(high_corr)
end

function iid_highCorrelations(x, type)
    high_corr = reshape([],0,2)
    N = length(x)
    for τ in 1:N
        if abs(x[τ]) > 3/sqrt(N)
            hc = [τ abs(x[τ])]
            high_corr = vcat(high_corr, hc)
        else
            nothing
        end
    end
    return(high_corr)
end

plotACF()
