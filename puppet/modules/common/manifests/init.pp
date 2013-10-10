class common {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>

  package { ["vim"]:
    ensure => present
  }
  
  @exec { "apt-update-post-repo-add":
    command => "/usr/bin/apt-get update"
  }
  
  @package { ["python-software-properties"]:
    ensure => present
  }
}