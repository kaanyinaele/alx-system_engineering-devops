# Increases the amount of traffic an Nginx server can handle

# Define the exec resource to modify ULIMIT in /etc/default/nginx
exec { 'fix--for-nginx':
  command => 'sed -i "s/^ulimit -n 15/ulimit -n 4096/" /etc/default/nginx',
  path	=> '/usr/bin:/bin',  # Ensure correct path to 'sed'
  onlyif  => 'grep "^ulimit -n 15" /etc/default/nginx',  # Only execute if the line exists
  notify  => Exec['nginx-restart'],  # Notify the nginx-restart exec to restart Nginx after this change
}

# Define the exec resource to restart Nginx
exec { 'nginx-restart':
  command 	=> '/etc/init.d/nginx restart',  # Command to restart Nginx
  path    	=> '/sbin:/usr/sbin:/bin:/usr/bin',  # Ensure correct path for Nginx restart command
  refreshonly => true,  # Only run this exec if notified
}



