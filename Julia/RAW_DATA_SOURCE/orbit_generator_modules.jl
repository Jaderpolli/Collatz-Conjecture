#= Objective: create the modules that creates the .csv
of the orbits of the accelerated collatz map in base10
and powers of 2 for every initial
condition at "RAW_DATA/INITIAL_CONDITIONS/" and store them
at "RAW_DATA/ORBITS/"
=#

using CSV
using DataFrames
using DelimitedFiles

#= These are the variables that define what type of initial condition is being used
type = "Prime"
var = readdlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_type_$(type)_MaxRand_$().dat", header = false)
var = Array(var)
mVectorSize = var[1] #size of the m-vector
MaxRand = var[2] #when type = "Random" this is the maximum value possible
primeBlockSize = var[3] # when type = "Prime" this is the number of the first primes taken =#

# this module has the CollatzMap function. It is used the accelerated collatz function
module CollatzMap
    function collatz(n::BigInt)
         n % 2 == 0 ? n = div(n,2) : n = div((3n+1),2) # if
         return(n)
     end
end

# this module contains the function that generates the orbit in base 10
module OrbitsBase10
    import Main.CollatzMap
    using CSV
    using DelimitedFiles
    using DataFrames

    function orbitbase10(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4;  type::String)
        n₀ = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv",BigInt, header = false)
        iterateVariable = BigInt(n₀[1,1])
        orbit = BigInt[iterateVariable]
        while iterateVariable > 1
            iterateVariable = CollatzMap.collatz(iterateVariable)
            push!(orbit, iterateVariable)
        end
        return(orbit)
    end
end

# this module saves the orbit in base 10 into a .csv file
module SavingOrbitsBase10

    import Main.CollatzMap
    import Main.OrbitsBase10
    using CSV
    using DataFrames
    using DelimitedFiles

    function savingorbitbase10(mVectorSize::Int64=100,MaxRand::Int64=10, primeBlockSize::Int64=4; type::String)
        for i in 1:factorial(primeBlockSize)
            println(i/factorial(primeBlockSize)*100) #time counter
            orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, primeBlockSize; type)
            writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv",orbit, header = false)
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
        orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_base10.csv", BigInt, header = false)
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
            writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", M, header = false)
            #=M = CSV.read("RAW_DATA/ORBITS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv", DataFrame, header = 1)
            rm("RAW_DATA/ORBITS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.csv")
            M = coalesce.(M, 0)
            M = Array(M[:,:])
            writedlm("RAW_DATA/ORBITS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_primeBlockSize_$(primeBlockSize)_power_of_2.dat", M)=#
        end
    end
end
