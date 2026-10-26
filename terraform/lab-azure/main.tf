resource "azurerm_resource_group" "rg" {            # cria um Resource Group; TIPO = azurerm_resource_group, APELIDO = rg
  name     = "rg-${var.projeto}"                    # nome no Azure; ${var.projeto} vira o valor da variável: rg-lab-tf
  location = var.location                           # região, lida da variável location

  tags = {                                          # etiquetas (chave = valor) para identificar o recurso
    ambiente = "estudo"                             # etiqueta "ambiente" com valor "estudo"
  }                                                 # fecha as tags
}                                                   # fecha o Resource Group

resource "azurerm_virtual_network" "vnet" {         # cria uma VNet (rede virtual); APELIDO = vnet
  name          = "vnet-${var.projeto}"             # nome no Azure: vnet-lab-tf
  address_space = ["10.10.0.0/16"]                  # faixa de IPs da rede (a lista fica entre colchetes)

  location            = azurerm_resource_group.rg.location  # LÊ a região do Resource Group acima (TIPO.APELIDO.CAMPO)
  resource_group_name = azurerm_resource_group.rg.name      # LÊ o nome do Resource Group; coloca a VNet dentro dele

  tags = {                                          # etiquetas da VNet
    ambiente = "estudo"                             # etiqueta "ambiente" com valor "estudo"
  }                                                 # fecha as tags
}                                                   # fecha a VNet

resource "azurerm_storage_account" "sa" {           # cria um Storage Account (o "drive" da nuvem); APELIDO = sa
  name = "st${replace(var.projeto, "-", "")}${var.sufixo_unico}"  # junta "st" + projeto sem traço + sufixo: stlabtfld1015

  location            = azurerm_resource_group.rg.location  # mesma região do Resource Group
  resource_group_name = azurerm_resource_group.rg.name      # fica dentro do mesmo Resource Group

  account_tier             = "Standard"             # tipo de disco: comum (o mais barato)
  account_replication_type = "LRS"                  # 3 cópias dos dados no mesmo datacenter (a mais barata)

  tags = {                                          # etiquetas do Storage Account
    ambiente = "estudo"                             # etiqueta "ambiente" com valor "estudo"
  }                                                 # fecha as tags
}                                                   # fecha o Storage Account
