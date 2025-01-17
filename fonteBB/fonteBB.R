
# FONTE BB ---------------------------------------------------------------------

if (!require("extrafont")) {
  install.packages("extrafont", method = "wininet")
}

library("extrafont")

# Check for BancoDoBrasil Textos font
if (!"BancoDoBrasil Textos" %in% fonts()) {
  # Import and load fonts if BancoDoBrasil Textos is not found
  font_import()
  loadfonts(device = "win")
}

# Fallback to Calibri if BancoDoBrasil Textos is still not found
if (!"BancoDoBrasil Textos" %in% fonts()) {
  windowsFonts(BancoDoBrasil = windowsFont("Calibri"))
  custom_font <- "Calibri"
} else {
  windowsFonts(BancoDoBrasil = windowsFont("BancoDoBrasil Textos"))
  custom_font <- "BancoDoBrasil Textos"
}

# ------------------------------------------------------------------------------
