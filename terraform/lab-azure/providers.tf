terraform {                             # bloco de configurações do próprio programa Terraform
  required_version = ">= 1.5"           # exige o Terraform na versão 1.5 ou mais nova
  required_providers {                  # lista dos providers (tradutores) que o projeto precisa
    azurerm = {                         # apelido do provider do Azure
      source  = "hashicorp/azurerm"     # de onde baixar: Terraform Registry, da HashiCorp
      version = "~> 4.0"                # aceita qualquer 4.x, nunca a 5.0
    }                                   # fecha o azurerm
  }                                     # fecha o required_providers
}                                       # fecha o bloco terraform

provider "azurerm" {                    # configuração do provider do Azure
  features {}                           # bloco obrigatório do azurerm; pode ficar vazio
}                                       # fecha o bloco provider
