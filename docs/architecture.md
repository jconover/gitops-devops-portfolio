# Architecture Notes

- Terraform provisions AWS foundations (VPC, subnets, IAM, EKS, Jenkins host, Argo CD bootstrap).
- Configuration management layering: Ansible for initial provisioning, Puppet for continuous drift control.
- CI/CD split: GitHub Actions handles developer feedback; Jenkins handles gated promotions.
- GitOps repo (this repo for now) drives Argo CD + Rollouts deployments to EKS environments.
