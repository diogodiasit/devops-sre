# Azure DevOps — Conceitos

Equivalências com o GitHub Actions e comportamentos do Azure Pipelines com Azure Repos.

## Equivalência GitHub ↔ Azure DevOps

| GitHub | Azure DevOps |
|---|---|
| Actions | Pipelines |
| Repositório | Repos |
| `.github/workflows/nome.yml` | `azure-pipelines.yml` (raiz do repositório) |
| `on:` | `trigger:` (push) ou `pr:` (pull request) |
| `runs-on:` | `pool: vmImage:` |
| `run:` | `script:` |
| `name:` | `displayName:` |
| `uses:` | `task:` |
| Secrets | Service Connection |
| Branch protection | Branch Policies |

## `pr:` no YAML não funciona com Azure Repos

- O bloco `pr:` só vale para repositórios **GitHub e Bitbucket**.
- No Azure Repos, o gatilho de Pull Request vem de uma **Branch Policy (Build Validation)**, configurada fora do YAML em **Repos > Branches**.

## `trigger:` já significa push

- No Azure Pipelines, `trigger:` sozinho é o gatilho de push — não existe a palavra `push`.
- Para rodar **somente** em PR, é preciso desligar o trigger de push:

```yaml
trigger:
  branches:
    exclude:
      - '*'
```

## Pipeline como "preview" durante o PR

Com uma Branch Policy configurada, pipelines com trigger na branch de destino podem rodar automaticamente durante o PR, como uma prévia do que aconteceria após o merge — antes do **Complete**.

## Push x abrir Pull Request

`git push` só envia o código. Abrir o Pull Request é uma ação separada, feita na interface **depois** do push; uma não dispara a outra.

## Conflito de merge não resolvido

- Um merge com conflito exige resolução manual, removendo os marcadores `<<<<<<<`, `=======` e `>>>>>>>`.
- Se o arquivo for salvo com os marcadores (por exemplo, editando no `nano` sem percebê-los), ele fica inválido sem nenhum erro aparente no Git.

> **Em produção:** em YAML de pipeline, um marcador esquecido quebra a esteira inteira. Revise o diff antes do commit.

## Service Connection

- Equivale ao par de secrets do GitHub (usuário + token), mas empacotado em um único objeto reutilizável.
- Configurado em **Project Settings > Service connections**.
- No YAML, é referenciado só pelo nome (ex.: `containerRegistry`), sem expor a credencial.
