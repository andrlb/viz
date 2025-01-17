
# PACKAGES ---------------------------------------------------------------------

packages <- c("beepr",
              "readxl",
              "tidyverse",
              "writexl",
              "ggplot2",
              "openxlsx"
)

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# COLOURS ----------------------------------------------------------------------

colours <- list(
  
# PALETA BB
  
  "bb-amarelo"      = "#FCFC30",
  "bb-amarelo-claro"= "#FFF7B5",
  "bb-azul-escuro"  = "#3333BD",
  "bb-azul"         = "#465EFF",
  "bb-roxo-escuro"  = "#735CC6",
  "bb-roxo-claro"   = "#BDB6FF",
  "bb-verde-escuro" = "#00EBD0",  
  "bb-verde-claro"  = "#83FFEA",
  "bb-rosa-escuro"  = "#FF6E91",
  "bb-rosa-claro"   = "#FFA7D3",
  "bb-azul-claro"   = "#54DCFC",
  "branco"          = "#FFFFFF",
  
# PALETA BB ESTILO

  "bb-estilo-azulS"   = "#0F2846",
  "bb-estilo-azulE"   = "#467DC3",
  "bb-estilo-areiaT"  = "#D7D2CD",
  "bb-estilo-amarelo" = "#FCFC30",
  
  
# 50 SHADES OF GREY

  "black"           = "#000000",
  "cinza-claro"     = "#E5E5E5",
  "cinza-azulado"   = "#99ABB7",

  # cinza excel:
  'cinza-50%' = '#808080',
  'cinza-35%' = '#595959',
  'cinza-25%' = '#404040',
  'cinza-15%' = '#262626',
  'cinza-05%' = '#0D0D0D',
  'cinza-00%' = '#000000',
  
  # cinza R:
  'grey100' = 'grey100',
  'grey90'  = 'grey90',
  'grey80'  = 'grey80',
  'grey70'  = 'grey70',
  'grey60'  = 'grey60',
  'grey50'  = 'grey50',
  'grey40'  = 'grey40',
  'grey30'  = 'grey30',
  'grey20'  = 'grey20',
  'grey10'  = 'grey10',
  'grey0'   = 'grey0',


  # mapa mundi
  "denim-claro"     = "#E5EDF4",
  "azul-oceano"     = "#2E6CA4",
  "azul-marinho"    = "#002D4B",
  
  # mapa da apresentação
  "uf-destaque"     = "#4179AC",
  "uf-outros"       = "#B3C9DE",
  
  # IDE IPE
  "ide-ipe-rosa"    = "#B47D7D",
  "ide-ipe-amber"   = "#FFC000",
  "ide-ipe-verde"   = "#5AAA90",
  "ide-ipe-azul"    = "#002D4B",
  
  # IFDM:
  "ifdm-laranja"    = "#FF7271",
  "ifdm-amarelo"    = "#FFDE72",
  "ifdm-azul"       = "#5BD4FF",
  "ifdm-verde"      = "#B9E08D",
  
  # inmetro
  "inmetro-DarkRed"    = "#C00000",
  "inmetro-RedOrange"  = "#FF3200",
  "inmetro-DarkOrange" = "#FF6000",
  "inmetro-Orange"     = "#FFA000",
  "inmetro-LightOrange"= "#FFC03C",
  "inmetro-PaleYellow" = "#FFFAAA",
  "inmetro-Gray"       = "#A5A5A5",
  "inmetro-PaleCyan"   = "#E1FFFF",
  "inmetro-LightBlue"  = "#B4F0FA",
  "inmetro-SkyBlue"    = "#96D2FA",
  "inmetro-MediumBlue" = "#50A5F5",
  "inmetro-Blue"       = "#1E6EEB",
  "inmetro-DarkBlue"   = "#0000CD",
  
  # bancos
  Caixa     = "#1C60AB",
  Caixa2    = "#E97715",
  Santander = "#EC0000", 
  Bradesco  = "#CC092F",
  Bradesco2 = "#B81570",
  Itau      = "#FF6001"
  
)

# SAVE TO RDATA ----------------------------------------------------------------

# Save into a .RData file:
save(
  colours,
  file = "colours.rdata")

# load: 
load("colours.rdata")

# SAVE TO XLSX -----------------------------------------------------------------

# Convert to dataframe
df_colours <- do.call(rbind, lapply(names(colours), function(name) {
  data.frame(cor = name, codigo = colours[[name]])
}))

# Adicionar a quarta coluna com o código da cor entre aspas
df_colours$codigo_com_aspas <- paste0('"', df_colours$codigo, '"')

# Create a workbook
wb <- createWorkbook()

# Add a worksheet
addWorksheet(wb, "Sheet1")

# Write the dataframe
writeData(wb, "Sheet1", df_colours)

# Apply colors to the third column based on the second column
for (i in 1:nrow(df_colours)) {
  color_style <- createStyle(fgFill = df_colours$codigo[i], fontColour = df_colours$codigo[i])
  writeData(wb, "Sheet1", df_colours$codigo[i], startCol = 4, startRow = i + 1, colNames = FALSE)
  addStyle(wb, "Sheet1", style = color_style, rows = i + 1, cols = 4, gridExpand = TRUE)
}

# Save the workbook
saveWorkbook(wb, "colours.xlsx", overwrite = TRUE)

# SAVE TO PNG ------------------------------------------------------------------

# Calculate the number of rows and columns in the grid
n <- ceiling(sqrt(length(colours)))

# Create a grid of positions manually to preserve the order
x <- rep(1:n, each = n)
y <- rev(rep(1:n, times = n))  # Reverse the y positions here
grid <- data.frame(x = x[1:length(colours)], y = y[1:length(colours)])

# Create a data frame with the colors and positions
df <- data.frame(
  color = factor(names(colours), levels = names(colours)),  # Keep the original order of colors
  count = rep(1, length(colours)),  # Equal count for each color
  x = grid$x,  # x position
  y = grid$y  # y position
)

# Function to calculate the luminance of a color
luminance <- function(color) {
  rgb <- col2rgb(colours[[color]])
  0.299*rgb[1,] + 0.587*rgb[2,] + 0.114*rgb[3,]
}

# Function to choose a readable color for the text
text_color <- function(color) {
  ifelse(luminance(color) > 128, "black", "white")
}

# Create the plot with squares
p <- ggplot(df, aes(x = x, y = y, fill = color)) +
  geom_tile(color = "black", lwd = 0.5) +  # Create the squares
  # geom_text(aes(label = color, color = sapply(color, text_color)), size = 4) +  # Add the color names
  geom_text(aes(label = paste(color, "\n", colours[color], sep = ""), color = sapply(color, text_color)), size = 2.5) +  # Add color names and RGB codes
  scale_fill_manual(values = unlist(colours)) +  # Use the color palette
  scale_color_identity() +  # Use the color specified in geom_text
  theme_void() +  # Remove axes and labels
  theme(plot.background = element_rect(fill = "black"),  # Set the background to black
        legend.position = "none")  # Remove the legend

# Display the plot
plot(p)

# Save the plot as a PNG file
ggsave("colours.png", plot = p, width = 10, height = 10, dpi = 300)

# Save the plot as a PDF file
ggsave("colours.pdf", plot = p, width = 10, height = 10, device = "pdf")

# END --------------------------------------------------------------------------

# Play the "coin" sound
beep(sound = "coin")
