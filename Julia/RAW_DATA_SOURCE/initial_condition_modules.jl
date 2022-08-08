#= This code has the algorithms to write the m-vector representation
of any natural number n in base 10. It also contains the reverse
algorithm that takes a m=vector and transforms it in a base 10
representation. Also the modules to generate the initial conditions and save them
=#

module AlgorithmsOfmVectors
    function algorithm_m_vector(base10number::BigInt)
        temporaryVariable = BigInt(base10number)
        mVector = Int64[]
        while temporaryVariable ≥ 1
            mᵢ = 0
            divisibleTemporaryVariable = BigInt(temporaryVariable)
            while divisibleTemporaryVariable % 2 == 0
                divisibleTemporaryVariable = div(divisibleTemporaryVariable,2)
                mᵢ = BigInt(mᵢ+1)
            end
            mVector = vcat(mVector, mᵢ)
            temporaryVariable = div(temporaryVariable,2^mᵢ)-1
        end
        return(mVector)
    end

    function algorithm_m1(base10number::BigInt)
        number = BigInt(base10number)
        m1 = 0
        while number % 2 == 0
                number = div(number,2)
                m1 += 1
        end
        return(m1)
    end

    function rev_algorithm_m_vector(mVector)
        base10number = BigInt(0)
        for i in 1:length(mVector)
            base10number = BigInt(base10number)+BigInt(2)^(sum(mVector[1:i]))
        end
        return(base10number)
    end
end

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

module InitialConditionsGenerator
    using Primes
    using Random
    using Combinatorics
    import Main.PascalTriangle

    # This function has 3 numerical optional args and 1 kwarg.
    # mVectorSize is the size of the m-vector initial condition;
    # type states if you want to construct a "Random", "Prime", "Even" or "Odd" building block of m-vector
    # BlockSize will only be active when type is not "Random" and states the size of the building block
    # MaxRand will only be active when type = "Random"
    function initialcondition(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Prime"
                primeblock = Int64[]
                for i in 1:BlockSize
                    primeblock = vcat(primeblock,prime(i))
                end
                allprimeblocks = collect(permutations(primeblock))
                setOfn₀ = zeros(Int64, length(allprimeblocks), mVectorSize+1)
                for i in 1:length(allprimeblocks)
                    n₀ = hcat(0,transpose(allprimeblocks[i])) #the line-array of the i-th building block
                    for j in 2:round(Int,mVectorSize/BlockSize)
                        n₀ = hcat(n₀,transpose(allprimeblocks[i])) #concatenating the blocks
                    end
                    setOfn₀[i,:] = n₀ #each line is one initial condition
                end
            elseif type == "Random"
                setOfn₀ = zeros(Int64, factorial(BlockSize), mVectorSize+1)
                for i in 1:factorial(BlockSize)
                    n₀ = hcat(0,transpose(rand(1:MaxRand,mVectorSize))) #this will create one initial conditions
                    setOfn₀[i,:] = n₀ #this will construct the matrix with rows forming initial conditions
                end
            elseif type == "Even"
                evenblock = Int64[]
                for i in 1:BlockSize
                    evenblock = vcat(evenblock, 2*i)
                end
                allevenblocks = collect(permutations(evenblock))
                setOfn₀ = zeros(Int64, length(allevenblocks), mVectorSize+1)
                for i in 1:length(allevenblocks)
                    n₀ = hcat(0,transpose(allevenblocks[i])) #the line-array of the i-th building block
                    for j in 2:round(Int64,mVectorSize/BlockSize)
                        n₀ = hcat(n₀,transpose(allevenblocks[i])) #concatenating the blocks
                    end
                    setOfn₀[i,:] = n₀ #each line is one initial condition
                end
            elseif type == "Odd"
                oddblock = Int64[]
                for i in 1:BlockSize
                    oddblock = vcat(oddblock, 2*i-1)
                end
                alloddblocks = collect(permutations(oddblock))
                setOfn₀ = zeros(Int64, length(alloddblocks), mVectorSize+1)
                for i in 1:length(alloddblocks)
                    n₀ = hcat(0,transpose(alloddblocks[i])) #the line-array of the i-th building block
                    for j in 2:round(Int,mVectorSize/BlockSize)
                        n₀ = hcat(n₀,transpose(alloddblocks[i])) #concatenating the blocks
                    end
                    setOfn₀[i,:] = n₀ #each line is one initial condition
                end
            elseif type == "Pascal Triangle"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                n₀ = hcat(0, pascalBlock)
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀, pascalBlock)
                end
                setOfn₀ = n₀
            elseif type == "Oscilatory"
                if BlockSize == 2
                    oscilatoryBlock = [1 2]
                else
                    oscilatoryBlock = hcat(transpose(Array(range(1,BlockSize))),transpose(Array(reverse(range(2, BlockSize-1)))))
                end
                n₀ = hcat(0,oscilatoryBlock)
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀, oscilatoryBlock)
                end
                setOfn₀ = n₀
            elseif type == "Linear"
                if BlockSize == mVectorSize
                    setOfn₀ = transpose(Array(range(0,mVectorSize)))
                else
                    linearBlock = transpose(Array(range(1,BlockSize)))
                    n₀ = hcat(0, linearBlock)
                    for j in 2:round(Int, mVectorSize/BlockSize)
                        n₀ = hcat(n₀, linearBlock)
                    end
                    setOfn₀ = n₀
                end
            else
                println("Input of InitialCondition function should be a type 'Random', 'Prime', 'Even', or 'Odd'") #error menssage
            end
        else
            if type == "Prime"
                primeBlock = Int64[]
                for i in 1:BlockSize
                    primeBlock = vcat(primeBlock,prime(i))
                end
                n₀ = hcat(0, transpose(primeBlock)) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀,transpose(primeBlock)) #concatenating the blocks
                end
                setOfn₀ = n₀
            elseif type == "Random"
                setOfn₀ = zeros(Int64, 4, mVectorSize+1)
                for i in 1:4
                    n₀ = hcat(0,transpose(rand(1:MaxRand,mVectorSize))) #this will create one initial conditions
                    setOfn₀[i, :] = n₀ #this will construct the matrix with rows forming initial conditions
                end
            elseif type == "Even"
                evenBlock = Int64[]
                for i in 1:BlockSize
                    evenBlock = vcat(evenBlock, 2*i)
                end
                n₀ = hcat(0, transpose(evenBlock)) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀,transpose(evenBlock)) #concatenating the blocks
                end
                setOfn₀ = n₀
            elseif type == "Odd"
                oddBlock = Int64[]
                for i in 1:BlockSize
                    oddBlock = vcat(oddBlock, 2*i-1)
                end
                n₀ = hcat(0, transpose(oddBlock)) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀,transpose(oddBlock)) #concatenating the blocks
                end
                setOfn₀ = n₀
            elseif type == "Pascal Triangle"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                n₀ = hcat(0, pascalBlock)
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀, pascalBlock)
                end
                setOfn₀ = n₀
            elseif type == "Oscilatory"
                if BlockSize == 2
                    oscilatoryBlock = [1 2]
                else
                    oscilatoryBlock = hcat(transpose(Array(range(1,BlockSize))),transpose(Array(reverse(range(2, BlockSize-1)))))
                end
                n₀ = hcat(0,oscilatoryBlock)
                for j in 2:round(Int,mVectorSize/BlockSize)
                    n₀ = hcat(n₀, oscilatoryBlock)
                end
                setOfn₀ = n₀
            else
                println("Input of InitialCondition function should be a type 'Random', 'Prime', 'Even', or 'Odd'") #error menssage
            end
        end
        return(setOfn₀)
    end
