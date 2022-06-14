#= This code has the algorithms to write the m-vector representation
of any natural number n in base 10. It also contains the reverse
algorithm that takes a m=vector and transforms it in a base 10
representation
=#

# ALGORITHMS That turn a base 10 into m-vector and vice-versa

module AlgorithmsOfmVectors
    function algorithm_m_vector(base10number::BigInt)
        temporaryVariable = BigInt(base10number)
        mVector = Int64[]
        while temporaryVariable > 1
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

#=
The objective of the following module is to generate systematic initial conditions
in m-vector representation with prime periodic sequences or randomic
=#

module InitialConditionsGenerator
    using Primes
    using Random
    using Combinatorics

    # This function has 3 numerical optional args and 1 kwarg.
    # mVectorSize is the size of the m-vector initial condition;
    # type states if you want to construct a "Random" m-vector or a "Prime" building block
    # primeBlockSize will only be active when type = "Prime" and states the size of the building block of primes
    # MaxRand will only be active when type = "Random"
    function initialcondition(mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        if type == "Prime"
            primeblock = Int64[]
            for i in 1:primeBlockSize
                primeblock = vcat(primeblock,prime(i))
            end
            allprimeblocks = collect(permutations(primeblock))
            setOfn₀ = zeros(Int64, length(allprimeblocks), mVectorSize+1)
            for i in 1:length(allprimeblocks)
                n₀ = hcat(0,transpose(allprimeblocks[i])) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/primeBlockSize)
                    n₀ = hcat(n₀,transpose(allprimeblocks[i])) #concatenating the blocks
                end
                setOfn₀[i,:] = n₀ #each line is one initial condition
            end
        elseif type == "Random"
            setOfn₀ = zeros(Int64, factorial(primeBlockSize), mVectorSize+1)
            for i in 1:factorial(primeBlockSize)
                n₀ = hcat(0,transpose(rand(1:MaxRand,mVectorSize))) #this will create one initial conditions
                setOfn₀[i,:] = n₀ #this will construct the matrix with rows forming initial conditions
            end
        elseif type == "Even"
            evenblock = Int64[]
            for i in 1:primeBlockSize
                evenblock = vcat(evenblock, 2*i)
            end
            allevenblocks = collect(permutations(evenblock))
            setOfn₀ = zeros(Int64, length(allevenblocks), mVectorSize+1)
            for i in 1:length(allevenblocks)
                n₀ = hcat(0,transpose(allevenblocks[i])) #the line-array of the i-th building block
                for j in 2:round(Int64,mVectorSize/primeBlockSize)
                    n₀ = hcat(n₀,transpose(allevenblocks[i])) #concatenating the blocks
                end
                setOfn₀[i,:] = n₀ #each line is one initial condition
            end
        elseif type == "Odd"
            oddblock = Int64[]
            for i in 1:primeBlockSize
                oddblock = vcat(oddblock, 2*i-1)
            end
            alloddblocks = collect(permutations(oddblock))
            setOfn₀ = zeros(Int64, length(alloddblocks), mVectorSize+1)
            for i in 1:length(alloddblocks)
                n₀ = hcat(0,transpose(alloddblocks[i])) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/primeBlockSize)
                    n₀ = hcat(n₀,transpose(alloddblocks[i])) #concatenating the blocks
                end
                setOfn₀[i,:] = n₀ #each line is one initial condition
            end
        elseif type == "Adjacent"
            adjacentblock = Int64[]
            for i in 1:primeBlockSize
                adjacentblock = vcat(adjacentblock, i)
            end
            alladjacentblocks = collect(permutations(adjacentblock))
            setOfn₀ = zeros(Int64, length(alladjacentblocks), mVectorSize+1)
            for i in 1:length(alladjacentblocks)
                n₀ = hcat(0,transpose(alladjacentblocks[i])) #the line-array of the i-th building block
                for j in 2:round(Int,mVectorSize/primeBlockSize)
                    n₀ = hcat(n₀,transpose(alladjacentblocks[i])) #concatenating the blocks
                end
                setOfn₀[i,:] = n₀ #each line is one initial condition
            end
        else
            println("Input of InitialCondition function should be a type 'Random', 'Prime', 'Even', 'Odd' or 'Adjacent'") #error menssage
        end
        return(setOfn₀)
    end
end

#=

=#

