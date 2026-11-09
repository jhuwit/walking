# walking 0.9.0

* Removed `magrittr` dependency; now uses the native pipe `|>`.
* Now requires R (>= 4.1.0).
* Fixed `verisense_count_steps(peak_finder = "fast")` accepting a peak within
  `k / 2` samples of the start of the signal, which the `"original"` finder
  (and the reference Verisense implementation) rejects. The two finders now
  give identical results.

# walking 0.8.1

* Typo in the new argument for disabling parallelization for python call.

# walking 0.8.0

* Removed parallelization option for `oak`.

# walking 0.7.0

* Reworked `walking` to use `actibase` functions now in CRAN.
* Submitting to CRAN.

# walking 0.4.0

* New `reticulate` initialization.
* Removing `install_forest` and the like.
* Initial CRAN submission.
