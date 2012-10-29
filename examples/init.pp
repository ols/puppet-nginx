class { 'nginx':
  nginx_user => 'apache',
}

## Example site with location options
nginx::site { 'test.example.com':
  ensure  => present,
  port    => '80',
  #  root    => '/var/www/test.example.com',
}

nginx::site::location { 'testlocation':
  site             => 'test.example.com',
  location         => '/testlocation',
  location_options => {
    'rewrite'      => '^ http://www.google.be permanent',
    'expires'      => 'max',
  }
}
