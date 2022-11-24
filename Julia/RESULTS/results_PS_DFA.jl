module FunctionsReadFit
    using StatsBase, DelimitedFiles, DataFrames, CSV

    function allβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT"
        folders = readdir(main)
        datas = []
        βs = []
        for folder in folders
            datas = readdir(string(main, "/", folder))
            for data in datas
                β = readdlm(string(main,"/", folder, "/",data))
                βs = vcat(βs, β[2])
            end
        end
        return(βs)
    end

    function randomβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Random"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function primeβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Prime"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function evenβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Even"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function oddβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Odd"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function oscilatoryβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Oscilatory"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function pascalβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Pascal"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function linearβ()
        main = "DATA/POWER_SPECTRA_STATIONARY_FIT/PS_FIT_Linear"
        datas = readdir(main)
        βs = []
        for data in datas
            β = readdlm(string(main,"/",data))
            βs = vcat(βs, β[2])
        end
        return(βs)
    end

    function allα()
        main = "DATA/DFA_STATIONARY_FIT"
        folders = readdir(main)
        datas = []
        αs = []
        for folder in folders
            datas = readdir(string(main, "/", folder))
            for data in datas
                α = readdlm(string(main,"/", folder, "/",data))
                αs = vcat(αs, α[2])
            end
        end
        return(αs)
    end

    function randomα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Random"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function primeα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Prime"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function evenα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Even"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function oddα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Odd"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function oscilatoryα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Oscilatory"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function pascalα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Pascal"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end

    function linearα()
        main = "DATA/DFA_STATIONARY_FIT/DFA_FIT_Odd"
        datas = readdir(main)
        αs = []
        for data in datas
            α = readdlm(string(main,"/",data))
            αs = vcat(αs, α[2])
        end
        return(αs)
    end
end

