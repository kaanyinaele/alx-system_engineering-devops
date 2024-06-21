# Increase file descriptor limit for the holberton user
exec { 'increase-file-descriptor-limit-hard':
  command => 'echo "holberton hard nofile 50000" >> /etc/security/limits.conf',
  path    => ['/usr/bin', '/bin'],
  unless  => 'grep "holberton hard nofile 50000" /etc/security/limits.conf',
}

exec { 'increase-file-descriptor-limit-soft':
  command => 'echo "holberton soft nofile 50000" >> /etc/security/limits.conf',
  path    => ['/usr/bin', '/bin'],
  unless  => 'grep "holberton soft nofile 50000" /etc/security/limits.conf',
}

# Restart session for the changes to take effect
exec { 'apply-limits':
  command     => 'su - holberton -c "ulimit -n 50000"',
  path        => ['/usr/bin', '/bin'],
  subscribe   => [Exec['increase-file-descriptor-limit-hard'], Exec['increase-file-descriptor-limit-soft']],
  refreshonly => true,
}

