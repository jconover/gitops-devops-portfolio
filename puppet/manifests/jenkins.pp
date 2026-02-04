class gitops::jenkins::baseline {
  package { 'git': ensure => installed }
  package { 'jenkins': ensure => installed }

  file { '/etc/jenkins_init.d/custom.conf':
    ensure  => file,
    content => "# managed by puppet\nJAVA_ARGS=\"-Djenkins.install.runSetupWizard=false\"\n",
    mode    => '0644',
  }

  file { '/var/lib/jenkins/jenkins.yaml':
    ensure  => file,
    content => template('gitops/jenkins_jcasc.erb'),
    owner   => 'jenkins',
    mode    => '0644',
  }

  service { 'jenkins':
    ensure => running,
    enable => true,
  }
}
