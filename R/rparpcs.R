#' Simulation from Pareto processes (max) using composition sampling
#'
#' The algorithm performs forward sampling by simulating first from a
#' mixture, then sample angles conditional on them being less than one.
#' The resulting sample from the angular distribution is then multiplied by
#' Pareto variates with tail index \code{shape}.
#'
#' Only extreme value models based on elliptical processes are handled. The \code{Lambda} matrix
#' is formed by evaluating the semivariogram \eqn{\gamma} at sites \eqn{s_i, s_j}, meaning that
#'  \eqn{\Lambda_{i,j} = \gamma(s_i, s_j)/2}.
#'
#' @author Leo Belzile
#' @param n sample size.
#' @param Lambda parameter matrix for the Brown--Resnick model. See \bold{Details}.
#' @param Sigma correlation matrix if \code{model = 'xstud'}, otherwise
#' the covariance matrix formed from the stationary Brown-Resnick process.
#' @param df degrees of freedom for extremal Student process.
#' @param model string indicating the model family.
#' @param shape tail index of the Pareto variates (reciprocal shape parameter). Must be strictly positive.
#' @param riskf string indicating the risk functional. Only \code{max} and \code{min} are currently supported.
#' @details The argument \code{Sigma} is ignored for the Brown-Resnick model
#' if \code{Lambda} is provided by the user.
#' @export
#' @seealso \code{\link{rparp}} for general simulation of Pareto processes based on an accept-reject algorithm.
#' @return an \code{n} by \code{d} matrix of samples, where \code{d = ncol(Sigma)}, with \code{attributes} \code{mixt.weights}.
#' @examples
#' \dontrun{
#' #Brown-Resnick, Wadsworth and Tawn (2014) parametrization
#' D <- 20L
#' loc <- cbind(runif(D), runif(D))
#' semivario <- function(d, alpha = 1.5, lambda = 1){0.5 * (d/lambda)^alpha}
#' Lambda <- semivario(as.matrix(dist(loc))) / 2
#' rparpcs(n = 10, Lambda = Lambda, model = 'br', shape = 0.1)
#' #Extremal Student
#' Sigma <- stats::rWishart(n = 1, df = 20, Sigma = diag(10))[,,1]
#' rparpcs(n = 10, Sigma = cov2cor(Sigma), df = 3, model = 'xstud')
#' }
rparpcs <- function(n, Lambda = NULL, Sigma = NULL, df = NULL, model = c("br", "xstud"), riskf = c("max", "min"), shape = 1) {
    model <- match.arg(model)
    riskf <- match.arg(riskf)
    stopifnot(shape > 0)
    if (model == "xstud") {
        if (is.null(df)) {
            stop("Invalid degree of freedom argument")
        }
        stopifnot(!is.null(Sigma))
        D <- nrow(Sigma)
        if (!isTRUE(all.equal(as.vector(diag(Sigma)), rep(1, D)))) {
            warning("Input `Sigma` must be a correlation matrix")
            Sigma <- cov2cor(Sigma)
        }
        weights <- weightsXstud(z = rep(1, D), Sigma = Sigma, df = df, riskf = riskf)
    } else if (model == "br") {
        if (!is.null(Lambda)) {
            D <- nrow(Lambda)
            weights <- weightsBR(z = rep(1, D), Lambda = Lambda, riskf = riskf)
        } else if (!is.null(Sigma)) {
            D <- nrow(Sigma)
            T1 <- cbind(rep(-1, D - 1), diag(D - 1))
            weights <- weightsBR_WT(z = rep(1, D), Sigma = Sigma, riskf = riskf)
        }
    }
    weights <- weights/sum(weights)
    id <- sample.int(n = D, size = n, replace = TRUE, prob = weights)
    tabu <- table(id)
    bins <- as.integer(names(tabu))
    tabu <- as.vector(tabu)
    # Matrix to store samples
    ang <- matrix(1, nrow = D, ncol = n)
    accu <- 0L
    for (i in 1:length(tabu)) {
        j <- bins[i]
        if (riskf == "max") {
            if (model == "xstud") {
                ang[-j, (accu + 1L):(accu + tabu[i])] <- pmax(TruncatedNormal::mvrandt(n = tabu[i], l = rep(-Inf, D - 1), u = rep(1,
                  D - 1), df = df + 1, Sig = (Sigma[-j, -j] - Sigma[-j, j, drop = FALSE] %*% Sigma[j, -j, drop = FALSE])/(df + 1)),
                  0)^df
            } else if (model == "br") {
                if (!is.null(Lambda)) {
                  ang[-j, (accu + 1L):(accu + tabu[i])] <- exp(TruncatedNormal::mvrandn(n = tabu[i], l = rep(-Inf, D - 1), u = 2 *
                    Lambda[j, -j], Sig = 2 * (outer(Lambda[-j, j], Lambda[j, -j], FUN = "+") - Lambda[-j, -j])) - 2 * Lambda[j, -j])
                } else if (!is.null(Sigma)) {
                  me <- diag(Sigma)[-j]/2 + Sigma[j, j]/2 - Sigma[j, -j]
                  Ti <- T1
                  Ti[, c(1L, j)] <- T1[, c(j, 1L)]
                  ang[-j, (accu + 1L):(accu + tabu[i])] <- exp(TruncatedNormal::mvrandn(n = tabu[i], l = rep(-Inf, D - 1), u = -me,
                    Sig = Ti %*% Sigma %*% t(Ti)) + me)
                }
            }
        } else if (riskf == "min") {
            if (model == "xstud") {
                ang[-j, (accu + 1L):(accu + tabu[i])] <- pmax(TruncatedNormal::mvrandt(n = tabu[i], u = rep(Inf, D - 1), l = rep(1,
                  D - 1), df = df + 1, Sig = (Sigma[-j, -j] - Sigma[-j, j, drop = FALSE] %*% Sigma[j, -j, drop = FALSE])/(df + 1)),
                  0)^df
            } else if (model == "br") {
                if (!is.null(Lambda)) {
                  ang[-j, (accu + 1L):(accu + tabu[i])] <- exp(TruncatedNormal::mvrandn(n = tabu[i], u = rep(Inf, D - 1), Sig = 2 *
                    (outer(Lambda[-j, j], Lambda[j, -j], FUN = "+") - Lambda[-j, -j]), l = 2 * Lambda[j, -j]) - 2 * Lambda[j, -j])
                } else if (!is.null(Sigma)) {
                  me <- diag(Sigma)[-j]/2 + Sigma[j, j]/2 - Sigma[j, -j]
                  Ti <- T1
                  Ti[, c(1L, j)] <- T1[, c(j, 1L)]
                  ang[-j, (accu + 1L):(accu + tabu[i])] <- exp(TruncatedNormal::mvrandn(n = tabu[i], u = rep(Inf, D - 1), l = -me,
                    Sig = Ti %*% Sigma %*% t(Ti)) + me)
                }
            }

        }
        accu <- accu + tabu[i]
    }
    samp <- runif(n)^(-shape) * t(ang[, sample.int(n, n, replace = FALSE)])
    attr(samp, "mixt.weights") <- weights
    return(samp)
}
#' Simulation of generalized Huesler-Reiss Pareto vectors via composition sampling
#'
#' Sample from the generalized Pareto process associated to Huesler-Reiss spectral profiles.
#' For the Huesler-Reiss Pareto vectors, the matrix \code{Sigma} is utilized to build \eqn{Q} viz.
#' \deqn{Q = \Sigma^{-1} - \frac{\Sigma^{-1}\mathbf{1}_d\mathbf{1}_d^\top\Sigma^{-1}}{\mathbf{1}_d^\top\Sigma^{-1}\mathbf{1}_d}.}
#' The location vector \code{m} and \code{Sigma} are the parameters of the underlying log-Gaussian process.
#'
#' @param n sample size
#' @param u vector of marginal location parameters (must be strictly positive)
#' @param alpha vector of shape parameters (must be strictly positive).
#' @param Sigma covariance matrix of process, used to define \eqn{Q}. See \bold{Details}.
#' @param m location vector of Gaussian distribution.
#' @return \code{n} by d matrix of observations
#' @references Ho, Z. W. O and C. Dombry (2017), Simple models for multivariate regular variations and the
#'   Huesler-Reiss Pareto distribution, \url{http://arxiv.org/abs/1712.09225v1}
#' @export
#' @examples
#' D <- 20L
#' loc <- cbind(runif(D), runif(D))
#' di <- as.matrix(dist(rbind(c(0, ncol(loc)), loc)))
#' semivario <- function(d, alpha = 1.5, lambda = 1){(d/lambda)^alpha}
#' Vmat <- semivario(di)
#' Sigma <- outer(Vmat[-1, 1], Vmat[1, -1], '+') - Vmat[-1, -1]
#' m <- Vmat[-1,1]
#' samp <- rparpcshr(n = 100, u = c(rep(1, 10), rep(2, 10)),
#'           alpha = seq(0.1, 1, length = 20), Sigma = Sigma, m = m)
rparpcshr <- function(n, u, alpha, Sigma, m) {
    D <- ncol(Sigma)
    Sigmainv <- solve(Sigma)
    q <- Sigmainv %*% rep(1, D)
    Q <- (Sigmainv - q %*% t(q)/sum(q))
    l <- c(Sigmainv %*% (((m %*% q - 1)/sum(q))[1] * rep(1, D) - m))
    if (any(u <= 0)) {
        stop("Threshold must be strictly positive")
    }
    if (any(alpha <= 0)) {
        stop("Tail indices must all be strictly positive")
    }
    alpha <- rep(alpha, length = D)
    u <- rep(u, length = D)
    Lst <- l - Q %*% diag(alpha) %*% log(u)  #prop 4.2 b/c u \neq 1
    weights <- weightsHR(z = rep(1, D), L = Lst, Q = Q)
    weights <- weights/sum(weights)
    id <- sample.int(n = D, size = n, replace = TRUE, prob = weights)
    tabu <- table(id)
    bins <- as.integer(names(tabu))
    tabu <- as.vector(tabu)
    # Matrix to store samples
    ang <- matrix(1, nrow = D, ncol = n)
    accu <- 0L
    for (i in 1:length(tabu)) {
        j <- bins[i]
        Qjinv <- solve(Q[-j, -j])
        ang[-j, (accu + 1L):(accu + tabu[i])] <- exp(TruncatedNormal::mvrandn(n = tabu[i], l = rep(-Inf, D - 1), u = c(-Qjinv %*%
            Lst[-j, ]), Sig = Qjinv) + c(Qjinv %*% Lst[-j, ]))
        accu <- accu + tabu[i]
    }
    R <- evd::rgpd(n = n, loc = 1, scale = 1, shape = 1)
    samp <- R * t(ang[, sample.int(n, n, replace = FALSE)])
    for (j in 1:ncol(samp)) {
        samp[, j] <- u[j] * (samp[, j]^(alpha[j]))  #coro 4.3
    }
    return(samp)
}


