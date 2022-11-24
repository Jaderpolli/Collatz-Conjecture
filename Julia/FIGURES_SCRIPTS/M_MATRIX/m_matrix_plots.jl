using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools

function savingFigure(pasta::String, mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
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

    if mVectorSize ≤ 360
        if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
            i = rand(1:factorial(BlockSize))
            pastaType = string(pasta, "/fig_$(type)")
            mkpath(pastaType)
            m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
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
            png(plt, string(pastaType,"/mmatrix_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).png"))
        elseif type == "Pascal" || type == "Oscilatory" || type == "Linear"
            i = 1
            pastaType = string(pasta, "/fig_$(type)")
            mkpath(pastaType)
            m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
            m = Int64.(replace(m, "" => -1))
            l = maximum(m)
            loadcolorscheme(:cs, vcat(RGB{Float64}(0,0,0), colorant"olivedrab1",make_colorscheme(palette, l)[1:end]))
            lenx = length(m[:,1])
            leny = length(m[1,:])
            plt = heatmap(transpose(m[:,:]),
                        fontfamily = "Computer Modern",
                        xlabel = L"t",
                        ylabel =  L"m_i",
                        c = cgrad(:cs, categorical = true),
                        size = (400,300), dpi = 500)
            png(plt, string(pastaType,"/mmatrix_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).png"))
        end
    else
        if type == "Random"
            i = rand(1:4)
            pastaType = string(pasta, "/fig_$(type)")
            mkpath(pastaType)
            m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
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
            png(plt, string(pastaType,"/mmatrix_n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).png"))
        else
            i = 1
            pastaType = string(pasta, "/fig_$(type)")
            mkpath(pastaType)
            m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
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
            png(plt, string(pastaType,"/mmatrix_n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).png"))
        end
    end
end

function runfigure()
    mVectorSizes = [2100] #this value is picked so that it generate large enough orbits and is
                    #divisible by 2,3,4,5 that are the blocksizes of primes
    MaxRand = 10
    maximumBlockSize =  5 # with this variable, we create 1!+2!+3!+4!+5!=152 initial conditions for each type (i.e. 608 initial conditions)
    types = ["Random","Prime", "Even", "Odd", "Pascal", "Oscilatory"#=,"Linear"=#]
    pasta = "D:/WINDOWS/Usuario/Documents/Collatz_map/FIGURES/M_MATRIX"
    mkpath(pasta)

    Threads.@threads for mVectorSize in mVectorSizes
        i = 0
        if mVectorSize ≤ 360
            Threads.@threads for type in types
                i += 1
                if type == "Linear"
                    mVectorSize = 180
                    BlockSizes = [30]
                    for BlockSize in BlockSizes
                        savingFigure(pasta, mVectorSize, MaxRand, BlockSize; type)
                    end
                else
                    for BlockSize in 2:maximumBlockSize
                        savingFigure(pasta, mVectorSize, MaxRand, BlockSize; type)
                    end
                end
            end
        else
            for type in types[2:end]
                BlockSize = 2
                savingFigure(pasta, mVectorSize, MaxRand, BlockSize; type)
            end
        end
    end
end

#runfigure()
