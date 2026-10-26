# CI/CD — Comandos

Comandos usados para preparar e testar os projetos Python antes de levá-los para o pipeline.

## Ambiente virtual Python (venv)

| Comando | O que faz |
|---|---|
| `python3 -m venv venv` | Cria um ambiente virtual isolado na pasta `venv/` (`-m venv` executa o módulo venv) |
| `source venv/bin/activate` | Ativa o ambiente (o prompt passa a mostrar `(venv)`) |
| `deactivate` | Sai do ambiente virtual |

> A pasta `venv/` é gerada localmente e está no `.gitignore` — nunca é versionada.

## Testes

| Comando | O que faz |
|---|---|
| `pip install pytest` | Instala o framework de testes dentro do venv |
| `pip install -r requirements.txt` | Instala as dependências com as versões fixadas no arquivo (`-r` = ler de arquivo) |
| `pytest` | Executa todos os arquivos `test_*.py` da pasta atual |

## GitHub Actions

| Comando | O que faz |
|---|---|
| `mkdir -p .github/workflows` | Cria a pasta onde o GitHub Actions procura os workflows (`-p` = cria as pastas intermediárias e não falha se já existirem) |

## Rodar os testes no container (igual ao pipeline)

```bash
cd cicd/projeto-agendamento/app
docker build -t agendamento-barbearia .   # -t = nome da imagem; . = contexto de build
docker run agendamento-barbearia          # o CMD da imagem executa o pytest
```
