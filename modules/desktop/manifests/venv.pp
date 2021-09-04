class desktop::venv {
  $packages = [
    'aactivator', 'black', 'flake8', 'pre-commit', 'tox', 'twine', 'virtualenv',
  ]
  $venv = '/home/tristan/opt/venv'

  util::virtualenv { $venv: venv => $venv }

  # TODO: this is quite slow, ideally I'd like something like
  # venv { '/home/tristan/opt/venv':
  #     user => 'tristan',
  #     packages => $packages,
  # }
  $packages.each |$pkg| {
    util::pip {"${venv}(${pkg})":
      pkg     => $pkg,
      venv    => $venv,
      require => Util::Virtualenv[$venv],
    }
  }

  $packages.each |$bin| {
    file { "/home/tristan/bin/${bin}":
      ensure  => 'link',
      target  => "${venv}/bin/${bin}",
      owner   => 'tristan',
      group   => 'tristan',
      require => [
        File['/home/tristan/bin'],
        Util::Pip["${venv}(${bin})"],
      ],
    }
  }

  # awscli deps conflict a lot so put them in their own environment
  $venv_aws = '/home/tristan/opt/awscli'
  util::virtualenv { $venv_aws: venv => $venv_aws }
  -> util::pip { "${venv_aws}(awscli)": pkg => 'awscli', venv => $venv_aws}
  -> file { '/home/tristan/bin/aws':
    ensure  => 'link',
    target  => "${venv_aws}/bin/aws",
    owner   => 'tristan',
    group   => 'tristan',
    require => [
      File['/home/tristan/bin'],
      Util::Pip["${venv_aws}(awscli)"],
    ],
  }
}
