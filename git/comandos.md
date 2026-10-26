# Git — Comandos

Referência dos comandos de versionamento usados no dia a dia deste repositório.

## Configuração inicial

| Comando | O que faz |
|---|---|
| `git init` | Inicia um repositório Git na pasta atual |
| `git config --global user.name "nome"` | Define o nome do autor (`--global` = vale para todos os repositórios do usuário) |
| `git config --global user.email "email"` | Define o e-mail do autor |
| `git config --global init.defaultBranch main` | Define `main` como nome padrão da branch principal |
| `git config --global --list` | Mostra todas as configurações globais |
| `git branch -m main` | Renomeia a branch atual para `main` (`-m` = *move*) |

## Fluxo básico

| Comando | O que faz |
|---|---|
| `git remote add origin <url>` | Conecta o repositório local ao remoto (`origin` = apelido do remoto) |
| `git add .` | Adiciona ao *stage* todas as mudanças da pasta atual (`.` = tudo) |
| `git commit -m "mensagem"` | Registra um snapshot do que está no *stage*, com mensagem descritiva |
| `git push` | Envia os commits para o remoto |
| `git push -u origin main` | Primeiro envio: `-u` grava o *upstream*, e depois basta `git push` |

## Branches e merge

| Comando | O que faz |
|---|---|
| `git branch` | Lista as branches; `*` marca a atual |
| `git branch nome-da-branch` | Cria uma branch (sem entrar nela) |
| `git checkout nome-da-branch` | Troca para uma branch existente |
| `git checkout -b nome-da-branch` | Cria a branch **e** entra nela (`-b` = *branch*) |
| `git merge nome-da-branch` | Traz as mudanças de outra branch para a atual |
| `git branch -d nome-da-branch` | Apaga uma branch já mergeada (`-d` = *delete*, seguro) |

## .gitignore

`touch .gitignore` cria o arquivo que lista o que **nunca** deve ser versionado:

```gitignore
# Segredos e credenciais
.env
*.pem
*.key

# Lixo de sistema operacional
.DS_Store
Thumbs.db

# Configuração pessoal de editor
.vscode/
.idea/
```

## Investigação de histórico

| Comando | O que faz |
|---|---|
| `git log` | Histórico de commits |
| `git blame <arquivo>` | Mostra, linha por linha, o último commit e autor que alterou cada linha |

> **Em produção:** `git log` e `git blame` respondem rápido à pergunta "o que mudou desde a última versão que funcionava?" quando algo quebra logo após um deploy.
