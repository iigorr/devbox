
class system-base {
  
  exec { 'apt-get-init':
    path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command => 'apt-get update',
    refreshonly => true
  }


  $basics = [ 'sudo', 'vim', 'python-software-properties']
  package { $basics:
    ensure => 'installed',
    require => Exec['apt-get-init'],
  }

  include system-base::users
}