#' Exponent measure for elliptical extreme value processes
#'
#' Measure of the set \eqn{[0, z]^c} for Huesler-Reiss, Brown-Resnick and extremal Student processes.
#' The expression appears in likelihood inference
#'
#' @param z vector at which to estimate exponent measure
#' @param Lambda parameter matrix for the Brown--Resnick model
#' @param Sigma correlation matrix if \code{model = 'xstud'}, otherwise
#' the covariance matrix formed from the stationary Brown-Resnick process.
#' @param df degrees of freedom for extremal Student process
#' @param m mean vector for the Huesler-Reiss model
#' @param model string indicating the model family
#' @param method string indicating the package from which to extract the numerical integration routine
#' @return numeric
#' @export
#' @importFrom TruncatedNormal mvNqmc
#' @importFrom TruncatedNormal mvTqmc
#' @examples
#' #Extremal Student
#' Sigma <- stats::rWishart(n = 1, df = 20, Sigma = diag(10))[,,1]
#' expme(z = rep(1, ncol(Sigma)), Sigma = cov2cor(Sigma), df = 3, model = 'xstud')
#' #Brown-Resnick model
#' D <- 5L
#' loc <- cbind(runif(D), runif(D))
#' di <- as.matrix(dist(rbind(c(0, ncol(loc)), loc)))
#' semivario <- function(d, alpha = 1.5, lambda = 1){(d/lambda)^alpha}
#' Vmat <- semivario(di)
#' Lambda <- Vmat[-1,-1]/2
#' expme(z <- rep(1, ncol(Lambda)), Lambda = Lambda, model = 'br', method = 'mvPot')
#' Sigma <- outer(Vmat[-1, 1], Vmat[1, -1], '+') - Vmat[-1, -1]
#' expme(z <- rep(1, ncol(Lambda)), Lambda = Lambda, model = 'br', method = 'mvPot')
expme <- function(z, Sigma = NULL, Lambda = NULL, m = NULL, df = NULL, model = c("hr", "br", "xstud"), method = c("mvPot", "TruncatedNormal",
    "mvtnorm")) {
    model <- match.arg(model)
    method <- match.arg(method)
    if (method == "mvtnorm") {
        if (!requireNamespace("mvtnorm", quietly = TRUE)) {
            warning("`mvtnorm` package is not installed.")
            method <- "TruncatedNormal"
        }
    } else if (method == "mvPot") {
        if (!requireNamespace("mvPot", quietly = TRUE)) {
            warning("`mvPot` package is not installed.")
            method <- "TruncatedNormal"
        }
    }
    if (model == "hr") {
        if (any(c(is.null(m), is.null(Sigma), ncol(Sigma) != nrow(Sigma)))) {
            stop("Invalid or missing arguments for the Huesler-Reiss model")
        }
        D <- ncol(Sigma)
        Sigmainv <- solve(Sigma)
        q <- Sigmainv %*% rep(1, D)
        Q <- (Sigmainv - q %*% t(q)/sum(q))
        l <- c(Sigmainv %*% (((m %*% q - 1)/sum(q))[1] * rep(1, D) - m))
        return(expmeHR(z = z, L = l, Q = Q, method = method))
    } else if (model == "xstud") {
        if (any(c(is.null(Sigma), is.null(df), ncol(Sigma) != nrow(Sigma)))) {
            stop("Invalid or missing arguments for the extremal Student model")
        }
        return(expmeXS(z = z, Sigma = Sigma, df = df, method = method))
    } else if (model == "br" && !is.null(Lambda)) {
        return(expmeBR(z = z, Lambda = Lambda, method = method))
    } else if (model == "br" && !is.null(Sigma)) {
        return(expmeBR_WT(z = z, Sigma = Sigma, method = method))
    } else {
        stop("Invalid input in `expme`")
    }
}

