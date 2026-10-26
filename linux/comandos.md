# Linux — Comandos

Referência dos comandos de administração Linux usados nos labs (Ubuntu no WSL).

## Navegação e arquivos

| Comando | O que faz |
|---|---|
| `pwd` | Mostra o diretório atual |
| `ls` | Lista arquivos e pastas do diretório atual |
| `ls -la` | Lista com detalhes (`-l`) e inclui arquivos ocultos (`-a`) |
| `mkdir nome` | Cria uma pasta (*make directory*) |
| `cd nome` | Entra em uma pasta (*change directory*) |
| `cd ..` | Volta um nível (`..` = pasta pai) |
| `touch arquivo.txt` | Cria um arquivo vazio |
| `cat arquivo.txt` | Exibe o conteúdo de um arquivo |
| `echo 'texto' > arquivo.txt` | Escreve no arquivo **substituindo** o conteúdo (`>`) |
| `echo 'texto' >> arquivo.txt` | **Adiciona** ao final do arquivo, sem apagar o que existe (`>>`) |

## Copiar, mover e remover

| Comando | O que faz |
|---|---|
| `cp origem.txt destino.txt` | Copia um arquivo |
| `cp -r pasta-origem/ pasta-destino/` | Copia uma pasta inteira (`-r` = recursivo) |
| `mv antigo.txt novo.txt` | Move **ou** renomeia um arquivo |
| `rm arquivo.txt` | Apaga um arquivo (sem lixeira, sem volta) |
| `rm -r pasta/` | Apaga a pasta e todo o conteúdo |
| `rmdir pasta/` | Apaga a pasta somente se estiver vazia |

## Busca em arquivos

| Comando | O que faz |
|---|---|
| `grep 'palavra' arquivo` | Procura a palavra e destaca onde aparece |
| `grep -i "palavra" arquivo` | Ignora maiúsculas/minúsculas (`-i` = *ignore case*) |
| `grep -v "palavra" arquivo` | Mostra as linhas que **não** contêm a palavra (`-v` = *invert*) |
| `grep -n "palavra" arquivo` | Mostra o número da linha (`-n` = *number*) |
| `grep -c "palavra" arquivo` | Conta as linhas que contêm a palavra (`-c` = *count*) |
| `grep -r "palavra" .` | Busca em todos os arquivos da pasta atual (`-r` = recursivo) |
| `find . -name "*.txt"` | Busca arquivos terminados em `.txt` a partir da pasta atual |
| `find . -name "*.log"` | Busca arquivos de log |
| `find . -type f` | Só arquivos (`f` = *file*) |
| `find . -type d` | Só pastas (`d` = *directory*) |
| `find . -name "*.txt" -type f` | Combina filtros: arquivos terminados em `.txt` |
| `wc -l arquivo` | Conta linhas (`wc` = *word count*, `-l` = *lines*) |
| `wc -w arquivo` | Conta palavras (`-w` = *words*) |
| `wc -c arquivo` | Conta caracteres/bytes (`-c`) |

## Permissões

Cada dígito do `chmod` é a soma de `r` = ler (4), `w` = escrever (2), `x` = executar (1), na ordem **dono / grupo / outros**.

| Comando | O que faz |
|---|---|
| `chmod 600 arquivo` | Dono lê e escreve (6); grupo e outros sem acesso (0) — uso típico: chaves e segredos |
| `chmod 644 arquivo` | Dono lê e escreve (6); grupo e outros só leem (4) — padrão para arquivos comuns |
| `chmod 755 arquivo` | Dono tudo (7); grupo e outros leem e executam (5) — padrão para scripts e pastas |
| `chmod 777 arquivo` | Todos com todas as permissões — **evitar em produção** |

## Processos e recursos

| Comando | O que faz |
|---|---|
| `ps aux` | Lista todos os processos (`a` = todos os usuários, `u` = mostra o dono, `x` = inclui processos sem terminal) |
| `ps aux \| grep nome` | Filtra processos pelo nome (`\|` = pipe, passa a saída de um comando para o próximo) |
| `top` | Processos em tempo real, equivalente ao Gerenciador de Tarefas (sair: `q`) |
| `df -h` | Espaço em disco (`df` = *disk free*, `-h` = formato legível KB/MB/GB) |
| `free -h` | Uso de memória RAM e swap (`-h` = formato legível) |

## Serviços (systemd)

| Comando | O que faz |
|---|---|
| `systemctl status servico` | Estado atual do serviço (active/inactive) |
| `systemctl start servico` | Inicia o serviço |
| `systemctl stop servico` | Para o serviço |
| `systemctl restart servico` | Para e inicia novamente |
| `systemctl enable servico` | Ativa a inicialização automática no boot |
| `systemctl disable servico` | Desativa a inicialização automática |

## Logs (journald)

| Comando | O que faz |
|---|---|
| `journalctl` | Todos os logs do sistema, sem filtro |
| `journalctl -u servico` | Logs de um serviço específico (`-u` = *unit*) |
| `journalctl -u servico -f` | Acompanha os logs do serviço em tempo real (`-f` = *follow*, como `tail -f`) |
| `journalctl -f` | Acompanha todos os logs ao vivo |

> **Uso em troubleshooting:** deixar `journalctl -f` aberto enquanto se reproduz o erro mostra o problema acontecendo na hora. Só funciona para serviços gerenciados pelo systemd no host; dentro de containers, use `docker logs -f`.

## Variáveis de ambiente e shell

| Comando | O que faz |
|---|---|
| `env` | Lista todas as variáveis de ambiente |
| `echo $VARIAVEL` | Exibe o valor de uma variável (`$` acessa o valor) |
| `NOME="valor"` | Cria uma variável local do shell (some ao fechar o terminal) |
| `export NOME="valor"` | Cria a variável e a disponibiliza para os processos filhos |
| `export PATH="/novo/caminho:$PATH"` | Adiciona um caminho ao `PATH` sem apagar os existentes |
| `source ~/.bashrc` | Recarrega a configuração do shell sem fechar o terminal |

`~/.bashrc` é o arquivo de configuração do Bash, executado sempre que um terminal interativo é aberto.

## Pacotes (apt)

| Comando | O que faz |
|---|---|
| `sudo apt update` | Atualiza a lista de pacotes disponíveis |
| `sudo apt upgrade` | Instala as atualizações dos pacotes já instalados |
| `sudo apt install nginx` | Instala um pacote (exemplo: nginx) |
| `sudo apt remove nginx` | Desinstala, mantendo os arquivos de configuração |
| `sudo apt purge nginx` | Desinstala tudo, incluindo as configurações |
