
class dev-base::php {

  $packages = [ "php5" ]
  package { $packages:
    ensure => "installed",
  }


}