# Terraform — Infraestrutura como código (local e Azure)

Dois labs de IaC com Terraform: um ciclo completo aplicado localmente e uma base de rede e armazenamento na Azure com provider `azurerm`, parametrizada e validada.

## Problema

Criar infraestrutura manualmente (portal, cliques) não é reprodutível, não passa por revisão e não deixa histórico. O objetivo era descrever recursos em código versionado, com:

- providers e versões fixadas;
- parâmetros separados do código (variables + tfvars);
- dependências entre recursos resolvidas pelo próprio Terraform;
- state fora do Git.

## Solução

| Lab | Providers | Recursos |
|---|---|---|
| [`lab-local`](./lab-local/) | `hashicorp/local` (~> 2.5), `hashicorp/random` (~> 3.6) | `random_pet` (nome aleatório) + 2 × `local_file`; o segundo arquivo referencia o primeiro (`local_file.readme.filename`), criando dependência implícita |
| [`lab-azure`](./lab-azure/) | `hashicorp/azurerm` (~> 4.0) | Resource Group `rg-lab-tf`, VNet `vnet-lab-tf` (`10.10.0.0/16`) e Storage Account Standard/LRS, todos com tags e região parametrizada (padrão `brazilsouth`) |

Organização dos arquivos, igual nos dois labs:

| Arquivo | Conteúdo |
|---|---|
| `providers.tf` | `required_version >= 1.5` e providers com restrição de versão |
| `variables.tf` | Variáveis com `description`, `type` e `default` (as obrigatórias ficam sem default de propósito) |
| `terraform.tfvars` | Valores das variáveis |
| `main.tf` | Recursos |
| `outputs.tf` | Saídas exibidas após o apply |
| `.terraform.lock.hcl` | Versões e hashes exatos dos providers (versionado) |
| `.gitignore` | Exclui `.terraform/`, `*.tfstate*`, `*.tfplan` e `crash.log` |

O nome do Storage Account é montado com funções e interpolação — `"st${replace(var.projeto, "-", "")}${var.sufixo_unico}"` — para atender à regra da Azure (só minúsculas e números, único globalmente).

## Como rodar

**lab-local** (sem nuvem):

```bash
cd terraform/lab-local
terraform init        # baixa os providers local e random
terraform validate    # valida a sintaxe e a coerência
terraform plan        # prévia: 3 recursos a criar
terraform apply       # cria os arquivos em saida/ (confirmar com yes)
terraform state list  # recursos registrados no state
terraform destroy     # remove tudo que foi criado
```

**lab-azure**:

```bash
cd terraform/lab-azure
az login --use-device-code                                         # autentica na Azure pelo código de dispositivo
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)    # informa a subscription ao provider azurerm
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy     # remover ao final para não gerar custo
```

- `--query id -o tsv`: extrai só o ID da subscription, em texto puro.
- Se o nome do Storage Account já estiver em uso, altere `sufixo_unico` em `terraform.tfvars`.

## Resultado

- **lab-local:** ciclo completo `init → validate → plan → apply → state → destroy` executado, com 3 recursos gerenciados no state e a dependência entre os arquivos resolvida automaticamente.
- **lab-azure:** código validado com `terraform validate` (`init` concluído, provider `azurerm` 4.81.0 travado no lock file). **O `apply` não foi executado:** a subscription de avaliação estava com o crédito expirado (estado `Warned`), que bloqueia a criação de recursos. O diagnóstico está documentado em [conceitos.md](./conceitos.md#labs-deste-repositório).
- Fluxo de IaC em equipe documentado (PR com `plan`, `apply` via pipeline com aprovação) em [conceitos.md](./conceitos.md#fluxo-em-equipe).
