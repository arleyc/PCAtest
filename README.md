
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
# PCA analysis of five uncorrelated (r=0) variables
library(MASS)
mu <- rep(0,5)
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
#> Empirical Psi = 0.1445, Max null Psi = 0.4359, Min null Psi = 0.0499, p-value = 0.73
#> Empirical Phi = 0.0850, Max null Phi = 0.1476, Min null Phi = 0.0499, p-value = 0.73
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
#> Empirical Psi = 0.7999, Max null Psi = 0.4694, Min null Psi = 0.0575, p-value = 0
#> Empirical Phi = 0.2000, Max null Phi = 0.1532, Min null Phi = 0.0536, p-value = 0
#> 
#> Empirical eigenvalue #1 = 1.78342, Max null eigenvalue = 1.51785, p-value = 0
#> Empirical eigenvalue #2 = 0.94318, Max null eigenvalue = 1.27171, p-value = 1
#> Empirical eigenvalue #3 = 0.81888, Max null eigenvalue = 1.09835, p-value = 1
#> Empirical eigenvalue #4 = 0.75285, Max null eigenvalue = 0.9815, p-value = 0.99
#> Empirical eigenvalue #5 = 0.70167, Max null eigenvalue = 0.85862, p-value = 0.72
#> 
#> PC 1 is significant and accounts for 35.7% (95%-CI:30.3-43.6) of the total variation
#> 
#> Variables , and 3 have significant loadings on PC 1
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
#> Empirical Psi = 5.0033, Max null Psi = 0.6097, Min null Psi = 0.0526, p-value = 0
#> Empirical Phi = 0.5002, Max null Phi = 0.1746, Min null Phi = 0.0513, p-value = 0
#> 
#> Empirical eigenvalue #1 = 2.98492, Max null eigenvalue = 1.5516, p-value = 0
#> Empirical eigenvalue #2 = 0.67789, Max null eigenvalue = 1.28816, p-value = 1
#> Empirical eigenvalue #3 = 0.54255, Max null eigenvalue = 1.11634, p-value = 1
#> Empirical eigenvalue #4 = 0.50678, Max null eigenvalue = 0.98476, p-value = 1
#> Empirical eigenvalue #5 = 0.28785, Max null eigenvalue = 0.85856, p-value = 1
#> 
#> PC 1 is significant and accounts for 59.7% (95%-CI:53.2-65.2) of the total variation
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
#> Empirical Psi = 10.9186, Max null Psi = 2.6938, Min null Psi = 0.6441, p-value = 0
#> Empirical Phi = 0.5099, Max null Phi = 0.2533, Min null Phi = 0.1238, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.84712, Max null eigenvalue = 2.13026, p-value = 0
#> Empirical eigenvalue #2 = 1.52017, Max null eigenvalue = 1.72539, p-value = 0.17
#> Empirical eigenvalue #3 = 0.70634, Max null eigenvalue = 1.43578, p-value = 1
#> Empirical eigenvalue #4 = 0.41356, Max null eigenvalue = 1.13288, p-value = 1
#> Empirical eigenvalue #5 = 0.34001, Max null eigenvalue = 0.95056, p-value = 1
#> Empirical eigenvalue #6 = 0.14515, Max null eigenvalue = 0.76715, p-value = 1
#> Empirical eigenvalue #7 = 0.02765, Max null eigenvalue = 0.65331, p-value = 1
#> 
#> PC 1 is significant and accounts for 55% (95%-CI:43.6-64) of the total variation
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
Evolution, 12, 946-957.  

## Citation

Camargo, A. (2022) PCAtest: Testing the statistical significance of
Principal Component Analysis in R. PeerJ 10: e12967. doi:
10.7717/peerj.12967
