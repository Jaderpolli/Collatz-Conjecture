using Plots
using DelimitedFiles
using StatsBase
using LaTeXStrings
using Plots.PlotMeasures
mkpath("FIGURES/fig4")

function plotACFrand(i, blocksize, subfig, sub, s)
    acf_rand = readdlm("DATA/ACF/ACF_Random/acf_n_0_$(i)_Random_mVectorSize_180_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("rand")

    iid_high_corr_rand = iid_highCorrelations(acf_rand, "rand")
    writedlm("FIGURES/fig3/iid_high_corr_rand_$(i)_blocksize_$(blocksize).csv", iid_high_corr_rand)
    bartlett_high_corr_rand = Bartlett_highCorrelations(acf_rand, "rand")
    writedlm("FIGURES/fig3/bartlett_high_corr_rand_$(i)_blocksize_$(blocksize).csv", bartlett_high_corr_rand)

    iid_high_corr_rand = readdlm("FIGURES/fig3/iid_high_corr_rand_$(i)_blocksize_$(blocksize).csv", header = false)
    bartlett_high_corr_rand = readdlm("FIGURES/fig3/bartlett_high_corr_rand_$(i)_blocksize_$(blocksize).csv", header = false)

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_rand = plot(abs.(acf_rand),
                        lc = colors[1],
                        fontfamily = "Palatino",
                        xminorticks = true,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = "", ylabel = "",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = :bottomleft,
                        label = false)
    figure_rand = scatter!(iid_high_corr_rand[:,1],iid_high_corr_rand[:,2],
                        ms = 4,
                        legend = false,
                        mc = :red4,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_rand = scatter!(bartlett_high_corr_rand[:,1],bartlett_high_corr_rand[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        legend = false,
                        mc = :red4,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_rand = plot!(size = (300/s,200/s), dpi = 500, grid = true)
    savefig(figure_rand, "FIGURES/fig3/fig_3$(subfig[sub]).pdf")
end

function plotACFprime(i, blocksize, subfig, sub, s)

    acf_prime = readdlm("DATA/ACF/ACF_Prime/acf_n_0_$(i)_Prime_mVectorSize_180_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("prime")

    iid_high_corr_prime = iid_highCorrelations(acf_prime, "prime")
     writedlm("FIGURES/fig3/iid_high_corr_prime_$(i)_blocksize_$(blocksize).csv", iid_high_corr_prime)
     bartlett_high_corr_prime = Bartlett_highCorrelations(acf_prime, "prime")
     writedlm("FIGURES/fig3/bartlett_high_corr_prime_$(i)_blocksize_$(blocksize).csv", bartlett_high_corr_prime)

    #iid_high_corr_prime = readdlm("FIGURES/fig3/iid_high_corr_prime_$(i)_blocksize_$(blocksize).csv", header = false)
    #bartlett_high_corr_prime = readdlm("FIGURES/fig3/bartlett_high_corr_prime_$(i)_blocksize_$(blocksize).csv", header = false)


    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_prime = plot(abs.(acf_prime),
                        lc = colors[2],
                        fontfamily = "Palatino",
                        xminorticks = true,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = "", ylabel = "",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = false)
    figure_prime = scatter!(iid_high_corr_prime[:,1],iid_high_corr_prime[:,2],
                        ms = 4,
                        legend = false,
                        mc = :orangered,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_prime = scatter!(bartlett_high_corr_prime[:,1],bartlett_high_corr_prime[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        legend = false,
                        mc = :orangered,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_prime = plot!(size = (300/s,200/s), dpi = 500, grid = true)
    savefig(figure_prime, "FIGURES/fig3/fig_3$(subfig[sub]).pdf")
end

function plotACFeven(i, blocksize, subfig, sub, s)

    acf_even = readdlm("DATA/ACF/ACF_Even/acf_n_0_$(i)_Even_mVectorSize_180_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("even")
   
     iid_high_corr_even = iid_highCorrelations(acf_even, "even")
     writedlm("FIGURES/fig3/iid_high_corr_even_$(i)_blocksize_$(blocksize).csv", iid_high_corr_even)
     bartlett_high_corr_even = Bartlett_highCorrelations(acf_even, "even")
     writedlm("FIGURES/fig3/bartlett_high_corr_even_$(i)_blocksize_$(blocksize).csv", bartlett_high_corr_even)

    # iid_high_corr_even = readdlm("FIGURES/fig3/iid_high_corr_even_$(i)_blocksize_$(blocksize).csv", header = false)
    # bartlett_high_corr_even = readdlm("FIGURES/fig3/bartlett_high_corr_even_$(i)_blocksize_$(blocksize).csv", header = false)


    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_even = plot(abs.(acf_even),
                        lc = colors[3],
                        xminorticks = true,
                        fontfamily = "Palatino",
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000], xlabel = "", ylabel = "",
                        yguidefontrotation = -90,
                        yscale = :log10,
                        xscale = :log10,
                        legend = false)
    figure_even = scatter!(iid_high_corr_even[:,1],iid_high_corr_even[:,2],
                        ms = 4,
                        legend = false,
                        mc = :darkgreen,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_even = scatter!(bartlett_high_corr_even[:,1],bartlett_high_corr_even[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        legend = false,
                        mc = :darkgreen,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_even = plot!(size = (300/s,200/s), dpi = 500, grid = true)
    savefig(figure_even, "FIGURES/fig3/3$(subfig[sub]).pdf")
end

function plotACFodd(i, blocksize)

    acf_odd = readdlm("DATA/ACF/ACF_Odd/acf_n_0_$(i)_Odd_mVectorSize_180_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("odd")
    
    #iid_high_corr_odd = iid_highCorrelations(acf_odd, "odd")
    #writedlm("FIGURES/fig3/iid_high_corr_odd_$(i)_blocksize_$(blocksize).csv", iid_high_corr_odd)
    #bartlett_high_corr_odd = Bartlett_highCorrelations(acf_odd, "odd")
    #writedlm("FIGURES/fig3/bartlett_high_corr_odd_$(i)_blocksize_$(blocksize).csv", bartlett_high_corr_odd)

    iid_high_corr_odd = readdlm("FIGURES/fig3/iid_high_corr_odd_$(i)_blocksize_$(blocksize).csv", header = false)
    bartlett_high_corr_odd = readdlm("FIGURES/fig3/bartlett_high_corr_odd_$(i)_blocksize_$(blocksize).csv", header = false)


    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_odd = plot(abs.(acf_odd),
                        lc = colors[4],
                        xminorticks = true,
                        fontfamily = "Palatino",
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
                        mc = :darkblue,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_odd = scatter!(bartlett_high_corr_odd[:,1],bartlett_high_corr_odd[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :darkblue,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_odd = plot!(size = (300,200), dpi = 500, grid = true)
    savefig(figure_odd, "FIGURES/fig3/acf_odd_$(i)_blocksize_$(blocksize).pdf")
end

function plotACFoscilatory(i, blocksize)

    acf_oscilatory = readdlm("DATA/ACF/ACF_Oscilatory/acf_n_0_$(i)_Oscilatory_mVectorSize_2100_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("oscilatory")
    
    iid_high_corr_oscilatory = iid_highCorrelations(acf_oscilatory, "oscilatory")
   writedlm("FIGURES/fig3/iid_high_corr_oscilatory_$(i)_mVectorSize_2100_blocksize_$(blocksize).csv", iid_high_corr_oscilatory)
    bartlett_high_corr_oscilatory = Bartlett_highCorrelations(acf_oscilatory, "oscilatory")
    writedlm("FIGURES/fig3/bartlett_high_corr_oscilatory_$(i)_mVectorSize_2100_blocksize_$(blocksize).csv", bartlett_high_corr_oscilatory)

#    iid_high_corr_oscilatory = readdlm("FIGURES/fig3/iid_high_corr_oscilatory_$(i)_mVectorSize_2100_blocksize_$(blocksize).csv", header = false)
#    bartlett_high_corr_oscilatory = readdlm("FIGURES/fig3/bartlett_high_corr_oscilatory_$(i)_mVectorSize_2100_blocksize_$(blocksize).csv", header = false)


    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_oscilatory = plot(abs.(acf_oscilatory),
                        lc = colors[5],
                        xminorticks = true,
                        fontfamily = "Computer Modern",
                        left_margin = 5mm,
                        yticks = [0.0000001,0.000001,0.00001, 0.0001,0.001,0.01,0.1,1],
                        xticks = [1, 10, 100, 1000, 10000], xlabel = L"\tau", ylabel = L"C( \tau)",
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
    figure_oscilatory = scatter!(bartlett_high_corr_oscilatory[:,1],bartlett_high_corr_oscilatory[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :purple4,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_oscilatory = plot!(size = (300,200), dpi = 500, grid = true)
    savefig(figure_oscilatory, "FIGURES/fig3/antigas/acf_oscilatory_$(i)_mVectorSize_2100_blocksize_$(blocksize).pdf")
end

function plotACFpascal(i, blocksize)

    acf_pascal = readdlm("DATA/ACF/ACF_Pascal/acf_n_0_$(i)_Pascal_mVectorSize_180_MaxRand_10_BlockSize_$(blocksize).csv", BigFloat, header = false)
    println("pascal")
    
    iid_high_corr_pascal = iid_highCorrelations(acf_pascal, "pascal")
    writedlm("FIGURES/fig3/iid_high_corr_pascal_$(i)_blocksize_$(blocksize).csv", iid_high_corr_pascal)
    bartlett_high_corr_pascal = Bartlett_highCorrelations(acf_pascal, "pascal")
    writedlm("FIGURES/fig3/bartlett_high_corr_pascal_$(i)_blocksize_$(blocksize).csv", bartlett_high_corr_pascal)

    # iid_high_corr_pascal = readdlm("FIGURES/fig3/iid_high_corr_pascal_$(i)_blocksize_$(blocksize).csv", header = false)
    # bartlett_high_corr_pascal = readdlm("FIGURES/fig3/bartlett_high_corr_pascal_$(i)_blocksize_$(blocksize).csv", header = false)

    colors = [:red, :orange, :green, :blue, :purple, :magenta]

    figure_pascal = plot(abs.(acf_pascal),
                        lc = colors[6],
                        xminorticks = true,
                        fontfamily = "Palatino",
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
                        mc = :magenta3,
                        markerstrokewidth = 0,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_pascal = scatter!(bartlett_high_corr_pascal[:,1],bartlett_high_corr_pascal[:,2],
                        ms = 4,
                        marker = [:star],
                        markerstrokewidth = 3,
                        label = L"C(\tau) > 3\sigma_{C(\tau)}",
                        mc = :magenta3,
                        frame = :box,
                        yscale = :log10,
                        xscale = :log10)
    figure_pascal = plot!(size = (300,200), dpi = 500, grid = true)
    savefig(figure_pascal, "FIGURES/fig3/acf_pascal_$(i)_blocksize_$(blocksize).pdf")
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


function plote()
    s = 1.9
    blocksizes = [2 3 5]
    subfig = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
    i = 1

    sub = 0

    for blocksize in blocksizes
        sub += 1
        plotACFrand(i, blocksize, subfig, sub,s)
        sub += 1
        plotACFprime(i, blocksize, subfig, sub, s)
        sub += 1
        plotACFeven(i, blocksize, subfig, sub, s)
    end
end

plote()