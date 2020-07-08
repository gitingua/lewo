unzip:
  pkg.installed:
    - pkgs:
      - unzip
 
wordpress_arh:
  archive.extracted:
    - name: /usr/share/nginx/
    - source: http://wordpress.org/latest.zip
    - skip_verify: True

/usr/share/nginx/wordpress:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 0755

wp-config:
  file:
    - managed
    - template: jinja
    - name: /usr/share/nginx/wordpress/wp-config.php
    - source: salt://lewo/wordpress/files/wp-config.init.jinja
    - user: nginx
    - group: nginx
    - mode: 0755
