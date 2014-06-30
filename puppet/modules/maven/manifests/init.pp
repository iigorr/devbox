class maven {

  package { "openjdk-7-jdk":
    ensure  => "installed",
    require => Exec['apt-get-init']
  }

  file { "/etc/profile.d/java.sh":
    ensure => file,
    content => 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")'
  }

  exec { "set-java-home":
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command => 'sh /etc/profile.d/java.sh',
    require => [Package["openjdk-7-jdk"], File["/etc/profile.d/java.sh"]],
    refreshonly => true,
  }

  exec { "set-java7-alternative":
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command => 'update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java',
    require => Package["openjdk-7-jdk"],
  }
 
  package { "maven":
    ensure => "installed",
    require => Exec["set-java-home"]
  }
}