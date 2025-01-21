# Load the necessary packages
library(grDevices)
library(ggplot2)

# pallete name:
pallete_name = "paleta_BB_estilo"

# Define your base colors
base_colors <- c(
  
  "#0F2846",  # bb-estilo-azulS
  "#467DC3",  # bb-estilo-azulE
  "#D7D2CD"   # bb-estilo-areiaT

  )
  
  # "#FCFC30",  # bb-amarelo
  # "#3333BD",  # bb-azul-escuro
  # "#465EFF",  # bb-azul
  # "#735CC6",  # bb-roxo-escuro
  # "#BDB6FF",  # bb-roxo-claro
  # "#00EBD0",  # bb-verde-escuro
  # "#83FFEA",  # bb-verde-claro
  # "#FF6E91",  # bb-rosa-escuro
  # "#FFA7D3",  # bb-rosa-claro
  # "#54DCFC",  # bb-azul-claro
  # "#FFFFFF",  # branco
  # "#0F2846",  # bb-estilo-azulS
  # "#467DC3",  # bb-estilo-azulE
  # "#D7D2CD"   # bb-estilo-areiaT



l = length(base_colors) *3

# Create a function to generate a palette
generate_palette <- function(colors, l) {
  colorRampPalette(colors)(l)
}

# Create a function to calculate luminance
calculate_luminance <- function(color) {
  rgb <- col2rgb(color) / 255
  c <- c(0.299, 0.587, 0.114)
  sum(rgb * c)
}

# Generate the palette
palette <- generate_palette(base_colors, l)

# Determine label colors based on luminance
label_colors <- sapply(palette, function(color) {
  if (calculate_luminance(color) > 0.5) "black" else "white"
})

# Create a data frame for plotting
palette_df <- data.frame(
  Color = factor(seq_along(palette), labels = palette),
  Hex = palette,
  LabelColor = label_colors
)

# Create the vertical plot and assign it to a variable
p_x <- ggplot(palette_df, aes(x = Color, y = 1, fill = Hex)) +
  geom_tile(width = 0.9, height = 0.9) +
  scale_fill_identity() +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank()   # Remove y-axis title
  ) +
  geom_text(aes(label = Hex, color = LabelColor), vjust = 0.5, hjust = 0.5, angle = 90) +
  scale_color_identity()

# Reverse the order of the palette and label colors for the p_y plot
palette_reversed <- rev(palette)
label_colors_reversed <- rev(label_colors)

# Create a data frame for the reversed palette
palette_df_reversed <- data.frame(
  Color = factor(seq_along(palette_reversed), labels = palette_reversed),
  Hex = palette_reversed,
  LabelColor = label_colors_reversed
)

# Create the horizontal plot with the reversed order and assign it to a variable
p_y <- ggplot(palette_df_reversed, aes(x = 1, y = Color, fill = Hex)) +
  geom_tile(width = 0.9, height = 0.9) +
  scale_fill_identity() +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.text.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(),  # Remove x-axis title
    axis.title.y = element_blank()   # Remove y-axis title
  ) +
  geom_text(aes(label = Hex, color = LabelColor), 
            vjust = 0.5, hjust = 0.5, size = 3.5) +
  scale_color_identity()

width_p_x = 8
height_p_x = 4

width_p_y = 1
height_p_y = 8

# Save the vertical plot to a PNG file
ggsave(
  paste0(pallete_name, "_x.png"), 
  plot = p_x, width = width_p_x, height = height_p_x, units = "in")

# Save the vertical plot to a PDF file
ggsave(
  paste0(pallete_name, "_x.pdf"),
  plot = p_x, width = width_p_x, height = height_p_x, units = "in")

# Save the horizontal plot to a PNG file
ggsave(
  paste0(pallete_name, "_y.png"),
  plot = p_y, width = width_p_y, height = height_p_y, units = "in")

# Save the horizontal plot to a PDF file
ggsave(
  paste0(pallete_name, "_y.pdf"),
  plot = p_y, width = width_p_y, height = height_p_y, units = "in")

plot(p_y)
