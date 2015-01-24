
class system-base {

  $apt_keys= ['neotechnology.gpg.key', 'elasticsearch.gpg.key', 'nodesource.gpg.key']
  aptkey { $apt_keys: }

  exec { 'apt-get-init':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'apt-get update',
  }

  package { 'apt-transport-https':
    ensure => 'installed',
    require => Exec['apt-get-init'],
  }


  file {'/etc/apt/sources.list.d/custom_sources.list':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/system-base/custom_sources.list',
    require => Package['apt-transport-https'],
  }

  exec { 'apt-get-update':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'apt-get update',
    require     => File['/etc/apt/sources.list.d/custom_sources.list'],
  }


  $basic_packages = [ 'sudo', 'vim', 'tree']
  package { $basic_packages:
    ensure => 'installed',
    require => Exec['apt-get-update'],
  }

  $purge_packages= ['consolekit', 'rsyslog', 'dbus', 'dbus-x11', 'nfs-kernel-server', 'nfs-common', 'portmap']
  package { $purge_packages:
    ensure => 'purged',
    require => Exec['apt-get-update'],
  }

  define aptkey ($key_name = $title) {
    file {"/tmp/$key_name":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/system-base/$key_name",
    }
    exec { "Import $key_name to apt keystore":
      path        => '/bin:/usr/bin',
      environment => 'HOME=/root',
      command     => "apt-key add /tmp/$key_name",
      user        => 'root',
      group       => 'root',
      logoutput   => on_failure,
      refreshonly => true,
      subscribe   => File["/tmp/$key_name"],
    }
  }

  include system-base::users
  include system-base::smb
}