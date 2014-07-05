class dev-base::python {

  $packages = [ 'python-dev']
  $pip_packages = [ 'sh', 'fabric', 'configparser' ]
  package { $packages:
    ensure  => 'installed',
    require => Exec['apt-get-init'],
  }

  define pip ($package_name = $title) {
    exec { "pip install $package_name":
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      unless  => "pip freeze | grep -i '^$package_name='",
      require => [Package["python-pip"], Package['python-dev']]
    }  
  }


  pip{ $pip_packages: }
}