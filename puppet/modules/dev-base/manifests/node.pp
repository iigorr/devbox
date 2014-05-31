class dev-base::node {

  exec { 'node-repo' :
    command => '/usr/bin/add-apt-repository ppa:chris-lea/node.js',
    creates => '/etc/apt/sources.list.d/chris-lea-node_js-precise.list',
    require => package['python-software-properties']
  }

  exec { 'apt-ready' :
    command => '/usr/bin/apt-get update',
    require => Exec['node-repo'],
    refreshonly => true
  }

  package { [ "nodejs" ] :
    require => Exec["apt-ready"]
  }
}