% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cb_sumtab.R
\name{cb_sumtab}
\alias{cb_sumtab}
\title{Summary Table of responses for codebook}
\usage{
cb_sumtab(metadata, response, num.var, na_sep = TRUE, type)
}
\arguments{
\item{metadata}{a \code{data.frame} object with survey metadata}

\item{response}{a \code{data.frame} object with survey response data}

\item{num.var}{single numeric value indexing column of variable in metadata}

\item{na_sep}{a boolean indicating use of SEP coding rules (defaults to TRUE)}

\item{type}{a character indicating variable type (factor, numeric)}
}
\value{
table with counts (for factors) or descriptive summary (for numerics) of responses in Latex format
}
\description{
Summary Table of responses for codebook
}
