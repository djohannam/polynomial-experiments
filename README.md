# Polynomial Experiments 

This respository is part of my Master Thesis at ETH Zürich: Kadison-Singer Type Questions for Strongly Rayleigh Measures and Ramanujan Graphs.

All our experiments were done using Julia. Our goal was to investigate roots of univariate polynomials, resulting from taking charactersitic polynomials of
random constructions of matrices. In order to investigate if these random polynomials have a special structure called interlacing, we needed to check if the
expectation over these polynomials is real rooted. 

The polynomials we let our operators act on are multivariate. The package MultivariatePolynomials in Julia allows us to work with multivariate polynomials, 
however it does not let us calculate roots. Therefore we needed to write functions to convert an object in MultivariatePolynomials to an object in Polynomials 
for which we can then calculate the roots. We further needed to do some rounding on the coefficients of the final polynomial as due to numerical instability we 
sometimes obtained terms with very small coefficients that are supposed to be zero. The file polyfunctions.jl contains functions solving the described problems.

The experiments are divided in two parts, as the thesis consists of two seperate projects:
1) ramanujan_graphs
2) kadison_singer_for_strongly_rayleigh

both folders contain Jupyter notebooks with polynomial experiments.

### How to install and run the project


