# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as consul with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

consul-init-env:
  file.managed:
    - name: {{ consul.service_env_path }}
    - makedirs: True
    - user: root
    - group: {{ consul.rootgroup }}
    - mode: '0644'
    - contents:
      - CONSUL_USER={{ consul.user }}
      - CONSUL_GROUP={{ consul.group }}

consul-init-file:
  file.managed:
    - name: {{ consul.service_path }}
    - source: {{ files_switch(['consul_service_unit.jinja'],
                              lookup='consul-init-file',
                              default_files_switch=["id", "init", "os_family"]
                 )
              }}
    - mode: {{ consul.service_mode }}
    - template: jinja
    - context:
        bin_dir : {{ consul.bin_dir }}
        config_dir : {{ consul.config_dir }}
        data_dir: {{ consul.config.data_dir }}
        group : {{ consul.group }}
        service_env_path : {{ consul.service_env_path }}
        user : {{ consul.user }}

{%- if consul.service %}

consul-service:
  service.running:
    - name: consul
    - enable: True
    - watch:
      - file: consul-init-env
      - file: consul-init-file

{%- endif %}
