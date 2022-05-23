#= Objective: create the modules that creates the .csv
of the orbits of the original collatz map in base10
and powers of 2 for every initial
condition at "RAW_DATA/INITIAL_CONDITIONS/" and store them
at "RAW_DATA/ORBITS3n+1/"
=#

using CSV
using DataFrames
using DelimitedFiles

# this module has the CollatzMap function. It is used the accelerated collatz function
module CollatzMapOriginal
    function collatz(n::BigInt)
        n % 2 == 0 ? n = div(n,2) : n = 3*n+1
        return(n)
    end
end

# this module contains the function that generates the orbit in base 10
module OrbitsBase10
    import Main.CollatzMapOriginal
    using CSV
    using DelimitedFiles
    using DataFrames

    function orbitbase10(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        n₀ = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv",BigInt, header = false)
        iterateVariable = BigInt(n₀[1,1])
        orbit = BigInt[iterateVariable]
        while iterateVariable > 1
            iterateVariable = CollatzMapOriginal.collatz(iterateVariable)
            push!(orbit, iterateVariable)
        end
        return(orbit)
    end

    function orbitbase10(x::BigInt)
        iterateVariable = x
        orbit = BigInt[iterateVariable]
        while iterateVariable > 1
            iterateVariable = CollatzMapOriginal.collatz(iterateVariable)
            push!(orbit, iterateVariable)
        end
        return(orbit)
    end
end

# this module saves the orbit in base 10 into a .csv file
module SavingOrbitsBase10

    import Main.CollatzMapOriginal
    import Main.OrbitsBase10
    using CSV
    using DataFrames
    using DelimitedFiles

    function savingorbitbase10(mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        for i in 1:factorial(primeBlockSize)
            println(i/factorial(primeBlockSize)*100) #time counter
            orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, primeBlockSize; type)
            writedlm("RAW_DATA/ORBITS_3n+1/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv",orbit, header = false)
        end
    end
end

# this module creates the orbit in m-vector representation, returning a big M matrix
# with all the m_i(t) and every m-vector at each time t is a row
module OrbitPowersOf2

    include("initial_condition_modules.jl")
    import Main.AlgorithmsOfmVectors
    using DelimitedFiles

    function orbitpowerof2(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        orbit = readdlm("RAW_DATA/ORBITS_3n+1/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
        # this creates an array with "nothing" but that can receive matrices as elements
        M = Array{Union{Nothing,Matrix{Int64}}}(nothing,length(orbit))
        for j in 1:length(orbit)
            mVector = AlgorithmsOfmVectors.algorithm_m_vector(orbit[j])
            M[j] = transpose(mVector) # the transpose is only to write every m-vector as a line of M
        end
        return(M)
    end
end

# This module contains the function that saves the M matrix and coalesce it, saving it finally as .csv
# and as a square matrix.
module SavingOrbitsPowerOf2

    import Main.OrbitPowersOf2
    using CSV
    using DataFrames
    using DelimitedFiles

    function savingorbitpowerof2(mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        for i in 1:factorial(primeBlockSize)
            println(i/factorial(primeBlockSize)*100)
            M = OrbitPowersOf2.orbitpowerof2(i, mVectorSize, MaxRand, primeBlockSize; type)
            writedlm("RAW_DATA/ORBITS_3n+1/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", M, header = false)
        end
    end
end
