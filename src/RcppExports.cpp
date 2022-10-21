#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// init_
LogicalVector init_(String argv0);
RcppExport SEXP _rswipl_init_(SEXP argv0SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< String >::type argv0(argv0SEXP);
    rcpp_result_gen = Rcpp::wrap(init_(argv0));
    return rcpp_result_gen;
END_RCPP
}
// done_
LogicalVector done_();
RcppExport SEXP _rswipl_done_() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(done_());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rswipl_init_", (DL_FUNC) &_rswipl_init_, 1},
    {"_rswipl_done_", (DL_FUNC) &_rswipl_done_, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_rswipl(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}