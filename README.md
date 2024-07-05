# About

Simple docker configuration with 
- Apache
- PHP 8.3
- Composer 2.4
- Mysql8
- PhpMyAdmin
- Node 16

# Requirements

- docker (26.1)
- docker-compose (2.27)

# Installation

Clone repository
```bash
git clone <repo>
```

Build  containers
```bash
docker compose build
```

Start container
```bash
docker compose up -d 
```

Services ports:
- webserver http://localhost:8082
- mysql http://localhost:3306
- phpmyadmin http://localhost:8081

Document root is automatically set to /public, to make changes go to /services/apache/000-default.conf and change configuration

```bash
<VirtualHost *:80>
ServerAdmin webmaster@localhost
DocumentRoot /var/www/html/public

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

