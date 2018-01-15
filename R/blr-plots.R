#' @importFrom ggplot2 geom_hline
#' @importFrom stats residuals rstandard hatvalues
#' @title Residual vs Fitted Values Plot
#' @description Residual vs fitted values plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param line_color color of the horizontal line
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_residual_fitted(model)
#'
#' @export
#'
blr_plot_residual_fitted <- function(model, point_color = 'blue', line_color = 'red',
                                     title = 'Standardized Pearson Residual vs Fitted Values',
                                     xaxis_title = 'Fitted Values',
                                     yaxis_title = 'Standardized Pearson Residual') {

  fit_val <- model %>%
    fitted

  res_val <- model %>%
    rstandard(type = "pearson")

  tibble(fit = fit_val, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = fit, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title) +
    geom_hline(yintercept = 0, color = line_color)

}

#' @title Residual Values Plot
#' @description Standardised pearson residuals plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_pearson_residual(model)
#'
#' @export
#'
blr_plot_pearson_residual <- function(model, point_color = 'blue',
                                      title = 'Standardized Pearson Residuals',
                                      xaxis_title = 'id',
                                      yaxis_title = 'Standardized Pearson Residuals') {

  res_val <- model %>%
    rstandard(type = 'pearson')

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title Deviance vs Fitted Values Plot
#' @description Deviance vs fitted values plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param line_color color of the horizontal line
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_deviance_fitted(model)
#'
#' @export
#'
blr_plot_deviance_fitted <- function(model, point_color = 'blue', line_color = 'red',
                                     title = 'Deviance Residual vs Fitted Values',
                                     xaxis_title = 'Fitted Values',
                                     yaxis_title = 'Deviance Residual') {

  fit_val <- model %>%
    fitted.values

  res_val <- model %>%
    rstandard

  tibble(fit = fit_val, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = fit, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title) +
    geom_hline(yintercept = 0, color = line_color)

}

#' @title Deviance Residual Values
#' @description Deviance residuals plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_deviance_residual(model)
#'
#' @export
#'
blr_plot_deviance_residual <- function(model, point_color = 'blue',
                                      title = 'Deviance Residuals Plot',
                                      xaxis_title = 'id',
                                      yaxis_title = 'Deviance Residuals') {

  res_val <- model %>%
    rstandard()

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title Leverage vs Fitted Values Plot
#' @description Leverage vs fitted values plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_leverage_fitted(model)
#'
#' @export
#'
blr_plot_leverage_fitted <- function(model, point_color = 'blue',
                                     title = 'Leverage vs Fitted Values',
                                     xaxis_title = 'Fitted Values',
                                     yaxis_title = 'Leverage') {

  fit_val <- model %>%
    fitted.values

  res_val <- model %>%
    hatvalues

  tibble(fit = fit_val, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = fit, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title Leverage Plot
#' @description Leverage plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_leverage(model)
#'
#' @export
#'
blr_plot_leverage <- function(model, point_color = 'blue',
                                       title = 'Leverage Plot',
                                       xaxis_title = 'id',
                                       yaxis_title = 'Leverage') {

  res_val <- model %>%
    hatvalues

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title Residual Diagnostics
#' @description Diagnostics for confidence interval displacement and
#' detecting ill fitted observations
#' @param model an object of class \code{glm}
#' @return C, CBAR, DIFDEV and DIFCHISQ
#' @examples
#' #' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_residual_diagnostics(model)
#'
#' @export
#'
blr_residual_diagnostics <- function(model) {

  hat_val <- model %>%
    hatvalues

  res_val <- model %>%
    residuals(type = "pearson") %>%
    raise_to_power(2)

  num <- res_val * hat_val

  den <- 1 %>%
    subtract(hat_val)

  c <- num %>%
    divide_by(den %>%
                raise_to_power(2))

  cbar <- num %>%
    divide_by(den)

  difdev <- model %>%
    rstandard %>%
    raise_to_power(2) %>%
    divide_by(cbar)

  difchisq <- cbar %>%
    divide_by(hat_val)

  result <- tibble(c = c, cbar = cbar, difdev = difdev, difchisq = difchisq)
  return(result)

}


#' @title CI Displacement C Plot
#' @description Confidence interval displacement diagnostics C plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_diag_c(model)
#'
#' @export
#'
blr_plot_diag_c <- function(model, point_color = 'blue',
                              title = 'CI Displacement C Plot',
                              xaxis_title = 'id',
                              yaxis_title = 'CI Displacement C') {

  res_val <- model %>%
    blr_residual_diagnostics %>%
    pull(c)

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title CI Displacement CBAR Plot
#' @description Confidence interval displacement diagnostics CBAR plot
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_diag_cbar(model)
#'
#' @export
#'
blr_plot_diag_cbar <- function(model, point_color = 'blue',
                            title = 'CI Displacement CBAR Plot',
                            xaxis_title = 'id',
                            yaxis_title = 'CI Displacement CBAR') {

  res_val <- model %>%
    blr_residual_diagnostics %>%
    pull(cbar)

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}


#' @title Diff Chisquare Plot
#' @description Diagnostics for detecting ill fitted observations
#' @param model an object of class \code{glm}
#' @param point_color color of the points
#' @param title title of the plot
#' @param xaxis_title x axis label
#' @param yaxis_title y axis label
#' @examples
#' model <- glm(honcomp ~ female + read + science, data = blorr::hsb2,
#' family = binomial(link = 'logit'))
#'
#' blr_plot_diag_difchisq(model)
#'
#' @export
#'
blr_plot_diag_difchisq <- function(model, point_color = 'blue',
                               title = 'Diff Chisquare Plot',
                               xaxis_title = 'id',
                               yaxis_title = 'Diff Chisquare') {

  res_val <- model %>%
    blr_residual_diagnostics %>%
    pull(difchisq)

  id <- res_val %>%
    length %>%
    seq_len

  tibble(id = id, resid = res_val) %>%
    ggplot() +
    geom_point(aes(x = id, y = resid), color = point_color) +
    ggtitle(title) + xlab(xaxis_title) + ylab(yaxis_title)

}