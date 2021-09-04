class desktop::launcher {
  gsetting { 'org.gnome.shell favorite-apps':
    ensure => [
      'org.gnome.Nautilus.desktop',
      'org.gnome.Terminal.desktop',
      'chrome.desktop',
      'gnome-control-center.desktop',
    ],
    user   => 'tristan',
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock multi-monitor':
    ensure => ':true',
    user   => 'tristan',
  }
}
