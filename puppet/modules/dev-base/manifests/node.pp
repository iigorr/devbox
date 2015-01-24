class dev-base::node {


  package { [ "nodejs" ] :
    ensure => installed,
    require => [Exec['apt-get-update'], System-base::Aptkey['nodesource.gpg.key']],
  }

  define npm ($package_name = $title) {
    $nodebase = '/usr/lib/node_modules/'

    exec { "/usr/bin/npm -g install $package_name":
      creates => "$nodebase/$package_name"
    }
  }

  npm { ['grunt-cli', 'mocha', 'bower']:
    require => Package['nodejs']
  }

}