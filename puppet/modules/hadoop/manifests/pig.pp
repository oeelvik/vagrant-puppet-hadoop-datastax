class hadoop::pig {
  require hadoop  

  package { 'pig':
    ensure => "latest",
    require => Apt::Ppa['ppa:hadoop-ubuntu/stable'],
  }

  exec {
    'add-pig-hadoop-envvars':
      command => '/bin/echo "
export HADOOP_CLASSPATH=/usr/lib/pig/*:/usr/lib/pig/lib/*:\$HADOOP_CLASSPATH
export PIG_INITIAL_ADDRESS=localhost
export PIG_RPC_PORT=9160
export PIG_PARTITIONER=org.apache.cassandra.dht.RandomPartitioner
export PIG_OPTS=-Dudf.import.list=org.apache.cassandra.hadoop.pig:\$PIG_OPTS
	  " >> /usr/lib/hadoop/conf/hadoop-env.sh',
      unless => "/bin/grep '/usr/lib/pig/*' /usr/lib/hadoop/conf/hadoop-env.sh",
      require => Package['hadoop'],
  }
}