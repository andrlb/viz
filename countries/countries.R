# ------------------------------------------------------------------------------
# PACKAGES
# ------------------------------------------------------------------------------

source("C:/Users/F0738707/OneDrive - Banco do Brasil S.A/_myRtools/packages/install_and_load_packages.R")

install_and_load_packages(
  "rvest", "tidyverse", "readxl", "writexl", "ISOcodes", "stringr"
)

# ------------------------------------------------------------------------------

folder = "C:/Users/F0738707/OneDrive - Banco do Brasil S.A/_myRtools/countries"

setwd(folder)

# ------------------------------------------------------------------------------

# Get the ISO 3166 country codes
country_codes <- ISO_3166_1

# View the first few rows of the country codes data frame
head(country_codes)

# ------------------------------------------------------------------------------

# Define the URL of the site
url <- "https://lingualid.com/countries-and-nationalities-in-brazilian-portuguese/"

# Read the HTML content of the page
webpage <- read_html(url)

# Extract the table rows containing country names
table_rows <- webpage %>%
  html_nodes("table tr")

# Extract the text from each row
countries <- table_rows %>%
  html_nodes("td") %>%
  html_text(trim = TRUE)

# Clean and format the country names
countries <- matrix(countries, ncol = 4, byrow = TRUE) %>%
  as.data.frame(stringsAsFactors = FALSE)

# Assign column names from the first row and remove the first row
colnames(countries) <- countries[1, ]
countries <- countries[-1, ]

colnames(countries)

# Remove rows with NA values and rows with empty strings
countries2 <- countries %>% drop_na() %>% filter_all(all_vars(. != "")) %>%
  rename(
    Country_EN = "Country",
    Country_PT = "Country (Portuguese)",
    Nationality_PT_male = "Nationality in Portuguese (masculine)",
    Nationality_PT_female = "Nationality in Portuguese (feminine)"
    
  )

# ------------------------------------------------------------------------------

# Create a dataframe mapping Alpha-3 codes to English country names (for merging)
country_code_map <- country_codes %>%
  select(Alpha_3, Name) %>%
  setNames(c("Alpha_3", "Country_EN"))

# Merge the countries dataframe with the country_code_map
country_codes_translated <- country_code_map %>%
  left_join(countries2, by = "Country_EN")

# Add the Country_Portuguese column to the original country_codes dataframe
country_codes <- country_codes %>%
  left_join(country_codes_translated %>% 
              select(colnames(country_codes_translated)), by = "Alpha_3")

# View the first few rows of the updated country_codes dataframe
head(country_codes)

# ------------------------------------------------------------------------------

countries_PT = country_codes %>% filter(is.na(Country_PT))

glimpse(countries_PT)

# Define the translations
# translations <- c(
#   "Aruba", "Anguilla", "Ilhas Åland", "Samoa Americana", "Antártica", 
#   "Territórios Franceses do Sul", "Bonaire, Santo Eustáquio e Saba", 
#   "Bahamas", "São Bartolomeu", "Bermudas", "Bolívia, Estado Plurinacional da", 
#   "Brunei Darussalam", "Ilha Bouvet", "Ilhas Cocos (Keeling)", "Costa do Marfim", 
#   "Congo, República Democrática do", "Ilhas Cook", "Curaçao", "Ilha Christmas", 
#   "Ilhas Cayman", "Tchéquia", "República Dominicana", "Saara Ocidental", 
#   "Ilhas Malvinas (Falkland)", "Ilhas Faroé", "Guernsey", "Gibraltar", "Guadalupe", 
#   "Gâmbia", "Groenlândia", "Guiana Francesa", "Guam", "Hong Kong", 
#   "Ilha Heard e Ilhas McDonald", "Ilha de Man", "Território Britânico do Oceano Índico", 
#   "Irã, República Islâmica do", "Israel", "Jersey", "Coreia, República da", 
#   "Laos, República Democrática Popular", "Macau", "São Martinho (parte Francesa)", 
#   "Moldávia, República da", "Mianmar", "Ilhas Marianas do Norte", "Montserrat", 
#   "Martinica", "Mayotte", "Nova Caledônia", "Ilha Norfolk", "Niue", "Pitcairn", 
#   "Porto Rico", "Coreia, República Popular Democrática da", "Palestina, Estado da", 
#   "Polinésia Francesa", "Reunião", "Federação Russa", "Geórgia do Sul e Ilhas Sandwich do Sul", 
#   "Santa Helena, Ascensão e Tristão da Cunha", "Svalbard e Jan Mayen", "São Pedro e Miquelon", 
#   "Sudão do Sul", "São Martinho (parte Holandesa)", "República Árabe da Síria", 
#   "Ilhas Turcas e Caicos", "Tokelau", "Timor-Leste", "Turquia", "Taiwan, Província da China", 
#   "Tanzânia, República Unida da", "Ilhas Menores Distantes dos Estados Unidos", 
#   "Santa Sé (Estado da Cidade do Vaticano)", "Venezuela, República Bolivariana da", 
#   "Ilhas Virgens Britânicas", "Ilhas Virgens Americanas", "Vietnã", "Wallis e Futuna"
# )

