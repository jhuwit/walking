skip_if_no_forest <- function() {
  if (!reticulate::py_module_available("forest")) {
    testthat::skip(
      "forest is not installed in the active reticulate environment; see forest issue #293 and llvmlite issue #1389."
    )
  }
}