expmeBR <- function(z, Lambda, method = c("mvPot", "mvtnorm", "TruncatedNormal")) {
    weights <- weightsBR(z = z, Lambda = Lambda, method = method)
    sum(weights/z)
}

expmeHR <- function(z, Q, L, method = c("mvPot", "mvtnorm", "TruncatedNormal")) {
    weights <- weightsHR(z = z, Q = Q, L = L, method = method)
    sum(weights/z)
}

expmeBR_WT <- function(z, Sigma, method = c("mvPot", "mvtnorm", "TruncatedNormal")) {
    weights <- weightsBR_WT(z = z, Sigma = Sigma, method = method)
    sum(weights/z)
}

expmeXS <- function(z, Sigma, df, method = c("mvPot", "mvtnorm", "TruncatedNormal")) {
  if (method == "mvtnorm") {
    if (!requireNamespace("mvtnorm", quietly = TRUE)) {
      warning("`mvtnorm` package is not installed.")
      method <- "TruncatedNormal"
    }
  } else if (method == "mvPot") {
    if (!requireNamespace("mvPot", quietly = TRUE)) {
      warning("`mvPot` package is not installed.")
      method <- "TruncatedNormal"
    }
  }
    D <- length(z)
    stopifnot(ncol(Sigma) == D | nrow(Sigma) == D | df > 0)
    if (!isTRUE(all.equal(as.vector(diag(Sigma)), rep(1, D)))) {
        warning("Input `Sigma` must be a correlation matrix")
        Sigma <- try(cov2cor(Sigma))
        if (is.character(Sigma)) {
            stop("Could not convert `Sigma` to a correlation matrix.")
        }
    }
    weights <- weightsXstud(z = z, Sigma = Sigma, df = df, method = method)
    sum(weights/z)
}

