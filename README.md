
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
#> Empirical Psi = 0.0688, Max null Psi = 0.4391, Min null Psi = 0.0393, p-value = 0.96
#> Empirical Phi = 0.0587, Max null Phi = 0.1482, Min null Phi = 0.0443, p-value = 0.96
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
#> Empirical Psi = 1.6125, Max null Psi = 0.5319, Min null Psi = 0.0540, p-value = 0
#> Empirical Phi = 0.2839, Max null Phi = 0.1631, Min null Phi = 0.0520, p-value = 0
#> 
#> Empirical eigenvalue #1 = 2.10089, Max null eigenvalue = 1.50657, p-value = 0
#> Empirical eigenvalue #2 = 0.92377, Max null eigenvalue = 1.30606, p-value = 1
#> Empirical eigenvalue #3 = 0.77332, Max null eigenvalue = 1.0849, p-value = 1
#> Empirical eigenvalue #4 = 0.71281, Max null eigenvalue = 0.97661, p-value = 1
#> Empirical eigenvalue #5 = 0.48921, Max null eigenvalue = 0.87261, p-value = 1
#> 
#> PC 1 is significant and accounts for 42% (95%-CI:36.4-50.3) of the total variation
#> 
#> Variables 1, 2, 4, and 5 have significant loadings on PC 1
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
#> Empirical Psi = 6.5224, Max null Psi = 0.6385, Min null Psi = 0.0652, p-value = 0
#> Empirical Phi = 0.5711, Max null Phi = 0.1787, Min null Phi = 0.0571, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.27708, Max null eigenvalue = 1.59532, p-value = 0
#> Empirical eigenvalue #2 = 0.54778, Max null eigenvalue = 1.32431, p-value = 1
#> Empirical eigenvalue #3 = 0.50354, Max null eigenvalue = 1.08899, p-value = 1
#> Empirical eigenvalue #4 = 0.38057, Max null eigenvalue = 0.97618, p-value = 1
#> Empirical eigenvalue #5 = 0.29104, Max null eigenvalue = 0.86362, p-value = 1
#> 
#> PC 1 is significant and accounts for 65.5% (95%-CI:58.6-72.6) of the total variation
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
#> Empirical Psi = 10.9186, Max null Psi = 2.4464, Min null Psi = 0.6633, p-value = 0
#> Empirical Phi = 0.5099, Max null Phi = 0.2413, Min null Phi = 0.1257, p-value = 0
#> 
#> Empirical eigenvalue #1 = 3.84712, Max null eigenvalue = 2.21571, p-value = 0
#> Empirical eigenvalue #2 = 1.52017, Max null eigenvalue = 1.70742, p-value = 0.13
#> Empirical eigenvalue #3 = 0.70634, Max null eigenvalue = 1.40805, p-value = 1
#> Empirical eigenvalue #4 = 0.41356, Max null eigenvalue = 1.07902, p-value = 1
#> Empirical eigenvalue #5 = 0.34001, Max null eigenvalue = 0.91932, p-value = 1
#> Empirical eigenvalue #6 = 0.14515, Max null eigenvalue = 0.7377, p-value = 1
#> Empirical eigenvalue #7 = 0.02765, Max null eigenvalue = 0.58508, p-value = 1
#> 
#> PC 1 is significant and accounts for 55% (95%-CI:45.7-65.7) of the total variation
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
Principal Component Analysis in R. PeerJ, in press.