translations <- c(
  "Aruba", "Anguilla", "Ilhas Åland", "Samoa Americana", "Antártica", 
  "Territórios Franceses do Sul", "Bonaire, Santo Eustáquio e Saba", 
  "Bahamas", "São Bartolomeu", "Bermudas", "Bolívia", 
  "Brunei Darussalam", "Ilha Bouvet", "Ilhas Cocos (Keeling)", "Costa do Marfim", 
  "Congo, República Democrática do", "Ilhas Cook", "Curaçao", "Ilha Christmas", 
  "Ilhas Cayman", "República Tcheca", "República Dominicana", "Saara Ocidental", 
  "Ilhas Malvinas", "Ilhas Faroé", "Guernsey", "Gibraltar", "Guadalupe", 
  "Gâmbia", "Groenlândia", "Guiana Francesa", "Guam", "Hong Kong", 
  "Ilha Heard e Ilhas McDonald", "Ilha de Man", "Território Britânico do Oceano Índico", 
  "Irã", "Israel", "Jersey", "Coreia do Sul", 
  "Laos", "Macau", "São Martinho (parte Francesa)", 
  "Moldávia", "Mianmar", "Ilhas Marianas do Norte", "Montserrat", 
  "Martinica", "Mayotte", "Nova Caledônia", "Ilha Norfolk", "Niue", "Pitcairn", 
  "Porto Rico", "Coreia do Norte", "Palestina", 
  "Polinésia Francesa", "Reunião", "Federação Russa", "Geórgia do Sul e Ilhas Sandwich do Sul", 
  "Santa Helena, Ascensão e Tristão da Cunha", "Svalbard e Jan Mayen", "São Pedro e Miquelon", 
  "Sudão do Sul", "São Martinho (parte Holandesa)", "Síria", 
  "Ilhas Turcas e Caicos", "Tokelau", "Timor-Leste", "Turquia", "Taiwan", 
  "Tanzânia", "Ilhas Menores Distantes dos Estados Unidos", 
  "Santa Sé (Estado da Cidade do Vaticano)", "Venezuela", 
  "Ilhas Virgens Britânicas", "Ilhas Virgens Americanas", "Vietnã", "Wallis e Futuna"
)

# Add the translations to the dataframe
countries_PT$Country_PT <- translations

# View the updated dataframe
head(countries_PT)

# ------------------------------------------------------------------------------

# Merge the updated dataframe with country_codes 
country_codes <- country_codes %>% 
  left_join(countries_PT %>% select(Alpha_3, Country_PT), by = "Alpha_3") %>% 
  mutate(Country_PT = coalesce(Country_PT.x, Country_PT.y)) %>% 
  select(-Country_PT.x, -Country_PT.y)

# View the first few rows of the updated country_codes dataframe
colnames(country_codes)

country_codes <- country_codes %>%
  select(Alpha_2, Alpha_3, Numeric, Country_EN, Country_PT, everything())

# Visualize as primeiras linhas do dataframe reordenado
head(country_codes)

# ------------------------------------------------------------------------------

save(country_codes, 
     file = file.path(folder, "country_codes.rdata")
       )

load(
  file.path(folder, "country_codes.rdata")
  )

# ------------------------------------------------------------------------------































