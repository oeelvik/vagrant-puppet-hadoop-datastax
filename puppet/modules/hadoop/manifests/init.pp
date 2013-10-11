class hadoop {

  realize Class['apt']
  apt::ppa { 'ppa:hadoop-ubuntu/stable': }
 
  package { 'hadoop':
    ensure => "latest",
    require => Apt::Ppa['ppa:hadoop-ubuntu/stable'],
  }
  
  exec {
    'set-hadoop-env':
      command => '/bin/echo "export JAVA_HOME=/usr/lib/jvm/java-6-oracle" >> /usr/lib/hadoop/conf/hadoop-env.sh',
      unless => "/bin/grep java-6-oracle /usr/lib/hadoop/conf/hadoop-env.sh",
      require => Package['hadoop'],
  }
}