define common::sshlocal ($user = $title) {
  
  case $user {
    'root':     { $homepath = "/root" }
    default:    { $homepath = "/home/${user}" }
  }

  exec { "${user}-local-ssh-keygen":
    command => "/usr/bin/ssh-keygen -t rsa -f ${homepath}/.ssh/id_rsa",
    user => "${user}",
    creates => "${homepath}/.ssh/id_rsa.pub",
  }

  exec { "${user}-local-ssh-auth":
    command => "/bin/cat ${homepath}/.ssh/id_rsa.pub >> ${homepath}/.ssh/authorized_keys; /bin/mkdir -p ${homepath}/.puppetflags/; /bin/touch ${homepath}/.puppetflags/${user}-local-ssh-auth",
    user => "${user}",
    creates => "${homepath}/.puppetflags/${user}-local-ssh-auth",
    require => Exec["${user}-local-ssh-keygen"],
  }

  exec { "${user}-local-ssh-known":
    command => "/bin/echo \"localhost `/bin/cat /etc/ssh/ssh_host_ecdsa_key.pub | /usr/bin/cut -d ' ' -f 1,2`\" > ${homepath}/.ssh/known_hosts; /bin/mkdir -p ${homepath}/.puppetflags/; /bin/touch ${homepath}/.puppetflags/${user}-local-ssh-known",
    user => "${user}",
    creates => "${homepath}/.puppetflags/${user}-local-ssh-known",
    require => Exec["${user}-local-ssh-keygen"],
  }

  exec { "${user}-local-ssh-known-ench":
    command => "/usr/bin/ssh-keygen -H; /bin/mkdir -p ${homepath}/.puppetflags/; /bin/touch ${homepath}/.puppetflags/${user}-local-ssh-known-ench",
    user => "${user}",
    creates => "${homepath}/.puppetflags/${user}-local-ssh-known-ench",
    require => Exec["${user}-local-ssh-known"],
  }
}