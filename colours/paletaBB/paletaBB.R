# PACKAGES ---------------------------------------------------------------------

packages <- c('grid', 'ggplot2', 'beepr')

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# COLOURS ----------------------------------------------------------------------

# Define colors as a list
paletaBB <- list(
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
  "bb-estilo-azulS"   = "#0F2846",
  "bb-estilo-azulE"   = "#467DC3",
  "bb-estilo-areiaT"  = "#D7D2CD",
  "bb-estilo-amarelo" = "#FCFC30"
)

# PARAMETERS -------------------------------------------------------------------

# Define the size of the squares
square_size <- 0.40
columns = 2
rows = length(paletaBB) / 2

# Create a data frame for the squares with the correct order
df <- data.frame(
  x = rep(1:columns, times=rows),
  y = rep(rev(1:rows), each=columns),
  fill = unlist(paletaBB)
)

# PLOT -------------------------------------------------------------------------

# Create the plot
p <- ggplot(df, aes(x = x, y = y, fill = fill)) +
  geom_rect(aes(xmin = x - square_size, 
                xmax = x + square_size, 
                ymin = y - square_size, 
                ymax = y + square_size), color = "black", linewidth = 0) +
  
  scale_fill_identity() +
  theme_void() +
  theme(aspect.ratio = rows / columns) +
  coord_fixed() +
  guides(fill = "none")

# SAVE -------------------------------------------------------------------------

# Save to a PNG file with transparent background
ggsave("paletaBB.png", p, width = 2, height = 6, bg = "transparent")

plot(p)

# END --------------------------------------------------------------------------

# Play the "coin" sound
# beep(sound = "coin")
