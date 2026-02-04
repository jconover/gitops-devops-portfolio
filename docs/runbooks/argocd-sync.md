# Argo CD Sync Failure Runbook

1. Check Argo CD app status: `argocd app get demo-api`.
2. Inspect events in EKS namespace `demo` for rollout details.
3. If drift is intentional, update manifests via Jenkins GitOps promotion step.
4. Roll back using `argocd app rollback demo-api <REVISION>` when necessary.
