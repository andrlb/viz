# PACKAGES ---------------------------------------------------------------------

packages <- c("grDevices")

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# ------------------------------------------------------------------------------

# hex to find the closest Rcolour:
hex_code <- "#B6DCF3" # Hex code

closest_Rcolour <- function(hex) {
  # Convert the hex code to RGB
  rgb_value <- col2rgb(hex)
  
  # Get the list of all colors and their RGB values
  color_names <- grDevices::colours()
  color_values <- t(grDevices::col2rgb(color_names))
  
  # Calculate the Euclidean distance between the RGB values
  distances <- sqrt(rowSums((color_values - matrix(rgb_value, nrow = nrow(color_values), ncol = 3, byrow = TRUE))^2))
  
  # Find the index of the closest color
  closest_index <- which.min(distances)
  
  # Return the name of the closest color
  closest_Rcolour <- color_names[closest_index]
  return(closest_Rcolour)
}

# Example usage
closest_Rcolour(hex_code)