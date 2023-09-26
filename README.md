# GENERAL INFORMATION

This README.md file was updated on 2023 September 11 by György Barabás.

## A. Paper associated with this archive

Parameter sensitivity of transient community dynamics


## B. Originator

György Barabás

- Division of Ecological and Environmental Modeling, Linköping University, Linköping, Sweden
- Institute of Evolution, Centre for Ecological Research, Budapest, Hungary


## C. Contact information

György Barabás

Linköping University, SE-58183 Linköping, Sweden

`gyorgy.barabas@liu.se`


## F. Funding Sources

Swedish Research Council (Vetenskapsrådet), grant VR 2017-05245


# ACCESS INFORMATION

## 1. License information

MIT License

Copyright (c) 2023 György Barabás

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## 2. Recommended citation for this code archive

xxx



# CODE FILE OVERVIEW

This repository consist of three code scripts and this README document

## Code scripts and workflow

1. `transient-sensitivity-analysis.m`: This file is a Mathematica package of routines implementing the elements of transient sensitivity analysis. It is used by the notebook file `examples.nb` (see below).
2. `examples.nb`: A Mathematica notebook file which utilizes the routines in `transient_sensitivity_analysis.m` in performing transient sensitivity analysis on three model examples.
3. `annual-plant-correlation.R`: An R script to explore the dependence of the correlation between population densities and sensitivities to perturbing the the death rate of the forb in the seed bank, in the annual plant model. It is stand-alone and will run independently of the other scripts above.


# SOFTWARE VERSIONS

The Mathematica package and notebook have been tested with Wolfram Mathematica 12.0.0.0, under Linux x86 (64 bit). However, it should work with earlier versions of Mathematica as well, and on different platforms.

The R script requires R 4.1 or higher. It also requires the `tidyverse` package suite and the `deSolve` package. Session information after running the script:

```
R version 4.2.2 (2022-10-31)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Monterey 12.6.7

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
 [1] deSolve_1.34    lubridate_1.9.2 forcats_1.0.0   stringr_1.5.0   dplyr_1.1.2
 [6] purrr_1.0.1     readr_2.1.4     tidyr_1.3.0     tibble_3.2.1    ggplot2_3.4.2
[11] tidyverse_2.0.0

loaded via a namespace (and not attached):
 [1] rstudioapi_0.14  magrittr_2.0.3   hms_1.1.2        tidyselect_1.2.0 munsell_0.5.0
 [6] timechange_0.1.1 colorspace_2.0-3 R6_2.5.1         rlang_1.1.1      fansi_1.0.3
[11] tools_4.2.2      grid_4.2.2       gtable_0.3.1     utf8_1.2.2       cli_3.6.1
[16] withr_2.5.0      ellipsis_0.3.2   lifecycle_1.0.3  farver_2.1.1     tzdb_0.3.0
[21] vctrs_0.6.2      glue_1.6.2       labeling_0.4.2   stringi_1.7.8    compiler_4.2.2
[26] pillar_1.9.0     generics_0.1.3   scales_1.2.1     pkgconfig_2.0.3
```
