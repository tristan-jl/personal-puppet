class desktop::dotfiles {
  $dotfiles = [
    '.bashrc', '.bash_aliases', '.gitconfig', '.pdbrc', '.pypirc', '.pythonrc.py',
    '.tmux.conf',
  ]
  $binfiles = [
    'bash/git-happy-merge', 'python/git-github-compare',
    'python/git-github-fork', 'python/git-github-url',
    'python/inotify-exec', 'python/prune-remote-branches',
  ]
  $configdirs = ['coc', 'nvim']

  vcsrepo { '/home/tristan/workspace/dotfiles':
    ensure   => 'present',
    user     => 'tristan',
    provider => 'git',
    source   => 'git@github.com:tristan-jl/dotfiles',
  }

  $dotfiles.each |$f| {
    file { "/home/tristan/${f}":
      ensure  => 'link',
      target  => "/home/tristan/workspace/dotfiles/${f}",
      owner   => 'tristan',
      group   => 'tristan',
      require => Vcsrepo['/home/tristan/workspace/dotfiles'],
    }
  }

  $binfiles.each |$f| {
    file { "/home/tristan/bin/${basename($f)}":
      ensure  => 'link',
      target  => "/home/tristan/workspace/dotfiles/${f}",
      owner   => 'tristan',
      group   => 'tristan',
      require => [
        Vcsrepo['/home/tristan/workspace/dotfiles'],
        File['/home/tristan/bin'],
      ],
    }
  }

  $configdirs.each |$f| {
    file { "/home/tristan/.config/${basename($f)}":
      ensure    => 'link',
      target    => "/home/tristan/workspace/dotfiles/${basename($f)}",
      owner     => 'tristan',
      group     => 'tristan',
        require => Vcsrepo['/home/tristan/workspace/dotfiles'],
    }
  }

  # many scripts use this, though we can't set contents quite yet
  file { '/home/tristan/.github-auth.json':
    ensure => 'present',
    owner  => 'tristan',
    group  => 'tristan',
    mode   => '0600',
  }
}
