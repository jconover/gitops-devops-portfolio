node 'jenkins-dev' {
  class { 'gitops::jenkins::baseline': }
}

node 'argocd-dev' {
  class { 'gitops::argocd::agent':
    argo_cluster_endpoint => 'https://k8s-api.dev.example.com',
    argo_bearer_token     => hiera('argo_bearer_token'),
  }
}
