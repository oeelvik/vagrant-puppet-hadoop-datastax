class hadoop::pdm( $hostname = 'localhost' ) {
  require hadoop

  file { 'core-site.xml':
    path => "/usr/lib/hadoop/conf/core-site.xml",
    owner => 'root',
    group => 'hadoop',
    mode => '0644',
    content => template("hadoop/core-site.xml.erb"),
  }

  file { 'hdfs-site.xml':
    path => "/usr/lib/hadoop/conf/hdfs-site.xml",
    owner => 'root',
    group => 'hadoop',
    mode => '0644',
    content => template("hadoop/hdfs-site.xml.erb"),
  }

  file { 'mapred-site.xml':
    path => "/usr/lib/hadoop/conf/mapred-site.xml",
    owner => 'root',
    group => 'hadoop',
    mode => '0644',
    content => template("hadoop/mapred-site.xml.erb"),
  }

  common::sshlocal { 'root': }

  exec { 'hadoop-namenode-format':
    command => '/usr/lib/hadoop/bin/hadoop namenode -format',
    user => "root",
    creates => '/var/dfs/data',
    require => [File['core-site.xml'], File['hdfs-site.xml'], File['mapred-site.xml'], Common::Sshlocal['root']],
  }

  exec { 'hadoop-start-all':
    command => '/usr/lib/hadoop/bin/start-all.sh',
    user => "root",
    unless => "/usr/bin/jps | /bin/grep NameNode",
    require => Exec['hadoop-namenode-format'],
  }
}