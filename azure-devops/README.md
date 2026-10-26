# Azure DevOps — Migração do CI/CD para Azure Repos e Azure Pipelines

Reimplementação do pipeline do [projeto-agendamento](../cicd/projeto-agendamento/) no ecossistema Azure DevOps: código no Azure Repos, esteira no Azure Pipelines, credencial de registry em Service Connection e validação de PR via Branch Policy.

## Problema

O mesmo projeto já tinha CI/CD no GitHub Actions. O objetivo era levá-lo para o **Azure DevOps**, plataforma comum em ambientes corporativos Microsoft, preservando as mesmas garantias:

- testes obrigatórios antes do merge na `main`;
- nenhuma credencial exposta no código;
- fluxo de trabalho por branch + Pull Request.

## Solução

| Requisito | GitHub (origem) | Azure DevOps (destino) |
|---|---|---|
| Repositório | GitHub | **Azure Repos** (clone e cópia do projeto) |
| Esteira | `.github/workflows/*.yml` | **`azure-pipelines.yml`** na raiz do repositório |
| Credencial do registry | Secrets `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` | **Service Connection** referenciada pelo nome (`containerRegistry`) |
| Gatilho de PR | `on: pull_request` | **Branch Policy > Build Validation** (o bloco `pr:` não vale para Azure Repos) |
| Proteção da `main` | Branch protection | **Branch Policies** |

Pontos técnicos resolvidos na migração:

- **`pr:` é ignorado no Azure Repos** → o gatilho de PR foi configurado como Build Validation em **Repos > Branches**.
- **`trigger:` equivale a push** → para uma esteira rodar só em PR, o trigger de push é desligado com `branches: exclude: ['*']`.
- **Conflito de merge salvo com os marcadores** `<<<<<<<`/`>>>>>>>` invalidava o YAML sem erro aparente → identificado e corrigido.

Detalhes em [conceitos.md](./conceitos.md) e [comandos.md](./comandos.md).

> O código e o `azure-pipelines.yml` ficam no repositório do Azure Repos; esta pasta documenta a implementação.

## Como rodar

```bash
git clone https://dev.azure.com/<organizacao>/<projeto>/_git/<repositorio> <pasta-local>
cp -r cicd/projeto-agendamento <pasta-local>/
cd <pasta-local>
git checkout -b feature/minha-mudanca
git add . && git commit -m "feat: descrição"
git push origin feature/minha-mudanca
```

- `git clone <url> <pasta>`: copia o repositório do Azure Repos para a pasta local.
- `cp -r`: copia o projeto inteiro (`-r` = recursivo).
- `git checkout -b`: cria a branch de trabalho e entra nela.
- `git push origin <branch>`: envia a branch; o PR é aberto em **Repos > Pull requests** e dispara a Build Validation.

Configuração no portal:

1. **Project Settings > Service connections:** criar a conexão do registry de containers.
2. **Pipelines > New pipeline:** apontar para o `azure-pipelines.yml` do Azure Repos.
3. **Repos > Branches > main > Branch policies:** adicionar a Build Validation com o pipeline.

## Resultado

- Pull Requests para a `main` no Azure Repos disparam o pipeline automaticamente via Build Validation; o merge depende do resultado.
- A credencial do registry fica centralizada numa Service Connection, fora do YAML.
- Mapa de equivalência GitHub Actions ↔ Azure Pipelines documentado para migrações futuras ([conceitos.md](./conceitos.md#equivalência-github--azure-devops)).
