#' Simple vertical barplot
#'
#' @param data a \code{data.frame} object
#' @param item a survey item
#' @param barcolor optional argument to set the color of the bar
#' @param barwidth optional argument to define the width of the bar
#' @param textvjust optional argument to adjust the text's horizontal alignment
#' @param textsize optional argument to adjust the text's size
#' @param min_textsize optional argument to set the minimum text size
#'
#' @return a vertical barplot
#' @export
#'
#' @import ggplot2
#' @import ggfittext
#'
#'
plot_bar_v <- function(data, item, barcolor = "#1F407A", barwidth = 0.8, textvjust = 2, textsize = 8, min_textsize = 5){
  data %>%
    filter({{item}} > -8) %>%
    group_by({{item}}) %>%
    count() %>%
    ungroup() %>%
    mutate(freq = n/sum(n)) %>%
    ggplot(aes(x = as.factor({{item}}), y = .data$freq, label = helper_percentage(.data$freq, 1))) +
    geom_col(fill = barcolor, width = barwidth) +
    geom_bar_text(size = textsize,
                  min.size = min_textsize,
                  family = "Roboto",
                  padding.y = grid::unit(textvjust, "mm"),
                  outside = TRUE) +
    labs(title = "",
         subtitle = "",
         caption = n_par(data, {{item}})) +
    theme_sep() +
    theme(axis.text.y = element_blank(),
          panel.grid.major.x = element_blank(),
          panel.grid.major.y = element_line(linetype = "dashed"),
          plot.caption = element_text(color = "grey"))

}
