class dev-base::python {

  $packages = [ 'python-dev']
  $pip-packages = [ 'sh', 'fabric' ]
  package { $packages:
    ensure => 'installed',
  }

  define pip ($package_name = $title) {
    exec { "pip install $package_name":
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      unless  => "pip freeze | grep $package_name",
      require => [Package["python-pip"], Package['python-dev']]
    }  
  }


  pip{ $pip-packages: }
}