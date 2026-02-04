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

### Dynamic Inventory via Terraform

The repository includes `inventories/terraform.yml`, which uses the `community.general.terraform` inventory plugin to read host data directly from the Terraform state in `terraform/environments/dev`. The local `ansible.cfg` enables the plugin and sets the inventory path so you can simply run commands from this directory. After running `terraform apply`, execute:

```bash
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventories/terraform.yml playbooks/jenkins.yml
```

If you prefer a static file, use `inventories/dev.ini.example` as a template, but keep real host/IP data in a local `inventories/dev.ini` (ignored from git).
