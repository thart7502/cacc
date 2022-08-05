#' Main effect
#'
#' @description Computes the main effect that a specific value of a variable produces on the outcome probability in a `cacc_matrix`.
#'
#' @param cacc_matrix A tibble. The output of the `cacc` function.
#' @param variable A single variable name contained in a `cacc_matrix`.
#' @param value A single numeric or character value the `variable` specified can take.
#'
#' @return Returns a numeric vector, ranging from 0 to 1, containing the main effect of the `value` of the selected `variable` on the probability of outcome.
#'
#' @export
#'
#' @examples
#' main_effect(
#'   cacc_matrix = cacc(data = test_data, ivs = c(iv1, iv2, iv3, iv4), dv = dv1),
#'   variable = iv4,
#'   value = 0
#')

main_effect <- function (cacc_matrix, variable, value) {

  cacc_effect <- cacc_matrix |>
    dplyr::group_by(dplyr::across(-c({{ variable }}, .data$freq, .data$p))) |>
    dplyr::filter(dplyr::n() > 1) |>
    dplyr::arrange({{ variable }}, .by_group = TRUE) |>
    dplyr::mutate(effect = dplyr::if_else(
      condition = {{ variable }} == value,
      true = NA_real_,
      false = .data$p - dplyr::nth(.data$p, which({{ variable }} == value))
    )) |>
    tidyr::drop_na()

  return (cacc_effect |> dplyr::pull(.data$effect))

}
