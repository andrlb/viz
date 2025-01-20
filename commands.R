# --------------------------------------------------
# RDS FILES
# --------------------------------------------------

df = data.frame(
  nome = c("Joao", "Maria"),
  altura = c(1.8, 1.7),
  peso = c(75, 71)
)

# save to a rds file:
saveRDS(df, file = "df.rds")

# load a rds file:
df <- readRDS(file = "df.rds")

# --------------------------------------------------
# RDATA FILES
# --------------------------------------------------

# save to rdata file:
save(df, file = "df.rdata")

# load a rdata file:
load(file = "df.rdata")

# --------------------------------------------------
# XLSX FILES
# --------------------------------------------------

# save to xlsx:
library(writexl)
write_xlsx(df, "df.xlsx")

# load from xlsx:
library(readxl)
df <- read_excel("df.xlsx")

# load all sheets:
# Get the names of all sheets in the Excel file
sheet_names <- excel_sheets("df.xlsx")

# Read all sheets into a list of data frames
my_list <- setNames(lapply(sheet_names, function(sheet) {
  read_excel("df.xlsx", sheet = sheet)
}), sheet_names)


# --------------------------------------------------
# CSV FILES
# --------------------------------------------------

library(readr)
data <- read_csv("path/to/your/file.csv")

# --------------------------------------------------
# LISTS
# --------------------------------------------------

# put the itens in the environment:
list2env(my_list, envir = .GlobalEnv)

# Delete the second item
my_list[[2]] <- NULL

# --------------------------------------------------
# ENVIRONMENT
# --------------------------------------------------

# List all objects that start with 'PAM_'
objects_to_remove <- grep("^PAM_", ls(), value = TRUE)
# Remove these objects
rm(list = objects_to_remove)

# --------------------------------------------------
# DATAFRAME
# --------------------------------------------------

# create a dataframe:
df = data.frame(matrix(nrow=5,ncol=0))

# join from other dataframe:
df = df %>% left_join(
  select(other_df, key_col1, key_col2, other_columns), 
  by = c("key_col1", "key_col2"))

# rename colnames:
new_data <- data %>%
  rename(
    new_column1 = old_column1,
    new_column2 = old_column2,
    new_column3 = old_column3
  )

# Create a new dataframe by selecting some columns and renaming them
new_df <- df %>%
  select(A, B) %>%
  rename(new_A = A, new_B = B)

# delete column:
df$column = NULL

# filter to another dataframe:
df <- data %>%
  filter(geography %in% c('var1', 'var2'))

# change order of the columns:
df <- df %>% select(coluna2, coluna1, coluna3)

# --------------------------------------------------
# IF ELSE
# --------------------------------------------------

if (condition) {
  # code to be executed if condition is TRUE
} else {
  # code to be executed if condition is FALSE
}

# --------------------------------------------------
# TIME ELAPSED
# --------------------------------------------------

# Get the start time
start_time <- Sys.time()

# Execute your command here

# Get the end time
end_time <- Sys.time()

# Calculate the time taken to execute the command
time_taken <- end_time - start_time

# Print the time taken
print(time_taken)

# --------------------------------------------------
# PARALLEL COMPUTING
# --------------------------------------------------

# Set up future to use multisession evaluation
plan(multisession)

# --------------------------------------------------
# PACKAGES
# --------------------------------------------------

# Para instalar pacotes do R na rede do banco:
install.packages("pacote", method="wininet")

# --------------------------------------------------
# FONTS
# --------------------------------------------------

# fonte bb:
library(extrafont) 
if (!"BancoDoBrasil Textos" %in% fonts()) {
  font_import()
  loadfonts(device = "win")
}

# --------------------------------------------------
# 
# --------------------------------------------------



# --------------------------------------------------
# 
# --------------------------------------------------



# --------------------------------------------------
# BEEPS
# --------------------------------------------------

# Play the "ping" sound
beep(sound = "ping")

# Play the "coin" sound
beep(sound = "coin")

# Play the "fanfare" sound
beep(sound = "fanfare")

# Play the "complete" sound
beep(sound = "complete")

# Play the "treasure" sound
beep(sound = "treasure")

# Play the "ready" sound
beep(sound = "ready")

# Play the "shotgun" sound
beep(sound = "shotgun")

# Play the "mario" sound
beep(sound = "mario")

# Play the "wilhelm" sound
beep(sound = "wilhelm")

# Play the "facebook" sound
beep(sound = "facebook")

# Play the "sword" sound
beep(sound = "sword")