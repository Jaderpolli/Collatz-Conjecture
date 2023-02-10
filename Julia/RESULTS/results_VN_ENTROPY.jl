module FunctionsReadEntropy
    using StatsBase, DelimitedFiles, DataFrames, CSV

    function allS()
        main = "DATA/VON_NEUMANN_ENTROPY"
        folders = readdir(main)
        datas = []
        Ss = []
        for folder in folders
            datas = readdir(string(main, "/", folder))
            for data in datas
                S = readdlm(string(main,"/", folder, "/",data))
                maxS = maximum(S[:,2])
                Ss = vcat(Ss, maxS)
            end
        end
        return(Ss)
    end

    function randomS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Random"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function primeS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Prime"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function evenS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Even"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function oddS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Odd"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function oscilatoryS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Oscilatory"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function pascalS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Pascal"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end

    function linearS()
        main = "DATA/VON_NEUMANN_ENTROPY/VN_Linear"
        datas = readdir(main)
        Ss = []
        for data in datas
            S = readdlm(string(main,"/",data))
            maxS = maximum(S[:,2])
            Ss = vcat(Ss, maxS)
        end
        return(Ss)
    end
end

module ResultsMeanStd
    using StatsBase, DelimitedFiles, DataFrames, CSV
    import.Main.FunctionsReadEntropy

    function S()
        folder = "DATA/VN_Results"
        mkpath(folder)

        Ss = FunctionsReadEntropy.allS()
        mean_and_stdS = mean_and_std(Ss)
        allresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/allresultsS.csv"), allresultsS)

        Ss = FunctionsReadEntropy.randomS()
        mean_and_stdS = mean_and_std(Ss)
        randomresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/randomresultsS.csv"), randomresultsS)

        Ss = FunctionsReadEntropy.primeS()
        mean_and_stdS = mean_and_std(Ss)
        primeresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/primeresultsS.csv"), primeresultsS)

        Ss = FunctionsReadEntropy.evenS()
        mean_and_stdS = mean_and_std(Ss)
        evenresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/evenresultsS.csv"), evenresultsS)

        Ss = FunctionsReadEntropy.oddS()
        mean_and_stdS = mean_and_std(Ss)
        oddresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/oddresultsS.csv"), oddresultsS)

        Ss = FunctionsReadEntropy.oscilatoryS()
        mean_and_stdS = mean_and_std(Ss)
        oscilatoryresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/oscilatoryresultsS.csv"), oscilatoryresultsS)

        Ss = FunctionsReadEntropy.pascalS()
        mean_and_stdS = mean_and_std(Ss)
        pascalresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/pascalresultsS.csv"), pascalresultsS)

        Ss = FunctionsReadEntropy.linearS()
        mean_and_stdS = mean_and_std(Ss)
        linearresultsS = DataFrame(meanS = [mean_and_stdS[1]], stdS = [mean_and_stdS[2]], dstdS = stdS = [2*mean_and_stdS[2]])
        CSV.write(string(folder,"/linearresultsS.csv"), linearresultsS)

        resultsS  = DataFrame(type = [], meanS = [], stdS = [], dstdS = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read(string(folder,"/$(tipo)resultsS.csv"), DataFrame)
            push!(resultsS, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write(string(folder,"/resultsS.csv"), resultsS)
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

    function pvalueOscilatoryS()
        randomSs = FunctionsReadEntropy.randomS()
        oscilatorySs = Float64.(FunctionsReadEntropy.oscilatoryS())
        p=pvalue(OneSampleTTest(oscilatorySs,mean(randomSs)), tail = :both)
        return(p)
    end

    function pvaluePascalS()
        randomSs = FunctionsReadEntropy.randomS()
        pascalSs = Float64.(FunctionsReadEntropy.pascalS())
        p=pvalue(OneSampleTTest(pascalSs,mean(randomSs)), tail = :both)
        return(p)
    end

        function pvalueLinearS()
        randomSs = FunctionsReadEntropy.randomS()
        linearSs = Float64.(FunctionsReadEntropy.linearS())
        p=pvalue(OneSampleTTest(linearSs,mean(randomSs)), tail = :both)
        return(p)
    end

    function pvaluesAll()
        pPrimeS = pvaluePrimeS()
        pEvenS = pvalueEvenS()
        pOddS = pvalueOddS()
        pOscilatoryS = pvalueOscilatoryS()
        pPascalS = pvaluePascalS()
        pLinearS = pvalueLinearS()

        pvaluesS  = DataFrame(Prime = [pPrimeS], Even = [pEvenS], Odd = [pOddS], Oscilatory = [pOscilatoryS], Pascal = [pPascalS], Linear = [pLinearS])
        CSV.write("DATA/VN_Results/pvaluesS.csv", pvaluesS)
    end
end

module t_S
    using StatsBase, DelimitedFiles, DataFrames, CSV
    
    function t_S_T()
        folderR = "DATA/VN_Results"
        mkpath(folderR)
        main = "DATA/VON_NEUMANN_ENTROPY"
        folders = readdir(main)
        for folder in folders
            datas = readdir(string(main, "/", folder))
            tS = []
            for data in datas
                S = readdlm(string(main,"/", folder, "/",data))
                maxS = maximum(S[:,2])
                t_S = findall(isequal(maxS), S[:,2])
                t_S = S[t_S[1],1]
                println(t_S)
                tS = vcat(tS, t_S)
            end
            mean_and_stdtS = mean_and_std(tS)
            resultstS = DataFrame(meantS = [mean_and_stdtS[1]], stdtS = [mean_and_stdtS[2]], dstdS = [2*mean_and_stdtS[2]])
            CSV.write(string(folderR,"/$(folder)_results_tS.csv"), resultstS)
        end
    end
end

import.Main.ResultsMeanStd
ResultsMeanStd.S()
import.Main.pvaluesStructured
pvaluesStructured.pvaluesAll()

import.Main.t_S
t_S.t_S_T()


