module PascalTriangle
    function pascaltriangle(n)

    row=Any[]

    #base case
    if n==1

        return Any[1]

    elseif n==2

        return Any[1,1]

    else

        #calculate the elements in each row
        for i in 2:n-1

            #rolling sum all the values within 2 windows from the previous row
            #but we cannot include two boundary numbers 1 in this row
            push!(row,pascaltriangle(n-1)[i-1]+pascaltriangle(n-1)[i])

        end

        #append 1 for both front and rear of the row
        pushfirst!(row,1)
        push!(row,1)

    end

    return row

    end
end

module VNEntropy
    using DelimitedFiles
    using StatsBase
    using LinearAlgebra
    using Combinatorics
    import Main.PascalTriangle

    function corrmatrix(mSample)
        n = length(mSample[:,1])
        N = length(mSample[1,:])
        R = zeros(N,N)
        for j in 1:N
            for i in 1:N
                Xᵢ = mSample[:,i] .- mean(mSample[:,i])
                Xⱼ = mSample[:,j] .- mean(mSample[:,j])
                XiXj = sum(Xᵢ .* Xⱼ)/n
                σᵢ = sqrt(mean(Xᵢ .* Xᵢ))
                σⱼ = sqrt(mean(Xⱼ .* Xⱼ))
                R[i,j] = XiXj/(σᵢ*σⱼ)
            end
        end
        return(R)
    end

    function vnentropy(R)
        N = length(R[:,1])
        ρ = R ./ N
        λ = eigvals(ρ)
        S = 0.0
        for i in 1:N
           S = S - λ[i]*log(λ[i])
        end
        return(S/log(N))
    end
end #VNEntropy module

module VNEntropyEvaluation
    import Main.VNEntropy
    using DelimitedFiles
    using StatsBase
    using LinearAlgebra
    using Combinatorics
    import Main.PascalTriangle

    function variatingTimeSeries(m, L, mVectorSize::Int64=100, BlockSize::Int64=4; type::String, i)
        T = length(m[:,1])
        ts = round(Int64, 5*T/10):round(Int64, 5*T/100):T
        VnS = reshape([],0,2)
        for j in ts
            mSample = m[1:j,:]
            println("$(j/T*100) %, mVectorSize = $(mVectorSize), BlockSize = $(BlockSize), type $(type), i = $(i)")
            S = VNEntropy.vnentropy(VNEntropy.corrmatrix(mSample))
            data = [j/T S]
            VnS = vcat(VnS, data)
        end
        return(VnS)
    end

    function savingVariatingTimeSeries(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4;  type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    L = 100
                    m = m[:,1:L]
                    m = Int64.(replace(m, "" => -1))
                    data = variatingTimeSeries(m, L, mVectorSize, BlockSize; type, i)
                    writedlm("DATA/VON_NEUMANN_ENTROPY/VN_$(type)/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", data, header = false)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    L = 100
                    m = m[:,1:L]
                    m = Int64.(replace(m, "" => -1))
                    data = variatingTimeSeries(m, L, mVectorSize, BlockSize; type, i)
                    writedlm("DATA/VON_NEUMANN_ENTROPY/VN_$(type)/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", data, header = false)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    L = 100
                    m = m[:,1:L]
                    m = Int64.(replace(m, "" => -1))
                    data = variatingTimeSeries(m, L, mVectorSize, BlockSize; type, i)
                    writedlm("DATA/VON_NEUMANN_ENTROPY/VN_$(type)/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", data, header = false)
                end
            end
        else
            if type == "Random"
                for i in 1:4
                    m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    L = 100
                    m = m[:,1:L]
                    m = Int64.(replace(m, "" => -1))
                    data = variatingTimeSeries(m, L, mVectorSize, BlockSize; type, i)
                    writedlm("DATA/VON_NEUMANN_ENTROPY/VN_$(type)/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", data, header = false)
                end
            else
                i = 1
                m = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                L = 100
                m = m[:,1:L]
                m = Int64.(replace(m, "" => -1))
                data = variatingTimeSeries(m, L, mVectorSize, BlockSize; type, i)
                writedlm("DATA/VON_NEUMANN_ENTROPY/VN_$(type)/vn_entropy_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize).csv", data, header = false)
            end
        end
    end
end
