define elasticsearch::plugin ($plugin = $title){
  require elasticsearch

  
  case $plugin {
  	'mobz/elasticsearch-head': { $short = 'head' }
  	default: { $short = $plugin }
  }

  exec { "es-install-plugin-${plugin}":
    command => "/usr/share/elasticsearch/bin/plugin --install ${plugin}",
    unless => "/usr/share/elasticsearch/bin/plugin --list | /bin/grep '${short}'",
  }
}