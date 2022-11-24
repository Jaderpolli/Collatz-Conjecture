using DelimitedFiles
using StatsBase
using Plots
using LaTeXStrings

function gammaset(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
    gammas = []
    if mVectorSize ≤ 360
        if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
            for i in 1:factorial(BlockSize)
                gamma = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                gammas = vcat(gammas,gamma)
            end
        elseif type == "Pascal" || type == "Oscilatory" || type == "Linear"
            i = 1
            gamma = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
            gammas = vcat(gammas,gamma)
        end
    else
        if type == "Random"
            for i in 1:4
                gamma = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                gammas = vcat(gammas,gamma)
            end
        else
            i = 1
            gamma = readdlm("DATA/GAMMA_2/gamma_2_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
            gammas = vcat(gammas,gamma)
        end
    end
    return(gammas)
end

function meangamma()
    mkpath("DATA/MEANGAMMA")


    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types = ["Random", "Prime", "Even", "Odd", "Pascal", "Oscilatory", "Linear"]

    gammas = []

    for mVectorSize in mVectorSizes
        i = 0
        for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    gammaSet = gammaset(mVectorSize,MaxRand, BlockSize; type)
                    gammas = vcat(gammas,  gammaSet)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    gammaSet = gammaset(mVectorSize,MaxRand, BlockSize; type)
                    gammas = vcat(gammas,  gammaSet)
                end
            end
        end
    end

    meangammas = mean(gammas)
    stdDeviationgamma = std(gammas)
    data = [meangammas stdDeviationgamma]
    writedlm("DATA/GAMMA_2/mean_std_gamma.csv", data, header = false, ',')
end

#meangamma()

function distributionplot()
    pasta = "FIGURES/GAMMA_2_FIGURES"


    mVectorSizes = [180, 2100]
    MaxRand = 10
    maximumBlockSize =  5
    types = ["Random", "Prime", "Even", "Odd", "Pascal", "Oscilatory", "Linear"]

    gammas = []

    for mVectorSize in mVectorSizes
        i = 0
        for type in types
            i += 1
            if type == "Linear"
                mVectorSize = 180
                BlockSizes = [30, 60, 180]
                for BlockSize in BlockSizes
                    gammaSet = gammaset(mVectorSize,MaxRand, BlockSize; type)
                    gammas = vcat(gammas,  gammaSet)
                end
            else
                for j in 2:maximumBlockSize
                    BlockSize = j
                    gammaSet = gammaset(mVectorSize,MaxRand, BlockSize; type)
                    gammas = vcat(gammas,  gammaSet)
                end
            end
        end
    end

    meangammas = mean(gammas)
    stdDeviationgamma = std(gammas)

    gammas = collect(Iterators.flatten(gammas))
    plt = histogram(gammas, fontfamily = "Computer Modern", 
        label = false, c = :orange, bins = 60,
        frame = :box, size = (400,200)
        )
    plt = plot!([meangammas;meangammas],[0;120],
        ls = :dash,
        lw = 1.5,
        lc = :black,
        legend = :topleft,
        label = label = L"\langle\gamma_2\rangle=  %$(Float16(meangammas))")
    devminus = meangammas- 2*stdDeviationgamma
    plt = plot!([devminus; devminus],[0;120],
        ls = :dash,
        lw = 1.5,
        lc = :grey,
        legend = :topleft,
        label = false)
    devplus = meangammas + 2*stdDeviationgamma
    plt = plot!([devplus; devplus],[0;120],
        ls = :dash,
        lw = 1.5,
        lc = :grey,
        legend = :topleft,
        label = label = L"\langle\gamma_2\rangle \pm 2\sigma")
    savefig(plt, string(pasta,"/dist_gamma.pdf"))
end

distributionplot()