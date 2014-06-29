
class system-base {

  file {'/tmp/neotechnology.gpg.key':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/system-base/neotechnology.gpg.key',
  }

  exec { "Import neotechnology key to apt keystore":
    path        => '/bin:/usr/bin',
    environment => 'HOME=/root',
    command     => 'apt-key add /tmp/neotechnology.gpg.key',
    user        => 'root',
    group       => 'root',
    unless      => 'apt-key list | grep neotechnology',
    logoutput   => on_failure,
    require     => File['/tmp/neotechnology.gpg.key'],
  }

  file {'/etc/apt/sources.list.d/neo4j.list':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/system-base/neo4j.list',
  }


  exec { 'apt-get-init':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'apt-get update',
    refreshonly => true,
    require     => File['/etc/apt/sources.list.d/neo4j.list'],
  }


  $basics = [ 'sudo', 'vim', 'tree', 'python-software-properties']
  package { $basics:
    ensure => 'installed',
    require => Exec['apt-get-init'],
  }

  include system-base::users
  include system-base::smb
}