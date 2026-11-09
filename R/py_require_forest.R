#' Require Forest module
#'
#' @param python_version Python version to use, passed to [reticulate::py_require()]
#' @param ... additional arguments passed to [reticulate::py_require()]
#'
#' @returns invisible NULL
#' @export
#'
#' @examples
#' \donttest{
#' files <- list.files()
#' py_require_forest()
#' walking:::cleanup_uv_lock_files()
#' stopifnot(length(setdiff(list.files(), files)) == 0L)
#' }
py_require_forest = function(python_version = "3.11", ...) {
  on.exit(cleanup_uv_lock_files(), add = TRUE)
  reticulate::py_require(
    c(
      "git+https://github.com/onnela-lab/forest@45fb41038bd46c25d9e6a4442aa74fa03b501317",
      intel_mac_pins()
    ),
    python_version = python_version,
    ...)
}

# numba >= 0.63 and llvmlite >= 0.46 do not ship macOS x86_64 wheels, so
# uv falls back to source builds that fail with Apple clang
# ("unsupported option '-fopenmp'").  Pin to the last releases with
# Intel Mac wheels.  See https://github.com/numba/numba/issues/10187
intel_mac_pins = function(
    sysname = Sys.info()[["sysname"]],
    machine = Sys.info()[["machine"]]) {
  if (identical(sysname, "Darwin") && machine %in% c("x86_64", "i386")) {
    c("numba==0.62.1", "llvmlite==0.45.1")
  } else {
    character(0)
  }
}
