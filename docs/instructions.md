# GitOps Control Plane Instructions

This guide walks through provisioning the infrastructure, configuring automation hosts, and deploying the demo application.

## Prerequisites

- AWS credentials with permissions for VPC, EC2, IAM, EKS, S3, DynamoDB.
- Terraform >= 1.6, Ansible >= 2.15, kubectl, argocd CLI, and docker installed locally.
- SSH key pair registered in AWS (referenced via `key_name`).

## 1. Bootstrap Remote State

```bash
cd terraform/bootstrap
terraform init
terraform apply -var "bucket_name=gitops-devops-portfolio-tfstate" \
  -var "dynamodb_table_name=gitops-devops-portfolio-locks"
```

## 2. Configure Environment Variables

For each environment (dev/stage/prod), copy the tfvars example and edit values:

```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
# update CIDRs, key_name, CIDR allow-lists, etc.
```

## 3. Provision Infrastructure

```bash
terraform init
terraform apply
```

Outputs will include VPC IDs, EKS details, and automation host public IPs (Jenkins, Argo, AWX, Puppet).

## 4. Configure Automation Hosts via Ansible

Use the Terraform dynamic inventory:

```bash
cd ../../..
cd ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventories/terraform.yml playbooks/jenkins.yml
ansible-playbook -i inventories/terraform.yml playbooks/argocd.yml
# TODO: add AWX/Puppet playbooks or roles as needed
```

## 5. Puppet Control Repo

Apply Puppet manifests on the Puppet server (or integrate with a control repo) to enforce Jenkins/Argo configurations:

```bash
puppet apply -e 'include gitops::jenkins::baseline'
```

## 6. Deploy Demo Service via GitOps

1. Build/push the `services/demo-api` container (CI pipeline).
2. Update manifests/Helm values in `gitops/apps/demo-api.yaml` as needed.
3. Argo CD syncs the application to EKS (`argocd app sync demo-api`).

## 7. Optional Enhancements

- Configure AWX job templates to run the Ansible playbooks automatically.
- Wire Jenkins pipelines to trigger AWX jobs and update the GitOps repo.
- Set up DNS/SSL for automation host UIs using Route53 and ACM.
- Document Day-2 operations (upgrades, rollback runbooks) in `docs/runbooks/`.
