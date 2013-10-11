class cassandra {
  class { 'cassandra::source': }
  
  package { 'cassandra': 
    require => Class['cassandra::source'],
  }
}