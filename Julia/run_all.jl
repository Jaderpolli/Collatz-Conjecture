# These first lines are intent to install the packages needed.
# If they are already installed, running it will update to they
# newest version.

import Pkg
Pkg.add("Primes")
Pkg.add("Random")
Pkg.add("Combinatorics")
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("DelimitedFiles")
Pkg.add("CurveFit")
Pkg.add("StatsBase")
Pkg.add("FFTW")
Pkg.add("LsqFit")
Pkg.add("LinearAlgebra")

# The lines bellow run all codes necessary to reproduce the results:

include("RAW_DATA_SOURCE/initial_condition_run.jl")
include("RAW_DATA_SOURCE/orbit_generator_run.jl")
include("DATA_PROCESSING/stationary_orbits_run.jl")
include("DATA_PROCESSING/increments_run.jl")
include("DATA_PROCESSING/step_stationary_orbit_run.jl")
include("DATA_ANALYSIS/DFA/dfa_run.jl")
include("DATA_ANALYSIS/POWER_SPECTRA/power_spectra_run.jl")
include("DATA_ANALYSIS/CORRELATIONS/autocorrelation_run.jl")
include("DATA_ANALYSIS/VON_NEUMANN_ENTROPY/von_neumann_entropy_run.jl")
include("RESULTS/results_PS_DFA.jl")
include("RESULTS/results_VN_ENTROPY.jl")

# If you intent to reproduce the figures, these packages also must 
# be installed

Pkg.add("Plots")
Pkg.add("Colors")
Pkg.add("ColorSchemes")
Pkg.add("ColorSchemeTools")
Pkg.add("LaTeXStrings")