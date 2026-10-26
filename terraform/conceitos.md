FASE 8 - TERRAFORM: CONCEITOS

IaC: infraestrutura descrita em código (.tf) e versionada no Git. É declarativo: diz O QUE quer, não COMO fazer.
Provider: o tradutor que fala com a plataforma (azurerm = Azure, aws, google, local = arquivos na máquina).
Resource: item do pedido. Formato: resource "TIPO" "APELIDO" { campos }.
Variable e tfvars: campos em branco (variables.tf) e seus valores (terraform.tfvars).
Output: o que o Terraform mostra no fim do apply.
Referência TIPO.APELIDO.CAMPO: lê o valor de outro recurso e cria dependência implícita (o outro é criado primeiro).
State (terraform.tfstate): a comanda. Liga cada item do código ao recurso real. Gerado sozinho no primeiro apply. Nunca editar na mão e nunca vai pro Git (pode ter segredos). Em equipe fica no remote backend (Storage Account com lock).
Drift: quando a realidade difere do código (alguém mexeu fora do Terraform). O plan detecta.
Ciclo: init, validate, plan, apply, destroy. O plan é o preview e não altera nada.

FLUXO REAL DE EMPRESA
branch, push, Pull Request (a esteira roda init, validate e plan; o revisor lê o plan), merge na main, esteira de deploy roda o apply (em produção, com aprovação via Environment).
O gatilho de cada esteira (push, pull_request, push na main) é escolhido no YAML. A branch guarda o trabalho até o dia de aplicar, e o plan é refeito antes do merge, porque o antigo fica velho.
Ninguém roda apply do próprio notebook em ambiente compartilhado.

OUTROS
Terraform vs Bicep: Bicep só funciona no Azure, o Terraform é multi-nuvem. Terraform cria a infraestrutura, Ansible configura o que está dentro dela.
OpenTofu: fork open source, criado depois da mudança de licença da HashiCorp em 2023.
Próxima camada: remote state com lock, módulos, ambientes (dev, homologação, produção) e import.

LABORATÓRIOS
lab-local: providers local e random. Cria arquivos de texto na máquina, sem nuvem. Serve para treinar o ciclo e o state.
lab-azure: provider azurerm. Resource Group, VNet e Storage Account. Validado com terraform validate, mas não aplicado: a subscription tem o crédito expirado (estado Warned) e não cria recursos.
Crédito de teste do Azure (US$ 200) vale 30 dias. Depois disso, só com upgrade para pay-as-you-go.
