
class dev-base::ruby {

  $packages = [ "ruby1.9.1", "rubygems" ]
  package { $packages:
    ensure => "installed",
  }


}