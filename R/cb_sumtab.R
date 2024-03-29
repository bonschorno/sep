#' Summary Table of responses for codebook
#'
#' @param metadata a \code{data.frame} object with survey metadata
#' @param response a \code{data.frame} object with survey response data
#' @param num.var single numeric value indexing column of variable in metadata
#' @param na_sep a boolean indicating use of SEP coding rules (defaults to TRUE)
#' @param type a character indicating variable type (factor, numeric)
#'
#' @return table with counts (for factors) or descriptive summary (for numerics) of responses in Latex format
#' @export
#'
#' @importFrom kableExtra kable kable_styling
#'
cb_sumtab = function(metadata, response, num.var, na_sep = TRUE, type){

  name = as.character(metadata[num.var, "Variable name"])
  variable = response[[name]]

  # Get NA count and remove NAs
  if(isTRUE(na_sep)){
    na = sum(variable < -9, na.rm = T)
    variable = variable[variable >= -9]}

  if(type == "numeric"){

    if(na_sep == TRUE){

    has_dk = ifelse(!is.na(
      metadata[metadata[, "Variable name"] == name, "-8"]), "yes", "no")
    has_no = ifelse(!is.na(
      metadata[metadata[, "Variable name"] == name, "-9"]), "yes", "no")}

    else{
      has_dk = "no"
      has_no = "no"}

    # Get DK count if relevant for variable (SEP Coding)
    if(has_dk == "yes"){
      dk = sum(variable == -8, na.rm = T)
      variable = variable[variable != -8]}

    # Get None count if relevant for variable (SEP Coding)
    if(has_no == "yes"){
      no = sum(variable == -9, na.rm = T)
      variable = variable[variable != -9]}

    # Get summary statistic
    values = summary(variable)

    # Shape summary table to kable format
    df = data.frame(t(data.frame(values = as.numeric(values))))
    colnames(df) = names(values)
    rownames(df) = NULL

    # Add DK count if relevant for variable (SEP coding)
    if(has_dk == "yes"){
      df$`-8` = dk}

    # Add None count if relevant for variable (SEP coding)
    if(has_no == "yes"){
      df$`-9` = no}

    # Add NA count if NAs have numeric code (SEP coding)
    if(isTRUE(na_sep)){
      df$`NA's` = na}

    # Print table
    numtab = df %>%
      kableExtra::kable("latex", booktabs = T) %>%
      kableExtra::kable_styling(latex_options = "hold_position")

    print(numtab)

  }else if(type == "factor"){

    # Get summary statistic
    values = table(variable)

    # Shape summary table to kable format
    df = data.frame(t(data.frame(values = as.numeric(values))))
    colnames(df) = names(values)
    rownames(df) = NULL

    # Add NA count if NAs have numeric code (SEP coding)
    if(isTRUE(na_sep)){
      df$`NA's` = na}
    else{
      df$`NA's` = sum(is.na(variable))}

    # Print table
    facttab = df %>%
      kableExtra::kable("latex", booktabs = T) %>%
      kableExtra::kable_styling(latex_options = "hold_position")

    print(facttab)
  }
}