weightsHR <- function(z, L, Q, method = c("mvPot", "mvtnorm", "TruncatedNormal"), ...) {
    ellipsis <- list(...)
    method <- match.arg(method)
    if (method == "mvtnorm") {
      if (!requireNamespace("mvtnorm", quietly = TRUE)) {
        warning("`mvtnorm` package is not installed.")
        method <- "TruncatedNormal"
      }
    } else if (method == "mvPot") {
      if (!requireNamespace("mvPot", quietly = TRUE)) {
        warning("`mvPot` package is not installed.")
        method <- "TruncatedNormal"
      }
    }
    D <- ncol(Q)
    weights <- rep(0, D)
    if (method == "mvPot") {
      if(!is.null(ellipsis$prime)){
        prime <- ellipsis$prime
      } else{
        prime <- 499L
      }
      if(!is.null(ellipsis$genvec)){
        stopifnot(length(ellipsis$genvec) >= D-1)
        genVec <- ellipsis$genvec[1:(D-1)]
      } else{
        genVec <- mvPot::genVecQMC(p = prime, D - 1)$genVec
      }
      if(is.null(ellipsis$nrep)){
        nrep <- 1L
      } else{
        nrep <- as.integer(ellipsis$nrep)
      }
    }
    for (j in 1:D) {
        Qmiinv <- solve(Q[-j, -j])
        weights[j] <- det(Qmiinv)^(0.5) * exp(0.5 * t(L[-j]) %*% Qmiinv %*% L[-j])[1] * switch(method, mvtnorm = mvtnorm::pmvnorm(upper = c(-Qmiinv %*%
            L[-j]), sigma = Qmiinv), mvPot = mvPot::mvtNormQuasiMonteCarlo(p = prime, upperBound = c(-Qmiinv %*% L[-j]), cov = Qmiinv,
            genVec = genVec, nrep = nrep)[1], TruncatedNormal = TruncatedNormal::mvNqmc(l = rep(-Inf, D - 1), n = 1e+05, u = c(-Qmiinv %*%
            L[-j]), Sig = Qmiinv)$prob)
    }
    return(weights)
}


