#' Grouped horizontal barplot
#'
#' @param data a \code{data.frame} object
#' @param item a survey item
#' @param by grouping variable
#' @param barpadding optional argument to adjust padding between bars
#' @param barwidth optional argument to define the bar's width
#' @param legendtitle optional argument to define a legend title
#' @param ... further arguments of \code{scale_fill_discrete} like \code{labels}
#'
#' @return a grouped horizontal barplot
#' @export
#'
#' @import dplyr
#' @import ggplot2
#' @import forcats

#'
plot_groupbar_h <- function(data, item, by, barpadding = 0.1, barwidth = 0.5, legendtitle = "", ...){
  data %>%
    filter({{item}} > -8,
           {{by}} > -8) %>%
    group_by({{item}}, {{by}}) %>%
    count() %>%
    group_by({{item}}) %>%
    mutate(freq = n/sum(n)) %>%
    ggplot(aes(x = fct_rev(as.factor({{item}})), y = .data$freq, fill = as.factor({{by}}))) +
    geom_col(position = position_dodge2(padding = 0.1), width = 0.5) +
    scale_y_continuous(labels = scales::label_percent(accuracy = 1)) +
    scale_fill_discrete(guide = guide_legend(reverse = TRUE), ...) +
    coord_flip() +
    labs(title = "",
         subtitle = "",
         fill = legendtitle,
         caption = n_par(data, {{item}})) +
    theme_sep() +
    theme(panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(linetype = "dashed"),
          legend.position = "bottom",
          plot.caption = element_text(color = "grey"))
}
