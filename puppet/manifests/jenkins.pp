class gitops::jenkins::baseline {
  package { 'git': ensure => installed }
  file { '/etc/jenkins_init.d/custom.conf':
    ensure  => file,
    content => "# managed by puppet\nJAVA_ARGS=\"-Djenkins.install.runSetupWizard=false\"\n",
    mode    => '0644',
  }
}
