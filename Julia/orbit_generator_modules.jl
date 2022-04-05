#= Objective: create the modules that creates the .csv
of the orbits of the accelerated collatz map in base10
and powers of 2 for every initial
condition at "RAW_DATA/INITIAL_CONDITIONS/" and store them
at "RAW_DATA/ORBITS/"
=#

using CSV
using DataFrames

# These are the variables that define what type of initial condition is being used
type = "Random"
var = readdlm("RAW_DATA/INITIAL_CONDITIONS/variables_n_0_$(type).dat", header = false)
var = Array(var)
vecsize = var[1] #size of the m-vector
maxrand = var[2] #when type = "Random" this is the maximum value possible
blocksize = var[3] # when type = "Prime" this is the number of the first primes taken

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
    import Main.blocksize, Main.type, Main.vecsize, Main.maxrand
    using CSV
    using DelimitedFiles
    using DataFrames

    function orbitbase10(i::Int64; type::String)
        if type == "Prime"
            n0 = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_base10.csv",BigInt, header = false)
        elseif type == "Random"
            n0 = readdlm("RAW_DATA/INITIAL_CONDITIONS/n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_base10.csv",BigInt, header = false)
        end
        num = BigInt(n0[1,1])
        orb = BigInt[num]
        while num > 1
            num = CollatzMap.collatz(num)
            push!(orb, num)
        end
        return(orb)
    end
end

# this module saves the orbit in base 10 into a .csv file
module SavingBase10

    import Main.CollatzMap
    import Main.OrbitsBase10
    import Main.blocksize, Main.type, Main.vecsize, Main.maxrand
    using CSV
    using DataFrames
    using DelimitedFiles

    function savingbase10()
        for i in 1:factorial(blocksize)
            println(i/factorial(blocksize)*100) #time counter
            orb = OrbitsBase10.orbitbase10(i; type)
            if type == "Prime"
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_base10.csv",orb)
            elseif type == "Random"
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_base10.csv",orb)
            end
        end
    end
end

# this module creates the orbit in m-vector representation, returning a big M matrix
# with all the m_i(t) and every m-vector at each time t is a row
module OrbitPowersOf2

    include("initial_condition_modules.jl")
    import Main.Algorithms, Main.vecsize, Main.maxrand, Main.blocksize, Main.type
    using DelimitedFiles

    function orbitpowerof2(i::Int64; type::String)
        if type == "Prime"
            orb = readdlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_base10.csv",BigInt, header = false)
        elseif type == "Random"
            orb = readdlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_base10.csv",BigInt, header = false)
        end
        # this creates an array with "nothing" but that can receive matrices as elements
        M = Array{Union{Nothing,Matrix{Int64}}}(nothing,length(orb))
        for j in 1:length(orb)
            mvec = Algorithms.algorithm(orb[j])
            M[j] = transpose(mvec) # the transpose is only to write every m-vector as a column of M
        end
        return(M)
    end
end

# This module contains the function that saves the M matrix and coalesce it, saving it finally as .csv
# and as a square matrix.
module SavingPowerOf2

    import Main.OrbitPowersOf2
    import Main.blocksize, Main.type, Main.vecsize, Main.maxrand
    using CSV
    using DataFrames
    using DelimitedFiles

    function savingpowerof2()
        for i in 1:factorial(blocksize)
            println(i/factorial(blocksize)*100)
            M = OrbitPowersOf2.orbitpowerof2(i; type)
            if type == "Prime"
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_power_of_2.csv",M)
                Ms = CSV.read("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_power_of_2.csv",DataFrame)
                Ms = coalesce.(Ms, 0)
                Ms = Array(Ms[:,:])
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_blocksize_$(blocksize)_power_of_2.csv",Ms)
            elseif type == "Random"
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_power_of_2.csv",M)
                Ms = CSV.read("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_power_of_2.csv",DataFrame)
                Ms = coalesce.(Ms, 0)
                Ms = Array(Ms[:,:])
                writedlm("RAW_DATA/ORBITS/orb_n_0_$(i)_$(type)_vecsize_$(vecsize)_maxrand_$(maxrand)_power_of_2.csv",Ms)
            end
        end
    end
end
