# GitOps DevOps Control Plane

A hands-on portfolio project demonstrating how to fuse infrastructure as code, CI/CD automation, and GitOps practices on AWS. The control plane provisions everything needed for a demo microservice platform, from networking to application rollout, and then keeps it compliant across environments.

## Objectives

1. Provision an opinionated AWS baseline (VPC, EKS, artifact storage, Jenkins host) using Terraform modules and remote state locking.
2. Apply base OS and application configuration with Ansible while showcasing Puppet for ongoing drift detection/remediation.
3. Build and test containerized microservices via GitHub Actions, then promote artifacts through Jenkins pipelines with automated security checks.
4. Drive continuous delivery with Argo CD + Argo Rollouts, illustrating progressive delivery patterns and GitOps workflows.
5. Capture Day-2 operations such as observability, incident response, and ChatOps notifications for a realistic portfolio narrative.

## High-Level Architecture

- **Infrastructure Layer (Terraform)**: Core modules for networking, compute, storage, and IAM. Terraform Cloud or S3/DynamoDB handles remote state. Includes reusable modules for VPC, EKS, Jenkins EC2, and supporting services like ECR and S3 buckets for artifacts.
- **Configuration Layer (Ansible & Puppet)**: Ansible playbooks bootstrap Jenkins, Argo CD CLI, and cluster add-ons. Puppet agents run on long-lived hosts (e.g., Jenkins EC2, bastion) to enforce configuration drift policies and emit compliance reports.
- **CI Layer (GitHub Actions & Jenkins)**:
  - GitHub Actions: lint Terraform, run docker builds, unit tests, and push images to ECR on pull requests.
  - Jenkins: orchestrates integration tests, vulnerability scans, image signing, and promotion by pushing manifest updates into the GitOps repo.
- **CD/GitOps Layer (Argo CD + Rollouts)**: A dedicated GitOps repository stores Kubernetes manifests and Helm charts. Argo CD syncs dev/stage/prod apps and leverages Argo Rollouts for blue/green or canary strategies. Notifications flow into Slack/Teams via webhooks.
- **Observability & Ops**: Prometheus/Grafana stack deployed via Helm, log shipping with Fluent Bit, and runbooks documented in the repo. Event hooks trigger ChatOps alerts on drift or failed syncs.

## Repository Structure (planned)

```
gitops-devops-portfolio/
├── README.md
├── docs/
│   ├── architecture.drawio
│   └── runbooks/
├── terraform/
│   ├── modules/
│   └── environments/
├── ansible/
│   ├── inventories/
│   └── playbooks/
├── puppet/
│   └── manifests/
├── services/
│   └── demo-api/
├── pipelines/
│   ├── github-actions/
│   └── jenkins/
└── gitops/
    └── apps/
```

## Roadmap

1. **Infrastructure bootstrap**: Define Terraform root module, set up remote state backend, and provision shared AWS resources.
2. **Cluster & tooling**: Deploy EKS, configure Argo CD, and stand up Jenkins with Ansible automation.
3. **Sample services**: Add at least one microservice (API + worker) with Dockerfiles, Helm charts, and automated tests.
4. **Pipelines**: Implement GitHub Actions workflow for PR validation and Jenkins pipeline for promotion/security checks.
5. **GitOps rollout**: Wire Jenkins to push manifest changes into `gitops/` and demonstrate Argo CD sync/rollback scenarios.
6. **Ops polish**: Add observability stack, drift dashboards, ChatOps notifications, and documentation/screenshots for your portfolio site.

## Next Actions

- Initialize Terraform module skeletons (`terraform/modules/{vpc,eks,jenkins}`) and environment definitions.
- Draft Ansible inventory/playbook placeholders plus Puppet manifest stubs.
- Scaffold demo service directory with starter Dockerfile and Helm chart template.
