
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PCAtest

<!-- badges: start -->
<!-- badges: end -->

The goal of PCAtest is to evaluate the overall significance of a PCA, of
each PC axis, and of the contributions of each observed variable to the
significant axes based on permutation-based statistical tests. PCAtest
uses random permutations to build null distributions for several
statistics of a PCAanalysis: Psi (Vieira 2012),Phi (Gleason and Staelin
1975), the rank-of-roots (ter Braak 1988), the index of the loadings
(Vieira 2012), and the correlations of the PC with the variables
(Jackson 1991). Comparing these distributions with the observed values
of the statistics, the function tests: (1) the hypothesis that there is
more correlational structure among the observed variables than expected
by random chance, (2) the statistical significance of each PC, and (3)
the contribution of each observed variable to each significant PC. The
function also calculates the sampling variance around mean observed
statistics based on bootstrap replicates.

## Installation

You can install the released and the development versions from
\[GitHub\] (<https://github.com/>) with:

``` r
# install.packages("devtools")
devtools::install_github("arleyc/PCAtest")
```

## Examples

``` r
library(PCAtest)
# PCA analysis of five uncorrelated variables
data("ex0")
result<-PCAtest(ex0, 100, 100, 0.05, varcorr=FALSE, counter=FALSE, plot=TRUE)
#> 
#> Sampling bootstrap replicates... Please wait
#> 
#> Calculating confidence intervals of empirical statistics... Please wait
#> 
#> Sampling random permutations... Please wait
#> 
#> Comparing empirical statistics with their null distributions... Please wait
#> 
#> ========================================================
#> Test of PCA significance: 5 variables, 100 observations
#> 100 bootstrap replicates, 100 random permutations
#> ========================================================
#> 
#> Empirical Psi = 0.1691, Max null Psi = 0.4296, Min null Psi = 0.0324, p-value = 0.59
#> Empirical Phi = 0.0920, Max null Phi = 0.1466, Min null Phi = 0.0403, p-value = 0.59
#> 
#> PCA is not significant!
```

<img src="man/figures/README-example1-1.png" width="100%" />

``` r
#PCA analysis of five correlated (r=0.25) variables
data("ex025")
result<-PCAtest(ex025, 100, 100, 0.05, varcorr=FALSE, counter=FALSE, plot=TRUE)
#> 
#> Sampling bootstrap replicates... Please wait
#> 
#> Calculating confidence intervals of empirical statistics... Please wait
#> 
#> Sampling random permutations... Please wait
#> 
#> Comparing empirical statistics with their null distributions... Please wait
#> 
#> ========================================================
#> Test of PCA significance: 5 variables, 100 observations
#> 100 bootstrap replicates, 100 random permutations
#> ========================================================
#> 
#> Empirical Psi = 1.1327, Max null Psi = 0.5166, Min null Psi = 0.0680, p-value = 0
#> Empirical Phi = 0.2380, Max null Phi = 0.1607, Min null Phi = 0.0583, p-value = 0
#> 
#> Empirical eigenvalue #1 = 1.88693, Max null eigenvalue = 1.57397, p-value = 0
#> Empirical eigenvalue #2 = 1.01454, Max null eigenvalue = 1.22064, p-value = 0.99
#> Empirical eigenvalue #3 = 0.8287, Max null eigenvalue = 1.13383, p-value = 1
#> Empirical eigenvalue #4 = 0.79299, Max null eigenvalue = 0.98174, p-value = 0.94
#> Empirical eigenvalue #5 = 0.47684, Max null eigenvalue = 0.85547, p-value = 1
#> 
#> PC 1 is significant and accounts for 37.7% (95%-CI:33.1-44.1) of the total variation
#> 
#> Variables 2, and 3 have significant loadings on PC 1
```

<img src="man/figures/README-example2-1.png" width="100%" />

``` r
#PCA analysis of five correlated (r=0.5) variables
data("ex05")
result<-PCAtest(ex05, 100, 100, 0.05, varcorr=FALSE, counter=FALSE, plot=TRUE)
#> 
#> Sampling bootstrap replicates... Please wait
#> 
#> Calculating confidence intervals of empirical statistics... Please wait
#> 
#> Sampling random permutations... Please wait
#> 
#> Comparing empirical statistics with their null distributions... Please wait
#> 
#> ========================================================
#> Test of PCA significance: 5 variables, 100 observations
#> 100 bootstrap replicates, 100 random permutations
#> ========================================================
#> 
#> Empirical Psi = 5.4655, Max null Psi = 0.4920, Min null Psi = 0.0634, p-value = 0
#> Empirical Phi = 0.5228, Max null Phi = 0.1568, Min null Phi = 0.0563, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.08098, Max null eigenvalue = 1.55877, p-value = 0
#> Empirical eigenvalue #2 = 0.63526, Max null eigenvalue = 1.23933, p-value = 1
#> Empirical eigenvalue #3 = 0.52603, Max null eigenvalue = 1.12528, p-value = 1
#> Empirical eigenvalue #4 = 0.43234, Max null eigenvalue = 0.97784, p-value = 1
#> Empirical eigenvalue #5 = 0.3254, Max null eigenvalue = 0.84725, p-value = 1
#> 
#> PC 1 is significant and accounts for 61.6% (95%-CI:54.3-68.3) of the total variation
#> 
#> Variables 1, 2, 3, 4, and 5 have significant loadings on PC 1
```

<img src="man/figures/README-example3-1.png" width="100%" />

``` r
#PCA analysis of seven morphological variables from 29 ant species (from
# Wong and Carmona 2021,  https://doi.org/10.1111/2041-210X.13568)
data("ants")
result<-PCAtest(ants, 100, 100, 0.05, varcorr=FALSE, counter=FALSE, plot=TRUE)
#> 
#> Sampling bootstrap replicates... Please wait
#> 
#> Calculating confidence intervals of empirical statistics... Please wait
#> 
#> Sampling random permutations... Please wait
#> 
#> Comparing empirical statistics with their null distributions... Please wait
#> 
#> ========================================================
#> Test of PCA significance: 7 variables, 29 observations
#> 100 bootstrap replicates, 100 random permutations
#> ========================================================
#> 
#> Empirical Psi = 10.9186, Max null Psi = 2.6890, Min null Psi = 0.4898, p-value = 0
#> Empirical Phi = 0.5099, Max null Phi = 0.2530, Min null Phi = 0.1080, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.84712, Max null eigenvalue = 2.21709, p-value = 0
#> Empirical eigenvalue #2 = 1.52017, Max null eigenvalue = 1.88288, p-value = 0.15
#> Empirical eigenvalue #3 = 0.70634, Max null eigenvalue = 1.39173, p-value = 1
#> Empirical eigenvalue #4 = 0.41356, Max null eigenvalue = 1.15168, p-value = 1
#> Empirical eigenvalue #5 = 0.34001, Max null eigenvalue = 1.00704, p-value = 1
#> Empirical eigenvalue #6 = 0.14515, Max null eigenvalue = 0.7973, p-value = 1
#> Empirical eigenvalue #7 = 0.02765, Max null eigenvalue = 0.5966, p-value = 1
#> 
#> PC 1 is significant and accounts for 55% (95%-CI:43.8-64.4) of the total variation
#> 
#> Variables 1, 2, 3, 4, 5, and 7 have significant loadings on PC 1
```

<img src="man/figures/README-example4-1.png" width="100%" />

## Testing

[Unit testing with testthat
(https://testthat.r-lib.org/)](tests/testthat/testthat.md)

## References

Gleason, T. C. and Staelin R. (1975) A proposal for handling missing
data. Psychometrika, 40, 229–252.  
Jackson, J. E. (1991) A User’s Guide to Principal Components. John Wiley
& Sons, New York, USA.  
ter Braak, C. F. J. (1990) Update notes: CANOCO (version 3.1).
Agricultural Mattematic Group, Report LWA-88-02, Wagningen,
Netherlands.  
Vieira, V. M. N. C. S. (2012) Permutation tests to estimate
significances on Principal Components Analysis. Computational Ecology
and Software, 2, 103–123.  
Wong, M. K. L. and Carmona, C. P. (2021) Including intraspecific trait
variability to avoid distortion of functional diversity and ecological
inference: Lessons from natural assemblages. Methods in Ecology and
Evolution. .
