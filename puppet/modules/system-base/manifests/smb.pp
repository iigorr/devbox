
class system-base::smb {
  
  package { [ 'samba', 'samba-common']:
    ensure => 'installed',
    require => Exec['apt-get-init'],
  }

  service { 'smbd':
    ensure     => running,
    hasrestart => true,
    pattern    => 'smbd',
    require    => Package['samba'],
    subscribe  => File['/etc/samba/smb.conf'],
  }

  file { '/etc/samba':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package['samba'],
  }

  file { '/etc/samba/smb.conf':
    owner   => root,
    group   => root,
    mode    => 755,
    content => template('system-base/smb.conf.erb'),
  }
}