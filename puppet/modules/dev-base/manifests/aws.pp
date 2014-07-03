class dev-base::aws {

  include dev-base::python

  $pip_packages= ['awscli', 'boto']
  dev-base::python::pip { $pip_packages: 
  }

  file{"/home/$username/.aws/":
    ensure => directory,
    require => User[$username],
  }
  
  file { "aws-config":
    path    => "/home/$username/.aws/config",
    owner   => "$username",
    group   => "$username",
    mode    => '0600',
    content => template('dev-base/aws/config.erb'),
    require => File["/home/$username/.aws/"]
  }
}
