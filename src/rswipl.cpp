#include <SWI-cpp.h>
#include "Rcpp.h"
using namespace Rcpp ;

// The SWI system should not be initialized twice; therefore, we keep track of
// its status.
bool pl_initialized = false ;

// Initialize SWI-prolog. This needs a list of the command-line arguments of 
// the calling program, the most important being the name of the main 
// executable, argv[0]. I added "-q" to suppress SWI prolog's welcome message
// which is shown in .onAttach anyway.
// [[Rcpp::export(.init)]]
LogicalVector init_(String argv0)
{
  if(pl_initialized)
    warning("Please do not initialize SWI-prolog twice in the same session.") ;
  
  // Prolog documentation requires that argv is accessible during the entire 
  // session. I assume that this pointer is valid during the whole R session,
  // and that I can safely cast it to const.
  const int argc = 2 ;
  const char* argv[argc] ;
  argv[0] = argv0.get_cstring() ;
  argv[1] = "-q" ;
  if(!PL_initialise(argc, (char**) argv))
    stop("rswipl_init: initialization failed.") ;

  pl_initialized = true ;  
  return true ;
}

// [[Rcpp::export(.done)]]
LogicalVector done_()
{
  if(!pl_initialized)
  {
    warning("rswipl_done: swipl has not been initialized") ;
    return true ;
  }

  PL_cleanup(0) ;
  pl_initialized = false ;
  return true ;
}
