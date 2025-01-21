# PACKAGES ---------------------------------------------------------------------

packages <- c(
  "httr",
  "jsonlite",
  "countries",
  "ggplot2"
  )

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

conflicts_prefer(dplyr::filter)

# ------------------------------------------------------------------------------

list_fields()

country_info(
  countries = c("USA")
  )

# ------------------------------------------------------------------------------

# Fetch the JSON data from the URL
url <- "https://restcountries.com/v3.1/all"
countries_data <- fromJSON(url, flatten = TRUE)

# Convert to a dataframe
countries_df <- as.data.frame(countries_data)

# Print the first few rows of the dataframe
head(countries_df)

# ------------------------------------------------------------------------------

# Set the path to the downloaded file
file_path <- "all.json"

# Read the JSON file into R
countries_data <- fromJSON(file_path, flatten = TRUE)

# Convert to a dataframe
countries_df <- as.data.frame(countries_data)

# Print the first few rows of the dataframe
head(countries_df)

colnames(countries_df)

# ------------------------------------------------------------------------------

# Get the world map data
world_map <- map_data("world")

# Plot the world map using ggplot2
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "grey50", linewidth = 0.1) +
  theme_minimal() +
  labs(title = NULL, x = NULL, y = NULL) + 
  theme(
    panel.background = element_rect(fill = "lightblue2"), # Paint water masses 
    panel.grid.major = element_blank(), # Remove major grid lines 
    panel.grid.minor = element_blank()) # Remove minor grid lines








