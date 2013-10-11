class common {
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>

  @class { 'apt': }

  package { ["vim"]:
    ensure => present
  }
}