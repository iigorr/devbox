
class dev-base {

  $basics = [ 'screen', 'strace', 'curl', 'wget', 'telnet', 'python', 'python-pip', 'git-core', 'neo4j', 'elasticsearch']
  package { $basics:
    ensure => 'installed',
    require => [Exec['apt-get-update'], System-base::Aptkey['elasticsearch.gpg.key'], System-base::Aptkey['neotechnology.gpg.key']],
  }

  file { "/home/$username/.gitconfig":
    ensure  => file,
    owner   => $username,
    group   => $username,
    source  => 'puppet:///modules/dev-base/.gitconfig',
    require => [User[$username], Package['git-core']],
  }

  include dev-base::python
  include dev-base::aws
  include dev-base::node
}