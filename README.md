# Polynomial Experiments 

This respository is part of my Master Thesis at ETH Zürich: Kadison-Singer Type Questions for Strongly Rayleigh Measures and Ramanujan Graphs.

All our experiments were done using Julia. Our goal was to investigate roots of univariate polynomials, resulting from taking charactersitic polynomials of
random constructions of matrices. In order to investigate if these random polynomials have a special structure called interlacing, we needed to check if the
expectation over these polynomials is real rooted. 

The polynomials we let our operators act on are multivariate. The package `MultivariatePolynomials` in Julia allows us to work with multivariate polynomials, 
however it does not let us calculate roots. Therefore we needed to write functions to convert an object in `MultivariatePolynomials` to an object in `Polynomials` 
for which we can then calculate the roots. We further needed to do some rounding on the coefficients of the final polynomial as due to numerical instability we 
sometimes obtained terms with very small coefficients that are supposed to be zero. The file [polyfunctions.jl](https://github.com/djohannam/polynomial-experiments/blob/main/polyfunctions.jl) contains functions solving the described problems.

The experiments are divided in two parts, as the thesis consists of two seperate projects:
1) [ramanujan_graphs](https://github.com/djohannam/polynomial-experiments/tree/main/ramanujan_graphs)
2) [kadison_singer_for_strongly_rayleigh](https://github.com/djohannam/polynomial-experiments/tree/main/kadison_singer_for_strongly_rayleigh)

both folders contain Jupyter notebooks with polynomial experiments.

## Getting started
### 1. Download and install Julia
If Julia is not already installed, [download Julia](https://julialang.org/downloads/)  for your operating system and install it by following the instructions.

### 2. Julia and Jupyter communication
Next the communication between Julia and Jupyter has to be established.
To do this, open a terminal window and start the Julia REPL by running:
```
julia
```
Inside the Julia REPL, next add Julia to Jupiter Notebooks by installing the Julia Kernel. To do this, run:
```julia
using Pkg
Pkg.add("IJulia")
```

### 3. Install project dependencies
The project needs several third-party packages. To install all dependencies, run:
```julia
using Pkg
Pkg.add([
    "Graphs",
    "Combinatorics",
    "LinearAlgebra",
    "MultivariatePolynomials",
    "Permutations",
    "Polynomials",
    "TypedPolynomials"])
```
