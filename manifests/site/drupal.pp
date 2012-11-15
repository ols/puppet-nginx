define nginx::site::drupal($ensure=present,$version=6) {

  file { "${nginx::params::nginx_sites_enabled}/${name}.d/drupal${version}.conf":
    ensure  => $ensure,
    content => template("nginx/includes/drupal${version}.erb"),
    notify  => Service['nginx'],
  }


}
