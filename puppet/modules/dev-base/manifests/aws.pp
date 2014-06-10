class dev-base::aws {


  exec { 'install awscli':
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command => 'pip install awscli',
    unless => 'pip freeze | grep awscli',
    require => [Package["python-pip"]],
  }

  file{"/home/$username/.aws/":
      ensure => directory,
  }
  file { "aws-config":
    path    => "/home/$username/.aws/config",
    owner   => "$username",
    group   => "$username",
    mode    => '0600',
    content => template('dev-base/aws/config.erb'),
    require => File['/home/$username/.aws/']
  }
}
