
class dev-base {

  $basics = [ "screen", "strace", "curl", "wget", "telnet"]
  package { $basics:
    ensure => "installed",
  }

  package { "git-core":
    ensure => installed,
  }

  file { "/home/$username/.gitconfig":
    ensure  => file,
    owner   => $username,
    group   => $username,
    source  => "puppet:///modules/dev-base/.gitconfig",
    require => [User[$username], Package['git-core']],
  }

  include dev-base::ruby
}