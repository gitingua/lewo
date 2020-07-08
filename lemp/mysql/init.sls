mysql:
  file:
    - managed
    - template: jinja
    - name: /etc/yum.repos.d/mariadb.repo
    - source: salt://lewo/lemp/mysql/files/mysql.init.jinja
    - user: root
    - group: root
    - mode: 0755

mariadb_server_installed:
  pkg.installed:
    - pkgs:
      - MariaDB-client
      - MariaDB-server
      - apg

mariadb:
  service.running:
    - enable: True
    - reload: True

create-db:
  cmd.run:
    - name: mysql -uroot -e "CREATE DATABASE wordpress;"

update-db:
  cmd.run:
    - name: mysql -uroot -e "FLUSH PRIVILEGES;"


