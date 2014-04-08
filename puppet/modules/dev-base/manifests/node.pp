
class dev-base::node {

  $packages = [ "nodejs" ]
  package { $packages:
    ensure => "installed",
  }


}