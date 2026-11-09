cleanup_uv_lock_files = function(paths = c(".", tempdir(), dirname(tempdir()))) {
  paths = unique(normalizePath(paths, winslash = "/", mustWork = FALSE))
  paths = paths[dir.exists(paths)]

  lock_files = unlist(lapply(paths, function(path) {
    list.files(
      path = path,
      pattern = "^uv.*[.]lock$",
      full.names = TRUE,
      recursive = TRUE,
      include.dirs = FALSE
    )
  }))
  lock_files = unique(lock_files[file.exists(lock_files)])

  if (length(lock_files) > 0) {
    unlink(lock_files, force = TRUE)
    invisible(!file.exists(lock_files))
  } else {
    invisible(logical())
  }
}

oak_base = function() {
  # checking/importing forest can trigger a uv environment build that
  # leaves uv-*.lock files in the temp directory (e.g. a failed numba build)
  on.exit(cleanup_uv_lock_files(), add = TRUE)
  if (!reticulate::py_module_available("forest")) {
    stop(
      "Python package 'forest' is not installed in the active reticulate environment. ",
      "Install it yourself before calling walking functions that use forest.\n",
      "If installation fails with \"clang++: error: unsupported option '-fopenmp'\", ",
      "that is a Python toolchain/OpenMP problem, not a walking problem.\n",
      "Use a Python environment where forest and numba/llvmlite already resolve cleanly, ",
      "then point reticulate at that environment.\n",
      "See https://github.com/onnela-lab/forest/issues/293 and ",
      "https://github.com/numba/llvmlite/issues/1389."
    )
  }
  fr = reticulate::import("forest")
  oak = fr$oak$base
  oak
}

# oak_base_noconvert = function() {
#   fr = reticulate::import("forest", convert = FALSE)
#   oak = fr$oak$base
#   oak
# }
