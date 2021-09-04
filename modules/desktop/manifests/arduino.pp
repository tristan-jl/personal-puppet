class desktop::arduino {
  include packages::arduino

  exec { 'add tristan to dialout group':
    command => 'usermod --append --groups dialout tristan',
    unless  => join([
        'id --name --groups --zero tristan | ',
        'grep --quiet --null-data --line-regexp dialout',
    ]),
    path    => '/usr/sbin:/usr/bin:/bin',
  }
}
