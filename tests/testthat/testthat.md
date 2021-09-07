Automated testing of PCAtest
================

## PCA of uncorrelated variables is not significant

``` r
library(testthat)
library(PCAtest)

data("ex0")
PCAout<-PCAtest(ex0, 100, 100, 0.05, indload=F, varcorr=FALSE, counter=F, plot=F)
```

    ## 
    ## Sampling bootstrap replicates... Please wait
    ## 
    ## Calculating confidence intervals of empirical statistics... Please wait
    ## 
    ## Sampling random permutations... Please wait
    ## 
    ## Comparing empirical statistics with their null distributions... Please wait
    ## 
    ## ========================================================
    ## Test of PCA significance: 5 variables, 100 observations
    ## 100 bootstrap replicates, 100 random permutations
    ## ========================================================
    ## 
    ## Empirical Psi = 0.1691, Max null Psi = 0.5742, Min null Psi = 0.0477, p-value = 0.66
    ## Empirical Phi = 0.0920, Max null Phi = 0.1694, Min null Phi = 0.0488, p-value = 0.66
    ## 
    ## PCA is not significant!

``` r
test_that("PCA of uncorrelated variables is not significant",{
    expect_gt(max(PCAout$`Null Psi`),PCAout$`Empirical Psi`)
    expect_gt(max(PCAout$`Null Phi`),PCAout$`Empirical Phi`)
  })
```

    ## Test passed 🥇

## PCA of two fully-correlated variables has only PC1 significant

``` r
v1<-seq(0,1,0.01)
v2<-seq(0,1,0.01)
x<-cbind(v1,v2)
PCAout<-PCAtest(x, 100, 100, 0.05, indload=F, varcorr=FALSE, counter=F, plot=F)
```

    ## 
    ## Sampling bootstrap replicates... Please wait
    ## 
    ## Calculating confidence intervals of empirical statistics... Please wait
    ## 
    ## Sampling random permutations... Please wait
    ## 
    ## Comparing empirical statistics with their null distributions... Please wait
    ## 
    ## ========================================================
    ## Test of PCA significance: 2 variables, 101 observations
    ## 100 bootstrap replicates, 100 random permutations
    ## ========================================================
    ## 
    ## Empirical Psi = 2.0000, Max null Psi = 0.1781, Min null Psi = 0.0000, p-value = 0
    ## Empirical Phi = 1.0000, Max null Phi = 0.2984, Min null Phi = 0.0011, p-value = 0
    ## 
    ## Empirical eigenvalue #1 = 2, Max null eigenvalue = 1.29844, p-value = 0
    ## Empirical eigenvalue #2 = 0, Max null eigenvalue = 0.99886, p-value = 1
    ## 
    ## PC 1 is significant and accounts for 100% (95%-CI:100-100) of the total variation

``` r
test_that("PCA of two fully-correlated variables has Psi=2, Phi=1,
  and only PC1 is significant",{
  expect_equal(PCAout$`Empirical Psi`,2.0000)
  expect_equal(PCAout$`Empirical Phi`,1.0000)
  expect_equal(PCAout$`Percentage of variation of empirical PC's`[1],100)
})
```

    ## Test passed 🎉
