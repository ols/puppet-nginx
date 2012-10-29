class { 'nginx':
  nginx_user => 'apache',
}

nginx::site { 'test.example.com':
  ensure  => present,
  content => '',
}
