
class system-base::users {
  
  user { $username:
    ensure     => "present",
    shell      => '/bin/bash',
    home       => "/home/$username",
    managehome => true,
    password   => $password,
    password_max_age => '99999',
    password_min_age => '0',
    groups     => ["users", "adm", "sudo"],
    require    => [ Package["sudo"]]
  }

  
  file { "/home/$username/.ssh":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => 700,
    require => User[$username]
  }

  file {"/home/$username/.ssh/authorized_keys":
    content => $public_key,
    owner   => $username,
    group   => $username,
    mode    => 600,
    require => File["/home/$username/.ssh"],
  }

  file { "/home/$username/.bashrc":
    ensure  => file,
    owner   => $username,
    group   => $username,
    source  => "puppet:///modules/system-base/.bashrc",
    require => User[$username],
  }

  file { "/etc/profile":
    ensure  => file,
    owner   => $username,
    group   => $username,
    source  => "puppet:///modules/system-base/profile",
    require => User[$username],
  }
}