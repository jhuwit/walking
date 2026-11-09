# Call py_require_forest but do cleanup for CRAN
walking::py_require_forest()
# Check for forest once: each py_module_available() call on a broken
# environment retries the (slow, failing) uv build and recreates lock files
options(walking.test_have_forest = isTRUE(suppressWarnings(walking::have_forest())))
walking:::cleanup_uv_lock_files()
