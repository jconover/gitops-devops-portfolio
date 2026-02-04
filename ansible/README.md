# Ansible Control Plane Automation

## Bootstrap

```bash
cd ansible
ansible-galaxy install -r requirements.yml
```

## Playbooks

- `playbooks/jenkins.yml`: Configures the Jenkins controller using geerlingguy roles plus JCasC template.
- `playbooks/argocd.yml`: Installs Argo CD CLI and templates kubeconfig for GitOps operations.

Inventory defaults live in `inventories/`, with additional group vars stored under `group_vars/`. After Terraform deploys the automation hosts, update the inventory hostnames/IPs (or use dynamic inventory) using the `jenkins_public_ip`, `argocd_public_ip`, `awx_public_ip`, and `puppet_public_ip` outputs from the corresponding environment.
