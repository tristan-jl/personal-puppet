class desktop {
  include desktop::apple_touchpad
  include desktop::arduino
  include desktop::background
  include desktop::dotfiles
  include desktop::go
  include desktop::homedir
  include desktop::launcher
  include desktop::purged
  include desktop::pypy
  include desktop::screensaver
  include desktop::terraform
  include desktop::venv
  include desktop::virtualbox

  include packages::debian_packaging
  include packages::build_deps
  include packages::editors
  include packages::gnome_terminal
  include packages::node
  include packages::python
  include packages::utilities

  if ! $::is_virtual {
    include packages::vlc
    include packages::virtualbox
  }
}
