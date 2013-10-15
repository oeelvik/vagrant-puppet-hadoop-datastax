class elasticsearch {
  exec { "install-elasticsearch":
    command => "/usr/bin/wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb; /usr/bin/dpkg -i elasticsearch-0.90.5.deb",
    user => "root",
    creates => "/etc/elasticsearch/",
  }

  service { "elasticsearch":
    enable => true,
    ensure => running,
    require => Exec['install-elasticsearch'],
  }
}