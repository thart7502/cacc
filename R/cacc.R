#' Conjunctive Analysis of Case Configurations
#'
#' @description Computes a Conjunctive Analysis of Case Configurations (CACC).
#'
#' @param data A data frame or a tibble.
#' @param x A vector of names of the independent variables, without quotes. Variables must be categorical, either integer, character, or factor.
#' @param y Name of the dependent variable, without quotes. Variable must be dichotomous with values 0 (absence) and 1 (presence).
#'
#' @return Returns a tibble with the CACC matrix.
#' @export
#'
#' @importFrom rlang .data
#'
#' @examples
#' cacc(data = test_data, x = c(iv1, iv2, iv3, iv4), y = dv1)
#' cacc(data = test_data, x = c(iv1_c, iv2_c, iv3_c, iv4_c), y = dv1)

cacc <- function (data, x, y) {

  # Generate the CACC matrix ----
  # Count all profiles
  matrix_total <- data |>
    dplyr::group_by(dplyr::across({{ x }})) |>
    dplyr::count() |>
    dplyr::ungroup() |>
    dplyr::arrange(dplyr::desc(.data$n)) |>
    dplyr::rename(freq_total = "n")

  # Count profiles associated with presence of the DV
  matrix_one <- data |>
    dplyr::filter({{ y }} == 1) |>
    dplyr::group_by(dplyr::across({{ x }})) |>
    dplyr::count() |>
    dplyr::ungroup() |>
    dplyr::arrange(dplyr::desc(.data$n)) |>
    dplyr::rename(freq_one = "n")

  # Calculate the probabilities of occurrence for each dominant profile ----
  # Merge both data frames
  cacc_matrix <- dplyr::full_join(
    matrix_total,
    matrix_one
  ) |>
    # Calculate probabilities of ocurrence for each profile
    dplyr::mutate(p = .data$freq_one / .data$freq_total) |>
    # Filter by dominant profiles
    # Determine the threshold for dominant profiles based on sample size
    dplyr::filter(.data$freq_total >= dplyr::if_else(
      condition = nrow(data) < 1000,
      true = 5,
      false = 10
    )) |>
    dplyr::arrange(dplyr::desc(.data$p)) |>
    dplyr::select(- .data$freq_one) |>
    dplyr::rename(freq = "freq_total")

  # Return the CACC matrix ----
  return(cacc_matrix)

}
