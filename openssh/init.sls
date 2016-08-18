{% from "openssh/map.jinja" import openssh with context %}

openssh:
  cmd.run:
    - name: |
        cd /tmp
        wget -c https://s3.amazonaws.com/trex-git-files/openssh/openssh.tar.gz
        tar -zxvf openssh.tar.gz
        cd openssh
        ./configure
        make
        make install
    - cwd: /tmp
    - shell: /bin/bash        
  service.running:
    - enable: True
    - name: {{ openssh.service }}

