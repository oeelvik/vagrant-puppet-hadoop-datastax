node default {
  class { 'common': }
  class { 'oracle-java': }
  class { 'hadoop::pdm': }
}