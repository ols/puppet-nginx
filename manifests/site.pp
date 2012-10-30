# Define: nginx::site
#
# Install a nginx site in /etc/nginx/sites-available
# (and symlink in /etc/nginx/sites-enabled).
#
#
# Parameters :
# * ensure: typically set to "present" or "absent". Defaults to "present"
# * content: site definition (should be a template).
#
define nginx::site($ensure='present', $port=undef, $root=undef) {
  case $ensure {
    'present' : {
      nginx::install_site { $name:
        port => $port,
        root => $root,
      }
    }
    'absent' : {
      file { "${nginx::params::nginx_sites_enabled}/${name}":
        ensure => absent,
        onlyif => "/usr/bin/test -L ${nginx::params::nginx_sites_enabled}/${name} && \
          /usr/bin/test ${nginx::params::nginx_sites_enabled}/$name -ef \
          ${nginx::params::nginx_sites_available}/${name}",
        notify  => Service['nginx'],
        require => Package['nginx'],
      }
    }
    default: { err ("Unknown ensure value: '$ensure'") }
  }
}
