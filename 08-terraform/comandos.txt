FASE 8 - TERRAFORM: COMANDOS

terraform -version      mostra a versão instalada
terraform init          baixa os providers do providers.tf (roda no começo ou ao trocar de provider)
terraform validate      confere a escrita e a coerência do código, sem falar com a nuvem
terraform fmt           arruma o estilo do código (com -check só verifica)
terraform plan          mostra o que vai ser criado (+), alterado (~) ou destruído (-), sem executar
terraform apply         executa o plano (pede yes)
terraform destroy       apaga tudo que o código criou
terraform state list    lista os recursos anotados no state
terraform show          mostra o state de forma legível

az login --use-device-code       login no Azure por código (laboratório no WSL)
az account show                  mostra a subscription ativa
az account list --all            lista as subscriptions, inclusive as que não estão Enabled
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)    informa ao azurerm qual subscription usar
