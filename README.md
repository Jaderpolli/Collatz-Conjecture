# Stochastic-like characteristics in Collatz Map

In this repository, all codes necessary to study the presence of stochastic behavior into the hailstone sequences of the Collatz Map are provided.
These codes were used to obtain the results of the paper "Stochastic-like characteristics of arithmetic dynamical
systems: the Collatz hailstone sequences" with contributin authors Jaderson G. Polli, E. P. Raposo, G. M. Viswanathan and M. G. E. da Luz.

## Description

The repository contains the folder "Julia" containing all codes necessary to obtain the results.
In the next section, the details on how to install and run the codes to obtain the data will be detailed.

## Instalation and Run Guide

All codes are written in Julia Language, then, after cloning this repository and before running the codes, one needs to
properly install the [Current Stable release of Julia](https://julialang.org/downloads/) and the packages listed bellow.
In the process of obtaining the results of the paper, Julia 1.7.2 was used.

The following packages are necessary to properly reproduce all results:

- `Primes`
- `Random`
- `Combinatorics`
- `CSV`
- `DataFrames`
- `DelimitedFiles`
- `CurveFit`
- `StatsBase`
- `FFTW`
- `LsqFit`
- `LinearAlgebra`

Additionally, if one wishes to reproduce the figures, the following packages are also needed:

- `Plots`
- `Colors`
- `ColorSchemes`
- `ColorSchemeTools`
- `LaTeXStrings`

The instalation of the packages, and verifying possible updates, is done together with the running of all codes in the file `run_all.jl` inside the `Julia` folder.

Then, in order to install the necessary packages and run all codes, simple open the Julia terminal on the main directory and run

`include("Julia/run_all.jl")`

This simple command will run all codes, in the following order:

- Generating and saving all initial conditions;
- Iterating and saving all orbits from all initial conditions;
- Transform the orbits into stationary time series;
- Calculate the increments time series from the stationary ones;
- Run the Power Spectrum, DFA, Autocorrelation and von Neumann Entropy calculations;
- Obtain the mean, standard deviation, and p-values for Power Spectrum, DFA and von Neumann Entropy distributions.

### Reproducing Figures

To reproduce the Figures, you must be sure that all needed packages listed above are installed, and then, from a Julia terminal opened in figure code folder, run:

`include(fig1.jl)`
`include(fig2.jl)`
`include(fig3.jl)`
`include(fig4.jl)`
`include(fig5.jl)`
`include(fig6.jl)`
`include(fig7.jl)`
`include(fig8.jl)`
`include(fig9.jl)`
`include(appendix.jl)`

This will create all figures and subfigures in separate .pdf files.
Make sure to run all codes and generate all data before ploting.