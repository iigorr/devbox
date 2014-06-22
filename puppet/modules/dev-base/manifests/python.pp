class dev-base::python {

  $packages = [ ]
  package { $packages:
    ensure => 'installed',
  }

  define pip ($package_name = $title) {
    exec { "pip install $package_name":
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      unless  => "pip freeze | grep $package_name",
      require => [Package["python-pip"]]
    }  
  }
}