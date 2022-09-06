module FunctionsReadFit
    using StatsBase, DelimitedFiles, DataFrames, CSV

    function allβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]
        βs = []
        for mVectorSize in mVectorSizes
            i = 0
            for type in types
                i += 1
                if type == "Linear"
                    mVectorSize = 180
                    BlockSizes = [30, 60, 180]
                    for BlockSize in BlockSizes
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_1_Linear_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        if mVectorSize ≤ 360
                            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                                for i in 1:factorial(BlockSize)
                                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    βs = vcat(βs, β[2])
                                end
                            elseif type == "Pascal Triangle" || type == "Oscilatory"
                                i = 1
                                β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                βs = vcat(βs, β[2])
                            end
                        else
                            if type == "Random"
                                for i in 1:4
                                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    βs = vcat(βs, β[2])
                                end
                            else
                                i = 1
                                β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                βs = vcat(βs, β[2])
                            end
                        end
                    end
                end
            end
        end
        return(βs)
    end

    function randomβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Random"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                else
                    for i in 1:4
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                end
            end
        end
        return(βs)
    end

    function primeβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Prime"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                else
                    i = 1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                end
            end
        end
        return(βs)
    end

    function evenβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Even"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                else
                    i = 1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                end
            end
        end
        return(βs)
    end

    function oddβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Odd"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        βs = vcat(βs, β[2])
                    end
                else
                    i = 1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                end
            end
        end
        return(βs)
    end

    function oscilatoryβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Oscilatory"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i=1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                else
                    i = 1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                end
            end
        end
        return(βs)
    end

    function pascalβ()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Pascal Triangle"
        βs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i=1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                else
                    i = 1
                    β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    βs = vcat(βs, β[2])
                end
            end
        end
        return(βs)
    end

    function linearβ()
        MaxRand = 10
        maximumBlockSize =  5
        type = "Linear"
        βs = []
        for j in 2:maximumBlockSize
            mVectorSize = 180
            BlockSizes = [30, 60, 180]
            for BlockSize in BlockSizes
                β = readdlm("DATA/POWER_SPECTRA_STATIONARY_FIT/fit_powerspectra_n_0_1_Linear_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                βs = vcat(βs, β[2])
            end
        end
        return(βs)
    end

    function allα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]
        αs = []
        for mVectorSize in mVectorSizes
            i = 0
            for type in types
                i += 1
                if type == "Linear"
                    mVectorSize = 180
                    BlockSizes = [30, 60, 180]
                    for BlockSize in BlockSizes
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_1_Linear_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        if mVectorSize ≤ 360
                            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                                for i in 1:factorial(BlockSize)
                                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    αs = vcat(αs, α[2])
                                end
                            elseif type == "Pascal Triangle" || type == "Oscilatory"
                                i = 1
                                α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                αs = vcat(αs, α[2])
                            end
                        else
                            if type == "Random"
                                for i in 1:4
                                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    αs = vcat(αs, α[2])
                                end
                            else
                                i = 1
                                α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                αs = vcat(αs, α[2])
                            end
                        end
                    end
                end
            end
        end
        return(αs)
    end

    function randomα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Random"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                else
                    for i in 1:4
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                end
            end
        end
        return(αs)
    end

    function primeα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Prime"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                else
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                end
            end
        end
        return(αs)
    end

    function evenα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Even"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                else
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                end
            end
        end
        return(αs)
    end

    function oddα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Odd"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        αs = vcat(αs, α[2])
                    end
                else
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                end
            end
        end
        return(αs)
    end

    function oscilatoryα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Oscilatory"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                else
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                end
            end
        end
        return(αs)
    end

    function pascalα()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Pascal Triangle"
        αs = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                else
                    i = 1
                    α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    αs = vcat(αs, α[2])
                end
            end
        end
        return(αs)
    end

    function linearα()
        MaxRand = 10
        maximumBlockSize =  5
        type = "Linear"
        αs = []
        for j in 2:maximumBlockSize
            mVectorSize = 180
            BlockSizes = [30, 60, 180]
            for BlockSize in BlockSizes
                α = readdlm("DATA/DFA_STATIONARY_FIT/fit_dfa_stationary_n_0_1_Linear_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                αs = vcat(αs, α[2])
            end
        end
        return(αs)
    end
end

module ResultsMeanStd
    using StatsBase, DelimitedFiles, DataFrames, CSV
    import.Main.FunctionsReadFit

    function α()
        αs = FunctionsReadFit.allα()
        mean_and_stdα = mean_and_std(αs)
        allresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/allresultsα.csv", allresultsα)

        αs = FunctionsReadFit.randomα()
        mean_and_stdα = mean_and_std(αs)
        randomresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/randomresultsα.csv", randomresultsα)

        αs = FunctionsReadFit.primeα()
        mean_and_stdα = mean_and_std(αs)
        primeresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/primeresultsα.csv", primeresultsα)

        αs = FunctionsReadFit.evenα()
        mean_and_stdα = mean_and_std(αs)
        evenresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/evenresultsα.csv", evenresultsα)

        αs = FunctionsReadFit.oddα()
        mean_and_stdα = mean_and_std(αs)
        oddresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/oddresultsα.csv", oddresultsα)

        αs = FunctionsReadFit.oscilatoryα()
        mean_and_stdα = mean_and_std(αs)
        oscilatoryresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/oscilatoryresultsα.csv", oscilatoryresultsα)

        αs = FunctionsReadFit.pascalα()
        mean_and_stdα = mean_and_std(αs)
        pascalresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/pascalresultsα.csv", pascalresultsα)

        αs = FunctionsReadFit.linearα()
        mean_and_stdα = mean_and_std(αs)
        linearresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write("DATA/DFA_STATIONARY_FIT/linearresultsα.csv", linearresultsα)

        resultsα  = DataFrame(type = [], meanα = [], stdα = [], dstdα = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read("DATA/DFA_STATIONARY_FIT/$(tipo)resultsα.csv", DataFrame)
            push!(resultsα, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write("DATA/DFA_STATIONARY_FIT/resultsα.csv", resultsα)
    end

    function β()
        βs = FunctionsReadFit.allβ()
        mean_and_stdβ = mean_and_std(βs)
        allresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/allresultsβ.csv", allresultsβ)

        βs = FunctionsReadFit.randomβ()
        mean_and_stdβ = mean_and_std(βs)
        randomresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/randomresultsβ.csv", randomresultsβ)

        βs = FunctionsReadFit.primeβ()
        mean_and_stdβ = mean_and_std(βs)
        primeresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/primeresultsβ.csv", primeresultsβ)

        βs = FunctionsReadFit.evenβ()
        mean_and_stdβ = mean_and_std(βs)
        evenresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/evenresultsβ.csv", evenresultsβ)

        βs = FunctionsReadFit.oddβ()
        mean_and_stdβ = mean_and_std(βs)
        oddresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/oddresultsβ.csv", oddresultsβ)

        βs = FunctionsReadFit.oscilatoryβ()
        mean_and_stdβ = mean_and_std(βs)
        oscilatoryresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/oscilatoryresultsβ.csv", oscilatoryresultsβ)

        βs = FunctionsReadFit.pascalβ()
        mean_and_stdβ = mean_and_std(βs)
        pascalresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/pascalresultsβ.csv", pascalresultsβ)

        βs = FunctionsReadFit.linearβ()
        mean_and_stdβ = mean_and_std(βs)
        linearresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/linearresultsβ.csv", linearresultsβ)

        resultsβ  = DataFrame(type = [], meanβ = [], stdβ = [], dstdβ = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read("DATA/POWER_SPECTRA_STATIONARY_FIT/$(tipo)resultsβ.csv", DataFrame)
            push!(resultsβ, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/resultsβ.csv", resultsβ)
    end
end

module pvaluesStructured
    using StatsBase, DelimitedFiles, DataFrames, CSV, HypothesisTests
    import.Main.FunctionsReadFit

    function pvaluePrimeα()
        randomαs = FunctionsReadFit.randomα()
        primeαs = Float64.(FunctionsReadFit.primeα())
        p=pvalue(OneSampleTTest(primeαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvaluePrimeβ()
        randomβs = FunctionsReadFit.randomβ()
        primeβs = Float64.(FunctionsReadFit.primeβ())
        p=pvalue(OneSampleTTest(primeβs,mean(randomβs)), tail = :both)
        return(p)
    end

    function pvalueEvenα()
        randomαs = FunctionsReadFit.randomα()
        evenαs = Float64.(FunctionsReadFit.evenα())
        p=pvalue(OneSampleTTest(evenαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvalueEvenβ()
        randomβs = FunctionsReadFit.randomβ()
        evenβs = Float64.(FunctionsReadFit.evenβ())
        p=pvalue(OneSampleTTest(evenβs,mean(randomβs)), tail = :both)
        return(p)
    end

    function pvalueOddα()
        randomαs = FunctionsReadFit.randomα()
        oddαs = Float64.(FunctionsReadFit.oddα())
        p=pvalue(OneSampleTTest(oddαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvalueOddβ()
        randomβs = FunctionsReadFit.randomβ()
        oddβs = Float64.(FunctionsReadFit.oddβ())
        p=pvalue(OneSampleTTest(oddβs,mean(randomβs)), tail = :both)
        return(p)
    end

    function pvaluesAll()
        pPrimeα = pvaluePrimeα()
        pPrimeβ = pvaluePrimeβ()
        pEvenα = pvalueEvenα()
        pEvenβ = pvalueEvenβ()
        pOddα = pvalueOddα()
        pOddβ = pvalueOddβ()

        pvaluesβ  = DataFrame(Prime = [pPrimeβ], Even = [pEvenβ], Odd = [pOddβ])
        CSV.write("DATA/POWER_SPECTRA_STATIONARY_FIT/pvaluesβ.csv", pvaluesβ)
        pvaluesα  = DataFrame(Prime = [pPrimeα], Even = [pEvenα], Odd = [pOddα])
        CSV.write("DATA/DFA_STATIONARY_FIT/pvaluesα.csv", pvaluesα)
    end
end

import.Main.ResultsMeanStd
ResultsMeanStd.α()
ResultsMeanStd.β()
# import.Main.pvaluesStructured
# pvaluesStructured.pvaluesAll()
