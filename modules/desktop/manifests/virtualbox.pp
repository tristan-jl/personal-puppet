class desktop::virtualbox {
  if $::is_virtual and $::virtual == 'virtualbox' {
    exec { 'add tristan to vboxsf group':
      command => 'usermod --append --groups vboxsf tristan',
      unless  => join([
          'id --name --groups --zero tristan | ',
          'grep --quiet --null-data --line-regexp vboxsf',
      ]),
      path    => '/usr/sbin:/usr/bin:/bin',
    }
  }
}
