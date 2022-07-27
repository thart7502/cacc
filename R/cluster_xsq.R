cluster_xsq <- function (cacc_matrix) {

  # Declare the frequency each dominant profile is observed in the sample
  obs <- cacc_matrix$freq

  # Count the dominant profiles observed
  n_obs <- nrow(x = cacc_matrix)

  # Calculate the expected counts by weighting the sum of dominant observations by the number of dominant profiles observed
  exp <- rep(
    x = sum(obs) / n_obs,
    times = n_obs
  )

  # Conduct the Chi-square test ----
  xsq <- stats::chisq.test(
    x = obs,
    p = exp,
    # `rescale.p = TRUE` because probabilities must sum 1
    rescale.p = TRUE
  )

  # Return the Chi-square results ----
  return (xsq)

}
