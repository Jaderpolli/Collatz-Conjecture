#= This code has the algorithms to write the m-vector representation
of any natural number n in base 10. It also contains the reverse
algorithm that takes a m=vector and transforms it in a base 10
representation
=#

# ALGORITHMS That turn a base 10 into m-vector and vice-versa

module Algorithms
    function algorithm(n::BigInt)
        M = BigInt(n)
        ms = BigInt[]
        while M > 1
            m = BigInt(0)
            p = BigInt(M)
            while p % 2 == 0
                p = div(p,2)
                m = BigInt(m+1)
            end
            ms = vcat(ms, m)
            M = div(M,2^m)-1
        end
        return(ms)
    end

    function rev_algorithm(ms)
        n = BigInt(0)
        for i in 1:length(ms)
            n = BigInt(n)+BigInt(2)^(sum(ms[1:i]))
        end
        return n
    end
end

#=
The objective of the following module is to generate systematic initial conditions
in m-vector representation with prime periodic sequences or randomic
=#

module InitialConditions

    using Primes
    using Random
    using Combinatorics

    # This function has 3 numerical optional args and 1 kwarg.
    # vecsize is the size of the m-vector initial condition;
    # type states if you want to construct a "Random" m-vector or a "Prime" building block
    # blocksize will only be active when type = "Prime" and states the size of the building block of primes
    # maxrand will only be active when type = "Random"
    function initialcondition(vecsize::Int64=100,maxrand::Int64=10, blocksize::Int64=4; type::String)
        if type == "Prime"
            # primes to be drafted
            draft = Int64[]
            for i in 1:blocksize
                draft = vcat(draft,prime(i))
            end # take the first "blocksize" primes
            micro = collect(permutations(draft)) # create an array with all combinatorics of the primes
            n0s = zeros(Int64,length(micro),vecsize+1) # the array where the various initial conditions will be saved
            for i in 1:length(micro)
                n0 = hcat(0,transpose(micro[i])) #the line-array of the i-th building block
                for j in 2:round(Int,vecsize/blocksize)
                    n0 = hcat(n0,transpose(micro[i])) #concatenating the blocks
                end
                n0s[i,:] = n0 #each row is one initial condition
            end
        elseif type == "Random"
            n0s = zeros(Int64, factorial(blocksize), vecsize+1)
            for i in 1:factorial(blocksize)
                n0 = hcat(0,transpose(rand(1:maxrand,vecsize))) #this will create one initial conditions
                n0s[i,:] = n0 #this will construct the matrix with rows forming initial conditions
            end
        else
            println("Input of InitialCondition function should be 'Prime' or 'Random'") #error menssage
        end
        return(n0s)
    end
end

#=

=#

module Saving
    import Main.Algorithms
    import Main.InitialConditions
    using CSV
    using DataFrames
    using DelimitedFiles

    #= to create the initial condition you should think if you want it to be constructed
    randomically or from periodic primes building blocks.
    In order to have an estimation of the size of the initial condition in base 10 you
    should consider the following formulas:

        for type=Prime: log_2(n_0) = vecsize/blocksize sum(primes of building block)

        for type=Random: log_2(n_0) ≈ vecsize[(maxrand+1)/2]

    this might help you to create your own initial conditions if you don't want to use
    the ones from the "RAW_DATA/INITIAL_CONDITIONS/" directory
    =#



    function saving_powers_of_2(vecsize::Int64=100, maxrand::Int64=10, blocksize::Int64=4; type::String)
        # from definition:
        # initialcondition(vecsize::Int=100,maxrand::Int=10, blocksize::Int=4; type::String)
        n0s = InitialConditions.initialcondition(vecsize, maxrand, blocksize; type)

        # this if condition exists to assure that the number of created initial conditions
        # is the same as expected by the factorial of blocksize
        if length(n0s[:,1])==factorial(blocksize)
            if type == "Prime"
                for i in 1:length(n0s[:,1])
                    # Next step is to define a module/code to handle file names, once it will have to be used in every program
                    fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_power_of_2.csv"
                    writedlm(fname, n0s[i,:])
                end
            elseif type == "Random"
                for i in 1:length(n0s[:,1])
                    fname = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_power_of_2.csv"
                    writedlm(fname, n0s[i,:])
                end
            else
                println("Input of InitialCondition function should be 'Prime' or 'Random'") #error menssage
            end
        else
            println("Number of initial conditions does not match with expected")
            #println(n0s)
            println(length(n0s[:,1]))
            println(factorial(blocksize))
        end
    end

    function saving_base10(vecsize::Int64=100, maxrand::Int64=10, blocksize::Int64=4; type::String)
        if type == "Prime"
            for i in 1:factorial(blocksize)
                fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_power_of_2.csv"
                fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_base10.csv"
                m = readdlm(fname_power_of_2,Int64)
                m = Vector(m[:,1])
                n = Algorithms.rev_algorithm(m)
                writedlm(fname_base10, n)
            end
        elseif type == "Random"
            for i in 1:factorial(blocksize)
                fname_power_of_2 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_power_of_2.csv"
                fname_base10 = "RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_base10.csv"
                m = readdlm(fname_power_of_2,Int64)
                m = Vector(m[:,1])
                n = Algorithms.rev_algorithm(m)
                writedlm(fname_base10, n)
            end
        end
    end
end
