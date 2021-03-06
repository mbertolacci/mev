% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/univdist.R
\name{gev.infomat}
\alias{gev.infomat}
\title{Information matrix for the generalized extreme value distribution}
\usage{
gev.infomat(par, dat, method = c("obs", "exp"), nobs = length(dat))
}
\arguments{
\item{par}{vector of \code{loc}, \code{scale} and \code{shape}}

\item{dat}{sample vector}

\item{method}{string indicating whether to use the expected  (\code{'exp'}) or the observed (\code{'obs'} - the default) information matrix.}

\item{nobs}{number of observations}
}
\description{
The function returns the expected or observed information matrix.
}
\keyword{internal}
