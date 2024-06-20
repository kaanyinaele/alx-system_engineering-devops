

# 0x12. Web Stack Debugging 2

This repository contains solutions for the tasks of the project "0x12. Web Stack Debugging 2". This project is part of the ALX System Engineering and DevOps curriculum.

## Table of Contents

- [Tasks](#tasks)
  - [0. Run software as another user](#0-run-software-as-another-user)
  - [1. Run Nginx as Nginx](#1-run-nginx-as-nginx)
- [Usage](#usage)
  - [0-iamsomeoneelse](#0-iamsomeoneelse)
  - [1-run_nginx_as_nginx](#1-run_nginx_as_nginx)
- [License](#license)

## Tasks

### 0. Run software as another user

Write a Bash script that accepts one argument and runs the `whoami` command under the user passed as an argument.

#### Requirements:
- The script should run the `whoami` command under the user passed as an argument.
- Ensure to try the script by passing different users.

#### Example:
```bash
root@ubuntu:~# whoami
root
root@ubuntu:~# ./0-iamsomeoneelse www-data
www-data
root@ubuntu:~# whoami
root
```

### 1. Run Nginx as Nginx

Fix the container so that Nginx is running as the `nginx` user.

#### Requirements:
- Nginx must be running as `nginx` user.
- Nginx must be listening on all active IPs on port 8080.
- You cannot use `apt-get remove`.
- Write a Bash script that configures the container to fit the above requirements.

#### After debugging:
```bash
root@ab6f4542747e:~# ps auxff | grep ngin[x]
nginx      884  0.0  0.0  77360  2744 ?        Ss   19:16   0:00 nginx: master process /usr/sbin/nginx
nginx      885  0.0  0.0  77712  2772 ?        S    19:16   0:00  \_ nginx: worker process
nginx      886  0.0  0.0  77712  3180 ?        S    19:16   0:00  \_ nginx: worker process
nginx      887  0.0  0.0  77712  3180 ?        S    19:16   0:00  \_ nginx: worker process
nginx      888  0.0  0.0  77712  3208 ?        S    19:16   0:00  \_ nginx: worker process
root@ab6f4542747e:~# nc -z 0 8080 ; echo $?
0
root@ab6f4542747e:~#
```

## Usage

### 0-iamsomeoneelse

1. Create the `0-iamsomeoneelse` script with the following content:
```bash
#!/bin/bash
# A script that runs the whoami command as another user
sudo -u "$1" whoami
```

2. Make the script executable:
```bash
chmod +x 0-iamsomeoneelse
```

3. Run the script with a specified user:
```bash
./0-iamsomeoneelse <username>
```

### 1-run_nginx_as_nginx

1. Create the `1-run_nginx_as_nginx` script with the following content:
```bash
#!/bin/bash
# Update nginx user and group in nginx configuration files

# Update /etc/nginx/nginx.conf
sed -i 's/user .*/user nginx;/' /etc/nginx/nginx.conf

# Ensure nginx runs on port 8080
sed -i 's/listen 80;/listen 8080;/' /etc/nginx/sites-available/default

# Start nginx
service nginx start
```

2. Make the script executable:
```bash
chmod +x 1-run_nginx_as_nginx
```

3. Run the script:
```bash
./1-run_nginx_as_nginx
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This README file provides a comprehensive guide on how to use the scripts and what the project entails. Make sure to include this file in your GitHub repository under the `0x12-web_stack_debugging_2` directory.