module SavingInitialConditions
    import Main.AlgorithmsOfmVectors
    import Main.InitialConditionsGenerator
    using CSV
    using DataFrames
    using DelimitedFiles

    #= to create the initial condition you should think if you want it to be constructed
    randomically or from periodic primes building blocks.
    In order to have an estimation of the size of the initial condition in base 10 you
    should consider the following formulas:

        for type=Prime: log_2(n_0) = mVectorSize/primeBlockSize sum(primes of building block)

        for type=Random: log_2(n_0) ≈ mVectorSize[(MaxRand+1)/2]

    this might help you to create your own initial conditions if you don't want to use
    the ones from the "RAW_DATA/INITIAL_CONDITIONS/" directory
    =#



    function saving_powers_of_2(mVectorSize::Int64=100, MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        # from definition:
        # initialcondition(mVectorSize::Int=100,MaxRand::Int=10, primeBlockSize::Int=4; type::String)
        setOfn₀ = InitialConditionsGenerator.initialcondition(mVectorSize, MaxRand, primeBlockSize; type)

        # this if condition exists to assure that the number of created initial conditions
        # is the same as expected by the factorial of primeBlockSize
        if length(setOfn₀[:,1])==factorial(primeBlockSize)
            for i in 1:length(setOfn₀[:,1])
                fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv"
                writedlm(fname, setOfn₀[i,:])
            end
        else
            println("Number of initial conditions does not match with expected")
            #println(setOfn₀)
            println(length(setOfn₀[:,1]))
            println(factorial(primeBlockSize))
        end
    end

    function saving_base10(mVectorSize::Int64=100, MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        for i in 1:factorial(primeBlockSize)
            fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv"
            fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv"
            mVector = readdlm(fname_power_of_2,Int64)
            mVector = Vector(mVector[:,1])
            base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
            writedlm(fname_base10, base10number)
        end
    end
end

#= While investigating different initial conditions, the hypothesis that conditions
whose initial m-vector is composed by 2 or 3 primes periodically give rise to deviations
in the autocorrelation function

The module bellow should create various larger initial conditions with 2 or 3 primes
repeated.
=#

module PrimeSpecialInitialConditions
    using Primes
    using Random
    using Combinatorics
    using DelimitedFiles
    import Main.AlgorithmsOfmVectors

    function primespecialinitialcondition(primeOrder::Int64=5, mVectorSize::Int64=180, primeBlockSize::Int64=2)
        primeblock = Int64[]
        for i in 1:primeOrder
            primeblock = vcat(primeblock, prime(i))
        end
        allprimeblocks = collect(combinations(primeblock,primeBlockSize))
        setOfn₀ = zeros(Int64, length(allprimeblocks), mVectorSize+1)
        for i in 1:length(allprimeblocks)
            n₀ = hcat(0,transpose(allprimeblocks[i])) #the line-array of the i-th building block
            for j in 2:round(Int,mVectorSize/primeBlockSize)
                n₀ = hcat(n₀,transpose(allprimeblocks[i])) #concatenating the blocks
            end
            setOfn₀[i,:] = n₀ #each line is one initial condition
        end
        return(setOfn₀)
    end

    #=
    Next we define a new function to save the special power of 2 initial conditions
    =#

    function saving_powers_of_2(primeOrder::Int64=5, mVectorSize::Int64=180, primeBlockSize::Int64=2; type::String)
        # from definition:
        # initialcondition(mVectorSize::Int=100,MaxRand::Int=10, primeBlockSize::Int=4; type::String)
        setOfn₀ = primespecialinitialcondition(primeOrder, mVectorSize, primeBlockSize)

        # this if condition exists to assure that the number of created initial conditions
        # is the same as expected by the factorial of primeBlockSize
        for i in 1:length(setOfn₀[:,1])
            fname = "RAW_DATA/SPECIAL_INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize)_power_of_2.csv"
            writedlm(fname, setOfn₀[i,:])
        end
    end

    function saving_base10(primeOrder::Int64=5, mVectorSize::Int64=180, primeBlockSize::Int64=2; type::String)
        primeblock = Int64[]
        for i in 1:primeOrder
            primeblock = vcat(primeblock, prime(i))
        end
        L = length(collect(combinations(primeblock,primeBlockSize)))
        for i in 1:L
            fname_power_of_2 = "RAW_DATA/SPECIAL_INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize)_power_of_2.csv"
            fname_base10 = "RAW_DATA/SPECIAL_INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_primeBlockSize_$(primeBlockSize)_base10.csv"
            mVector = readdlm(fname_power_of_2,Int64)
            mVector = Vector(mVector[:,1])
            base10number = AlgorithmsOfmVectors.rev_algorithm_m_vector(mVector)
            writedlm(fname_base10, base10number)
        end
    end
end
