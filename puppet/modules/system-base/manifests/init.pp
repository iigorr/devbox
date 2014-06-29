
class system-base {

  $apt_keys= ['neotechnology.gpg.key', 'elasticsearch.gpg.key']
  
  aptkey {$apt_keys: }

  file {'/etc/apt/sources.list.d/custom_sources.list':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/system-base/custom_sources.list',
  }


  exec { 'apt-get-init':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'apt-get update',
    refreshonly => true,
    require     => File['/etc/apt/sources.list.d/custom_sources.list'],
  }


  $basic_packages = [ 'sudo', 'vim', 'tree', 'python-software-properties']
  package { $basic_packages:
    ensure => 'installed',
    require => Exec['apt-get-init'],
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
      unless      => "apt-key list | grep $key_name",
      logoutput   => on_failure,
      require     => File["/tmp/$key_name"],
    } 
  }

  include system-base::users
  include system-base::smb
}