weightsBR <- function(z, Lambda, method = c("mvPot", "mvtnorm", "TruncatedNormal"), riskf = c("max", "min"), ...) {
    ellipsis <- list(...)
    method <- match.arg(method)
    if (method == "mvtnorm") {
      if (!requireNamespace("mvtnorm", quietly = TRUE)) {
        warning("`mvtnorm` package is not installed.")
        method <- "TruncatedNormal"
      }
    } else if (method == "mvPot") {
      if (!requireNamespace("mvPot", quietly = TRUE)) {
        warning("`mvPot` package is not installed.")
        method <- "TruncatedNormal"
      }
    }
    riskf <- match.arg(riskf)
    si <- switch(riskf, max = 1, min = -1)
    D <- length(z)
    stopifnot(ncol(Lambda) == D | nrow(Lambda) == D)
    weights <- rep(0, D)
    if (method == "mvtnorm") {
        for (j in 1:D) {
            weights[j] <- mvtnorm::pmvnorm(lower = rep(-Inf, D - 1), upper = si * (2 * Lambda[-j, j] + log(z[-j]) - log(z[j])), sigma = 2 *
                (outer(Lambda[-j, j], Lambda[j, -j], FUN = "+") - Lambda[-j, -j]))
        }
    } else if (method == "mvPot") {
      if(!is.null(ellipsis$prime)){
        prime <- ellipsis$prime
      } else{
        prime <- 499L
      }
      if(!is.null(ellipsis$genvec)){
        stopifnot(length(ellipsis$genvec) >= D-1)
        genVec <- ellipsis$genvec[1:(D-1)]
      } else{
        genVec <- mvPot::genVecQMC(p = prime, D - 1)$genVec
      }
      if(is.null(ellipsis$nrep)){
        nrep <- 1L
      } else{
        nrep <- as.integer(ellipsis$nrep)
      }
        for (j in 1:D) {
            weights[j] <- mvPot::mvtNormQuasiMonteCarlo(p = prime, upperBound = si * (2 * Lambda[-j, j] + log(z[-j]) - log(z[j])),
                cov = 2 * (outer(Lambda[-j, j], Lambda[j, -j], FUN = "+") - Lambda[-j, -j]), genVec = genVec,  nrep = nrep)[1]
        }
    } else if (method == "TruncatedNormal") {
        for (j in 1:D) {
            weights[j] <- TruncatedNormal::mvNqmc(l = rep(-Inf, D - 1), n = 1e+05, u = si * (2 * Lambda[-j, j] + log(z[-j]) - log(z[j])),
                Sig = 2 * (outer(Lambda[-j, j], Lambda[j, -j], FUN = "+") - Lambda[-j, -j]))$prob
        }
    }
    return(weights)
}

