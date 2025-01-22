library(openxlsx)

number_of_columns = 8

name_font = "Verdana"
hex_font  = "Lucida Console"

name_font_size = 8
hex_font_size  = 8

name_col =  "auto" # 15
hex_col  = "auto" # 7
space_col = 1.5

row_height = 20

# Function to create the Excel and PDF files with dynamic column groups and separator columns
generate_files <- function(num_groups) {
  
  # Get the HEX codes for the colour names
  colour_names <- colours()
  
  # Create a named list where the name is the colour name and the content is the HEX code
  colour_list <- setNames(lapply(colour_names, function(colour) rgb(t(col2rgb(colour))/255)), colour_names)
  
  # Convert the list to a data frame
  Rcolours <- data.frame(colourName = names(colour_list), HexCode = unlist(colour_list), stringsAsFactors = FALSE)
  
  # Reset the row names
  rownames(Rcolours) <- NULL
  
  # Determine the size of each group
  total_colors <- nrow(Rcolours)
  group_size <- ceiling(total_colors / num_groups)
  
  # Create a workbook and add a worksheet
  wb <- createWorkbook()
  addWorksheet(wb, "colours", gridLines = FALSE)
  
  # Define a list to store the colors for each group
  color_groups <- list()
  
  # Function to calculate text color based on background color
  get_text_color <- function(bg_color) {
    rgb_val <- col2rgb(bg_color)
    brightness <- (0.299 * rgb_val[1] + 0.587 * rgb_val[2] + 0.114 * rgb_val[3]) / 255
    if (brightness > 0.5) {
      return("black")
    } else {
      return("white")
    }
  }
  
  # Write the dataframes to the worksheet in the specified number of groups with separator columns
  for (i in 1:num_groups) {
    start_row <- (i - 1) * group_size + 1
    end_row <- min(i * group_size, total_colors)
    group <- Rcolours[start_row:end_row, ]
    
    start_col <- (i - 1) * 3 + 1
    writeData(wb, sheet = "colours", x = group$colourName, startCol = start_col, colNames = FALSE)
    writeData(wb, sheet = "colours", x = group$HexCode, startCol = start_col + 1, colNames = FALSE)
    
    color_groups[[i]] <- Rcolours$HexCode[start_row:end_row]
    
    # Apply the colours to the 'colourName' and 'HexCode' columns for the group
    for (j in 1:nrow(group)) {
      bg_color <- Rcolours$HexCode[start_row + j - 1]
      text_color <- get_text_color(bg_color)
      hex_style <- createStyle(fontName = hex_font, fontSize = hex_font_size, fgFill = bg_color, fontColour = text_color, valign = "center", border = "topBottom", borderColour = "white")
      name_style <- createStyle(fontName = name_font, fontSize = name_font_size, fgFill = bg_color, fontColour = text_color, valign = "center", border = "topBottom", borderColour = "white")
      addStyle(wb, sheet = "colours", style = name_style, rows = j, cols = start_col)
      addStyle(wb, sheet = "colours", style = hex_style, rows = j, cols = start_col + 1)

      # Set row height for each row
      setRowHeights(wb, sheet = "colours", rows = j, heights = row_height)  # Adjust height as needed
    }
    
    # Adjust the column widths based on the content and make them slightly wider
    setColWidths(wb, sheet = "colours", cols = start_col, widths = name_col)  # Adjust width as needed
    setColWidths(wb, sheet = "colours", cols = start_col + 1, widths = hex_col)  # Adjust width as needed
    
    # Set the width of the separator column
    setColWidths(wb, sheet = "colours", cols = start_col + 2, widths = space_col)
  }
  
  # Save the workbook
  saveWorkbook(wb, file = "Rcolours.xlsx", overwrite = TRUE)
}

# Example usage: Generate files with n groups of columns
generate_files(number_of_columns)
