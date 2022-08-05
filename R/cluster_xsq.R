#' Chi-Square Goodness-of-Fit Test
#'
#' @description Computes a Chi-Square Goodness-of-Fit Test to determine whether there is statistically significant clustering of observations among dominant profiles in a `cacc_matrix`.
#'
#' @param cacc_matrix A tibble. The output of the `cacc` function.
#'
#' @return Returns a list with the Chi-square results. This is the same object returned by the `chisq.test` function from the `stats` package.
#'
#' @export
#'
#' @examples
#' cluster_xsq(cacc(data = test_data, ivs = c(iv1, iv2, iv3, iv4), dv = dv1))

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