weightsBR_WT <- function(z, Sigma, method = c("mvPot", "mvtnorm", "TruncatedNormal"), riskf = c("max", "min"), ...) {
    ellipsis <- list(...)
    method <- match.arg(method)
    if (method == "mvtnorm") {
      if (!requireNamespace("mvtnorm", quietly = TRUE)) {
        warning("`mvtnorm` package is not installed.")
        method <- "TruncatedNormal"
      }
    } else if (method == "mvPot") {
      if (!requireNamespace("mvPot", quietly = TRUE)) {
        warning("`mvPot` package is not installed.")
        method <- "TruncatedNormal"
      }
    }
    riskf <- match.arg(riskf)
    si <- switch(riskf, max = 1, min = -1)
    D <- length(z)
    stopifnot(ncol(Sigma) == D | nrow(Sigma) == D)
    weights <- rep(0, D)
    Ti <- cbind(rep(-1, D - 1), diag(D - 1))
    if (method == "mvPot") {
      if(!is.null(ellipsis$prime)){
        prime <- ellipsis$prime
      } else{
        prime <- 499L
      }
      if(!is.null(ellipsis$genvec)){
        stopifnot(length(ellipsis$genvec) >= D-1)
        genVec <- ellipsis$genvec[1:(D-1)]
      } else{
        genVec <- mvPot::genVecQMC(p = prime, D - 1)$genVec
      }
      if(is.null(ellipsis$nrep)){
        nrep <- 1L
      } else{
        nrep <- as.integer(ellipsis$nrep)
      }
    }
    for (j in 1:D) {
        if (j > 1) {
            Ti[, (j - 1):j] <- Ti[, j:(j - 1)]
        }
        if (method == "mvtnorm") {
            weights[j] <- mvtnorm::pmvnorm(lower = rep(-Inf, D - 1), upper = si * (log(z[-j]/z[j]) + diag(Sigma)[-j]/2 + Sigma[j,
                j]/2 - Sigma[j, -j]), sigma = Ti %*% Sigma %*% t(Ti))
        } else if (method == "mvPot") {
                weights[j] <- mvPot::mvtNormQuasiMonteCarlo(p = prime, upperBound = si * (log(z[-j]/z[j]) + diag(Sigma)[-j]/2 +
                Sigma[j, j]/2 - Sigma[j, -j]), cov = Ti %*% Sigma %*% t(Ti), genVec = genVec, nrep = nrep)[1]
        } else if (method == "TruncatedNormal") {
            weights[j] <- TruncatedNormal::mvNqmc(l = rep(-Inf, D - 1), n = 1e+05, u = si * (log(z[-j]/z[j]) + diag(Sigma)[-j]/2 +
                Sigma[j, j]/2 - Sigma[j, -j]), Sig = Ti %*% Sigma %*% t(Ti))$prob
        }
    }
    return(weights)
}

