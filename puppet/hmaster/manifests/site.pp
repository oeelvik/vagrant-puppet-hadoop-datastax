node default {
  class { 'common': }
  class { 'oracle-java': }
  class { 'hadoop::pdm': }
  class { 'cassandra': }
  class { 'cassandra::hadoop': 
    notify => Exec['hadoop-start-all']
  }
}