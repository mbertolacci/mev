// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// EuclideanWeights
arma::vec EuclideanWeights(arma::mat x, arma::rowvec mu);
RcppExport SEXP mev_EuclideanWeights(SEXP xSEXP, SEXP muSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< arma::rowvec >::type mu(muSEXP);
    rcpp_result_gen = Rcpp::wrap(EuclideanWeights(x, mu));
    return rcpp_result_gen;
END_RCPP
}
// emplik
List emplik(arma::mat z, arma::colvec mu, arma::vec lam, double eps, double M, double thresh, int itermax);
RcppExport SEXP mev_emplik(SEXP zSEXP, SEXP muSEXP, SEXP lamSEXP, SEXP epsSEXP, SEXP MSEXP, SEXP threshSEXP, SEXP itermaxSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::mat >::type z(zSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type mu(muSEXP);
    Rcpp::traits::input_parameter< arma::vec >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< double >::type eps(epsSEXP);
    Rcpp::traits::input_parameter< double >::type M(MSEXP);
    Rcpp::traits::input_parameter< double >::type thresh(threshSEXP);
    Rcpp::traits::input_parameter< int >::type itermax(itermaxSEXP);
    rcpp_result_gen = Rcpp::wrap(emplik(z, mu, lam, eps, M, thresh, itermax));
    return rcpp_result_gen;
END_RCPP
}
// rdir
NumericMatrix rdir(int n, NumericVector alpha, bool normalize);
RcppExport SEXP mev_rdir(SEXP nSEXP, SEXP alphaSEXP, SEXP normalizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< bool >::type normalize(normalizeSEXP);
    rcpp_result_gen = Rcpp::wrap(rdir(n, alpha, normalize));
    return rcpp_result_gen;
END_RCPP
}
// mvrnorm
NumericMatrix mvrnorm(int n, NumericVector mu, NumericMatrix Sigma);
RcppExport SEXP mev_mvrnorm(SEXP nSEXP, SEXP muSEXP, SEXP SigmaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type mu(muSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    rcpp_result_gen = Rcpp::wrap(mvrnorm(n, mu, Sigma));
    return rcpp_result_gen;
END_RCPP
}
// mvrnorm_arma
arma::mat mvrnorm_arma(int n, arma::colvec Mu, arma::mat Xmat);
RcppExport SEXP mev_mvrnorm_arma(SEXP nSEXP, SEXP MuSEXP, SEXP XmatSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type Mu(MuSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type Xmat(XmatSEXP);
    rcpp_result_gen = Rcpp::wrap(mvrnorm_arma(n, Mu, Xmat));
    return rcpp_result_gen;
END_RCPP
}
// rPlog
NumericVector rPlog(int d, int index, NumericVector theta);
RcppExport SEXP mev_rPlog(SEXP dSEXP, SEXP indexSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(rPlog(d, index, theta));
    return rcpp_result_gen;
END_RCPP
}
// rPneglog
NumericVector rPneglog(int d, int index, NumericVector theta);
RcppExport SEXP mev_rPneglog(SEXP dSEXP, SEXP indexSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(rPneglog(d, index, theta));
    return rcpp_result_gen;
END_RCPP
}
// rPdirmix
NumericVector rPdirmix(int d, int index, NumericMatrix alpha, NumericVector weight);
RcppExport SEXP mev_rPdirmix(SEXP dSEXP, SEXP indexSEXP, SEXP alphaSEXP, SEXP weightSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type weight(weightSEXP);
    rcpp_result_gen = Rcpp::wrap(rPdirmix(d, index, alpha, weight));
    return rcpp_result_gen;
END_RCPP
}
// rPbilog
NumericVector rPbilog(int d, int index, NumericVector alpha);
RcppExport SEXP mev_rPbilog(SEXP dSEXP, SEXP indexSEXP, SEXP alphaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type alpha(alphaSEXP);
    rcpp_result_gen = Rcpp::wrap(rPbilog(d, index, alpha));
    return rcpp_result_gen;
END_RCPP
}
// rPexstud
NumericVector rPexstud(int index, arma::mat sigma, NumericVector al);
RcppExport SEXP mev_rPexstud(SEXP indexSEXP, SEXP sigmaSEXP, SEXP alSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type sigma(sigmaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type al(alSEXP);
    rcpp_result_gen = Rcpp::wrap(rPexstud(index, sigma, al));
    return rcpp_result_gen;
END_RCPP
}
// rPHuslerReiss
NumericVector rPHuslerReiss(int index, arma::mat Lambda);
RcppExport SEXP mev_rPHuslerReiss(SEXP indexSEXP, SEXP LambdaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type Lambda(LambdaSEXP);
    rcpp_result_gen = Rcpp::wrap(rPHuslerReiss(index, Lambda));
    return rcpp_result_gen;
END_RCPP
}
// rPBrownResnick
NumericVector rPBrownResnick(int index, NumericMatrix Sigma);
RcppExport SEXP mev_rPBrownResnick(SEXP indexSEXP, SEXP SigmaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    rcpp_result_gen = Rcpp::wrap(rPBrownResnick(index, Sigma));
    return rcpp_result_gen;
END_RCPP
}
// rPSmith
NumericVector rPSmith(int index, arma::mat Sigma, arma::mat loc);
RcppExport SEXP mev_rPSmith(SEXP indexSEXP, SEXP SigmaSEXP, SEXP locSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type loc(locSEXP);
    rcpp_result_gen = Rcpp::wrap(rPSmith(index, Sigma, loc));
    return rcpp_result_gen;
END_RCPP
}
// rPdir
NumericVector rPdir(int d, int index, NumericVector alpha, bool irv);
RcppExport SEXP mev_rPdir(SEXP dSEXP, SEXP indexSEXP, SEXP alphaSEXP, SEXP irvSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< bool >::type irv(irvSEXP);
    rcpp_result_gen = Rcpp::wrap(rPdir(d, index, alpha, irv));
    return rcpp_result_gen;
END_RCPP
}
// rlogspec
NumericMatrix rlogspec(int n, int d, NumericVector theta);
RcppExport SEXP mev_rlogspec(SEXP nSEXP, SEXP dSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(rlogspec(n, d, theta));
    return rcpp_result_gen;
END_RCPP
}
// rneglogspec
NumericMatrix rneglogspec(int n, int d, NumericVector theta);
RcppExport SEXP mev_rneglogspec(SEXP nSEXP, SEXP dSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(rneglogspec(n, d, theta));
    return rcpp_result_gen;
END_RCPP
}
// rdirmixspec
NumericMatrix rdirmixspec(int n, int d, NumericMatrix alpha, NumericVector weight);
RcppExport SEXP mev_rdirmixspec(SEXP nSEXP, SEXP dSEXP, SEXP alphaSEXP, SEXP weightSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type weight(weightSEXP);
    rcpp_result_gen = Rcpp::wrap(rdirmixspec(n, d, alpha, weight));
    return rcpp_result_gen;
END_RCPP
}
// rbilogspec
NumericMatrix rbilogspec(int n, NumericVector alpha);
RcppExport SEXP mev_rbilogspec(SEXP nSEXP, SEXP alphaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type alpha(alphaSEXP);
    rcpp_result_gen = Rcpp::wrap(rbilogspec(n, alpha));
    return rcpp_result_gen;
END_RCPP
}
// rexstudspec
NumericMatrix rexstudspec(int n, arma::mat sigma, NumericVector al);
RcppExport SEXP mev_rexstudspec(SEXP nSEXP, SEXP sigmaSEXP, SEXP alSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type sigma(sigmaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type al(alSEXP);
    rcpp_result_gen = Rcpp::wrap(rexstudspec(n, sigma, al));
    return rcpp_result_gen;
END_RCPP
}
// rhrspec
NumericMatrix rhrspec(int n, arma::mat Lambda);
RcppExport SEXP mev_rhrspec(SEXP nSEXP, SEXP LambdaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type Lambda(LambdaSEXP);
    rcpp_result_gen = Rcpp::wrap(rhrspec(n, Lambda));
    return rcpp_result_gen;
END_RCPP
}
// rbrspec
NumericMatrix rbrspec(int n, NumericMatrix Sigma);
RcppExport SEXP mev_rbrspec(SEXP nSEXP, SEXP SigmaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    rcpp_result_gen = Rcpp::wrap(rbrspec(n, Sigma));
    return rcpp_result_gen;
END_RCPP
}
// rsmithspec
NumericMatrix rsmithspec(int n, arma::mat Sigma, arma::mat loc);
RcppExport SEXP mev_rsmithspec(SEXP nSEXP, SEXP SigmaSEXP, SEXP locSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type loc(locSEXP);
    rcpp_result_gen = Rcpp::wrap(rsmithspec(n, Sigma, loc));
    return rcpp_result_gen;
END_RCPP
}
// rdirspec
NumericMatrix rdirspec(int n, int d, NumericVector alpha, bool irv);
RcppExport SEXP mev_rdirspec(SEXP nSEXP, SEXP dSEXP, SEXP alphaSEXP, SEXP irvSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< bool >::type irv(irvSEXP);
    rcpp_result_gen = Rcpp::wrap(rdirspec(n, d, alpha, irv));
    return rcpp_result_gen;
END_RCPP
}
// rmevA1
NumericMatrix rmevA1(int n, int d, NumericVector param, int model, NumericMatrix Sigma, arma::mat loc);
RcppExport SEXP mev_rmevA1(SEXP nSEXP, SEXP dSEXP, SEXP paramSEXP, SEXP modelSEXP, SEXP SigmaSEXP, SEXP locSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type param(paramSEXP);
    Rcpp::traits::input_parameter< int >::type model(modelSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type loc(locSEXP);
    rcpp_result_gen = Rcpp::wrap(rmevA1(n, d, param, model, Sigma, loc));
    return rcpp_result_gen;
END_RCPP
}
// rmevA2
NumericMatrix rmevA2(int n, int d, NumericVector param, int model, NumericMatrix Sigma, arma::mat loc);
RcppExport SEXP mev_rmevA2(SEXP nSEXP, SEXP dSEXP, SEXP paramSEXP, SEXP modelSEXP, SEXP SigmaSEXP, SEXP locSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type param(paramSEXP);
    Rcpp::traits::input_parameter< int >::type model(modelSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type loc(locSEXP);
    rcpp_result_gen = Rcpp::wrap(rmevA2(n, d, param, model, Sigma, loc));
    return rcpp_result_gen;
END_RCPP
}
// rmevspec_cpp
NumericMatrix rmevspec_cpp(int n, int d, NumericVector param, int model, NumericMatrix Sigma, arma::mat loc);
RcppExport SEXP mev_rmevspec_cpp(SEXP nSEXP, SEXP dSEXP, SEXP paramSEXP, SEXP modelSEXP, SEXP SigmaSEXP, SEXP locSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type param(paramSEXP);
    Rcpp::traits::input_parameter< int >::type model(modelSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< arma::mat >::type loc(locSEXP);
    rcpp_result_gen = Rcpp::wrap(rmevspec_cpp(n, d, param, model, Sigma, loc));
    return rcpp_result_gen;
END_RCPP
}
// rmevasy
NumericMatrix rmevasy(int n, int d, NumericVector param, LogicalMatrix asym, IntegerVector ncompo, NumericMatrix Sigma, int model);
RcppExport SEXP mev_rmevasy(SEXP nSEXP, SEXP dSEXP, SEXP paramSEXP, SEXP asymSEXP, SEXP ncompoSEXP, SEXP SigmaSEXP, SEXP modelSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type d(dSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type param(paramSEXP);
    Rcpp::traits::input_parameter< LogicalMatrix >::type asym(asymSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type ncompo(ncompoSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Sigma(SigmaSEXP);
    Rcpp::traits::input_parameter< int >::type model(modelSEXP);
    rcpp_result_gen = Rcpp::wrap(rmevasy(n, d, param, asym, ncompo, Sigma, model));
    return rcpp_result_gen;
END_RCPP
}
// Zhang_Stephens
List Zhang_Stephens(NumericVector x, NumericVector init, NumericVector adapt_sd, bool adapt, int burnin, int niter, int thin, int method);
RcppExport SEXP mev_Zhang_Stephens(SEXP xSEXP, SEXP initSEXP, SEXP adapt_sdSEXP, SEXP adaptSEXP, SEXP burninSEXP, SEXP niterSEXP, SEXP thinSEXP, SEXP methodSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type init(initSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type adapt_sd(adapt_sdSEXP);
    Rcpp::traits::input_parameter< bool >::type adapt(adaptSEXP);
    Rcpp::traits::input_parameter< int >::type burnin(burninSEXP);
    Rcpp::traits::input_parameter< int >::type niter(niterSEXP);
    Rcpp::traits::input_parameter< int >::type thin(thinSEXP);
    Rcpp::traits::input_parameter< int >::type method(methodSEXP);
    rcpp_result_gen = Rcpp::wrap(Zhang_Stephens(x, init, adapt_sd, adapt, burnin, niter, thin, method));
    return rcpp_result_gen;
END_RCPP
}
