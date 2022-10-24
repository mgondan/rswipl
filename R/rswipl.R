# Load libswipl.dll/so on startup
# 
# This cannot be delegated to a useDynLib directive in NAMESPACE (at least not
# under linux). The reason is that rolog.so itself is able to load other 
# packages (i.e. prolog libraries), and therefore exports a number of 
# prolog-specific symbols. The additional option local=FALSE makes sure these
# symbols are imported on startup. This option is not available in if we use
# useDynLib in NAMESPACE.
#
.onLoad <- function(libname, pkgname)
{
  # Load libswipl.dylib under Linux and macOS
  if(.Platform$OS.type == "unix")
  {
    # Find folder like x86_64-linux
    fp <- file.path(libname, pkgname, "swipl", "lib", "swipl", "lib")
    arch <- R.version$arch
    if(arch == 'aarch64')
      arch <- 'arm64'
    folder <- dir(fp, pattern=arch, full.names=TRUE)
    if(!length(folder) & arch == "arm64")
      folder <- dir(fp, pattern="aarch64-linux", full.names=TRUE)	

    # Preload libswipl.dll
    if(R.version$os == "linux-gnu")
      dyn.load(file.path(folder, paste("libswipl", .Platform$dynlib.ext, sep="")))
    else
      dyn.load(file.path(folder, "libswipl.dylib")) # macOS
  }
	
  if(.Platform$OS.type == "windows")
  {
    folder <- file.path(libname, pkgname, "swipl", "bin")
    dyn.load(file.path(folder, paste("libswipl", .Platform$dynlib.ext, sep="")))
  }

  invisible()
}

.onUnload <- function(libpath)
{
  if(.Platform$OS.type == "unix")
  {
    fp <- file.path(libpath, "swipl", "lib", "swipl", "lib")
    arch <- R.version$arch
    if(arch == 'aarch64')
      arch <- 'arm64'
    folder <- dir(fp, pattern=arch, full.names=TRUE)
    if(!length(folder) & arch == "arm64")
      folder <- dir(fp, pattern="aarch64-linux", full.names=TRUE)	

    if(R.version$os == "linux-gnu")
      dyn.unload(file.path(folder, paste("libswipl", .Platform$dynlib.ext, sep="")))
    else
      dyn.unload(file.path(folder, "libswipl.dylib")) # macOS
  }
	
  if(.Platform$OS.type == "windows")
  {
    folder <- file.path(libpath, "swipl", "bin")
    dyn.unload(file.path(folder, paste("libswipl", .Platform$dynlib.ext, sep="")))
  }

  # Load rswipl.dll/so
  library.dynam(chname="rswipl", package=pkgname, lib.loc=libname, local=FALSE)
  invisible()
}

.onAttach <- function(libname, pkgname)
{
  if(.Platform$OS.type == "unix")
    Sys.setenv(SWI_HOME_DIR=file.path(libname, pkgname, "swipl", "lib", "swipl"))

  if(.Platform$OS.type == "windows")
    Sys.setenv(SWI_HOME_DIR=file.path(libname, pkgname, "swipl"))
  
  invisible()
}

.onDetach <- function(libpath)
{
  Sys.unsetenv("SWI_HOME_DIR")
}

#' Start SWI-Prolog
#'
#' @param argv1
#' file name of the R executable
#'
#' @return
#' `TRUE` on success
#' 
#' @details 
#' SWI-prolog is automatically initialized when this library is loaded, so
#' the function below is normally not directly invoked.
#'
rswipl_init <- function(argv1=commandArgs()[1])
{
  .init(argv1)
}

#' Clean up when detaching the library
#' 
#' @return
#' `TRUE` on success
rswipl_done <- function()
{
  .done()
}
