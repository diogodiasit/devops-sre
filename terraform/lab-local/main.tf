resource "random_pet" "sufixo" {                  # gera um nome aleatório (ex.: happy-otter); TIPO = random_pet, APELIDO = sufixo
  length = 2                                      # quantidade de palavras do nome
}                                                 # fecha o random_pet

resource "local_file" "readme" {                  # cria um arquivo de texto na sua máquina; APELIDO = readme
  filename = "${path.module}/saida/${var.projeto}-${random_pet.sufixo.id}.txt"  # caminho: pasta do projeto + saida/ + projeto + nome aleatório
  content  = "${var.mensagem}\n"                  # conteúdo do arquivo: o texto da variável + uma quebra de linha
}                                                 # fecha o primeiro arquivo

resource "local_file" "resumo" {                  # cria o segundo arquivo de texto; APELIDO = resumo
  filename = "${path.module}/saida/resumo.txt"    # caminho do segundo arquivo, dentro da pasta saida/
  content  = "Arquivo principal: ${local_file.readme.filename}\n"  # LÊ o caminho do primeiro arquivo (TIPO.APELIDO.CAMPO)
}                                                 # fecha o segundo arquivo
