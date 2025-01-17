
# CONFERE SE DUAS PLANILHAS XLSX SÃO EXATAMENTE IGUAIS -------------------------

library(readxl)
library(dplyr)
library(writexl)

file1 <- "C:/Users/F0738707/OneDrive - Banco do Brasil S.A/andre/dados/bacen/fiscal/bacen_fiscal.xlsx"
file2 <- "G:/BB8555-GEASE/Interna/Dados/Brasil/Fiscal/Fiscal2_backup_20240930.xlsx"

# Read all sheets into lists of dataframes
sheets1 <- lapply(excel_sheets(file1), read_excel, path = file1)
sheets2 <- lapply(excel_sheets(file2), read_excel, path = file2)

# Name the list elements with sheet names
names(sheets1) <- excel_sheets(file1)
names(sheets2) <- excel_sheets(file2)

compare_df_cols <- function(df1, df2) {
  diffs <- list()
  common_cols <- intersect(names(df1), names(df2))
  for (col in common_cols) {
    if (!identical(df1[[col]], df2[[col]])) {
      diffs[[col]] <- data.frame(File1 = df1[[col]], File2 = df2[[col]])
    }
  }
  diffs
}

compare_sheets <- function(sheet1, sheet2) {
  differences <- list()
  for (name in names(sheet1)) {
    if (!identical(sheet1[[name]], sheet2[[name]])) {
      differences[[name]] <- compare_df_cols(sheet1[[name]], sheet2[[name]])
    } else {
      differences[[name]] <- data.frame(Note = "No differences")
    }
  }
  differences
}

differences <- compare_sheets(sheets1, sheets2)

# Ensure the differences are data frames before exporting
unnested_differences <- lapply(differences, function(sheet) {
  if (length(sheet) > 0) {
    as.data.frame(do.call(cbind, sheet))
  } else {
    data.frame(Note = "No differences")
  }
})

# Export differences to an Excel file with each sheet representing differences of corresponding sheets
write_xlsx(unnested_differences, path = "C:/Users/F0738707/OneDrive - Banco do Brasil S.A/andre/dados/bacen/fiscal/differences_report.xlsx")

