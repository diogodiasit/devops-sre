output "arquivo_principal" {                           # cria uma saída com este nome (aparece na tela no final)
  description = "Caminho do arquivo principal criado"  # texto que explica o que é esta saída
  value       = local_file.readme.filename             # o que mostrar: o caminho do primeiro arquivo (TIPO.APELIDO.CAMPO)
}                                                      # fecha a saída

output "nome_aleatorio" {                              # cria uma saída chamada nome_aleatorio
  description = "Nome aleatorio gerado"                # texto que explica o que é esta saída
  value       = random_pet.sufixo.id                   # o nome gerado pelo random_pet
}                                                      # fecha a saída
