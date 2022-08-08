# `cacc`: Conjunctive Analysis of Case Configurations

An R Package to compute Conjunctive Analysis of Case Configurations (CACC), Situational Clustering Tests, and Main Effects

# Description

This R package contains a set of functions to conduct Conjunctive Analysis of Case Configurations (CACC) (Miethe, Hart & Regoeczi, 2008), to identify and quantify situational clustering in dominant case configurations (Hart, 2019), and to determine the main effects of specific variable values on the probabilities of outcome (Hart, Rennison & Miethe, 2017). Initially conceived as an exploratory technique for multivariate analysis of categorical data, CACC has developed to include formal statistical tests that can be applied in a wide variety of contexts. This technique allows examining composite profiles of different units of analysis in an alternative way to variable-oriented methods.

# Installation

You can install the latest development version of the package directly from GitHub with `devtools`:

```{r}
# Check if the `devtools` package needs to be installed
if (!require("devtools")) install.package("devtools")

# Install the `cacc` package from GitHub
devtools::install_github("amoneva/cacc")
```
