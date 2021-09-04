class desktop::terraform {
  # https://www.terraform.io/downloads.html

  $version = '1.0.1'
  $checksum = 'da94657593636c8d35a96e4041136435ff58bb0061245b7d0f82db4a7728cef3'

  file { "/home/tristan/opt/terraform-${version}":
    ensure  => 'directory',
    owner   => 'tristan',
    group   => 'tristan',
    require => File['/home/tristan/opt'],
  }
  -> archive { "/tmp/terraform${version}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip",
    checksum      => $checksum,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/tristan/opt/terraform-${version}",
    creates       => "/home/tristan/opt/terraform-${version}/terraform",
    user          => 'tristan',
    group         => 'tristan',
    require       => Package['curl'],
  }
  -> file { '/home/tristan/bin/terraform':
    ensure  => 'link',
    target  => "/home/tristan/opt/terraform-${version}/terraform",
    owner   => 'tristan',
    group   => 'tristan',
    require => File['/home/tristan/bin'],
  }
}
