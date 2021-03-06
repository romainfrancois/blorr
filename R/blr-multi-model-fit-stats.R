#' Multi model fit statistics
#'
#' Measures of model fit statistics for multiple models.
#'
#' @param model An object of class \code{glm}.
#' @param ... Objects of class \code{glm}.
#'
#' @return A tibble.
#'
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = hsb2,
#' family = binomial(link = 'logit'))
#'
#' model2 <- glm(honcomp ~ female + read + math, data = hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_multi_model_fit_stats(model, model2)
#'
#' @importFrom purrr map_df
#' @importFrom magrittr set_colnames
#'
#' @family model fit statistics
#'
#' @export
blr_multi_model_fit_stats <- function(model, ...) UseMethod("blr_multi_model_fit_stats")

#' @rdname blr_multi_model_fit_stats
#' @export
#'
blr_multi_model_fit_stats.default <- function(model, ...) {

  blr_check_model(model)

  k        <- list(model, ...)
  j        <- map(k, blr_model_fit_stats)
  n        <- length(j)
  names(j) <- letters[seq_len(n)]

  for (i in seq_len(n)) {
    class(j[[i]]) <- "list"
  }

  result <- list(mfit = map_df(j, as_tibble))
  class(result) <- "blr_multi_model_fit_stats"

  return(result)

}

#' @export
#'
print.blr_multi_model_fit_stats <- function(x, ...) {

  df <-
    x %>%
    use_series(mfit) %>%
    select(-lr_df, -dev_df)

  measures <- c(
    "Log-Lik Intercept Only", "Log-Lik Full Model", "Deviance",
    "LR", "Prob > LR", "MCFadden's R2", "McFadden's Adj R2",
    "ML (Cox-Snell) R2", "Cragg-Uhler(Nagelkerke) R2",
    "McKelvey & Zavoina's R2", "Efron's R2", "Count R2",
    "Adj Count R2", "AIC", "BIC"
  )

  model_id <-
    x %>%
    use_series(mfit) %>%
    nrow() %>%
    seq_len(.)

  col_names <- c(paste("Model", model_id))
  print(multi_fit_stats_table(df, measures, col_names))

}


multi_fit_stats_table <- function(df, measures, col_names) {

	df %>%
	  t() %>%
	  round(3)  %>%
	  magrittr::set_colnames(col_names) %>%
	  tibble::as_tibble() %>%
	  tibble::add_column(Measures = measures, .before = 1) %>%
	  as.data.frame() 

}
