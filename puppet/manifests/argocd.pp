class gitops::argocd::agent {
  package { 'argocd':
    ensure   => installed,
    provider => 'apt',
  }
  file { '/etc/argocd/kubeconfig':
    ensure  => file,
    content => template('gitops/argocd_kubeconfig.erb'),
    mode    => '0600',
  }
}
