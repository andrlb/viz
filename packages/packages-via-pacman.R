# source("C:/andre/assessoria/2_tools/packages.R")

if(!require("pacman")) install.packages("pacman")

pacman::p_load(
  
# Data Manipulation and Analysis
  tidyverse, # suite of packages designed for data science
             # loads: ggplot2, dplyr, tidyr, readr,
             #        purrr, tibble, stringr, forcats
  
  reshape2,  # Data restructuring
  
# Data Visualization
  ggthemes,  # extra themes, scales and geoms for ggplot
  ggpubr,    # nice commands for ggplot2

# Geographic Data
  geobr,     # read geographic data from Brazil
  sf,        # support for spatial vector data
  
# World Geographic Data
  rnaturalearth, # world map data from Natural Earth
  rnaturalearthdata,

# Brazilian Data
  sidrar,     # Access data from SIDRA IBGE
  GetBCBData, # Access data from BACEN
  rbcb,       # Access data from BACEN

# Date and Time Manipulation
  lubridate, # Date-time data manipulation  

# Excel Data Interaction
  readxl,    # read from xlsx
  writexl,   # write to xlsx
  openxlsx,  # read, write and edit XLSX files, keeping the format

# Paralel Computing:
  furrr,     # parallel mapping
  httr,      # HTTP tools

# Econometrics
  forecast,  # Time Series Analysis
  plm,       # Linear models for panel data
  seasonal,  # Seasonal adjustment

# Web acrapping
  rvest,     # download and manipulate HTML and XML
  
# Miscellaneous
  calendR,      # calendários
  pryr,         # Tools for Computing
  RColorBrewer, # Color schemes for maps and graphics 
  extrafont,    # Use non-standard fonts
  scales,       # comma in numbers
  kableExtra,   # nice tables
  beepr         # beep

)

cat("para instalar pacotes dentro da rede do banco, use este comando: \ninstall.packages(\"nome-do-pacote\", method = \"wininet\")\n")
