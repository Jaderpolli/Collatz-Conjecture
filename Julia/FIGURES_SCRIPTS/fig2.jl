using Plots, Plots.PlotMeasures, DelimitedFiles, ColorSchemes, LaTeXStrings, Colors, ColorSchemeTools
using CSV, StatsPlots, DataFrames, LinearAlgebra, StatsBase, Distributions

function distmonobit(l,a)
    data = CSV.read("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", DataFrame)
    monobit = unique(filter(! <(0.001), data.monobit))
    monobit = unique(filter(! >(3), monobit))
    monobit = vec(monobit)
    hist = fit(Histogram, monobit, minimum(monobit):0.05:maximum(monobit))
    nhist = normalize(hist, mode = :pdf)
    x = range(minimum(monobit), maximum(monobit), length = length(nhist.weights))
    c = Chisq(1)
    plt = scatter(x, nhist.weights, lw = 2, xrange = (minimum(monobit)-0.1, 3), fontfamily = "Palatino", ms = 3,
                lc = :black, frame = :box, markershape = :circle, mc = :tomato4, markerstrokewidth = 0, size = (200/l,300/a),
                    label = "Monobit PDF", fg_legend = :false)
    plt = plot!(c, lw = 1.5, lc = :black, yrange = (-0.1, 4), ls = :dash, label = "Chisq(1)")
    savefig(plt, "FIGURES/fig2/monobit.pdf")
end

function distpokerm2(l,a)
    data = CSV.read("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", DataFrame)
    pokerm2 = unique(filter(! <(0.001), data.pokerm2))
    pokerm2 = unique(filter(! >(20), pokerm2))
    pokerm2 = vec(pokerm2)
    hist = fit(Histogram, pokerm2, minimum(pokerm2):0.25:maximum(pokerm2))
    nhist = normalize(hist, mode = :pdf)
    x = range(minimum(pokerm2), maximum(pokerm2), length = length(nhist.weights))
    c = Chisq(3)
    plt = scatter(x, nhist.weights, lw = 2, xrange = (minimum(pokerm2)-0.1, 15), fontfamily = "Palatino", ms = 2.5,
                lc = :black, frame = :box, markershape = :circle, mc = :firebrick, markerstrokewidth = 0, size = (200/l,150/a),
                    label = "Poker m2 PDF", fg_legend = :false)
    plt = plot!(c, lw = 1.5, lc = :black, yrange = (-0.01, 0.3), ls = :dash, label = "Chisq(3)")
    savefig(plt, "FIGURES/fig2/pokerm2.pdf")
end

function distpokerm3(l,a)
    data = CSV.read("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", DataFrame)
    pokerm3 = unique(filter(! <(0.001), data.pokerm3))
    pokerm3 = unique(filter(! >(25), pokerm3))
    pokerm3 = vec(pokerm3)
    hist = fit(Histogram, pokerm3, minimum(pokerm3):0.5:maximum(pokerm3))
    nhist = normalize(hist, mode = :pdf)
    x = range(minimum(pokerm3), maximum(pokerm3), length = length(nhist.weights))
    c = Chisq(7)
    plt = scatter(x, nhist.weights, lw = 1.5, xrange = (minimum(pokerm3)-0.1, 25), fontfamily = "Palatino", ms = 2.5,
                lc = :black, frame = :box, markershape = :circle, mc = :crimson, markerstrokewidth = 0, size = (200/l,150/a),
                    label = "Poker m3 PDF", fg_legend = :false)
    plt = plot!(c, lw = 1.5, lc = :black, yrange = (-0.01, 0.2), ls = :dash, label = "Chisq(7)")
    savefig(plt, "FIGURES/fig2/pokerm3.pdf")
end

function distpokerm4(l,a)
    data = CSV.read("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", DataFrame)
    pokerm4 = unique(filter(! <(0.001), data.pokerm4))
    pokerm4 = unique(filter(! >(45), pokerm4))
    pokerm4 = vec(pokerm4)
    hist = fit(Histogram, pokerm4, minimum(pokerm4):0.7:maximum(pokerm4))
    nhist = normalize(hist, mode = :pdf)
    x = range(minimum(pokerm4), maximum(pokerm4), length = length(nhist.weights))
    c = Chisq(15)
    plt = scatter(x, nhist.weights, lw = 1.5, xrange = (minimum(pokerm4)-0.1, 45), fontfamily = "Palatino", ms = 2.5,
                lc = :black, frame = :box, markershape = :circle, mc = :tomato2, markerstrokewidth = 0, size = (200/l,150/a),
                    label = "Poker m4 PDF", fg_legend = :false)
    plt = plot!(c, lw = 1.5, lc = :black, yrange = (-0.01, 0.14), ls = :dash, label = "Chisq(15)")
    savefig(plt, "FIGURES/fig2/pokerm4.pdf")
end

function distruns(l,a)
    data = CSV.read("DATA/CRIPTOGRAPHY/pseudo-random-bit-tests.csv", DataFrame)
    datak = groupby(data, :krun)
    datak8 = datak[3]
    runsk8 = unique(filter(! <(0.001), datak8.runs))
    runsk8 = unique(filter(! >(45), runsk8))
    runsk8 = vec(runsk8)
    hist = fit(Histogram, runsk8, minimum(runsk8):0.7:maximum(runsk8))
    nhist = normalize(hist, mode = :pdf)
    x = range(minimum(runsk8), maximum(runsk8), length = length(nhist.weights))
    c = Chisq(14)
    plt = scatter(x, nhist.weights, lw = 1.5, xrange = (minimum(runsk8)-0.1, 45), fontfamily = "Palatino", ms = 2.5,
                lc = :black, frame = :box, markershape = :circle, mc = :salmon2, markerstrokewidth = 0, size = (200/l,150/a),
                    label = "runs k8 PDF", fg_legend = :false)
    plt = plot!(c, lw = 1.5, lc = :black, yrange = (-0.01, 0.14), ls = :dash, label = "Chisq(14)")
    savefig(plt, "FIGURES/fig2/runsk8.pdf")
end


l = 1.4
a = 1.4

mkpath("FIGURES/fig2")
distmonobit(l,a)
distpokerm2(l,a)
distpokerm3(l,a)
distpokerm4(l,a)
distruns(l,a)