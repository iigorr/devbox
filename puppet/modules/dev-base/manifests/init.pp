
class dev-base {


  exec { "apt-get-init":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    command => "apt-get update",
  }

  $basics = [ "screen", "strace", "sudo", "curl", "wget", "telnet" ]
  package { $basics:
    ensure => "installed",
    require => Exec["apt-get-init"],
  }

  package { "git-core":
    ensure => installed,
  }

}