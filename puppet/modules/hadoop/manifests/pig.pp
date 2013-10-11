class hadoop::pig {
  require hadoop  

  package { 'pig':
    ensure => "latest",
    require => Apt::Ppa['ppa:hadoop-ubuntu/stable'],
  }
}