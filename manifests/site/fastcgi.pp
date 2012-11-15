define nginx::site::fastcgi ($ensure=present,$options=undef) {

  file { "${nginx::params::nginx_sites_enabled}/${name}.d/fastcgi.inc":
    ensure  => $ensure,
    content => template('nginx/includes/fastcgi.erb'),
    notify  => Service['nginx'],
  }

}
