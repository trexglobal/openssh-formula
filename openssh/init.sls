{% from "openssh/map.jinja" import openssh with context %}
{% set custom_install        = salt['pillar.get']('sshd_formula_config:Custom', none) %}

{% if custom_install is not none %}
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
{% else %}
openssh:
  pkg.installed:
    - name: {{ openssh.server }}
  service.running:
    - enable: True
    - name: {{ openssh.service }}
    - require:
      - pkg: {{ openssh.server }}
{% endif %}