module ResultsMeanStd
    using StatsBase, DelimitedFiles, DataFrames, CSV
    import.Main.FunctionsReadFit

    function α()
        folder = "DATA/Results_alfa"
        mkpath(folder)

        αs = FunctionsReadFit.allα()
        mean_and_stdα = mean_and_std(αs)
        allresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/allresultsα.csv"), allresultsα)

        αs = FunctionsReadFit.randomα()
        mean_and_stdα = mean_and_std(αs)
        randomresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/randomresultsα.csv"), randomresultsα)

        αs = FunctionsReadFit.primeα()
        mean_and_stdα = mean_and_std(αs)
        primeresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/primeresultsα.csv"), primeresultsα)

        αs = FunctionsReadFit.evenα()
        mean_and_stdα = mean_and_std(αs)
        evenresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/evenresultsα.csv"), evenresultsα)

        αs = FunctionsReadFit.oddα()
        mean_and_stdα = mean_and_std(αs)
        oddresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/oddresultsα.csv"), oddresultsα)

        αs = FunctionsReadFit.oscilatoryα()
        mean_and_stdα = mean_and_std(αs)
        oscilatoryresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/oscilatoryresultsα.csv"), oscilatoryresultsα)

        αs = FunctionsReadFit.pascalα()
        mean_and_stdα = mean_and_std(αs)
        pascalresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/pascalresultsα.csv"), pascalresultsα)

        αs = FunctionsReadFit.linearα()
        mean_and_stdα = mean_and_std(αs)
        linearresultsα = DataFrame(meanα = [mean_and_stdα[1]], stdα = [mean_and_stdα[2]], dstdα = stdα = [2*mean_and_stdα[2]])
        CSV.write(string(folder,"/linearresultsα.csv"), linearresultsα)

        resultsα  = DataFrame(type = [], meanα = [], stdα = [], dstdα = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read(string(folder,"/$(tipo)resultsα.csv"), DataFrame)
            push!(resultsα, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write(string(folder,"/resultsα.csv"), resultsα)
    end

    function β()
        folder = "DATA/Results_beta"
        mkpath(folder)

        βs = FunctionsReadFit.allβ()
        mean_and_stdβ = mean_and_std(βs)
        allresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/allresultsβ.csv"), allresultsβ)

        βs = FunctionsReadFit.randomβ()
        mean_and_stdβ = mean_and_std(βs)
        randomresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/randomresultsβ.csv"), randomresultsβ)

        βs = FunctionsReadFit.primeβ()
        mean_and_stdβ = mean_and_std(βs)
        primeresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/primeresultsβ.csv"), primeresultsβ)

        βs = FunctionsReadFit.evenβ()
        mean_and_stdβ = mean_and_std(βs)
        evenresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/evenresultsβ.csv"), evenresultsβ)

        βs = FunctionsReadFit.oddβ()
        mean_and_stdβ = mean_and_std(βs)
        oddresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/oddresultsβ.csv"), oddresultsβ)

        βs = FunctionsReadFit.oscilatoryβ()
        mean_and_stdβ = mean_and_std(βs)
        oscilatoryresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/oscilatoryresultsβ.csv"), oscilatoryresultsβ)

        βs = FunctionsReadFit.pascalβ()
        mean_and_stdβ = mean_and_std(βs)
        pascalresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/pascalresultsβ.csv"), pascalresultsβ)

        βs = FunctionsReadFit.linearβ()
        mean_and_stdβ = mean_and_std(βs)
        linearresultsβ = DataFrame(meanβ = [mean_and_stdβ[1]], stdβ = [mean_and_stdβ[2]], dstdβ = [2*mean_and_stdβ[2]])
        CSV.write(string(folder,"/linearresultsβ.csv"), linearresultsβ)

        resultsβ  = DataFrame(type = [], meanβ = [], stdβ = [], dstdβ = [])
        types = ["all","random", "prime", "even", "odd", "oscilatory", "pascal", "linear"]
        for tipo in types
            results = CSV.read(string(folder,"/$(tipo)resultsβ.csv"), DataFrame)
            push!(resultsβ, (tipo, results[1,1], results[1,2], results[1,3]))
        end
        CSV.write(string(folder,"/resultsβ.csv"), resultsβ)
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

    function pvalueOscilatoryα()
        randomαs = FunctionsReadFit.randomα()
        oscilatoryαs = Float64.(FunctionsReadFit.oscilatoryα())
        p=pvalue(OneSampleTTest(oscilatoryαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvalueOscilatoryβ()
        randomβs = FunctionsReadFit.randomβ()
        oscilatoryβs = Float64.(FunctionsReadFit.oscilatoryβ())
        p=pvalue(OneSampleTTest(oscilatoryβs,mean(randomβs)), tail = :both)
        return(p)
    end

    function pvaluePascalα()
        randomαs = FunctionsReadFit.randomα()
        pascalαs = Float64.(FunctionsReadFit.pascalα())
        p=pvalue(OneSampleTTest(pascalαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvaluePascalβ()
        randomβs = FunctionsReadFit.randomβ()
        pascalβs = Float64.(FunctionsReadFit.pascalβ())
        p=pvalue(OneSampleTTest(pascalβs,mean(randomβs)), tail = :both)
        return(p)
    end

    function pvalueLinearα()
        randomαs = FunctionsReadFit.randomα()
        linearαs = Float64.(FunctionsReadFit.linearα())
        p=pvalue(OneSampleTTest(linearαs,mean(randomαs)), tail = :both)
        return(p)
    end

    function pvalueLinearβ()
        randomβs = FunctionsReadFit.randomβ()
        linearβs = Float64.(FunctionsReadFit.linearβ())
        p=pvalue(OneSampleTTest(linearβs,mean(randomβs)), tail = :both)
        return(p)
    end
    
    function pvaluesAll()
        folderbeta = "DATA/Results_beta"
        folderalfa = "DATA/Results_alfa"

        pPrimeα = pvaluePrimeα()
        pPrimeβ = pvaluePrimeβ()
        pEvenα = pvalueEvenα()
        pEvenβ = pvalueEvenβ()
        pOddα = pvalueOddα()
        pOddβ = pvalueOddβ()
        pOscilatoryα = pvalueOscilatoryα()
        pOscilatoryβ = pvalueOscilatoryβ()
        pPascalα = pvaluePascalα()
        pPascalβ = pvaluePascalβ()
        pLinearα = pvalueLinearα()
        pLinearβ = pvalueLinearβ()

        pvaluesβ  = DataFrame(Prime = [pPrimeβ], Even = [pEvenβ], Odd = [pOddβ], Oscilatory = [pOscilatoryβ], Pascal = [pPascalβ], Linear = [pLinearβ])
        CSV.write(string(folderbeta,"/pvaluesβ.csv"), pvaluesβ)
        pvaluesα  = DataFrame(Prime = [pPrimeα], Even = [pEvenα], Odd = [pOddα], Oscilatory = [pOscilatoryα], Pascal = [pPascalα], Linear = [pLinearα])
        CSV.write(string(folderalfa,"/pvaluesα.csv"), pvaluesα)
    end
end

import.Main.ResultsMeanStd
ResultsMeanStd.α()
ResultsMeanStd.β()
import.Main.pvaluesStructured
pvaluesStructured.pvaluesAll()
