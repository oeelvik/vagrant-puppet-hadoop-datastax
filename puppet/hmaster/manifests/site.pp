node default {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>
  
  exec { "apt-update-post-repo-add":
    command => "/usr/bin/apt-get update"
  }
  
  package { ["python-software-properties"]:
    ensure => present
  }

  class { 'oracle-java': }
  class { 'hadoop': }
}