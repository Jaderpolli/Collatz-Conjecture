using CSV, DelimitedFiles, StatsBase, DataFrames, Distributions, LinearAlgebra, SpecialFunctions

# This code contains the functions for the criptography tests and the function that runs them

# Monobit test

#=

Given a binary vector b, then the frequency test (monobit)
calculates de asimetry between 0's and 1's in the vector
by 

X = (n0 - n1)^2/n

where X is the test value, n0 and n1 are the number of 
zeros and ones in b, and n is the length of b.

=#

function monobit(b)
    n1 = sum(b)
    n0 = length(b)-n1
    X = (n1-n0)^2/length(b)
    return(X)
end

# Series test

function serialtest(b)
    n = length(b)
    n1 = sum(b)
    n0 = n-n1
    n00 = 0
    n01 = 0
    n11 = 0
    n10 = 0
    for j in 1:n-1
        if b[j] == b[j+1]
            if b[j] == 0
                n00 += 1
            else
                n11 += 1
            end
        else
            if b[j] == 0
                n01 += 1
            else
                n10 += 1
            end
        end
    end
    X = 4/(n-1)*(n00^2+n01^2+n10^2+n11^2) - 2/n * (n0^2+n1^2) + 1
    return(X)
end

# Poker Test

function pokertest(b, m::Int64)
    n = length(b)
    r = n % m
    b = b[1:end-r]
    n = length(b)
    k = floor(n/m)
    if k ≥ 5*2^m
        base10 = zeros(Int64(k))
        i = 0
        for l in 1:m:n
            i += 1
            block = b[l:l+m-1]
            for j in 1:length(block)
                base10[i] += 2^(j-1)*block[end-j+1]
            end
        end
        nis = []
        for i in 0:2^m-1
            ni = count(x -> x == Float64(i), base10)
            nis = vcat(nis, ni)
        end
        X = 2^m/k * sum( nis .^2) - k
    else
        println("The length n of the vector must be such that floor(n/m) > 5*2^m")
    end
    return(X)
end

# Run Test

function runstest(b)
    n = length(b)

    diffs = findall(x-> x==1, abs.(diff(b[1:end-1])))

    if b[1] == 0
        gLength = [diffs[1]]
        bLength = [diffs[2]-diffs[1]]
        if length(diffs) % 2 == 0
            for j in 1:round(Int64,(length(diffs))/2)-1
                gLength = vcat(gLength, diffs[2*j+1]-diffs[2*j])
                bLength = vcat(bLength, diffs[2*j+2]-diffs[2*j+1])
            end
        elseif length(diffs) % 2 == 1
            gLength = vcat(gLength, diffs[3]-diffs[2])
            for j in 1:round(Int64,(length(diffs))/2)-2
                bLength = vcat(bLength, diffs[2*j+2]-diffs[2*j+1])
                gLength = vcat(gLength, diffs[2*j+3]-diffs[2*j+2])
            end
        end
    elseif b[1] == 1
        bLength = [diffs[1]]
        gLength = [diffs[2]-diffs[1]]
        if length(diffs) % 2 == 0
            for j in 1:round(Int64,(length(diffs))/2)-1
                bLength = vcat(bLength, diffs[2*j+1]-diffs[2*j])
                gLength = vcat(gLength, diffs[2*j+2]-diffs[2*j+1])
            end
        elseif length(diffs) % 2 == 1
            bLength = vcat(bLength, diffs[3]-diffs[2])
            for j in 1:round(Int64,(length(diffs))/2)-2
                gLength = vcat(gLength, diffs[2*j+2]-diffs[2*j+1])
                bLength = vcat(bLength, diffs[2*j+3]-diffs[2*j+2])
            end
        end
    end

    k = 1
    ek = 10
    while ek > 5.0
        ek = (n - k + 3)/2^(k+2)
        k += 1
    end
    k = Int64(k-1)
    #k =3

    B = zeros(k)
    G = zeros(k)

    df = DataFrame(k = [], ei = [], Bi = [], Gi = [], B = [], G = [])

    for i in 1:k
        ei = (n - i + 3) / (2^(i+2))
        Bi = count(x -> x == i, bLength)
        Gi = count(x -> x == i, gLength)
        B[i] = (Bi - ei)^2/ei
        G[i] = (Gi - ei)^2/ei
        push!(df, [i, ei, Bi, Gi, B, G])
    end
    X = sum(B) + sum(G)
    #p = 1 - ccdf(Chisq(Int64(2k-2)), X)
    return(X, k)
end


 #= ARRUMAR ESSA PARTE DO CÓDIGO PARA SALVAR UM DATAFRAME DO TIPO

      FILENAME | monobit |  serial | poker | run   |
    ------------------------------------------------
    file1.csv  |  x1[1]  |  x2[1]  | x3[1] | x4[1] |
    file2.csv  |  x1[2]  |  x2[2]  | x3[2] | x4[2] |
        .      |    .    |    .    |   .   |   .   |
        .      |    .    |    .    |   .   |   .   |
        .      |    .    |    .    |   .   |   .   |
    file997.csv| x1[997] | x2[997] |x3[997]|x4[997]|

    onde xi[j] representa a medida i da série j.

 =#

function saving_tests()
    files = readdir("RAW_DATA/ORBITS")
    mkpath("DATA/CRIPTOGRAPHY")
    mon = zeros(length(files), 1)
    pok = zeros(length(files), 3)
    run = zeros(length(files), 2)
    j = 0
    n = zeros(length(files))
    n0 = zeros(length(files))
    n1 = zeros(length(files))
    for file in files
        j += 1
        println("Rodando o arquivo $(chop(file,head = 0, tail = 10)). - - - - - Concluído = ", 100*j/length(files), " %")
        x = readdlm("RAW_DATA/ORBITS/$(file)", BigInt)
        x = x .% 2
        
        n[j] = length(x)
        
        n1i = sum(x)
        n0i = n[j]-n1i

        n0[j] = Int64(n0i)
        n1[j] = Int64(n1i)

        monob = monobit(x)
        mon[j,1] = monob[1]

        poker2 = pokertest(x, 2)
        pok[j, 1] = poker2[1]
        
        poker3 = pokertest(x,3)
        pok[j, 2] = poker3[1]
        
        poker4 = pokertest(x,4)
        pok[j, 3] = poker4[1]

        runs = runstest(x)
        run[j,1] = runs[1]
        run[j, 2] = runs[2]

    end
    df = DataFrame(file = files, length = n, n_0 = n0, n_1 = n1, 
                monobit = mon[:,1],                
                pokerm2 = pok[:,1],
                pokerm3 = pok[:,2],
                pokerm4 = pok[:,3],
                runs = run[:,1], krun = run[:,2])
    CSV.write("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", df)
end

saving_tests()