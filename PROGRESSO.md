# 🎮 Progresso — Jornada DevOps/SRE

**Personagem:** 🧝‍♂️ Diogo Dias, o Elfo Mago da Tecnologia
**Nível atual:** 5 — Automatizador de Pipelines
**XP total:** 990
**Próximo nível:** 6 — Mestre da Nuvem (faltam 10 XP)

---

## 🏅 Badges conquistadas

- 🐧 Dominador do Terminal (Fase 1 - Linux)
- 🔀 Mestre do Git (Fase 2 - Git)
- 🌐 Detetive de Redes (Fase 3 - Redes)
- 🔑 Guardião das Chaves (Fase 3 - SSH)
- 🐳 Domador de Containers (Fase 4 - Docker)
- 📦 Publicador de Imagens (Fase 4 - Docker Hub)
- 🔄 Mestre do CI/CD (Fase 5 - Pipelines automatizados)
- 🛡️ Guardião da Branch Protegida (Fase 5 - Branch Protection)
- ☁️ Poliglota da Nuvem (Fase 6 - Azure DevOps)

---

## 🗺️ Mapa de fases

- [x] Fase 1 — Linux (pasta: 01-linux)
- [x] Fase 2 — Git (pasta: 02-git)
- [x] Fase 3 — Redes básicas (pasta: 03-redes-basicas)
- [x] Fase 4 — Docker (pasta: 04-docker) — containers, volumes, compose, Docker Hub
- [x] Fase 5 — CI/CD (pasta: 05-cicd) — GitHub Actions, PR automatizado, branch protection, build e publicação automática de imagem Docker
- [x] Fase 6 — Azure DevOps (pasta: 06-azure-devops) — Azure Repos, Pipelines, Service Connections, Branch Policies
- [x] Fase 7 — Kubernetes (pasta: 07-kubernetes) — Deployment, Service, Ingress, ConfigMap e Secret, probes, HPA, volumes persistentes, namespaces e RBAC (conceito), AKS (conceito)
- [x] Fase 8 — Terraform (pasta: 08-terraform) — IaC, providers, variables e outputs, state, ciclo init/validate/plan/apply/destroy, fluxo de PR com esteira de IaC; laboratório local praticado e código Azure (azurerm) validado, sem apply (crédito expirado)
- [ ] Fase 9 — Monitoramento
- [ ] Fase 10 (chefão final) — Projetos de entrevista real, incluindo migração on-premise → Azure

---

## 📅 Streak

- Dias estudando: (atualizar a cada sessão)

---

## Como o XP funciona

- Aprender um conceito novo: +20 XP
- Praticar de verdade no terminal: +30 XP
- Completar um quiz/desafio: +20 XP
- Commitar no GitHub: +10 XP
- Errar e tentar de novo: +10 XP (errar também conta, porque é tentativa)
- Projetos extras/divertidos não contam XP — são só diversão, separados do progresso oficial

### HPA (Horizontal Pod Autoscaler) ✅
- Lógica: HPA decide quantos pods pela média de CPU em % do `requests`; metrics-server mede; `limits` é o teto
- Prática: escala de 2 → 6 pods com gerador de carga e volta para 2 após a janela de 5 min
- Debug: `describe hpa` (Metrics, Conditions, Events); bug de `requests` ausente → `<unknown>`
- Extras vistos: Cluster Autoscaler, overprovisioning, rolling update, Events x logs, limpeza do cluster

### Volumes persistentes ✅
- Lógica: pod é descartável; disco fica fora dele. PVC = pedido (nome fixo, o que o pod usa), PV = disco real registrado (criado sozinho), StorageClass = tipo de disco, driver CSI = tradutor com a nuvem
- Prática: PVC de 1Gi no minikube → Bound; pod gravador escreve nota; pod apagado; pod leitor novo lê a mesma nota; limpeza com reclaimPolicy Delete
- Regras: pod aponta para o PVC (nunca o PV); 1 PVC = 1 PV; tamanho só aumenta; nome não muda; Retain em produção
- Extras vistos: snapshot e backup (disco persistente não é backup), responsabilidade compartilhada com a nuvem, StatefulSet só no conceito, custo do projeto final na Azure

### AKS ✅ (só conceito)
- Lógica: AKS = Kubernetes com o Control Plane gerenciado pela Azure; eu cuido de nodes, rede, segurança, atualizações, custo e aplicações
- Comparação: sem AKS (self-managed) eu monto e mantenho o Control Plane, o etcd, os certificados e as atualizações
- Extras vistos: responsabilidade compartilhada, SaaS x PaaS x IaaS, Standard x Automatic x Fleet Manager, AKS x Container Apps x ACI, atualizações (canais, nodes, imagem), custo e conta de estudante

### Terraform ✅ (laboratório local; Azure só código validado)
- Lógica: Terraform = infraestrutura em código; descrevo o que quero (declarativo); provider = tradutor que fala com a plataforma; state = comanda que liga cada item do código ao recurso real e nunca vai pro Git
- Prática: instalei Terraform e Azure CLI no WSL; laboratório local (providers local e random) com init, validate, plan, apply e state (3 recursos); laboratório Azure (Resource Group, VNet, Storage Account) escrito e validado com `terraform validate`
- Debug: `az login --use-device-code` com código expirado; subscription em estado Warned (crédito de teste acabou) não cria recursos e o Azure CLI a esconde da lista (`az account list --all`)
- Regras: plan não altera nada; apply só depois de revisão; referência TIPO.APELIDO.CAMPO cria dependência entre recursos; state nunca editado na mão
- Extras vistos: fluxo real (branch, PR com plan, merge, apply com aprovação via Environment), gatilhos push e pull_request, drift, Bicep x Terraform x Ansible, OpenTofu, crédito do Azure (US$ 200 em 30 dias) e Azure for Students
