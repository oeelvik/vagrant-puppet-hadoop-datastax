class oracle-java {

  realize Exec["apt-update-post-repo-add"]
  realize Package["python-software-properties"]

  exec { "add-apt-repository-oracle":
    command => "/usr/bin/add-apt-repository -y ppa:webupd8team/java",
    notify => Exec["apt-update-post-repo-add"],
    require => Package["python-software-properties"]
  }
 
  exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';
 
    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }
 
  package { 'oracle-java6-installer':
    ensure => "latest",
    require => [Exec['add-apt-repository-oracle'], Exec['set-licence-selected'], Exec['set-licence-seen'],Exec["apt-update-post-repo-add"]]
  }
}