end

module SavingInitialConditions
    import Main.AlgorithmsOfmVectors
    import Main.InitialConditionsGenerator
    using CSV
    using DataFrames
    using DelimitedFiles

    #= to create the initial condition you should think if you want it to be constructed
    randomically or from structured periodic building blocks.
    In order to have an estimation of the size of the initial condition in base 10 you
    should consider the following formulas:

        for type=Prime, Even, Odd: log_2(n_0) = mVectorSize/BlockSize sum(elements of building block)

        for type=Random: log_2(n_0) ≈ mVectorSize[(MaxRand+1)/2]

    this might help you to create your own initial conditions if you don't want to use
    the ones from the "RAW_DATA/INITIAL_CONDITIONS/" directory
    =#

    function saving_powers_of_2(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        # from definition:
        # initialcondition(mVectorSize::Int=100,MaxRand::Int=10, BlockSize::Int=4; type::String)
        setOfn₀ = InitialConditionsGenerator.initialcondition(mVectorSize, MaxRand, BlockSize; type)

        # this if condition exists to assure that the number of created initial conditions
        # is the same as expected by the factorial of BlockSize
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:length(setOfn₀[:,1])
                    fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                    writedlm(fname, setOfn₀[i,:])
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                writedlm(fname, setOfn₀)
            end
        else
            if type == "Random"
                for i in 1:4
                    fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                    writedlm(fname, setOfn₀[i,:])
                end
            else
                fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                writedlm(fname, setOfn₀)
            end
        end
    end

    function saving_base10(mVectorSize::Int64=100, MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 360
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                    fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv"
                    mVector = readdlm(fname_power_of_2,Int64)
                    mVector = Vector(mVector[:,1])
                    base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
                    writedlm(fname_base10, base10number)
                end
            elseif type == "Pascal Triangle" || type == "Oscilatory" || type == "Linear"
                fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv"
                mVector = readdlm(fname_power_of_2,Int64)
                mVector = Vector(mVector[1,:])
                base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
                writedlm(fname_base10, base10number)
            end
        else
            if type == "Random"
                for i in 1:4
                    fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                    fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv"
                    mVector = readdlm(fname_power_of_2,Int64)
                    mVector = Vector(mVector[:,1])
                    base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
                    writedlm(fname_base10, base10number)
                end
            else
                fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv"
                fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_1_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv"
                mVector = readdlm(fname_power_of_2,Int64)
                mVector = Vector(mVector[1,:])
                base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
                writedlm(fname_base10, base10number)
            end
        end
    end
end
