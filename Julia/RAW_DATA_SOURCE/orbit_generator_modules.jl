#= Objective: create the modules that creates the .csv
of the orbits of the accelerated collatz map in base10
and powers of 2 for every initial
condition at "RAW_DATA/INITIAL_CONDITIONS/" and store them
at "RAW_DATA/ORBITS/"
=#

using CSV
using DataFrames
using DelimitedFiles
using Primes

#= These are the variables that define what type of initial condition is being used
type = "Prime"
var = readdlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_type_$(type)_MaxRand_$().dat", header = false)
var = Array(var)
mVectorSize = var[1] #size of the m-vector
MaxRand = var[2] #when type = "Random" this is the maximum value possible
BlockSize = var[3] # when type = "Prime" this is the number of the first primes taken =#

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

    function orbitbase10(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4;  type::String)
        n₀ = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",BigInt, header = false)
        iterateVariable = BigInt(n₀[1,1])
        orbit = BigInt[iterateVariable]
        while iterateVariable > 1
            iterateVariable = CollatzMap.collatz(iterateVariable)
            push!(orbit, iterateVariable)
        end
        return(orbit)
    end

    function orbitbase10(x::BigInt)
        iterateVariable = x
        orbit = BigInt[iterateVariable]
        while iterateVariable > 1
            iterateVariable = CollatzMap.collatz(iterateVariable)
            push!(orbit, iterateVariable)
        end
        return(orbit)
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


# this module saves the orbit in base 10 into a .csv file
module SavingOrbitsBase10

    import Main.CollatzMap
    import Main.OrbitsBase10
    using CSV
    using Primes
    using Combinatorics
    using DataFrames
    using DelimitedFiles
    import Main.PascalTriangle

    function savingorbitbase10(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",orbit, header = false)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",orbit, header = false)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",orbit, header = false)
                end
            end
        else
            if type == "Random"
                for i in 1:4
                    #println(i/factorial(BlockSize)*100) #time counter
                    orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",orbit, header = false)
                end
            else
                i = 1
                orbit= OrbitsBase10.orbitbase10(i, mVectorSize, MaxRand, BlockSize; type)
                writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv",orbit, header = false)
            end
        end
    end
end

# this module creates the orbit in m-vector representation, returning a big M matrix
# with all the m_i(t) and every m-vector at each time t is a row
module OrbitPowersOf2

    include("initial_condition_modules.jl")
    import Main.AlgorithmsOfmVectors
    import Main.CollatzMap
    using DelimitedFiles

    function orbitpowerof2(i::Int64, mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
        # this creates an array with "nothing" but that can receive matrices as elements
        M = Array{Union{Nothing,Matrix{Int64}}}(nothing,length(orbit))
        j = 1
        Threads.@threads for orbitVector in orbit
            j += 1
            mVector = AlgorithmsOfmVectors.algorithm_m_vector(orbitVector)
            M[j] = transpose(mVector) # the transpose is only to write every m-vector as a line of M
        end
        return(M)
    end

    function orbitpowerof2(orbit)
        M = Array{Union{Nothing,Matrix{Int64}}}(nothing,length(orbit))
        for j in eachindex(orbit)
            mVector = AlgorithmsOfmVectors.algorithm_m_vector(orbit[j])
            M[j] = transpose(mVector) # the transpose is only to write every m-vector as a line of M
        end
        return(M)
    end

    function fastorbitpowerof2(m, orbit, BlockSize; type)
        Ms = Array{Union{Nothing,Matrix{Int64}}}(nothing,length(orbit))
        Ms[1] = Matrix(m)
        for j in 2:length(orbit)
            println("$(j/length(orbit)*100), BlockSize = $(BlockSize), type = $(type)")
            if m[1] ≥ 1
                m[1] = m[1] - 1
                Ms[j] = Matrix(m)
            end
            if m[1] == 0
                m = transpose(AlgorithmsOfmVectors.algorithm_m_vector(orbit[j]))
                Ms[j] = Matrix(m)
            end
        end
        return(Ms)
    end
end

# This module contains the function that saves the M matrix and coalesce it, saving it finally as .csv
# and as a square matrix.
module SavingOrbitsPowerOf2

    import Main.OrbitPowersOf2
    using CSV
    using DataFrames
    using DelimitedFiles
    using Primes
    using Combinatorics
    import Main.PascalTriangle

    function savingorbitpowerof2(mVectorSize::Int64=100,MaxRand::Int64=10, BlockSize::Int64=4; type::String)
        if mVectorSize ≤ 2000
            if type == "Random" || type == "Prime" || type == "Even" || type == "Odd"
                for i in 1:factorial(BlockSize)
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    m = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    m = transpose(m)
                    M = OrbitPowersOf2.fastorbitpowerof2(m, orbit, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", M, header = false)
                end
            elseif type == "Pascal"
                pascalBlock = transpose(PascalTriangle.pascaltriangle(BlockSize))
                allpascalblocks = unique(collect(permutations(pascalBlock)))
                for i in eachindex(allpascalblocks)
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    m = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    m = transpose(m)
                    M = OrbitPowersOf2.fastorbitpowerof2(m, orbit, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", M, header = false)
                end
            elseif type == "Linear" || type == "Oscilatory"
                for i in 1:2
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    m = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    m = transpose(m)
                    M = OrbitPowersOf2.fastorbitpowerof2(m, orbit, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", M, header = false)
                end
            end
        else
            if type == "Random"
                for i in 1:4
                    orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                    m = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                    m = transpose(m)
                    M = OrbitPowersOf2.fastorbitpowerof2(m, orbit, BlockSize; type)
                    writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", M, header = false)
                end
            else
                i = 1
                orbit = readdlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_base10.csv", BigInt, header = false)
                m = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", header = false)
                m = transpose(m)
                M = OrbitPowersOf2.fastorbitpowerof2(m, orbit, BlockSize; type)
                writedlm("RAW_DATA/ORBITS/orbit_n_0_$(i)_$(type)_mVectorSize_$(mVectorSize)_MaxRand_$(MaxRand)_BlockSize_$(BlockSize)_power_of_2.csv", M, header = false)
            end
        end
    end
end
