# Define: install_site
#
# Install nginx vhost
# This definition is private, not intended to be called directly
#
define nginx::install_site($port=undef,$root=undef) {
  include nginx::params

  $server_name = $name

  # create the site folder
  file { "${nginx::params::nginx_sites_enabled}/${name}.d":
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => [ Package['nginx'], File[$nginx::params::nginx_sites_available] ],
  }

  # create the site definition
  file { "${nginx::params::nginx_sites_available}/${name}.conf":
    ensure    => present,
    content   => template("nginx/site.erb"),
    require   => File[$nginx::params::nginx_sites_available],
  }

  # now, enable it.
  file { "${nginx::params::nginx_sites_enabled}/${name}.conf":
    ensure  => link,
    target  => "${nginx::params::nginx_sites_available}/${name}.conf",
    notify  => Service['nginx'],
    require => File["${nginx::params::nginx_sites_available}/${name}.conf"],
  }
}
