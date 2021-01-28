#' Simple vertical barplot
#'
#' @param data a \code{data.frame} object
#' @param item a survey item
#' @param dk_share share of "Don't knows". Check \code{eda_freqtable} for share.
#' @param barcolor optional argument to set the color of the bar
#' @param barwidth optional argument to define the width of the bar
#' @param textvjust optional argument to adjust the text's horizontal alignment
#' @param textsize optional argument to adjust the text's size
#' @param textcolor optional argument to adjust the text's colour (default to white)
#'
#' @return a vertical barplot
#' @export
#'
#' @import ggplot2
#'
plot_bar_v <- function(data = currentwave, item, dk_share = "?", barcolor = "#1F407A", barwidth = 0.8, textvjust = 1.7, textsize = 4, textcolor = "white"){
  data %>%
    filter({{item}} > -8) %>%
    group_by({{item}}) %>%
    count() %>%
    ungroup() %>%
    mutate(freq = n/sum(n)) %>%
    ggplot(aes(x = as.factor({{item}}), y = .data$freq)) +
    geom_col(fill = barcolor, width = barwidth) +
    geom_text(aes(label=helper_percentage(.data$freq, 2)), vjust = textvjust, size = textsize, color = textcolor, family = "Roboto") +
    labs(title = "",
         subtitle = "",
         caption = paste0('Graphik exklusive "Weiss nicht" Antworten: Anteil ', dk_share, '%')) +
    theme_sep() +
    theme(axis.text.y = element_blank(),
          panel.grid.major.x = element_blank(),
          panel.grid.major.y = element_line(linetype = "dashed"),
          plot.caption = element_text(face = "italic"))

}