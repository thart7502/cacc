#' Main effect
#'
#' @description Computes the main effect that a specific value of a variable produces on the outcome probability in a `cacc_matrix`.
#'
#' @param cacc_matrix A tibble. The output of the `cacc` function.
#' @param iv A single variable name contained in a `cacc_matrix`.
#' @param value A single numeric or character value the `iv` specified can take.
#'
#' @return Returns a tibble containing a single numeric variable, ranging from 0 to 1, containing the main effects of the `value` of the selected `iv` on the probability of outcome.
#'
#' @export
#'
#' @references Hart, T. C., Rennison, C. M., & Miethe, T. D. (2017). Identifying Patterns of Situational Clustering and Contextual Variability in Criminological Data: An Overview of Conjunctive Analysis of  Case  Configurations. *Journal  of  Contemporary Criminal  Justice, 33*(2),  112–120. https://doi.org/10.1177/1043986216689746
#'
#' @examples
#' main_effect(
#'   cacc_matrix = cacc(data = test_data, ivs = c(iv1, iv2, iv3, iv4), dv = dv1),
#'   iv = iv4,
#'   value = 0
#' )

main_effect <- function (cacc_matrix, iv, value) {

  # Calculate the main effect ----
  cacc_effect <- cacc_matrix |>
    dplyr::group_by(dplyr::across(-c({{ iv }}, .data$freq, .data$p))) |>
    dplyr::filter(dplyr::n() > 1) |>
    dplyr::arrange({{ iv }}, .by_group = TRUE) |>
    dplyr::mutate(effect = dplyr::if_else(
      condition = {{ iv }} == value,
      true = NA_real_,
      false = .data$p - dplyr::nth(.data$p, which({{ iv }} == value))
    )) |>
    dplyr::ungroup() |>
    tidyr::drop_na()

  return (cacc_effect |> dplyr::select(.data$effect))

}
