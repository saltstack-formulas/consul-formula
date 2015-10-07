{% from "consul/map.jinja" import consul with context %}

unzip:
  pkg.installed

consul_download:
  archive.extracted:
    - name: /opt/consul
    - source: http://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip
    - source_hash: sha1=b3ae610c670fc3b81737d44724ebde969da66ebf
    - archive_format: zip
    - require:
      - pkg: unzip

consul_ui_download:
  archive.extracted:
    - name: /opt/consul
    - source: http://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip
    - source_hash: sha1=67a2665e3c6aa6ca95c24d6176641010a1002cd6
    - archive_format: zip
    - if_missing: /opt/consul/dist
    - require:
      - pkg: unzip

consul_link:
  file.symlink:
    - target: /opt/consul/consul
    - name: /usr/local/bin/consul

consul_user:
  group.present:
    - name: consul
  user.present: 
    - name: consul
    - createhome: false
    - system: true
    - groups:
      - consul
    - require:
      - group: consul

consul_init_script:
  file.managed:
    {% if salt['test.provider']('service') == 'upstart' %}
    - source: salt://consul/files/consul.upstart
    - name: /etc/init/consul.conf
    - mode: 0644
    {% else %}
    - source: salt://consul/files/consul.sysvinit
    - name: /etc/init.d/consul
    - mode: 0755
    {% endif %}

consul_config_dir:
  file.directory:
    - name: /etc/consul.d
    - user: consul
    - group: consul

consul_data_dir:
  file.directory:
    - name: /var/consul
    - user: consul
    - group: consul

consul_config:
  file.managed:
    - source: salt://consul/files/config.json
    - template: jinja
    - name: /etc/consul.d/config.json
    {% if consul.service != False %}
    - watch_in:
       - service: consul
    {% endif %}
    - user: consul
    - group: consul
    - require:
      - user: consul

{% if consul.service != False %}
consul_service:
  service.running:
    - name: consul
{% endif %}