weightsXstud <- function(z, Sigma, df, method = c("mvPot", "mvtnorm", "TruncatedNormal"), riskf = c("max", "min"), ...) {
    ellipsis <- list(...)
    method <- match.arg(method)
    if (method == "mvtnorm") {
      if (!requireNamespace("mvtnorm", quietly = TRUE)) {
        warning("`mvtnorm` package is not installed.")
        method <- "TruncatedNormal"
      }
    } else if (method == "mvPot") {
      if (!requireNamespace("mvPot", quietly = TRUE)) {
        warning("`mvPot` package is not installed.")
        method <- "TruncatedNormal"
      }
    }
    riskf <- match.arg(riskf)
    si <- switch(riskf, max = 1, min = -1)
    D <- nrow(Sigma)
    stopifnot(nrow(Sigma) == length(z))
    weights <- rep(0, D)
    if (method == "mvtnorm") {
        for (j in 1:D) {
            weights[j] <- mvtnorm::pmvt(lower = rep(-Inf, D - 1), df = df + 1, upper = si * (exp((log(z[-j]) - log(z[j]))/df) - Sigma[-j,
                j]), sigma = (Sigma[-j, -j] - Sigma[-j, j, drop = FALSE] %*% Sigma[j, -j, drop = FALSE])/(df + 1))
        }
    } else if (method == "mvPot") {
      if(!is.null(ellipsis$prime)){
        prime <- ellipsis$prime
      } else{
        prime <- 499L
      }
      if(!is.null(ellipsis$genvec)){
        stopifnot(length(ellipsis$genvec) >= D-1)
        genVec <- ellipsis$genvec[1:(D-1)]
      } else{
        genVec <- mvPot::genVecQMC(p = prime, D - 1)$genVec
      }
      if(is.null(ellipsis$nrep)){
        nrep <- 1L
      } else{
        nrep <- as.integer(ellipsis$nrep)
      }
        for (j in 1:D) {
            weights[j] <- mvPot::mvTProbQuasiMonteCarlo(p = prime, upperBound = si * (exp((log(z[-j]) - log(z[j]))/df) - Sigma[-j,
                j]), cov = (Sigma[-j, -j] - Sigma[-j, j, drop = FALSE] %*% Sigma[j, -j, drop = FALSE])/(df + 1), nu = df + 1, genVec = genVec, nrep = nrep)[1]
        }
    } else if (method == "TruncatedNormal") {
        for (j in 1:D) {
            weights[j] <- TruncatedNormal::mvTqmc(l = rep(-Inf, D - 1), df = df + 1, n = 1e+05, u = si * (exp((log(z[-j]) - log(z[j]))/df) -
                Sigma[-j, j]), Sig = (Sigma[-j, -j] - Sigma[-j, j, drop = FALSE] %*% Sigma[j, -j, drop = FALSE])/(df + 1))$prob
        }
    }
    return(weights)
}
