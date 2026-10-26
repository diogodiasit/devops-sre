terraform {                              # bloco de configurações do próprio programa Terraform
  required_version = ">= 1.5"            # exige o Terraform na versão 1.5 ou mais nova
  required_providers {                   # lista dos providers (tradutores) que o projeto precisa
    local = {                            # apelido do provider que cria arquivos na sua máquina
      source  = "hashicorp/local"        # de onde baixar: Terraform Registry, da HashiCorp
      version = "~> 2.5"                 # aceita qualquer 2.x (2.5, 2.6...), nunca a 3.0
    }                                    # fecha o provider local
    random = {                           # apelido do provider que gera valores aleatórios
      source  = "hashicorp/random"       # de onde baixar: Terraform Registry, da HashiCorp
      version = "~> 3.6"                 # aceita qualquer 3.x (3.6, 3.7...), nunca a 4.0
    }                                    # fecha o provider random
  }                                      # fecha o required_providers
}                                        # fecha o bloco terraform
