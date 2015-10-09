{% from "consul/map.jinja" import consul with context %}

unzip:
  pkg.installed

consul_download:
  archive.extracted:
    - name: /opt/consul
    - source: http://dl.bintray.com/mitchellh/consul/0.5.2_linux_{{ salt['grains.get']('osarch', '386') }}.zip
    {% if salt['grains.get']('osarch', '386') == 'amd64' %}
    - source_hash: sha1=b3ae610c670fc3b81737d44724ebde969da66ebf
    {% else %}
    - source_hash: sha1=a4eaaa66668682f40ccb40daefcf0732a185d3a4
    {% endif %}
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
    {% if consul.service != False %}
    - watch_in:
       - service: consul
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

consul_script_dir:
  file.directory:
    - name: /opt/consul/scripts
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

{% for script in consul.scripts %}
consul_service_register_{{ loop.index }}:
  file.managed:
    - source: {{ script.source }}
    - name: {{ script.name }}
    - template: jinja
    - user: consul
    - group: consul
    - mode: 0755
{% endfor %}

consul_service_register_config:
  file.managed:
    - source: salt://consul/files/services.json
    - name: /etc/consul.d/services.json
    - template: jinja
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

