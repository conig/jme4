# Installation

```
remotes::install_github("conig/jme4")
```

# Usage

## Lmer

```
model <- jme4("Sepal.Width ~ 1 + (1|Species)", data = iris)
summary(model)
#> Linear mixed model fit by maximum likelihood  ['lmerMod']
#> Formula: Sepal_Width ~ 1 + (1 | Species)
#>    Data: jellyme4_data
#> Control: 
#> lme4::lmerControl(optimizer = "nloptwrap", optCtrl = list(maxeval = 1),  
#>     calc.derivs = FALSE, check.nobs.vs.nRE = "warning")
#> 
#>      AIC      BIC   logLik deviance df.resid 
#>    118.2    127.3    -56.1    112.2      147 
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -3.2874 -0.6379  0.0625  0.6513  2.8947 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  Species  (Intercept) 0.07333  0.2708  
#>  Residual             0.11539  0.3397  
#> Number of obs: 150, groups:  Species, 3
#> 
#> Fixed effects:
#>             Estimate Std. Error t value
#> (Intercept)   3.0573     0.1588   19.25
#> optimizer (LN_BOBYQA) convergence code: 5 (fit with MixedModels.jl)
```

## glmer

```
iris$long_petal = iris$Sepal.Length > 6
model <- jme4("long_petal ~ 1 + (1|Species)", data = iris, family = "binomial")
summary(model)
#> Generalized linear mixed model fit by maximum likelihood (Laplace
#>   Approximation) [glmerMod]
#>  Family: binomial  ( logit )
#> Formula: long_petal ~ 1 + (1 | Species)
#>    Data: jellyme4_data
#> Weights: jellyme4_weights
#> Control: 
#> lme4::glmerControl(optimizer = "nloptwrap", optCtrl = list(maxeval = 1),  
#>     calc.derivs = FALSE, check.nobs.vs.nRE = "warning")
#> 
#>      AIC      BIC   logLik deviance df.resid 
#>      132      138      -64      128      148 
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.09318 -0.81264 -0.08039  0.47774  1.23056 
#> 
#> Random effects:
#>  Groups  Name        Variance Std.Dev.
#>  Species (Intercept) 10.65    3.263   
#> Number of obs: 150, groups:  Species, 3
#> 
#> Fixed effects:
#>             Estimate Std. Error z value Pr(>|z|)
#> (Intercept)   -1.624      1.967  -0.826    0.409
#> optimizer (LN_BOBYQA) convergence code: 5 (fit with MixedModels.jl)
```