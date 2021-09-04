class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.3.5-linux64'
  $pypy2_sha256 = '4858b347801fba3249ad90af015b3aaec9d57f54d038a58d806a1bd3217d5150'
  $pypy3 = 'pypy3.7-v7.3.5-linux64'
  $pypy3_sha256 = '9000db3e87b54638e55177e68cbeb30a30fe5d17b6be48a9eb43d65b3ebcfc26'

  archive { "/tmp/${pypy2}.tar.bz2":
    ensure        => 'present',
    source        => "https://downloads.python.org/pypy/${pypy2}.tar.bz2",
    checksum      => $pypy2_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/tristan/opt',
    creates       => "/home/tristan/opt/${pypy2}/bin/pypy",
    user          => 'tristan',
    group         => 'tristan',
    require       => [Package['curl'], File['/home/tristan/opt']],
  }
  ['pypy', 'pypy2'].each |$bin| {
    file { "/home/tristan/bin/${bin}":
      ensure  => 'link',
      target  => "/home/tristan/opt/${pypy2}/bin/pypy",
      owner   => 'tristan',
      group   => 'tristan',
      require => [
        File['/home/tristan/bin'],
        Archive["/tmp/${pypy2}.tar.bz2"],
      ],
    }
  }

  archive { "/tmp/${pypy3}.tar.bz2":
    ensure        => 'present',
    source        => "https://downloads.python.org/pypy/${pypy3}.tar.bz2",
    checksum      => $pypy3_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/tristan/opt',
    creates       => "/home/tristan/opt/${pypy3}/bin/pypy3",
    user          => 'tristan',
    group         => 'tristan',
    require       => [Package['curl'], File['/home/tristan/opt']],
  }
  file { '/home/tristan/bin/pypy3':
    ensure  => 'link',
    target  => "/home/tristan/opt/${pypy3}/bin/pypy3",
    owner   => 'tristan',
    group   => 'tristan',
    require => [
      File['/home/tristan/bin'],
      Archive["/tmp/${pypy3}.tar.bz2"],
    ],
  }
}
