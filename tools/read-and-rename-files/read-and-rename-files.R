
# Read the file names of a folder and then rename some files:

# Set the path to your folder
path = list(
  files = "C:/Users/F0738707/OneDrive - Banco do Brasil S.A/macro/docs/JPMorgan",
  names = "names/"
)

# Get all file names in the folder
file_names <- list.files(path = path$files)
print(file_names)

# ------------------------------------------------------------------------------

#  df is your dataframe with columns 'old_name' and 'new_name'
df <- data.frame(old_name = c("oldfile1.txt", "oldfile2.txt"), 
                 new_name = c("newfile1.txt", "newfile2.txt"))

# save to xlsx:
library(writexl)
write_xlsx(df, file.path(path$names, "df.xlsx"))

# load from xlsx:
library(readxl)
df <- read_excel(file.path(path$names, "df.xlsx"))

# ------------------------------------------------------------------------------

# Function to rename files
rename_files <- function(file_names) {
  for (file_name in file_names) {
    if (startsWith(file_name, "JPM_Global_Data_Watch_")) {
      # Extract the date using a regular expression
      date <- sub(".*_(\\d{4}-\\d{2}-\\d{2})_.*", "\\1", file_name)
      
      # Construct the new file name
      new_name <- paste0("JPM_Global_Data_Watch_", date, ".pdf")
      
      print(paste("Old Name:", file_name))
      print(paste("New Name:", new_name))
      
      # Rename the files
      file.rename(file.path(path$files, file_name), file.path(path$files, new_name))
    }
  }
}

# Call the function
rename_files(file_names)

# Get all file names in the folder
file_names <- list.files(path = path$files)
print(file_names)

