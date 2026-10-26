# CI/CD — Conceitos

Fundamentos de integração e entrega contínuas aplicados nos pipelines deste repositório.

## CI/CD

- **CI (Integração Contínua):** a cada mudança, os testes rodam automaticamente.
- **CD (Entrega/Deploy Contínuo):** build e publicação automáticos depois que os testes passam.
- Objetivo central: eliminar intervenção manual repetitiva e detectar falhas antes de chegarem à branch principal.

## Runner

- Máquina virtual temporária do GitHub: nasce, executa os passos do workflow e é destruída.
- Não é o computador do usuário nem um acesso remoto a ele.

## Estrutura de um workflow (`.yml`)

| Chave | Função |
|---|---|
| `on:` | Gatilho (o que dispara o workflow) |
| `jobs:` | Lista de trabalhos a executar |
| `runs-on:` | Sistema operacional do runner (ex.: `ubuntu-latest`) |
| `steps:` | Passos, executados em ordem |
| `uses:` | Chama uma action pronta (ex.: `actions/checkout@v4`) |
| `run:` | Executa um comando de terminal |

## `on: push` x `on: pull_request`

- **push:** dispara quando o código já foi enviado — mesmo quebrado, ele já está na branch.
- **pull_request:** dispara quando um PR é aberto ou atualizado, **antes** de o código entrar na branch de destino.

## `paths` (filtro de gatilho)

Em monorepos (vários projetos no mesmo repositório), `on: push` sozinho dispara para qualquer mudança em qualquer pasta. `paths:` restringe o gatilho a mudanças em um caminho específico.

## Pull Request e branch protection

Um push direto na `main` com teste falhando só **avisa** — não impede o código de entrar. A proteção de branch resolve isso com duas regras:

- **Require a pull request before merging:** bloqueia push direto na `main`.
- **Require status checks to pass before merging:** trava o botão de merge até os testes passarem.

> **Por que isso importa em produção:** sem essas duas regras, o CI/CD funciona só como alarme, não como barreira de qualidade.

## Tipos de teste

| Tipo | O que testa |
|---|---|
| Unidade | Código chamando código diretamente, sem interface (ex.: `verificar_horario()`) |
| Integração | Várias peças juntas (ex.: chamada real a uma API), ainda sem navegador |
| E2E / front-end | Ferramentas como Cypress/Playwright simulam cliques reais no navegador |

## Mock

Versão "falsa" de uma dependência (hardware, API) que devolve uma resposta controlada, para testar a lógica sem o recurso real. Exemplo neste repositório: `MockControladora` em [controle-acesso](./controle-acesso/sistema_acesso.py).

## Fixture

Função executada automaticamente antes de cada teste (`@pytest.fixture(autouse=True)`), garantindo que um teste não interfira nos dados de outro.

## venv (ambiente virtual)

- Erro comum: `externally-managed-environment` ao rodar `pip install` direto no sistema.
- Causa: o Ubuntu protege o Python do sistema contra instalação de bibliotecas avulsas.
- Solução: criar um ambiente isolado só para o projeto (ver [comandos](./comandos.md)).
- O isolamento é das ferramentas (pip/python); o efeito do código sobre os arquivos do projeto continua real.

## GitHub Actions x Azure DevOps

Mesmo conceito, nomes diferentes:

| GitHub Actions | Azure DevOps |
|---|---|
| runner | agente |
| `.github/workflows/*.yml` | `azure-pipelines.yml` |
| jobs / steps | stages / tasks |

Comparativo completo em [azure-devops/conceitos.md](../azure-devops/conceitos.md).
