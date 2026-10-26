output "resource_group_nome" {                       # cria uma saída com este nome (aparece na tela no final)
  description = "Nome do Resource Group criado"      # texto que explica o que é esta saída
  value       = azurerm_resource_group.rg.name       # o que mostrar: o nome do Resource Group (TIPO.APELIDO.CAMPO)
}                                                    # fecha a saída

output "vnet_id" {                                   # cria uma saída chamada vnet_id
  description = "ID da VNet criada"                  # texto que explica o que é esta saída
  value       = azurerm_virtual_network.vnet.id      # o ID único da VNet no Azure (o mesmo que vai pro state)
}                                                    # fecha a saída

output "storage_account_nome" {                      # cria uma saída chamada storage_account_nome
  description = "Nome do Storage Account criado"     # texto que explica o que é esta saída
  value       = azurerm_storage_account.sa.name      # o nome final já montado (st + projeto + sufixo)
}                                                    # fecha a saída
