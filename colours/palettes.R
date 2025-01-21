
# PACKAGES ---------------------------------------------------------------------

packages <- c('ggplot2', 'RColorBrewer', 'viridis', 'ggsci', 'wesanderson',
              'paletteer')

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# ------------------------------------------------------------------------------

library(RColorBrewer)

# Display all available color palettes
display.brewer.all()

# Use a specific palette
palette <- brewer.pal(9, "Set1")
print(palette)

# ------------------------------------------------------------------------------

# Install and load the package
library(viridis)

# Use a viridis palette
colors <- viridis(5)
print(colors)

# Visualize with a plot
barplot(1:5, col=viridis(5))


# ------------------------------------------------------------------------------

# Install and load the package
library(ggsci)

# Use a palette from Nature
palette <- pal_npg("nrc")(9)
print(palette)

# Visualize with a plot
barplot(1:9, col=palette)


# ------------------------------------------------------------------------------
# Install and load the package
library(wesanderson)

# Use a palette inspired by the film "Moonrise Kingdom"
palette <- wes_palette("Moonrise1")
print(palette)

# Visualize with a plot
barplot(1:length(palette), col=palette)


# ------------------------------------------------------------------------------

# Install and load the package
library(paletteer)

# Use a palette from ggthemes
palette <- paletteer_d("ggthemes::Tableau_20")
print(palette)

# Visualize with a plot
barplot(1:20, col=palette)

# ------------------------------------------------------------------------------

