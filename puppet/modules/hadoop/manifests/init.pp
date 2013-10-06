class hadoop { 
  exec { "add-apt-repository-hadoop":
    command => "/usr/bin/add-apt-repository -y ppa:hadoop-ubuntu/stable",
    notify => Exec["apt-update-post-repo-add"],
    require => Package["python-software-properties"]
  }
 
  package { 'hadoop':
    ensure => "latest",
    require => Exec['add-apt-repository-hadoop'],
  }
  
  exec {
    'set-hadoop-env':
      command => '/bin/echo "export JAVA_HOME=/usr/lib/jvm/java-6-oracle" >> /usr/lib/hadoop/conf/hadoop-env.sh';
  }
}