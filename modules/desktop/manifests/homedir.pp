class desktop::homedir {
  file { [
    '/home/tristan/Documents',
    '/home/tristan/Pictures',
    '/home/tristan/Public',
    '/home/tristan/Templates',
    '/home/tristan/Videos',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }

  file { ['/home/tristan/bin', '/home/tristan/opt']:
    ensure => 'directory',
    owner  => 'tristan',
    group  => 'tristan',
  }
}
