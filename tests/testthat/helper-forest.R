skip_if_no_forest <- function() {
  if (!isTRUE(getOption("walking.test_have_forest", FALSE))) {
    testthat::skip(
      "forest is not installed in the active reticulate environment; see forest issue #293 and llvmlite issue #1389."
    )
  }
}
