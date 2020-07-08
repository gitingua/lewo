/etc/yum.conf:
  file.append:
    - text:
      - proxy=http://proxy:8080

/etc/environment:
  file.append:
    - text:
      - export http_proxy=http://proxy:8080
      - export https_proxy=http://proxy:8080
      - export no_proxy="*.ru, *.tech"
