class maven {

  package { "openjdk-7-jdk":
    ensure => "installed",
  }

  file { "/etc/profile.d/java.sh":
    ensure => file,
    content => 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")'
  }

  exec { "set-java-home":
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command => 'sh /etc/profile.d/java.sh',
    require => [Package["openjdk-7-jdk"], File["/etc/profile.d/java.sh"]]
  }

  package { "maven2":
    ensure => "installed",
    require => Exec["set-java-home"]
  }
}