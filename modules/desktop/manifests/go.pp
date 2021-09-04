class desktop::go {
  # https://golang.org/dl/
  $go = 'go1.17.linux-amd64'
  $sha256 = '6bf89fc4f5ad763871cf7eac80a2d594492de7a818303283f1366a7f6a30372d'

  file { "/home/tristan/opt/${go}":
    ensure => 'directory',
    owner  => 'tristan',
    group  => 'tristan',
  }
  -> archive { "/tmp/${go}.tar.gz":
    ensure        => 'present',
    source        => "https://dl.google.com/go/${go}.tar.gz",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/tristan/opt/${go}",
    creates       => "/home/tristan/opt/${go}/go/bin/go",
    user          => 'tristan',
    group         => 'tristan',
    require       => [Package['curl'], File['/home/tristan/opt']],
  }
  ['go', 'gofmt'].each |$bin| {
    file { "/home/tristan/bin/${bin}":
      ensure  => 'link',
      target  => "/home/tristan/opt/${go}/go/bin/${bin}",
      owner   => 'tristan',
      group   => 'tristan',
      require => [File['/home/tristan/bin'], Archive["/tmp/${go}.tar.gz"]],
    }
  }
}
