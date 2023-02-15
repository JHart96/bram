# bram - A wrapper for simple Bayesian workflows with brms

Bram is a tiny R package that acts as a wrapper for brms. The goal of Bram is to provide a simple, easy-to-use Bayesian workflow for brms models. The workflow is opinionated, and is designed to encourage setting informative priors, thorough posterior checks, and estimating marginal effects.

# Installation

Bram can be installed with the `remotes` library:
```r
remotes::install_github("JHart96/bram")
```

# Quickstart

The full quickstart vignette can be viewed by running `vignette("quickstart", package="bram")`. The following code gives a basic example of the Bram workflow:
```r
# Define model
model <- bram(cyl ~ scale(hp) + scale(disp), data=mtcars, family="poisson")

# Set and check priors
priors <- c(
  prior(normal(0, 0.5), coef="scalehp"),
  prior(normal(0, 0.8), coef="scaledisp"),
  prior(normal(1, 1), class="Intercept")
)
model$set_priors(priors)
model$prior_check()

# Fit model
model$fit()

# Model checks
model$diagnostics()
model$posterior_check()

# Model summary
model$summary()
```

# Functions

The basic functions implemented in Bram are:

* `model <- bram(formula, data, family)` defines an R6 Bram object. All analysis will be based on this object.
* `model$get_priors()` retrieves the default `brmsprior` object.
* `model$set_priors()` sets the `brmsprior` object.
* `model$prior_check()` performs basic prior predictive checks.
* `model$fit()` fits the model.
* `model$diagnostics()` runs basic diagnostic checks of the sampler.
* `model$posterior_check()` performs basic posterior predictive checks.
* `model$summary()` generates a model summary based on estimated marginal effects.
