# Docker — Comandos

Referência dos comandos usados nos labs de containers. O projeto prático está em [webserver/](./webserver/).

## Instalação e teste

| Comando | O que faz |
|---|---|
| `docker --version` | Mostra a versão instalada |
| `docker run hello-world` | Roda um container de teste (baixa a imagem se ela não existir localmente) |

## Executar containers

| Comando | O que faz |
|---|---|
| `docker run -d -p 8080:80 nginx` | Sobe um nginx em segundo plano (`-d` = *detached*) mapeando a porta 8080 do host para a 80 do container (`-p host:container`) |
| `docker run -d --restart unless-stopped -p 8080:80 nginx` | Igual, com política de reinício automático (ver [conceitos](./conceitos.md#políticas-de-restart)) |
| `docker run -d -p 8081:80 meu-webserver` | Roda a imagem própria em outra porta |
| `docker exec -it <CONTAINER_ID> bash` | Abre um shell dentro de um container em execução (`-i` = interativo, `-t` = terminal) |

## Ciclo de vida

| Comando | O que faz |
|---|---|
| `docker ps` | Containers em execução |
| `docker ps -a` | Todos os containers, inclusive os parados (`-a` = *all*) |
| `docker start <CONTAINER_ID>` | Religa um container existente e parado, mantendo a configuração (inclusive a porta) |
| `docker stop <CONTAINER_ID>` | Para um container em execução |
| `docker rm <CONTAINER_ID>` | Remove um container (precisa estar parado) |

**`run` x `start`**

- `docker run` cria um container **novo** (porta e opções são definidas de novo).
- `docker start` religa um container **existente**, com a configuração anterior.
- Um container parado (`Exited`) ainda existe; um container removido (`rm`) deixa de existir.

## Imagens

| Comando | O que faz |
|---|---|
| `docker images` | Lista as imagens locais |
| `docker build -t meu-webserver .` | Constrói uma imagem a partir do Dockerfile (`-t` = nome/tag; `.` = pasta atual como contexto de build) |

Dockerfile mínimo usado no lab:

```dockerfile
# Parte de uma imagem base pronta
FROM nginx:alpine
# Copia o arquivo local para dentro da imagem
COPY index.html /usr/share/nginx/html/index.html
```

> Os arquivos usados em `COPY` precisam estar dentro do **contexto de build** (a pasta do build e suas subpastas — nunca fora dela, como `../`).

## Logs

| Comando | O que faz |
|---|---|
| `docker logs -f <nome_ou_id>` | Acompanha os logs do container em tempo real (`-f` = *follow*) |

> Equivalente ao `journalctl -f`, mas para containers. Containers normalmente não rodam systemd, então `journalctl` não funciona dentro deles.

## Docker Compose

Arquivo do lab: [docker-compose.yml](./docker-compose.yml) — sobe o site (build local) e um PostgreSQL com volume persistente.

```bash
cp .env.example .env      # define a senha do banco fora do arquivo versionado
docker compose up -d      # sobe todos os serviços em segundo plano (-d = detached)
docker compose ps         # lista os serviços do projeto
docker compose down       # derruba os serviços (o volume nomeado é mantido)
```
