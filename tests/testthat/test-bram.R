test_that("bram works", {
  # Define model
  expect_error(
    model <- bram(cyl ~ scale(hp) + scale(disp), data=mtcars, family="poisson"),
    regexp = NA
  )

  # Check messages pre model fit
  expect_message (
    model$diagnostics()
  )

  expect_message (
    model$posterior_check()
  )

  # Set and check priors
  expect_error (
    priors <- model$get_priors(),
    regexp = NA
  )

  expect_true (
    inherits(model$get_priors(), "brmsprior")
  )

  priors <- c(
    brms::prior("normal(0, 1.5)", coef="scalehp"),
    brms::prior("normal(0, 1)", coef="scaledisp"),
    brms::prior("normal(0, 1)", class="Intercept")
  )

  expect_error (
    model$set_priors(priors),
    regexp = NA
  )

  expect_error (
    model$prior_check(),
    regexp = NA
  )

  # Fit the model
  expect_error (
    model$fit(),
    regexp = NA
  )

  # Check the sampler diagnostics
  expect_error (
    model$diagnostics(),
    regexp = NA
  )

  # Run posterior checks
  expect_error (
    model$posterior_check(),
    regexp = NA
  )

  # Create model summary
  expect_error (
    model$summary(),
    regexp = NA
  )
})
