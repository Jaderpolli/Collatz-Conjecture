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

function algoritmo(n)
    M = n
    ms = []
    while M > 1
        m = 0
        p = M
        while p % 2 == 0
            p = p/2
            m = m+1
        end
        push!(ms, m)
        M = M/2^m-1
    end
    return(ms)
end

function rev_algoritmo(ms)
    n = BigInt(0)
    for i in 1:length(ms)
        n = BigInt(n)+BigInt(2)^(sum(ms[1:i]))
    end
    return n
end
