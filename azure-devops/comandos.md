# Azure DevOps — Comandos

Comandos usados para levar o projeto de CI/CD para o Azure Repos e operar o fluxo de branch + Pull Request.

## Clonar o repositório do Azure Repos

```bash
git clone https://dev.azure.com/<organizacao>/<projeto>/_git/<repositorio> <pasta-local>
```

- `git clone <url> <pasta-local>`: copia o repositório remoto para a pasta indicada.
- A URL segue o formato `dev.azure.com/<organização>/<projeto>/_git/<repositório>`.

## Copiar o projeto existente para o novo repositório

```bash
cp -r ~/devops-sre-labs/cicd/projeto-agendamento ~/<pasta-local>/
```

- `cp -r`: copia a pasta inteira (`-r` = recursivo).

## Fluxo de branch + Pull Request

O fluxo é o mesmo do GitHub; muda só a interface.

| Comando | O que faz |
|---|---|
| `git checkout -b nome-da-branch` | Cria a branch de trabalho e entra nela |
| `git add .` | Adiciona as mudanças ao *stage* |
| `git commit -m "mensagem"` | Registra o commit |
| `git push origin nome-da-branch` | Envia a branch para o Azure Repos |

Depois do push, o Pull Request é aberto pela interface do Azure DevOps (**Repos > Pull requests**).

## Sincronizar a main local

| Comando | O que faz |
|---|---|
| `git checkout main` | Volta para a branch principal |
| `git pull` | Baixa e integra as mudanças do remoto (após o merge do PR) |
