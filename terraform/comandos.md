# Terraform — Comandos

Referência dos comandos usados nos labs [lab-local](./lab-local/) e [lab-azure](./lab-azure/).

## Ciclo de vida

| Comando | O que faz |
|---|---|
| `terraform -version` | Mostra a versão instalada |
| `terraform init` | Baixa os providers declarados em `providers.tf` (no início do projeto ou ao trocar de provider) e gera o `.terraform.lock.hcl` |
| `terraform validate` | Confere sintaxe e coerência do código, sem falar com a nuvem |
| `terraform fmt` | Formata o código no estilo padrão (`-check` só verifica, sem alterar) |
| `terraform plan` | Mostra o que será criado (`+`), alterado (`~`) ou destruído (`-`), sem executar |
| `terraform apply` | Executa o plano (pede confirmação `yes`) |
| `terraform destroy` | Remove tudo que o código criou |

## State

| Comando | O que faz |
|---|---|
| `terraform state list` | Lista os recursos registrados no state |
| `terraform show` | Exibe o state de forma legível |

## Azure CLI (autenticação do provider azurerm)

| Comando | O que faz |
|---|---|
| `az login --use-device-code` | Login por código de dispositivo — útil no WSL, onde o navegador não abre direto |
| `az account show` | Mostra a subscription ativa |
| `az account list --all` | Lista as subscriptions, inclusive as que não estão `Enabled` (`--all`) |

```bash
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
```

- Informa ao provider `azurerm` qual subscription usar.
- `--query id`: filtra o campo `id` (JMESPath); `-o tsv`: saída em texto puro, sem aspas.
- `$( ... )`: substitui pelo resultado do comando; `export` disponibiliza a variável para o Terraform.
