# ------------------------------------------------------------------------------

# use this in your script:
# source("https://raw.githubusercontent.com/andrlb/_myRtools/refs/heads/main/packages/install_and_load_packages.R")

# Example usage:
# install_and_load_packages("dplyr", "ggplot2")

# ------------------------------------------------------------------------------

# Define a function to install and update packages
install_and_load_packages <- function(...) {
  packages <- c(...)
  
  for (pkg in packages) {
    if (!suppressMessages(suppressWarnings(require(pkg, character.only = TRUE)))) {
      install.packages(pkg, method = "wininet")
      library(pkg, character.only = TRUE)
    } 
  } 
  message(
    " Example usage:\n install_and_load_packages(\"dplyr\", \"ggplot2\") \n All packages installed and loaded."
    )
}

# ------------------------------------------------------------------------------
  
# Define a function to install and update packages
# install_and_load_packages <- function(...) {
#   packages <- c(...)
#     
#     for (pkg in packages) {
#       if (!require(pkg, character.only = TRUE)) {
#         install.packages(pkg, method = "wininet")
#         library(pkg, character.only = TRUE)
#       } 
#     } 
#     message(
#       " Example usage:\n install_and_load_packages(\"dplyr\", \"ggplot2\") \n All packages installed and loaded."
#     )
#   }  
  
# ------------------------------------------------------------------------------

# packages = c(
#   # Data Manipulation and Analysis
#   "tidyverse", # suite of packages designed for data science
#                # loads: ggplot2, dplyr, tidyr, readr,
#                #        purrr, tibble, stringr, forcats
#   
#   "reshape2",  # Data restructuring
#   "janitor",   # data cleaning
#   
#   # Data Visualization
#   "ggthemes",  # extra themes, scales and geoms for ggplot
#   "ggpubr",    # nice commands for ggplot2
#   
#   # Geographic Data
#   "geobr",     # read geographic data from Brazil
#   "sf",        # support for spatial vector data
#   
#   # World Geographic Data
#   "rnaturalearth", # world map data from Natural Earth
#   "rnaturalearthdata",
#   
#   # Brazilian Data
#   "sidrar",     # Access data from SIDRA IBGE
#   "GetBCBData", # Access data from BACEN
#   "rbcb",       # Access data from BACEN
#   
#   # Date and Time Manipulation
#   "lubridate", # Date-time data manipulation  
#   
#   # Excel Data Interaction
#   "readxl",    # read from xlsx
#   "writexl",   # write to xlsx
#   "openxlsx",  # read, write and edit XLSX files, keeping the format
#   
#   # Parallel Computing:
#   "furrr",     # parallel mapping
#   "httr",      # HTTP tools
#   
#   # Econometrics
#   "forecast",  # Time Series Analysis
#   "plm",       # Linear models for panel data
#   "seasonal",  # Seasonal adjustment
#   
#   # Web Scraping
#   "rvest",     # download and manipulate HTML and XML
#   
#   # Miscellaneous
#   "calendR",      # calendars
#   "pryr",         # Tools for Computing
#   "RColorBrewer", # Color schemes for maps and graphics 
#   "extrafont",    # Use non-standard fonts
#   "scales",       # comma in numbers
#   "kableExtra",   # nice tables
#   "beepr"         # beep
# )