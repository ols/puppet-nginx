# Define: install_site
#
# Install nginx vhost
# This definition is private, not intended to be called directly
#
define nginx::install_site($content=undef) {
  include nginx::params

  # first, make sure the site config exists
  case $content {
    undef: {
      $real_config_content = ''
    }
    default: {
      $real_config_content = $content
    }
  }

  # create the site folder
  file { "${nginx::params::nginx_sites_enabled}/${name}.d":
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => [ Package['nginx'], File[$nginx::params::nginx_sites_available] ],
  }

  file { "${nginx::params::nginx_sites_enabled}/${name}.d/placeholder.conf":
    ensure  => present,
    require => File["${nginx::params::nginx_sites_enabled}/${name}.d"],
  }

  # create the site definition
  file { "${nginx::params::nginx_sites_available}/${name}.conf":
    ensure       => present,
    content      => "include ${nginx::params::nginx_sites_enabled}/${name}.d/*;",
    require      => File[$nginx::params::nginx_sites_available],
  }

  # now, enable it.
  file { "${nginx::params::nginx_sites_enabled}/${name}.conf":
    ensure  => link,
    target  => "${nginx::params::nginx_sites_available}/${name}.conf",
    notify  => Service['nginx'],
    require => File["${nginx::params::nginx_sites_available}/${name}.conf"],
  }
}
