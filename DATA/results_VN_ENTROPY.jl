module FunctionsReadEntropy
    using StatsBase, DelimitedFiles, DataFrames, CSV

    function allS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        types = ["Random", "Prime", "Even", "Odd", "Pascal Triangle", "Oscilatory", "Linear"]
        Ss = []
        for mVectorSize in mVectorSizes
            i = 0
            for type in types
                i += 1
                if type == "Linear"
                    mVectorSize = 180
                    BlockSizes = [30, 60, 180]
                    for BlockSize in BlockSizes
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_Linear_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                else
                    for j in 2:maximumBlockSize
                        BlockSize = j
                        if mVectorSize ≤ 360
                            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                                for i in 1:factorial(BlockSize)
                                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    maxS = maximum(S[:,2])
                                    Ss = vcat(Ss, maxS)
                                end
                            elseif type == "Pascal Triangle" || type == "Oscilatory"
                                i = 1
                                S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                maxS = maximum(S[:,2])
                                Ss = vcat(Ss, maxS)
                            end
                        else
                            if type == "Random"
                                for i in 1:4
                                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                    maxS = maximum(S[:,2])
                                    Ss = vcat(Ss, maxS)
                                end
                            elseif BlockSize == 5 && type == "Even"
                                continue
                            else
                                i = 1
                                S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                                maxS = maximum(S[:,2])
                                Ss = vcat(Ss, maxS)
                            end
                        end
                    end
                end
            end
        end
        return(Ss)
    end

    function randomS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Random"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                else
                    for i in 1:4
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                end
            end
        end
        return(Ss)
    end

    function primeS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Prime"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                else
                    i = 1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                end
            end
        end
        return(Ss)
    end

    function evenS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Even"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if BlockSize == 5
                    continue
                elseif mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                else
                    i = 1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                end
            end
        end
        return(Ss)
    end

    function oddS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Odd"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    for i in 1:factorial(BlockSize)
                        S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                        maxS = maximum(S[:,2])
                        Ss = vcat(Ss, maxS)
                    end
                else
                    i = 1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                end
            end
        end
        return(Ss)
    end

    function oscilatoryS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Oscilatory"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i=1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                else
                    i = 1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                end
            end
        end
        return(Ss)
    end

    function pascalS()
        mVectorSizes = [180, 2100]
        MaxRand = 10
        maximumBlockSize =  5
        type = "Pascal Triangle"
        Ss = []
        for mVectorSize in mVectorSizes
            for j in 2:maximumBlockSize
                BlockSize = j
                if mVectorSize ≤ 360
                    i=1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                else
                    i = 1
                    S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                    maxS = maximum(S[:,2])
                    Ss = vcat(Ss, maxS)
                end
            end
        end
        return(Ss)
    end

    function linearS()
        MaxRand = 10
        maximumBlockSize =  5
        type = "Linear"
        Ss = []
        for j in 2:maximumBlockSize
            mVectorSize = 180
            BlockSizes = [30, 60, 180]
            for BlockSize in BlockSizes
                S = readdlm("DATA/VON_NEUMANN_ENTROPY/vn_entropy_n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", header = false)
                maxS = maximum(S[:,2])
                Ss = vcat(Ss, maxS)
            end
        end
        return(Ss)
    end

end

module ResultsMeanStd
    using StatsBase, DelimitedFiles, DataFrames, CSV
    import.Main.FunctionsReadEntropy

    function Entropy()
        Ss = FunctionsReadEntropy.allS()
        mean_and_stdS = mean_and_std(Ss)
        allresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/allresultsS.csv", allresultsS)

        Ss = FunctionsReadEntropy.randomS()
        mean_and_stdS = mean_and_std(Ss)
        randomresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/randomresultsS.csv", randomresultsS)

        Ss = FunctionsReadEntropy.primeS()
        mean_and_stdS = mean_and_std(Ss)
        primeresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/primeresultsS.csv", primeresultsS)

        Ss = FunctionsReadEntropy.evenS()
        mean_and_stdS = mean_and_std(Ss)
        evenresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/evenresultsS.csv", evenresultsS)

        Ss = FunctionsReadEntropy.oddS()
        mean_and_stdS = mean_and_std(Ss)
        oddresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/oddresultsS.csv", oddresultsS)

        Ss = FunctionsReadEntropy.oscilatoryS()
        mean_and_stdS = mean_and_std(Ss)
        oscilatoryresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/oscilatoryresultsS.csv", oscilatoryresultsS)

        Ss = FunctionsReadEntropy.pascalS()
        mean_and_stdS = mean_and_std(Ss)
        pascalresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/pascalresultsS.csv", pascalresultsS)

        Ss = FunctionsReadEntropy.linearS()
        mean_and_stdS = mean_and_std(Ss)
        linearresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/linearresultsS.csv", linearresultsS)

        resultsS  = DataFrame(type = [], meanS = [], stdS = [], dstdS = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read("DATA/VON_NEUMANN_ENTROPY/$(tipo)resultsS.csv", DataFrame)
            push!(resultsS, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write("DATA/VON_NEUMANN_ENTROPY/resultsS.csv", resultsS)

    end
end

module pvaluesStructured
    using StatsBase, DelimitedFiles, DataFrames, CSV, HypothesisTests
    import.Main.FunctionsReadEntropy

    function pvaluePrimeS()
        randomSs = FunctionsReadEntropy.randomS()
        primeSs = Float64.(FunctionsReadEntropy.primeS())
        p=pvalue(OneSampleTTest(primeSs,mean(randomSs)), tail = :both)
        return(p)
    end

    function pvalueEvenS()
        randomSs = FunctionsReadEntropy.randomS()
        evenSs = Float64.(FunctionsReadEntropy.evenS())
        p=pvalue(OneSampleTTest(evenSs,mean(randomSs)), tail = :both)
        return(p)
    end

    function pvalueOddS()
        randomSs = FunctionsReadEntropy.randomS()
        oddSs = Float64.(FunctionsReadEntropy.oddS())
        p=pvalue(OneSampleTTest(oddSs,mean(randomSs)), tail = :both)
        return(p)
    end

    function pvaluesAll()
        pPrimeS = pvaluePrimeS()
        pEvenS = pvalueEvenS()
        pOddS = pvalueOddS()

        pvaluesS  = DataFrame(Prime = [pPrimeS], Even = [pEvenS], Odd = [pOddS])
        CSV.write("DATA/VON_NEUMANN_ENTROPY/pvaluesS.csv", pvaluesS)
    end
end

# import.Main.ResultsMeanStd
# ResultsMeanStd.Entropy()
import.Main.pvaluesStructured
pvaluesStructured.pvaluesAll()
