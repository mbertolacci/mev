% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{.rsmithspec}
\alias{.rsmithspec}
\title{Generates from \eqn{Q_i}{Qi}, the spectral measure of the Smith model (moving maxima)}
\usage{
.rsmithspec(n, Sigma_chol, loc)
}
\arguments{
\item{n}{sample size}

\item{Sigma_chol}{Cholesky decomposition of the \code{d}-dimensional covariance matrix (upper triangular)}

\item{loc}{location matrix}
}
\value{
an \code{n} by \code{d} sample from the spectral distribution
}
\description{
Simulation algorithm of Dombry et al. (2015)
}
\references{
Dombry, Engelke and Oesting (2016). Exact simulation of max-stable processes,
\emph{Biometrika}, \bold{103}(2), 303--317.
}
\keyword{internal}
