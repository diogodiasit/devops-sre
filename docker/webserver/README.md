# Webserver containerizado com Docker Compose

Servidor web Nginx construído a partir de um Dockerfile próprio, orquestrado com um PostgreSQL via Docker Compose e publicado no Docker Hub.

## Problema

Empacotar um site estático de forma reprodutível, rodá-lo junto com um banco de dados com persistência e distribuir a imagem para qualquer máquina.

## Solução

| Peça | Implementação |
|---|---|
| Imagem | [`Dockerfile`](./Dockerfile): `FROM nginx:alpine` + `COPY` do [`index.html`](./index.html) |
| Orquestração | [`docker-compose.yml`](../docker-compose.yml): serviço `site` (build local, porta `8083:80`) e `banco` (`postgres:16`) |
| Persistência | Volume nomeado `dados-postgres` montado em `/var/lib/postgresql/data` |
| Segredo | Senha do banco lida de `.env` (não versionado); modelo em [`.env.example`](../.env.example) |
| Distribuição | Imagem publicada em `docker.io/diogojdiasit/estudos-devops-webserver` (tag + push) |

## Como rodar

Com Docker Compose (site + banco):

```bash
cd docker
cp .env.example .env        # defina a senha do banco no .env
docker compose up -d        # build do site e subida dos serviços em segundo plano
```

Acesse `http://localhost:8083`.

Só a imagem publicada:

```bash
docker pull diogojdiasit/estudos-devops-webserver
docker run -d -p 8080:80 diogojdiasit/estudos-devops-webserver
```

- `-d`: roda em segundo plano; `-p 8080:80`: porta 8080 do host → porta 80 do container.

## Resultado

- Site servido pelo Nginx em container, a partir de imagem própria.
- Banco PostgreSQL com dados preservados no volume entre recriações do container.
- Imagem disponível publicamente no Docker Hub.

Demonstração em vídeo: [Google Drive](https://drive.google.com/file/d/1iAQM2N8m5RQ0xifzyF-sENz_NpfXmMSV/view?usp=drive_link)

Conceitos aplicados: Dockerfile (`FROM`, `COPY`), Compose (`services`, `build`, `image`, `ports`, `environment`, `volumes`), volumes para persistência, publicação no Docker Hub e indentação YAML (2 espaços por nível).
