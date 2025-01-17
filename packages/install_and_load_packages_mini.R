
# PACKAGES ---------------------------------------------------------------------

packages <- c('janitor', 'ggplot2', 'readxl', 'writexl')

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# ------------------------------------------------------------------------------
