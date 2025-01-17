# ------------------------------------------------------------------------------
# PACKAGES
# ------------------------------------------------------------------------------

packages <- c("stringr", "pdftools", "magick")

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, method = "wininet")
  }
  library(pkg, character.only = TRUE)
}

# ------------------------------------------------------------------------------
# CAMINHO PARA OS PDFS
# ------------------------------------------------------------------------------

# Caminhos para os arquivos PDF
caminhos_pdf <- c(
  file.path(
    
# FOLDER DO PDF:

"C:/Users/F0738707/OneDrive - Banco do Brasil S.A/_macro/docs/FOMC/minutes",
    
c(
      
# NOME DOS ARQUIVOS PDF:

"fomcminutes20241218.pdf",
"fomcminutes20241107.pdf"
      
)))

# ------------------------------------------------------------------------------
# FUNÇÃO PARA CONVERTER PDF EM PNG
# ------------------------------------------------------------------------------

# Função para converter PDF em uma única imagem
converter_pdf_para_uma_imagem <- function(caminho_pdf) {
  # Carregar o PDF como imagem
  imagens <- image_read_pdf(caminho_pdf, density = 300)
  
  # Combinar as imagens em uma única imagem
  imagem_combinada <- image_append(imagens, stack = TRUE)
  
  # Criar o nome do arquivo PNG substituindo '.pdf' por '.png'
  caminho_imagem <- sub("\\.pdf$", ".png", caminho_pdf)
  
  # Salvar a imagem combinada
  image_write(imagem_combinada, path = caminho_imagem, format = "png")
  cat("PDF salvo como uma única imagem em", caminho_imagem, "\n")
}



# Converter cada PDF em uma única imagem
for (caminho_pdf in caminhos_pdf) {
  converter_pdf_para_uma_imagem(caminho_pdf)
}

# ------------------------------------------------------------------------------