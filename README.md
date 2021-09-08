
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
#> Empirical Psi = 0.1691, Max null Psi = 0.4437, Min null Psi = 0.0258, p-value = 0.62
#> Empirical Phi = 0.0920, Max null Phi = 0.1490, Min null Phi = 0.0359, p-value = 0.62
#> 
#> PCA is not significant!
```

<img src="man/figures/README-example1-1.png" width="100%" />

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
#> Empirical Psi = 5.4655, Max null Psi = 0.4878, Min null Psi = 0.0736, p-value = 0
#> Empirical Phi = 0.5228, Max null Phi = 0.1562, Min null Phi = 0.0607, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.08098, Max null eigenvalue = 1.45248, p-value = 0
#> Empirical eigenvalue #2 = 0.63526, Max null eigenvalue = 1.23669, p-value = 1
#> Empirical eigenvalue #3 = 0.52603, Max null eigenvalue = 1.11611, p-value = 1
#> Empirical eigenvalue #4 = 0.43234, Max null eigenvalue = 0.97139, p-value = 1
#> Empirical eigenvalue #5 = 0.3254, Max null eigenvalue = 0.85561, p-value = 1
#> 
#> PC 1 is significant and accounts for 61.6% (95%-CI:54.3-67.4) of the total variation
#> 
#> Variables 1, 2, 3, 4, and 5 have significant loadings on PC 1
```

<img src="man/figures/README-example2-1.png" width="100%" />

``` r
#PCA analysis of five correlated (r=1) variables
v1<-seq(0,1,0.01)
v5=v4=v3=v2=v1
ex1<-cbind(v1,v2,v3,v4,v5)
result<-PCAtest(ex1, 100, 100, 0.05, varcorr=FALSE, counter=FALSE, plot=TRUE)
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
#> Test of PCA significance: 5 variables, 101 observations
#> 100 bootstrap replicates, 100 random permutations
#> ========================================================
#> 
#> Empirical Psi = 20.0000, Max null Psi = 0.4898, Min null Psi = 0.0449, p-value = 0
#> Empirical Phi = 1.0000, Max null Phi = 0.1565, Min null Phi = 0.0474, p-value = 0
#> 
#> Empirical eigenvalue #1 = 5, Max null eigenvalue = 1.56104, p-value = 0
#> Empirical eigenvalue #2 = 0, Max null eigenvalue = 1.29453, p-value = 1
#> Empirical eigenvalue #3 = 0, Max null eigenvalue = 1.09254, p-value = 1
#> Empirical eigenvalue #4 = 0, Max null eigenvalue = 0.98273, p-value = 1
#> Empirical eigenvalue #5 = 0, Max null eigenvalue = 0.88869, p-value = 1
#> 
#> PC 1 is significant and accounts for 100% (95%-CI:100-100) of the total variation
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
#> Empirical Psi = 10.9186, Max null Psi = 3.0863, Min null Psi = 0.6896, p-value = 0
#> Empirical Phi = 0.5099, Max null Phi = 0.2711, Min null Phi = 0.1281, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.84712, Max null eigenvalue = 2.33334, p-value = 0
#> Empirical eigenvalue #2 = 1.52017, Max null eigenvalue = 1.63958, p-value = 0.14
#> Empirical eigenvalue #3 = 0.70634, Max null eigenvalue = 1.36886, p-value = 1
#> Empirical eigenvalue #4 = 0.41356, Max null eigenvalue = 1.16601, p-value = 1
#> Empirical eigenvalue #5 = 0.34001, Max null eigenvalue = 1.00719, p-value = 1
#> Empirical eigenvalue #6 = 0.14515, Max null eigenvalue = 0.78543, p-value = 1
#> Empirical eigenvalue #7 = 0.02765, Max null eigenvalue = 0.60957, p-value = 1
#> 
#> PC 1 is significant and accounts for 55% (95%-CI:41.4-63.6) of the total variation
#> 
#> Variables 1, 2, 3, 4, 5, and 7 have significant loadings on PC 1
```

<img src="man/figures/README-example4-1.png" width="100%" />

## Testing

[Automated testing with testthat](tests/testthat/testthat.md)
