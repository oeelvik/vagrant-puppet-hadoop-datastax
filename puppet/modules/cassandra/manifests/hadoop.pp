class cassandra::hadoop {
  exec {
    'add-cassandra-hadoop-classpath':
      command => '/bin/echo "export HADOOP_CLASSPATH=/usr/share/cassandra/*:/usr/share/cassandra/lib/*:\$HADOOP_CLASSPATH" >> /usr/lib/hadoop/conf/hadoop-env.sh',
      unless => "/bin/grep 'usr/share/cassandra' /usr/lib/hadoop/conf/hadoop-env.sh",
      require => Package['hadoop'],
  }
}