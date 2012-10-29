class nginx::params {
  $nginx_includes = '/etc/nginx/includes'
  $nginx_conf = '/etc/nginx/conf.d'
  $nginx_sites_enabled = '/etc/nginx/sites-enabled'
  $nginx_sites_available = '/etc/nginx/sites-available'

  $real_nginx_user = $nginx::nginx_user ? {
    undef   => 'www-data',
    default => $nginx::nginx_user
  }

  $real_nginx_worker_processes = $nginx::nginx_worker_processes ? {
    undef   => '1',
    default => $nginx::nginx_worker_processes
  }

  $real_nginx_worker_connections = $nginx::nginx_worker_connections ? {
    undef   => '1024',
    default => $nginx::nginx_worker_connections
  }
}
