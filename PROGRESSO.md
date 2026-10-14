# 🎮 Progresso — Jornada DevOps/SRE

**Personagem:** 🧝‍♂️ Diogo Dias, o Elfo Mago da Tecnologia
**Nível atual:** 5 — Automatizador de Pipelines
**XP total:** 850
**Próximo nível:** 6 — Mestre da Nuvem (faltam 150 XP)

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
- [ ] Fase 8 — Terraform
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
