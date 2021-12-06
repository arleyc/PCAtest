
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
library(MASS)
mu <- c(0,0,0,0,0)
Sigma <- matrix(c(rep(c(1,0,0,0,0,0),4),1),5)
ex0 <- mvrnorm(100, mu = mu, Sigma = Sigma )
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
#> Empirical Psi = 0.2299, Max null Psi = 0.5100, Min null Psi = 0.0372, p-value = 0.4
#> Empirical Phi = 0.1072, Max null Phi = 0.1597, Min null Phi = 0.0431, p-value = 0.4
#> 
#> PCA is not significant!
```

<img src="man/figures/README-example1-1.png" width="100%" />

``` r
#PCA analysis of five correlated (r=0.25) variables
Sigma <- matrix(c(rep(c(1,0.25,0.25,0.25,0.25,0.25),4),1),5)
ex025 <- mvrnorm(100, mu = mu, Sigma = Sigma )
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
#> Empirical Psi = 2.3413, Max null Psi = 0.4924, Min null Psi = 0.0589, p-value = 0
#> Empirical Phi = 0.3421, Max null Phi = 0.1569, Min null Phi = 0.0543, p-value = 0
#> 
#> Empirical eigenvalue #1 = 2.36135, Max null eigenvalue = 1.57297, p-value = 0
#> Empirical eigenvalue #2 = 0.75291, Max null eigenvalue = 1.23965, p-value = 1
#> Empirical eigenvalue #3 = 0.71891, Max null eigenvalue = 1.10155, p-value = 1
#> Empirical eigenvalue #4 = 0.60379, Max null eigenvalue = 0.98527, p-value = 1
#> Empirical eigenvalue #5 = 0.56303, Max null eigenvalue = 0.85324, p-value = 0.99
#> 
#> PC 1 is significant and accounts for 47.2% (95%-CI:39.6-56) of the total variation
#> 
#> Variables 1, 2, 3, 4, and 5 have significant loadings on PC 1
```

<img src="man/figures/README-example2-1.png" width="100%" />

``` r
#PCA analysis of five correlated (r=0.5) variables
Sigma <- matrix(c(rep(c(1,0.5,0.5,0.5,0.5,0.5),4),1),5)
ex05 <- mvrnorm(100, mu = mu, Sigma = Sigma )
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
#> Empirical Psi = 4.5082, Max null Psi = 0.4986, Min null Psi = 0.0690, p-value = 0
#> Empirical Phi = 0.4748, Max null Phi = 0.1579, Min null Phi = 0.0587, p-value = 0
#> 
#> Empirical eigenvalue #1 = 2.87877, Max null eigenvalue = 1.54201, p-value = 0
#> Empirical eigenvalue #2 = 0.78154, Max null eigenvalue = 1.27045, p-value = 1
#> Empirical eigenvalue #3 = 0.52172, Max null eigenvalue = 1.07366, p-value = 1
#> Empirical eigenvalue #4 = 0.4498, Max null eigenvalue = 0.99073, p-value = 1
#> Empirical eigenvalue #5 = 0.36817, Max null eigenvalue = 0.84305, p-value = 1
#> 
#> PC 1 is significant and accounts for 57.6% (95%-CI:51.8-63.3) of the total variation
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
#> Empirical Psi = 10.9186, Max null Psi = 2.7272, Min null Psi = 0.5626, p-value = 0
#> Empirical Phi = 0.5099, Max null Phi = 0.2548, Min null Phi = 0.1157, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.84712, Max null eigenvalue = 2.32691, p-value = 0
#> Empirical eigenvalue #2 = 1.52017, Max null eigenvalue = 1.64493, p-value = 0.17
#> Empirical eigenvalue #3 = 0.70634, Max null eigenvalue = 1.36716, p-value = 1
#> Empirical eigenvalue #4 = 0.41356, Max null eigenvalue = 1.10597, p-value = 1
#> Empirical eigenvalue #5 = 0.34001, Max null eigenvalue = 0.90719, p-value = 1
#> Empirical eigenvalue #6 = 0.14515, Max null eigenvalue = 0.80389, p-value = 1
#> Empirical eigenvalue #7 = 0.02765, Max null eigenvalue = 0.60203, p-value = 1
#> 
#> PC 1 is significant and accounts for 55% (95%-CI:40-66.9) of the total variation
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
