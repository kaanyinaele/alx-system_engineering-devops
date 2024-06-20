# 0x17. Web Stack Debugging 3

This repository contains solutions for the tasks of the project "0x17. Web Stack Debugging 3". This project is part of the ALX System Engineering and DevOps curriculum.

## Table of Contents

- [Tasks](#tasks)
  - [0. Strace is your friend](#0-strace-is-your-friend)
- [Usage](#usage)
  - [0-strace_is_your_friend.pp](#0-strace_is_your_friendpp)
- [License](#license)

## Tasks

### 0. Strace is your friend

Using `strace`, find out why Apache is returning a 500 error. Once you find the issue, fix it and then automate it using Puppet (instead of using Bash as you were previously doing).

#### Requirements:
- Your `0-strace_is_your_friend.pp` file must contain Puppet code.
- You can use whatever Puppet resource type you want for your fix.

#### Example:
```bash
root@e514b399d69d:~# curl -sI 127.0.0.1
HTTP/1.0 500 Internal Server Error
Date: Fri, 24 Mar 2017 07:32:16 GMT
Server: Apache/2.4.7 (Ubuntu)
X-Powered-By: PHP/5.5.9-1ubuntu4.21
Connection: close
Content-Type: text/html

root@e514b399d69d:~# puppet apply 0-strace_is_your_friend.pp
Notice: Compiled catalog for e514b399d69d.ec2.internal in environment production in 0.02 seconds
Notice: /Stage[main]/Main/Exec[fix-wordpress]/returns: executed successfully
Notice: Finished catalog run in 0.08 seconds
root@e514b399d69d:~# curl -sI 127.0.0.1:80
root@e514b399d69d:~#
HTTP/1.1 200 OK
Date: Fri, 24 Mar 2017 07:11:52 GMT
Server: Apache/2.4.7 (Ubuntu)
X-Powered-By: PHP/5.5.9-1ubuntu4.21
Link: <http://127.0.0.1/?rest_route=/>; rel="https://api.w.org/"
Content-Type: text/html; charset=UTF-8

root@e514b399d69d:~# curl -s 127.0.0.1:80 | grep Holberton
<title>Holberton &#8211; Just another WordPress site</title>
<link rel="alternate" type="application/rss+xml" title="Holberton &raquo; Feed" href="http://127.0.0.1/?feed=rss2" />
<link rel="alternate" type="application/rss+xml" title="Holberton &raquo; Comments Feed" href="http://127.0.0.1/?feed=comments-rss2" />
    	<div id="wp-custom-header" class="wp-custom-header"><img src="http://127.0.0.1/wp-content/themes/twentyseventeen/assets/images/header.jpg" width="2000" height="1200" alt="Holberton" /></div>  </div>
                        	<h1 class="site-title"><a href="http://127.0.0.1/" rel="home">Holberton</a></h1>
    	<p>Yet another bug by a Holberton student</p>
root@e514b399d69d:~#
```

## Usage

### 0-strace_is_your_friend.pp

1. **Investigate the 500 Internal Server Error:**
	- Use `strace` to attach to the Apache process and observe the system calls.
	- Use `tmux` to open multiple windows: one for running `strace` and another for making HTTP requests using `curl`.

	```bash
	# Start a tmux session
	tmux

	# In one tmux window, run strace on the Apache process
	strace -p <apache_process_id>

	# In another tmux window, make an HTTP request
	curl -sI 127.0.0.1
	```

2. **Identify and fix the issue:**
	- The `strace` output should help identify the root cause of the 500 error (e.g., missing files, permission issues, etc.).
	- Once identified, create a Puppet manifest to automate the fix.

3. **Create the Puppet manifest (`0-strace_is_your_friend.pp`):**
	```puppet
	# Puppet manifest to fix the Apache 500 error

	exec { 'fix-apache':
  	command => 'touch /var/www/html/wp-settings.php && chown www-data:www-data /var/www/html/wp-settings.php',
  	onlyif  => 'test ! -f /var/www/html/wp-settings.php',
	}
	```

4. **Apply the Puppet manifest:**
	```bash
	# Apply the Puppet manifest
	puppet apply 0-strace_is_your_friend.pp
	```

5. **Verify the fix:**
	```bash
	# Check the HTTP response
	curl -sI 127.0.0.1:80
	```

