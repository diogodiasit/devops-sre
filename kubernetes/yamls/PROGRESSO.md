
### Namespaces e RBAC ✅ (só conceito)
- Lógica: namespace = pasta do cluster (nomes repetidos, permissões por pasta); Kubernetes não tem cadastro de usuários, só confere um documento (token ou certificado)
- Identidade: kubeconfig (clusters, users, contexts) diz para onde ir e como buscar o token; login central (OIDC): provedor valida a senha e emite o token; apiserver confere assinatura, aud e validade
- RBAC: Role (o que pode, em um namespace) + RoleBinding (quem recebe, grupo vindo do token); só libera, o que não está escrito é proibido; resourceNames limita a um objeto
- Extras vistos: certificate-authority-data, Forbidden como sintoma de referência errada, menor privilégio, cuidado com secrets e delete de PVC; prática no minikube pulada por decisão ("a lógica basta")
