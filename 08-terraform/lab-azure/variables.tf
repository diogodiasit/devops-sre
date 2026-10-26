variable "location" {                                     # cria a variável "location"; no código vira var.location
  description = "Regiao do Azure onde os recursos serao criados"  # texto que explica para que serve
  type        = string                                    # tipo: texto
  default     = "brazilsouth"                             # valor reserva: vale se ninguém informar outro
}                                                         # fecha a variável location

variable "projeto" {                                      # cria a variável "projeto"; no código vira var.projeto
  description = "Nome do projeto, usado nos nomes dos recursos"   # texto que explica para que serve
  type        = string                                    # tipo: texto
  default     = "lab-tf"                                  # valor reserva; fica no meio dos nomes (rg-lab-tf)
}                                                         # fecha a variável projeto

variable "sufixo_unico" {                                 # cria a variável "sufixo_unico"
  description = "Sufixo para o Storage Account (unico no mundo, so letras minusculas e numeros)"  # explica o uso
  type        = string                                    # tipo: texto
}                                                         # sem "default" de propósito: o Terraform exige o valor
