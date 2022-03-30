#= This code has the algorithms to
write the m-vector representation
of any natural number n in base 10.
It also contains the reverse
algorithm that takes a m=vector
and transforms it in a base 10
representation

Next step is make it write a file
with the result in the RAW_DATA/
directory =#

# ALGORITHMS

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

# READ m-vector and return base 10 number

module Saving

    import Main.Algorithms
    using CSV
    using DataFrames
    using DelimitedFiles

    function rev_save()
        m = CSV.read("RAW_DATA/INITIAL_CONDITIONS/n_0_2_power_of_2.csv", DataFrame)
        m = Vector(m[:,1])
        n = Algorithms.rev_algorithm(m)
        writedlm("RAW_DATA/INITIAL_CONDITIONS/n_0_2_base10.csv", n)
    end

    rev_save()
end

import Main.Saving
