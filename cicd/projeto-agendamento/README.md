# CI/CD com GitHub Actions — Projeto Agendamento

[![Testes](https://github.com/diogodiasit/devops-sre-labs/actions/workflows/agendamento.yml/badge.svg)](https://github.com/diogodiasit/devops-sre-labs/actions/workflows/agendamento.yml)
[![Deploy](https://github.com/diogodiasit/devops-sre-labs/actions/workflows/deploy-agendamento.yml/badge.svg)](https://github.com/diogodiasit/devops-sre-labs/actions/workflows/deploy-agendamento.yml)

Pipeline completo de integração e entrega contínuas para uma aplicação Python containerizada: testes automáticos em cada Pull Request, proteção da branch principal e publicação automática da imagem no Docker Hub após o merge.

## Problema

Uma aplicação de agendamento (barbearia) precisava de um fluxo em que:

- nenhum código quebrado chegasse à `main`;
- os testes rodassem no **mesmo ambiente** em que a aplicação é empacotada, e não só na máquina de quem desenvolve;
- a imagem publicada fosse sempre a da versão aprovada, sem build ou push manual.

## Solução

| Camada | Implementação |
|---|---|
| Aplicação | [`sistema_agendamento.py`](./app/sistema_agendamento.py): regras de expediente (09h–18h), almoço (12h–13h), blocos de 30 min, conflito por barbeiro e catálogo de serviços |
| Testes | [`test_agendamento.py`](./app/test_agendamento.py): 7 testes `pytest`, com fixture que isola o estado entre os testes |
| Container | [`Dockerfile`](./app/Dockerfile): `python:3.12-slim`; copia o `requirements.txt` antes do código para reaproveitar o cache de camadas; `CMD ["pytest"]` |
| Dependências | [`requirements.txt`](./app/requirements.txt) com versões fixadas |
| CI | [`agendamento.yml`](../../.github/workflows/agendamento.yml): em todo PR para a `main`, faz o build da imagem e roda os testes **dentro do container** |
| CD | [`deploy-agendamento.yml`](../../.github/workflows/deploy-agendamento.yml): em push na `main` (ou seja, após o merge), faz login no Docker Hub com secrets, build e push de `diogojdiasit/agendamento-barbearia:latest` |
| Governança | Branch protection na `main`: *Require a pull request before merging* + *Require status checks to pass* |

```
feature branch ──► Pull Request ──► [CI] build + pytest no container ──► merge liberado
                                                                          │
                                                       push na main ◄─────┘
                                                            │
                                     [CD] docker login (secrets) → build → push Docker Hub
```

## Como rodar

Localmente, reproduzindo exatamente o que o CI faz:

```bash
cd cicd/projeto-agendamento/app
docker build -t agendamento-barbearia .
docker run --rm agendamento-barbearia
```

- `docker build -t agendamento-barbearia .`: constrói a imagem (`-t` = nome; `.` = pasta atual como contexto).
- `docker run --rm agendamento-barbearia`: executa o container, cujo `CMD` roda o `pytest`; `--rm` remove o container ao terminar.

Sem Docker, num ambiente virtual Python:

```bash
python3 -m venv venv && source venv/bin/activate   # cria e ativa o ambiente isolado
pip install -r requirements.txt                     # instala as versões fixadas
pytest                                              # roda os testes
```

Secrets necessários no repositório (**Settings > Secrets and variables > Actions**): `DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`.

## Resultado

- Todo Pull Request para a `main` executa o build e os 7 testes no container; o merge só é liberado com os checks verdes.
- Push direto na `main` é bloqueado — o deploy só acontece via merge de PR aprovado.
- Cada merge publica automaticamente a imagem `diogojdiasit/agendamento-barbearia:latest` no Docker Hub, sem credenciais no código.

## Projeto relacionado

[controle-acesso](../controle-acesso/): sistema de controle de acesso com `MockControladora`, que simula o hardware (catraca) nos testes. Foi a primeira versão do pipeline de testes e hoje fica como exemplo de testes com mock.
