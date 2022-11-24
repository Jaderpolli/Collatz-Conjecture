using Plots
using DelimitedFiles
using Plots.PlotMeasures
using LaTeXStrings

function main()
    pasta = "Julia/FIGURES_SCRIPTS/FIGURAS_BONITAS"
    mkpath(pasta)


    plt = plot(dpi = 500,
        fontfamily = "Computer Modern",
        xlabel = L"t/T",
        ylabel = L"S_{\mathrm{max}}",
        yrange = (4.0, log(100)+0.02),
        framestyle = :box,
        yguidefontrotation = -90
    )
    l = 0

    colors = [:royalblue1, :crimson, :gold3, :purple4]
    shapes = [:rect, :star5, :diamond, :rtriangle]

    types = ["Prime", "Even", "Odd", "Adjacent"]
    MaxRand = 10
    mVectorSizes  = [180, 360, 360, 360]
    maximumPrimeBlockSizes = [5, 4, 4, 4]

    for i in eachindex(types)
        type = types[i]
        maximumPrimeBlockSize = maximumPrimeBlockSizes[i]
        mVectorSize = mVectorSizes[i]
        l += 1
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                data = readdlm("D:/Windows/Usuario/Documents/Collatz_map/DATA/VON_NEUMANN_ENTROPY/variating_time_series_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                maxS = maximum(data)
                p = findall(isequal(maxS), data[:,2])
                p = data[p,1]
                #plt = plot!(data[:,1], data[:,2], ms = 2, alpha = 0.3, ls = :dash, lc = colors[l], mc = colors[l], markerstrokewidth = 0, label = false)
                plt = scatter!([p], [maxS], markershape = [shapes[j-1]], ms = 4, markeralpha = 0.9, mc = colors[i], markerstrokewidth = 0, label = false)
            end
        end
        scatter!([3.5], markershape = [:circle], ms = 4, mc = colors[i], markerstrokewidth = 0,
                        label = "$(type)", left_margin = 8mm, legend = :bottomright)
    end

    mVectorSize = 180
    maximumPrimeBlockSize =  5
    types = ["Random"]
    for i in eachindex(types)
        type = types[i]
        l += 1
        for j in 2:maximumPrimeBlockSize
            primeBlockSize = j
            for k in 1:factorial(primeBlockSize)
                data = readdlm("D:/Windows/Usuario/Documents/Collatz_map/DATA/VON_NEUMANN_ENTROPY/variating_time_series_entropy_n_0_$(k)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize).csv", header = false)
                maxS = maximum(data)
                p = findall(isequal(maxS), data[:,2])
                p = data[p,1]
                #plt = plot!(data[:,1], data[:,2], ms = 2, alpha = 0.3, ls = :dash, lc = colors[l], mc = colors[l], markerstrokewidth = 0, label = false)
                plt = scatter!([p], [maxS], markershape = :+, ms = 4, mc = :red, markerstrokewidth = 0, label = false)
            end
        end
    end
    plt = scatter!([3.5], markershape = :+, ms = 4, mc = :red, markerstrokewidth = 0,
                    label = "Random", left_margin = 8mm, legend = :bottomright)
    plt = plot!([0.6;1],[log(100);log(100)], ls = :dash, lc = :black, label = L"S_{\mathrm{lim}} = \ln(100)")
    #plt = plot!([3.5], lc = :red, label = "Random", left_margin = 5mm, yrange = (3.6,log(100)))
    savefig(plt, string(pasta,"/S_max_all_conditions.pdf"))
end

main()
