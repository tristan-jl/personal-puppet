class desktop::screensaver {
  gsetting { 'org.gnome.desktop.session idle-delay':
    ensure => 0,
    user   => 'tristan',
  }
  gsetting { 'org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type':
    ensure => 'nothing',
    user   => 'tristan',
  }
}
