remi-release:
  pkg.installed:
    - sources:
      - remi-release: http://rpms.remirepo.net/enterprise/remi-release-7.rpm

remi-php:
  cmd.run:
    - name: yum-config-manager -y --enable remi-php72

php-inst:
  pkg.installed:
    - pkgs:
      - php72
      - php72-php-fpm
      - php72-php-mysqlnd
      - php72-php-opcache
      - php72-php-xml
      - php72-php-xmlrpc
      - php72-php-gd
      - php72-php-mbstring 
      - php72-php-json
      - php72-php-xml

php_ini:
  file:
    - managed
    - template: jinja
    - name: /etc/opt/remi/php72/php.ini
    - source: salt://lewo/lemp/php/files/php.ini.jinja
    - user: root
    - group: root
    - mode: 0755

php_www:
  file:
    - managed
    - template: jinja
    - name: /etc/opt/remi/php72/php-fpm.d/www.conf
    - source: salt://lewo/lemp/php/files/www.conf.jinja
    - user: root
    - group: root
    - mode: 0755

php72-php-fpm:
  service.running:
    - enable: True
    - reload: True

