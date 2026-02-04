# Ansible Control Plane Automation

## Bootstrap

```bash
cd ansible
ansible-galaxy install -r requirements.yml
```

## Playbooks

- `playbooks/jenkins.yml`: Configures the Jenkins controller using geerlingguy roles plus JCasC template.
- `playbooks/argocd.yml`: Installs Argo CD CLI and templates kubeconfig for GitOps operations.

Inventory defaults live in `inventories/`, with additional group vars stored under `group_vars/`.
