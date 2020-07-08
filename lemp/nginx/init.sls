nginx-release-centos:
  pkg.installed:
    - sources:
      - nginx-release-centos: http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

epel-inst:
  pkg.installed:
    - pkgs:
      - epel-release
      - wget
      - yum-utils
      - nginx

httpd_IN:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: tcp
    - connstate: NEW
    - dport: 80
    - protocol: tcp
    - save: True
https_in:
   iptables.append:
     - use:
       - iptables: httpd_IN
     - dport: 443

httpd_OU:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - jump: ACCEPT
    - match: tcp
    - connstate: NEW
    - protocol: tcp
    - sport: 80
    - save: True

https_ou:
   iptables.append:
     - use:
       - iptables: httpd_OU
     - sport: 443

/etc/nginx/conf.d/default.conf:
  file:
    - managed
    - template: jinja
    - name: /etc/nginx/conf.d/default.conf
    - source: salt://lewo/lemp/nginx/files/default.jinja
    - user: root
    - group: root
    - mode: 644

nginx:
  service.running:
    - enable: True
    - reload: True

