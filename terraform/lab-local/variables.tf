variable "projeto" {                                          # cria a variável "projeto"; no código vira var.projeto
  description = "Nome do projeto, usado no nome dos arquivos" # texto que explica para que serve
  type        = string                                        # tipo: texto
  default     = "lab-local"                                   # valor reserva: vale se ninguém informar outro
}                                                             # fecha a variável projeto

variable "mensagem" {                                         # cria a variável "mensagem"; no código vira var.mensagem
  description = "Texto que sera escrito dentro do arquivo"    # texto que explica para que serve
  type        = string                                        # tipo: texto
}                                                             # sem "default" de propósito: o Terraform exige o valor
