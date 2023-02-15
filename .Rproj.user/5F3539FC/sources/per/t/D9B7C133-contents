#' Define bram model object
#'
#' @param formula Formula for the brms model
#' @param data Data for the brms model
#' @param family Regression family for the brms model
#'
#' @return A Bram model object
#' @export
bram <- function(formula, data, family=brms::brmsfamily("gaussian")) {
  Bram$new(formula, data, family)
}

Bram <- R6::R6Class("Bram",
  public = list (
    initialize = function(formula, data, family) {
      self$formula <- formula
      self$data <- data
      self$family <- family
    },
    fit = function(...) {
      self$brms_model <- brms::brm(
        self$formula,
        self$data,
        self$family,
        backend=self$backend,
        cores=self$cores,
        prior=self$get_priors(),
        ...
      )
    },
    get_priors = function(...) {
      if (is.null(private$priors)) {
        priors <- brms::get_prior(self$formula, self$data, self$family)
      } else {
        priors <- private$priors
      }
      priors
    },
    set_priors = function(priors, ...) {
      private$priors <- priors
      private$refit_prior_model <- TRUE
    },
    prior_check = function(force_refit=FALSE) {
      # Lazy load brms prior model
      if (is.null(self$brms_prior_model) || private$refit_prior_model || force_refit) {
        self$brms_prior_model <- brms::brm(
          self$formula,
          self$data,
          self$family,
          backend=self$backend,
          cores=self$cores,
          prior=self$get_priors(),
          sample_prior="only"
        )
        private$refit_prior_model <- FALSE
      }

      # Plot density
      plot(bayesplot::pp_check(self$brms_prior_model))

      # Plot marginals
      mfx_prior <- marginaleffects::marginaleffects(self$brms_prior_model, type="link")
      plot(mfx_prior)
    },
    posterior_check = function () {
      if (is.null(self$brms_model)) {
        message("Model must be fit to data with the $fit() function before posterior checks can be made")
      } else {
        # Plot density
        plot(bayesplot::pp_check(self$brms_model))

        # Plot marginals
        plot(bayesplot::pp_check(self$brms_model, type="scatter_avg"))
      }
    },
    diagnostics = function () {
      if (is.null(self$brms_model)) {
        message("Model must be fit to data with the $fit() function before diagnostics can be checked")
      } else {
        # Plot traceplot
        plot(bayesplot::mcmc_trace(self$brms_model))
        # Print summary
        print(summary(self$brms_model))
      }
    },
    summary = function () {
      if (is.null(self$brms_model)) {
        message("Model must be fit to data with the $fit() function before diagnostics can be checked")
      } else {
        # Compute marginals and plot and print summary
        mfx <- marginaleffects::marginaleffects(self$brms_model, type="link")
        print(summary(mfx))
        plot(mfx)
      }
    },
    formula = NULL,
    data = NULL,
    family = NULL,
    cores = 4,
    backend = "cmdstanr",
    brms_model = NULL,
    brms_prior_model = NULL
  ),
  private = list (
    priors = NULL,
    refit_prior_model = FALSE
  )
)
