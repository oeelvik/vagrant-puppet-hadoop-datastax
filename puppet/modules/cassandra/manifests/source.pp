class cassandra::source {
  apt::source { 'cassandra':
    location          => 'http://www.apache.org/dist/cassandra/debian',
    release           => '',
    repos             => '11x main',
    include_src       => true,
  }
    
  apt::key { 'F758CE318D77295D':
    key_server => 'pgp.mit.edu',
  }
    
  apt::key { '2B5C1B00':
    key_server => 'pgp.mit.edu',
  }
}