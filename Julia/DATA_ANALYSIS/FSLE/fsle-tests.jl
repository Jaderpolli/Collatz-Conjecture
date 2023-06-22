using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames, LinearAlgebra, StatsBase, Distributions, Measurements

include("../../RAW_DATA_SOURCE/initial_condition_modules.jl")
include("../../RAW_DATA_SOURCE/orbit_generator_modules.jl")

import Main.AlgorithmsOfmVectors
import Main.OrbitsBase10
import Main.CollatzMap

# Function for testing the coalescence of given n0

function coalescence_test(n0::BigInt)
    x = n0
    y = x+1
    colx = OrbitsBase10.orbitbase10(x)
    coly = OrbitsBase10.orbitbase10(y)
    m = minimum([length(colx), length(coly)])
    d = abs.((colx[1:m]) .- (coly[1:m]))
    if sum(iszero.(d)) > 0
        return(0)
    else
        return(1)
    end
end

# function for calculating the finite size lyapunov expoent (FSLE) of a given n0

function fsle3(n0::BigInt)
    x = n0
    y = x+1
    colx = OrbitsBase10.orbitbase10(x)
    coly = OrbitsBase10.orbitbase10(y)
    m = minimum([length(colx), length(coly)])
    d = abs.((colx[1:m]) .- (coly[1:m]))
    if sum(iszero.(d)) > 0
        nothing
    else
        δ₀ = d[1]
        t = 0
        τ = []
        δt = []
        for j in 2:length(d)
            if d[j] ≥ 2*δ₀
                t += 1
                push!(τ, t)
                push!(δt, log(d[j]/δ₀))
                δ₀ = d[j]
                t = 0
            elseif d[j] ≤ δ₀/2
                t += 1
                push!(τ, t)
                push!(δt, log(d[j]/δ₀))
                δ₀ = d[j]
                t = 0
            else
                t += 1
            end
        end
        return(δt, τ)
    end
end

# function that implements the fsle for all n0 in 2^4 < n0 < 2^17

function nco_lyap()
    ks = []
    n0s = []
    for p in 4:16
        k= 0
        #p = 15
        println("coalescent orbits, p = ", p)
        for j in 2^p:2^(p+1)
            n0 = BigInt(j)
            res = coalescence_test(n0)
            if res == 0
                nothing
            elseif res == 1
                x0 = n0
                push!(n0s, x0)
                k += 1
            end
        end
        push!(ks, k/(2^(p+1)-2^p))
    end

    n0s = filter(!iszero, n0s)

    writedlm("DATA/FSLE/n0s.csv", n0s)

    println("calculando lyapunov")

    λs = reshape([], 0, 2)
    for j in n0s
        #println(j/n0s[end], " calculando lyapunov n0 = ", j)
        println(j)
        n0 = BigInt(j)
        res = fsle3(n0)
        τ = res[2]
        δt = res[1]
        λ = mean(δt) ./ mean(τ)
        λs = vcat(λs, [n0 λ])
    end
    writedlm("DATA/FSLE/lyapunovs-2-4-to-2-17.csv", λs)
end

nco_lyap()

# function that count the number of coalescent orbits between 2^4 < n0 < 2^17 for all n0 in this range

function count_coalesce()
    ks = []
    for p in 4:17
        m = 11
        println("coalescent orbits, p = ", p)
        k = 0
        for j in 2^p:2^(p+1)
            n0 = BigInt(j)
            res = coalescence_test(n0)
            if res == 0
                nothing
            elseif res == 1
                k += 1
            end
        end
        push!(ks, k/(2^(p+1)-2^p))
    end
    writedlm("DATA/FSLE/percentual-of-non-coalescent-orbits-2-4-to-2-18.csv", ks)
end

count_coalesce()

# function that count the number of coalescent orbits between 2^18 < n0 < 2^1000 by creating ensembles of 
# 2^15 randomly selected n0 in each range 2^k < n0 < 2^(k+1)

function large_count_coalesce()
    ks = []
    for p in 18:1000
        m = 11
        println("coalescent orbits, p = ", p)
        n0i = rand(2^BigInt(p):2^BigInt(p+1), 2^m)
        k = 0
        for j in n0i
            n0 = BigInt(j)
            res = coalescence_test(n0)
            if res == 0
                nothing
            elseif res == 1
                k += 1
            end
        end
        push!(ks, k/(2^(p+1)-2^p))
    end
    writedlm("DATA/FSLE/percentual-of-non-coalescent-orbits-2-18-to-2-1000.csv", ks)
end

large_count_coalesce()

# function that implements the fsle for all n0 in 2^18 < n0 < 2^1000 for an ensemble of 2^11 n0 in each magnitude 2^k<n0<2^(k+1)

function nco_lyap_hc()
    ks = []
    k= 0
    p = 11
    maxt = 1000
    for t in 1000:maxt
        n0s = []
        n0i = rand(2^BigInt(t):2^BigInt(t+1), 2^p)
        println("coalescent orbits, t = ", t)
        for j in n0i
            n0 = BigInt(j)
            res = coalescence_test(n0)
            if res == 0
                nothing
            elseif res == 1
                n0s = vcat(n0s, n0)
                k += 1
            end
        end
        n0s = filter(!iszero, n0s)
        push!(ks, length(n0s)/2^p)
        if t == maxt
            writedlm("DATA/FSLE/n0s-2-$(maxt).csv", n0s)
        end
    end

    n0s = readdlm("DATA/FSLE/n0s-2-$(maxt).csv", BigInt)

    println("calculando lyapunov")

    λs = reshape([], 0, 2)
    for j in n0s
        #println(j/n0s[end], " calculando lyapunov n0 = ", j)
        n0 = BigInt(j)
        res = fsle3(n0)
        τ = res[2]
        δt = res[1]
        λ = mean(δt) ./ mean(τ)
        λs = vcat(λs, [n0 λ])
    end
    writedlm("DATA/FSLE/lyapunovs_2-$(maxt).csv", λs)
end

nco_lyap_hc()
