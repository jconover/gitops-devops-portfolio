# Terraform Modules & Environments

## Modules

- `terraform/modules/vpc`: Provisions VPC, public/private subnets, NAT gateways, route tables, and exports subnet IDs plus the EKS node security group.
- `terraform/modules/eks`: Thin wrapper around the official EKS module with opinionated defaults and managed node group settings.
- `terraform/modules/jenkins`: Creates a Jenkins EC2 instance with dedicated security group, user-data bootstrap, and outputs for public/private IPs (defaults to the latest Canonical Ubuntu 24.04 AMI unless overridden).
- `terraform/modules/argocd_host`: Stands up a lightweight VM that can host the Argo CD CLI/UI and GitOps tooling (also defaults to Ubuntu 24.04).
- `terraform/bootstrap`: Stands up the remote-state S3 bucket and DynamoDB lock table.

## Environment Inputs

Each environment under `terraform/environments/<env>` consumes the modules via `terraform.tfvars`. Example inputs are provided as `terraform.tfvars.example` for dev/stage/prod; copy to `terraform.tfvars` and adjust CIDRs, node groups, and regions per deployment.

## Outputs

- `module.vpc.public_subnet_ids`: Use for public load balancers or bastion hosts.
- `module.vpc.private_subnet_ids`: Feed into EKS, databases, or internal services.
- `module.vpc.eks_node_security_group_id`: Apply to worker nodes or other compute requiring same policies.
- `module.eks.cluster_name`, `module.eks.kubeconfig`: Cluster identifiers and API endpoint (sensitive) for CI/CD wiring.
- `module.jenkins.public_ip` / `module.argocd_host.public_ip`: External IP addresses for the automation hosts (also exported at the environment level for convenience).

## Usage

```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

Repeat for `stage` or `prod` after adjusting inputs/remote state configuration.
