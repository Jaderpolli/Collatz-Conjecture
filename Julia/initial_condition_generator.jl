#=
The objective of this code is to generate systematic initial conditions
in m-vector representation with prime periodic sequences
=#

module Primes_m
    using Primes
    using Random
    # primes to be drafted
    draft = primes(1,11)
    micro = zeros(Int64,(120,5))
    for j in 1:factorial(5)
        micro[j,:] = shuffle(draft)
    end
    micro = unique(micro[:,:],dims=1)
    println(micro)
    println(size(micro[:,:]))
end
