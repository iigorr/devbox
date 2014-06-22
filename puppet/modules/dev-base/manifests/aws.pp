class dev-base::aws {

  include dev-base::python

  dev-base::python::pip { 'awscli': 
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
    require => File["/home/$username/.aws/"]
  }
}
